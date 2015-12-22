From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] do_compare_entry: use already-computed path
Date: Tue, 22 Dec 2015 10:51:41 -0800
Message-ID: <xmqq60zqe2pu.fsf@gitster.mtv.corp.google.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	<xmqqzix3e61h.fsf@gitster.mtv.corp.google.com>
	<1450740784.3892.3.camel@twopensource.com>
	<CAPc5daW4ru0j4Zd3ynnRcG8df7sZ9ZuVHu8mz2rxVonZpyE4Gw@mail.gmail.com>
	<1450758362.3892.7.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBS2G-0000rE-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbbLVSvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 13:51:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbbLVSvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 13:51:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52F91350DD;
	Tue, 22 Dec 2015 13:51:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xrldvJMzSFyLGO8P+/Ogbi2vhko=; b=xtFoZ7
	szp2x2ALuUaa+1DA9nj50+3nTzXG8adIw5k1t+CaYhPC9WoyKw5UIECcSsmQvbIK
	23rka07NcgcKCB1T/SylUZCwrVr3tBxiBKicgRXaMGI1S3TrvJcIXoWIOpjbWSxa
	OqCf/Dc+Yk2sUCfBlsjECCvPsir5WhrlhvCLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N6tPN8SEkAun222ImvbFiLsmLjlKz2fb
	cYp4zhxtrKxWjcGR7CFKUwUz76/v7HrpRCP3i48YMILOlq1GjdVDxu1yADCjUgOP
	0mzXjATsnVY/faJYcyOvhAYQd8zQ0nsy3jMKWqZhllcchOrPwx3zvT4ytk/Qs8ij
	1Tm2JQvz9PU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A654350DC;
	Tue, 22 Dec 2015 13:51:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B5C79350DB;
	Tue, 22 Dec 2015 13:51:42 -0500 (EST)
In-Reply-To: <1450758362.3892.7.camel@twopensource.com> (David Turner's
	message of "Mon, 21 Dec 2015 23:26:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AD3D3B8-A8DD-11E5-8A12-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282899>

David Turner <dturner@twopensource.com> writes:

> On Mon, 2015-12-21 at 15:34 -0800, Junio C Hamano wrote:
>> Great. Thanks, will queue w/o 1/2 (though I do not think it would
>> hurt).
>> 
>> On Mon, Dec 21, 2015 at 3:33 PM, David Turner <
>> dturner@twopensource.com> wrote:
>> > On Mon, 2015-12-21 at 15:27 -0800, Junio C Hamano wrote:
>> > > Thanks.  Does the number still stay at 25% improvement?
>> > 
>> > Yes.
>
> BTW, that function, via ce_in_traverse_path, gets called about 40
> million times when switching (checking out) between master and a
> branch that's a few months old (and that contains relatively small
> changes from master-as-of-then. Our repo only has approximately a
> quarter -million files.  This seems somewhat unreasonable to me,
> but I haven't really looked into what's going on.  Do you happen
> to know why this is and whether it is likely to be a bug?

That does sound excessive; smells like somebody is being overly
cautious (i.e. a performance bug).

We might be seeing something similar to what e53e6b44 observed and
attempted to correct.  I dunno.
