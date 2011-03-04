From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Thu, 03 Mar 2011 16:08:57 -0800
Message-ID: <7v8vwv927a.fsf@alter.siamese.dyndns.org>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 01:09:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIa1-00058e-Pm
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759019Ab1CDAJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 19:09:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903Ab1CDAJG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 19:09:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D9E44E05;
	Thu,  3 Mar 2011 19:10:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4o+Q10s1p5kc
	9awV18Z6g9oAX64=; b=Z+OAvmikCCehdOVNUUVeWhQXAg1KyY/+bMb5LEbltm19
	SlqYZOIm7jbw+xN0M1gMCjOflTyWv9Pn+7AQyv8pxX3dfCl2IenM3ISXHWwFkg7f
	QDaQ30SgLNbvOVU8fypjaXbyRsJDMU4l0IKOnyJZrOfTIL2zQBFM0139y+GZ8iA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NeQneu
	lj35WE1U+4BG2da0IJD2wpkitsQmoICDt0qlYHE11XlcGttmQ+rUNC8v3bxusFaN
	TBxyt3M4KAiUON4LTxHfy0y//1SFcoZWQ5QB8RkzEKKbAI5rryDo1FG8ClvCtaAV
	Lj3H+AH1TuHDpDt1O8Co/Wyv480K0hcHc/rMs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B0CE4E04;
	Thu,  3 Mar 2011 19:10:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C9594DFF; Thu,  3 Mar 2011
 19:10:21 -0500 (EST)
In-Reply-To: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  3 Mar
 2011 19\:43\:21 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD9C3108-45F3-11E0-A1E2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168416>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Instead of creating the repository at $GIT_DIR, --real-git-dir will
> tell git to put the repository there, then make $GIT_DIR a .git file
> that points to --real-git-dir.

Just like you, I am also bad at naming things, so I cannot offhand sugg=
est
a better name, even though I _know_ --real-git-dir sounds horrible.

The naming aside, the feature is what we have wanted to have for a long
time and is way overdue.  Thanks for showing how small-impact the
necessary changes are.

"submodule init subpro" should be able to use this to clone a submodule
with:

	git clone --xxx=3D.git/modules/subpro.git subpro

When we need to switch to a revision without that submodule, after maki=
ng
sure that there is no precious file in subpro/ directory, we would:

	rm -rf subpro/

Now, what do we need to switch back to a revision with that submodule? =
 It
would involve something like this:

	... after checking if we already have .git/modules/subpro.git
        ... and seeing that we do ...

	mkdir subpro
	commit=3D$(git rev-parse :subpro)
        echo 'gitdir: ../.git/modules/subpro.git' >subpro/.git
	cd subpro && git checkout $commit^0

The above four lines packaged for "git submodule" script would be a use=
ful
thing to have, especially because then nobody has to write the "echo" p=
art.

>  I intend to make 'git init --real-git-dir' move current repo to
>  somewhere else if called on existing repo.

I don't know if that is useful in real life.  Do you have a concrete us=
e
case (like the one I showed an example above) in mind?
