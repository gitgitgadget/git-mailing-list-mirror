From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git submodule update: have a dedicated helper for cloning
Date: Wed, 03 Feb 2016 16:54:53 -0800
Message-ID: <xmqqegctjnvm.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-7-git-send-email-sbeller@google.com>
	<xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbeDBf=AfA2RUhkfjwJqJ7pr30xW3UTXqiha_EPpisvnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:55:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR8CJ-0005K5-QV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 01:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877AbcBDAy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 19:54:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754822AbcBDAy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 19:54:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70C63426C2;
	Wed,  3 Feb 2016 19:54:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CV+JkQXCah0dTwTqisucAW1kFZE=; b=TfgszP
	vxFqyyMgM3dE++dhmJPcqNFPl0MNZaBWncyqwx+DHi0/qpdem7THgj0nXnUBrLBy
	dlV6GrveNoqI7PqqRdIMYycn1GxQTR/jIgdF9nYFLUvNChdfSPT0SvHaxUOwKuCK
	knBOfrOnX6HuJX3QHIV3J9gSKYuIeSjXB77qM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gDj8uS9ncytFZFG3d4rXBn9Uzf2dqKVC
	5L7Vxz958dnGAm2ZIZnZW/Ch1t2DlqOuEPFvb8FitHsCI91OcYkBr2iBzmAJOuNW
	YAPlXiNeBCzycuHgXfeaZs//+InUi6azD7XSUoMfXrdiTAVLhKyG301M4thEyUwx
	IM3b0OVVZyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6712D426C1;
	Wed,  3 Feb 2016 19:54:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DBF4C426C0;
	Wed,  3 Feb 2016 19:54:54 -0500 (EST)
In-Reply-To: <CAGZ79kbeDBf=AfA2RUhkfjwJqJ7pr30xW3UTXqiha_EPpisvnw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 3 Feb 2016 15:41:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7BA5F22-CAD9-11E5-9E2B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285388>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 3, 2016 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +             if (ce_stage(ce)) {
>>> +                     if (pp->recursive_prefix)
>>> +                             strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
>>> +                                     pp->recursive_prefix, ce->name);
>
> As a side question: Do we care about proper visual directory
> separators in Windows?

You know I do not do Windows ;-)  I'll leave the question for others
to answer (I am trying not to be one of the the only small number of
people who review code around here).

> I never run into this BUG after having proper initialization, so maybe it's not
> worth carrying this code around. (We have many other places where
> submodule_from_{path, name} is used unchecked, so why would this place
> be special?)

That is why I wondered if moudule_list() is a better place to do so.
That is where the list of everybody works on come from.

>>> +             /*
>>> +              * Looking up the url in .git/config.
>>> +              * We must not fall back to .gitmodules as we only want to process
>>> +              * configured submodules.
>>> +              */
>>> +             strbuf_reset(&sb);
>>
>> Doesn't this invalidate displaypath, when pp->recursive_prefix is in
>> effect?  It still seems to be used to create an error message just a
>> few lines below...
>
> Yes that is programmer error. Also the final cleanup of the strbuf is missing.

Yeah, the calling convention to relative_path() might be performant,
but I agree that it is not the easiest API function to use correctly.
