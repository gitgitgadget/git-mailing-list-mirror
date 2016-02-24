From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: do not delete i-t-a entries in worktree even when forced
Date: Wed, 24 Feb 2016 15:23:04 -0800
Message-ID: <xmqq60xdsnfr.fsf@gitster.mtv.corp.google.com>
References: <1456314317-30301-1-git-send-email-pclouds@gmail.com>
	<xmqqa8mpsom6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:23:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYimB-0003qf-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcBXXXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 18:23:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753585AbcBXXXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 18:23:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15A9347AAA;
	Wed, 24 Feb 2016 18:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hkEwNAVoCbld
	nYyBTPd5LDJkkrQ=; b=a+z0cROhxjXfpg+N4wmVfcpYE6KltzDZBB5yV+GOCrGn
	IIMTnLtq7y8k9fsb9bA+8stsVVhY/oU2aHY9Ev/gkNu40oOFj5+YaXL3HumDIWs+
	Enj1H1/mfZDnZ7R3OGucPRUhQgg719doUJg69MJ4uWm8KfMRFfmxSKSAmlYcBQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q1EZu1
	885R47RyG4Ba+Azrzqm3yo3pAETaaZ+kus7POBlbjQMxw62IFvG5bScPlUOOAzqF
	OqMdzVFiE0WO8lxqlZyfYGySeE0Mz6bSFMChuKfVz89ZHZoRXtMywWZ2rpJcLWij
	IN9v4Lvm77JFtws27enyKUm2Ln9N1GkoaNRHQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D8ED47AA9;
	Wed, 24 Feb 2016 18:23:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CC7747AA7;
	Wed, 24 Feb 2016 18:23:05 -0500 (EST)
In-Reply-To: <xmqqa8mpsom6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 24 Feb 2016 14:57:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E8CF07A-DB4D-11E5-8D42-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287278>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Intent-to-add entries are basically "I may want to commit these file=
s
>> later, but for now they are untracked". As such, when the user does =
"git
>> reset --hard <tree>", which removes i-t-a entries from the index, i-=
t-a
>> entries in worktree should be kept as untracked.
>
> Hmm, I can see that the control flow of "reset --hard" for an i-t-a
> path does pass through this function, but it is not very obvious
> to see how this will not negatively affect other uses of the
> unpack-trees machinery (e.g. "checkout" and "merge", especially when
> such a path needs to turn into a directory by getting removed).
>

Thinking about it more, I have to say that I do not agree with the
basic premise of this patch.  I-T-A is not "may want to commit, but
they are untracked" at all.  It is "I know I want to add, I just
cannot yet decide the exact contents".

That is why "git add -N newfile && git grep string" would find the
string from newfile, and "git add -N newfile && git diff HEAD newfile"
would show the addition.

Sane people would expect that "git reset --hard HEAD" would behave
as "git diff HEAD | git apply --index -R" when your index is fully
merged, but this change will break the expectation.

Earlier we changed "git commit" to pretend as if an I-T-A entry does
not exist in "git add -N newfile && git commit", but I think that
was a mistake that was caused by the same fuzzy thinking.

3f6d56de (commit: ignore intent-to-add entries instead of refusing,
2012-02-07) does talk about the use of "git add -N" in conjunction
with "git status" and "git diff", but somehow nobody realized that
it was introducing inconsistency in the semantics.
