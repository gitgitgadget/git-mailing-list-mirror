From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 08:29:10 -0700
Message-ID: <xmqqmvoc1lix.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
	<xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
	<57230F71.2020401@alum.mit.edu>
	<xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
	<57233E19.4000200@alum.mit.edu>
	<20160429121228.GA27952@sigill.intra.peff.net>
	<572367B4.4050207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 17:29:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awAM3-00089r-Av
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbcD2P3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:29:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753114AbcD2P3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 11:29:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2EDD16175;
	Fri, 29 Apr 2016 11:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXySM2loufCfPyP+X3tnL0CVuYk=; b=TyqDMk
	B3EARmDw19RDRqs0esmrVXE4vcCsYRoNuDUA+UkRdDF/dkkDqNGsHxlJa3pKVqQG
	+VEIA9jIONrbkK0cTQAqrbGmZx1qH14HEzk1Gc/7m2TzxlsCxu9CDkTc5BkaqNgW
	LOxYHMLJRUj7HEPG+SSOHcpPHgBDQ9cum1FmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TqcI5MPwyQVZNNBFU62lQQPYR28DeekH
	ZOE6CS2FG0nCQEk6E8A4UbyJeN1YzirnZhNR4PI+vpTiP+3sa/MZQTfx0/QkVdEf
	LVbGFSwjjd4Tz7m8/PLEnVK2Ojm8RsejDdrHbJlezgVswokPkEyDCVPtDKGQYVcX
	LLgXL7p45sQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E87D016174;
	Fri, 29 Apr 2016 11:29:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FA0116173;
	Fri, 29 Apr 2016 11:29:12 -0400 (EDT)
In-Reply-To: <572367B4.4050207@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 29 Apr 2016 15:55:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FDCB8B8-0E1F-11E6-A43E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293018>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/29/2016 02:12 PM, Jeff King wrote:
>> On Fri, Apr 29, 2016 at 12:57:29PM +0200, Michael Haggerty wrote:
>> 
>>> Remember, we're talking about rename_ref() only, not reference deletion
>>> in general. rename_ref() is not very robust anyway--it doesn't happen in
>>> a single transaction, and it is vulnerable to being defeated by
>>> simultaneous reference updates by other processes. It *does* wrap the
>>> deletion of newrefname in a transaction; the only question is whether an
>>> old_sha1 is supplied to that transaction.
>>>
>>> So, suppose that newrefname starts at value A, and there are two updates
>>> running simultaneously:
>>>
>>> 1. An update of reference newrefname from A -> B
>>>
>>> 2. A rename of reference oldrefname to newrefname, which includes
>>>    a. read_ref_full("newrefname") and
>>>    b. delete_ref("newrefname").
>> 
>> I wondered at first if you meant "oldrefname" in 2b. That is, a rename
>> would involve writing to "newrefname" and then deleting "oldrefname",
>> and not doing the old_sha1 and normal locking on the deletion of
>> oldrefname would be bad (in case somebody else updated it while we were
>> operating).
>> 
>> But reading the patch again, that's not what's going on. You're talking
>> just about the case where we force-overwrite an existing newrefname, and
>> delete it first to do so. But what I don't understand is:
>
> It's beyond the ambition of this patch to fix this old rename_ref()
> code, but...

Thanks for a clear explanation.  The NULL might want to be explained
in in-code comment (e.g. "here we do not care about verifying old
value because..."), then.
