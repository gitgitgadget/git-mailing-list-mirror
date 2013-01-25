From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Thu, 24 Jan 2013 20:55:50 -0800
Message-ID: <7vip6l7tex.fsf@alter.siamese.dyndns.org>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com>
 <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org>
 <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
 <7vwqv3dw2n.fsf@alter.siamese.dyndns.org>
 <CACsJy8CtV-ngy4iGm3Vn3bu9XwpSrZ_AeWpPxTC2TY_qXv=Cxw@mail.gmail.com>
 <7v1udacugj.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bq8aQ69twWtwHyNzez2OwTN1wHxqHwb_AM-Qo4TUuv8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybKp-00018L-CI
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab3AYEzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:55:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab3AYEzw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:55:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34557C44D;
	Thu, 24 Jan 2013 23:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0pW4suI5/vZxokb5mTM26PHYhGU=; b=gQaFuU
	VuRaIf/qKVCjhVrlDAWGTcMLDcLX6UqLFxI0g5k6felDZ1ZWYON2UO8DOlSO+jM/
	8lohCGz/7TECtUhdQgSxOMRK4uy7RfYkyXhoFMaJIbpMI/pHfUBRQc23HchMzpmM
	KUq2fkFfOMLdFArzwdodyQYYeBtYVwI9QCD98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iq39ZM2TohVr/k193HF0NuQ1SStwQyN3
	5VWyANWwG5LNpsOIoUfQjWw1kSJJRI7U4BlTma5sXp86TAs1L3cU74ofUSS28D+O
	n1kzzZNSA1gLWiCwCELUT0KQ0vv8oOFTSYg0HlFvAoOHiRur5SbIlm3N5HSav/Tx
	H/Hg41w6vHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B55C44C;
	Thu, 24 Jan 2013 23:55:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95D9FC447; Thu, 24 Jan 2013
 23:55:51 -0500 (EST)
In-Reply-To: <CACsJy8Bq8aQ69twWtwHyNzez2OwTN1wHxqHwb_AM-Qo4TUuv8Q@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 25 Jan 2013 08:46:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E237D7C-66AB-11E2-98B2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214494>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jan 25, 2013 at 1:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> I don't think we need to support two different sets of wildcards in
>>> the long run. I'm thinking of adding ":(glob)" with WM_PATHNAME.
>>> Pathspec without :(glob) still uses the current wildcards (i.e. no
>>> FNM_PATHNAME). At some point, like 2.0, we either switch the behavior
>>> of patterns-without-:(glob) to WM_PATHNAME, or just disable wildcards
>>> when :(glob) is not present.
>>
>> Yeah, I think that is sensible.
>>
>> I am meaning to merge your retire-fnmatch topic to 'master'.
>
> I thought you wanted it to stay in 'next' longer :-)

I only said "a bit longer than other topics", and the topic has been
cooking on 'next' for three weeks by now, which is a lot longer.  I
haven't been keeping exact tallies, but trivial ones graduate from
'next' to 'master' in 3 to 5 days, ones with medium complexity in 7
to 10 days on average, I think.

> That looks ok. You may want to mention that "**" syntax is enabled in
> .gitignore and .gitattributes as well (even without USE_WILDMATCH).

Yeah, I forgot about that behaviour, and it is a bit confusing
story.  You did that in 237ec6e (Support "**" wildcard in .gitignore
and .gitattributes, 2012-10-15).

c41244e (wildmatch: support "no FNM_PATHNAME" mode, 2013-01-01) that
is part of the retire-fnmatch topic, changes the behaviour of
wildmatch() with respect to /**/ magic drastically, but everything
cancels out in the end:

 - With the current master without nd/retire-fnmatch, wildmatch()
   always works in WM_PATHNAME mode wrt '/**/'; match_pathname()
   that is used for attr/ignore matching uses wildmatch() so a
   pattern "**/Makefile" matches "Makefile" at the top, affected by
   the "**/" magic;

 - After merging nd/retire-fnmatch, wildmatch() needs WM_PATHNAME
   passed in order to grok '/**/' magic, but match_pathname() is
   changed in the same commit to pass WM_PATHNAME, so the "**/"
   magic is retained for ignore/attr matching.

> We
> could even stop the behavior change in for-each-ref (FNM_PATHNAME in
> general) but I guess because it's a nice regression, nobody would
> complain.

That is not a "regression" (whose definition is "we inadvertently
changed the behaviour and fixed that once, but the breakage came
back").  It is a behaviour change that is backward incompatible.

I would agree that it is a nice behaviour change, though ;-)

Thanks.
 
