From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 13:17:18 -0700
Message-ID: <xmqqoau6hz1t.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWWb-0000Nb-KF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbaIWURV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:17:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64949 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaIWURU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 350E23AA8C;
	Tue, 23 Sep 2014 16:17:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZYnv+1C2kX/c+QuXKxlUnYSRI8g=; b=ZVrMwq
	WYoHl6vaylLi46sWY0xl/0VC2yChUdDskrW+Af+qnJ0qu6bkMB/mGBD6t6AtFOmd
	u0y7u2cIKuklsZYjHMJftHUra/ow0OMQP0j9cnV0ZrDJuxk91BhVFRybQIW2xjmN
	IjsFGVO0COWjQziQIPR454L12lgne7tweExMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2o0uAN9Ubkbzc3ob5NYse8J6KIxYAcf
	2qObmWO3BGYd+heFn5g+W8EFFgC2zgI2yAnZs4IcgwFSqVgWrvFfg5ppbSMxGqXu
	VOaFEN1SnYbkDGGkI3X7L9DpjFX9phR2JgpsqzoEkPZ1uX3Zj468kkJhHvJld4Gi
	cfcuSC5+koQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C14B3AA8B;
	Tue, 23 Sep 2014 16:17:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A023A3AA8A;
	Tue, 23 Sep 2014 16:17:19 -0400 (EDT)
In-Reply-To: <xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Sep 2014 11:54:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EB5E110-435E-11E4-A59D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257437>

Junio C Hamano <gitster@pobox.com> writes:

> SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
> turn out that what you are trying to do might be an equilvalent of
>
> 	git format-patch ... |
>         # first lose all \r\n
>         dos2unix | 
> 	# then make everything \r\n
>         unix2dos |
>         # and apply
>         git am
>
> which is not workable in the first place.  I dunno.

This is a tangent, but if the problem were slightly different, I
would be more sympathetic.  For example

    A popular MUA, when asked to write out a message in the mbox
    format, ends _all_ the lines in its output with CRLF, whether
    the original was sent as LF-only or CRLF, and there is no way to
    convince it to use LF-only.  "git apply" fails to grok such an
    input.

could be, if the use of such an MUA is very prevalent, a common
problem worth working around.

But then I would suspect that the workaround for such a case may not
be "accept /dev/null\n and /dev/null\r\n equally".  It is likely
that the right workaround for such a case would be to "turn all \r\n
into \n before processing".
