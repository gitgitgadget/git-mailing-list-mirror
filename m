From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] bash: don't declare 'local words' to make zsh happy
Date: Tue, 3 May 2011 20:53:15 +0300
Message-ID: <BANLkTimbLhkMRKLUBWhjg+oBtRwAEWGSqQ@mail.gmail.com>
References: <20110428160115.GA19003@goldbirke>
	<1304006513-19392-1-git-send-email-szeder@ira.uka.de>
	<1304006513-19392-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 03 19:54:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJna-0005i9-AK
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab1ECRxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 13:53:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44808 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1ECRxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 13:53:16 -0400
Received: by fxm17 with SMTP id 17so278033fxm.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WueTTurasvd8k42GguNPRKzhoe2oBbRZhd/h4OQbK54=;
        b=MwypGTVS7qzSBBq03Zm99n/YXYRS//gCWl49tMuq6HH44tFDhSNPIHOy4ke+uRa/Ob
         CzUw6rbg25BRpkv14CS2Lj6vJ7Bf62HCsxdxVEJQAiFJx0R59JGEbScpvj1cWRFNy5ZN
         Maf1fFzfzMXW8pr4bJBoFTpJOEa751JkyjL88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qi2t16w7guvZxNpSMZ3rtCPRfv7Xq/Um8MmBDdfByp+NmqdVMOwNQVlMLiJYjSpTHf
         Ddtvq7N8qtJnCeHSkHaK/KAMteQqmr4r3idbcVqxpeZv+vG0JWHG17a/vkM96mlSvuNh
         8p8bySI5olz3ppm7JeU8TGiZ7ZqLgErvxE53g=
Received: by 10.223.73.133 with SMTP id q5mr118543faj.127.1304445195101; Tue,
 03 May 2011 10:53:15 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 3 May 2011 10:53:15 -0700 (PDT)
In-Reply-To: <1304006513-19392-3-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172677>

On Thu, Apr 28, 2011 at 7:01 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> The "_get_comp_words_by_ref -n :=3D words" command from the
> bash_completion library reassembles a modified version of COMP_WORDS
> with ':' and '=3D' no longer treated as word separators and stores it=
 in
> the ${words[@]} array. =C2=A0Git's programmable tab completion script=
 uses
> this to abstract away the difference between bash v3's and bash v4's
> definitions of COMP_WORDS (bash v3 used shell words, while bash v4
> breaks at separator characters); see v1.7.4-rc0~11^2~2 (bash: get
> --pretty=3Dm<tab> completion to work with bash v4, 2010-12-02).
>
> zsh has (or rather its completion functions have) another idea about
> what ${words[@]} should contain: the array is prepopulated with the
> words from the command it is completing. =C2=A0For reasons that are n=
ot
> well understood, when git-completion.bash reserves its own "words"
> variable with "local words", the variable becomes empty and cannot be
> changed from then on. =C2=A0So the completion script neglects the arg=
uments
> it has seen, and words complete like git subcommand names. =C2=A0For
> example, typing "git log origi<TAB>" gives no completions because
> there are no "git origi..." commands.
>
> However, when this words variable is not declared as local but is jus=
t
> populated by _get_comp_words_by_ref() and then read in various
> completion functions, then zsh seems to be happy about it and our
> completion script works as expected.
>
> So, to get our completion script working again under zsh and to
> prevent the words variable from leaking into the shell environment
> under bash, we will only declare words as local when using bash.
>
> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
> Explained-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A08 ++++++-=
-
> =C2=A01 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 862b840..6869765 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2608,9 +2608,11 @@ _git ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if [[ -n ${ZSH_VERSION-} ]]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emulate -L bas=
h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setopt KSH_TYP=
ESET
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local words
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> - =C2=A0 =C2=A0 =C2=A0 local cur words cword prev
> + =C2=A0 =C2=A0 =C2=A0 local cur cword prev
> =C2=A0 =C2=A0 =C2=A0 =C2=A0_get_comp_words_by_ref -n =3D: cur words c=
word prev
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while [ $c -lt $cword ]; do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=3D"${words[c=
]}"
> @@ -2659,9 +2661,11 @@ _gitk ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if [[ -n ${ZSH_VERSION-} ]]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emulate -L bas=
h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setopt KSH_TYP=
ESET
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local words
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> - =C2=A0 =C2=A0 =C2=A0 local cur words cword prev
> + =C2=A0 =C2=A0 =C2=A0 local cur cword prev
> =C2=A0 =C2=A0 =C2=A0 =C2=A0_get_comp_words_by_ref -n =3D: cur words c=
word prev
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__git_has_doubledash && return
> --
> 1.7.5.86.g799a6

Here's another option:

=46rom 603e4db259283a4eb6bac2315a630480e3238f50 Mon Sep 17 00:00:00 200=
1
=46rom: Felipe Contreras <felipe.contreras@gmail.com>
Date: Tue, 3 May 2011 20:45:26 +0300
Subject: [PATCH] git-completion: fix zsh support

It turns out 'words' is a special variable used by zsh completion.

There's probably a bug in zsh's bashcompinit:
http://article.gmane.org/gmane.comp.shells.zsh.devel/22546

But in the meantime we can workaround it this way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 00691fc..d32b1b8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2608,6 +2608,9 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# 'words' has special meaning in zsh; override that
+		typeset -h words
 	fi

 	local cur words cword prev
--=20
1.7.5

--=20
=46elipe Contreras
