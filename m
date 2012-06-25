From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v5] git on Mac OS and precomposed unicode
Date: Mon, 25 Jun 2012 15:33:32 -0700
Message-ID: <7vwr2vdnsz.fsf@alter.siamese.dyndns.org>
References: <201206241747.06525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:33:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjHqn-0004EX-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 00:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab2FYWdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 18:33:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757697Ab2FYWdf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 18:33:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B03989980;
	Mon, 25 Jun 2012 18:33:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lXTLpFaWr5ct
	fX5wCxW7mKDjmC4=; b=F9AlA7uSDqRG+IolBwSQ5ERg0fq3oLI3D3zoh8pNiZoQ
	BZuidWz1Li5OGuM+23hNDQTUGwiEh0NRtOfEG4v8jQxGohReqZIrCUFfjJ18wiP4
	qCuQ0e6ACnIBT9dJ82NOrM1Rxnl3OCx4dpFcvT7IbXhDyEFWomeWTJWOghHvGP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PhUDBD
	e657Ou+FT65CXdopOqu2OPpN+sMbISZInytoraV0m9mOdDfkXUKICremMd+k6rBf
	nC1aKXgA9t/4lIro9GrTikUsprT63FIxIeDKIdq8/QE/Q/z1kH2BUMIJ1K3PV1BS
	3cnDNEci+myp7K+jeVWG3lGzagTYUVwZkPFbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A752A997F;
	Mon, 25 Jun 2012 18:33:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 137E5997E; Mon, 25 Jun 2012
 18:33:33 -0400 (EDT)
In-Reply-To: <201206241747.06525.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sun, 24 Jun 2012 17:47:05
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC50E5FE-BF15-11E1-9DAB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200601>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The problem:

As to the log message, I've rewritten it a bit by reordering
paragraphs and cutting redundant sentences. For exact wording nits,
please check 'pu' when I finish today's integration cycle and push
the results out, but I'll justify the reasoning behind my rewrite
here.

> Mac OS X may manipulate file names containing unicode on file systems
> HFS+, VFAT or SAMBA.
>
> When a file using unicode code points outside ASCII is created on a H=
=46S+ drive,
> the file name is converted into decomposed unicode and written to dis=
k.
> No conversion is done if the file name is already decomposed unicode.

I do not think it matters very much if it is written decomposed
(HFS+) or precomposed (VFAT). The important glitch that affects us
is that readdir(3) on Mac OS X gives the readers decomposed form,
unless over NFS, and the important saving grace that your patch
exploits is that stat/open/etc. will take either form and name the
same file.  So I tried to minimize the description on how it is
written to disk in my rewrite.

> The unicode decomposition creates some problems:
> - "git add" needs the decomposed form on the command line,
>   so that the file name is picked up when readdir() is called
>   to build a list of files on disk.
> - The decomposed form is not (easily) available on the keyboard.
>   To work around this, a wildcard could be used in "git add":
>   Instead of using "git add M=C3=A4rchen.txt" the user needs to enter
>   "git add M*rchen", "git add M<TAB>" or "git add *".
> - "git log", "git mv" and all other commands needs the decomposed for=
m
>   to find the file name which is stored as decomposed in the index.
> - The file names are stored in decomposed unicode in the index, but
>   precomposed on disk.
>     This makes it impossible to use this repository under e.g.
>     Linux or Windows:
>     All files appear to be deleted in the decomposed form and
>     untracked in the precomposed form.

I do not think "workaround" deserves a mention; presense of mixture
of precomposed and decomposed forms is the root cause of the
problem, and even if we prefer to use precomposed form (for
interoperability if nothing else), the "workaround" to force more
decomposed input will make the problem worse, not better.

> Knowing that Mac OS X writes file names as precomposed to disk,

Again, how it writes is not important; readdir(3) giving us what is
different from what we used for creat(2) is.

> The argv[] conversion allows to use the TAB filename completion done =
by the
> shell on command line.

Yes, this is exactly why "workaround" is not a workaround, but is
yet another problem.

> When creating a new git repository with "git init" or "git clone",
> "core.precomposedunicode" will be set "false".
>
> The user needs to activate this feature manually.
> She typically sets core.precomposedunicode to "true" on HFS and VFAT,
> or file systems mounted via SAMBA onto a Linux box.

This we might want to change it in a couple of cycles after this
feature hits 'next' and people gain experience with it.

I think the reason to choose the safer "false" default is to keep
the behaviours between an old repository on Mac OS X and a new
repository cloned from it also on Mac OS X the same, but if we can
detect that the filesystem is broken, and have a code to work around
the breakage, I think the longer term direction would be to set it
to ensure that the resulting history records paths consistently in
precomposed form (another choice might be to normalize to decomposed
form, but my understanding is that it would not help anybody, as
nobody other than Mac OS X uses it).

Thanks.
