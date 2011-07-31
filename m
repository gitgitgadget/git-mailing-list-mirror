From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout,
 --update-ref=<ref> support into porcelain.
Date: Sun, 31 Jul 2011 20:35:12 +0200
Message-ID: <CAP8UFD2uWRS4KznUAQCCF8sShGy6+sGWgNsLj8mmO7Ur1CDrCQ@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
	<1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 20:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnar8-000299-Rm
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 20:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1GaSfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 14:35:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41557 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1GaSfN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 14:35:13 -0400
Received: by gxk21 with SMTP id 21so3150107gxk.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8FTQFDpIiSfScL4EyedpRcQvi53p9zhnSISkOMLTAp4=;
        b=sAXB9tWdTZsuQqXUvbn4ZnXrxVfydJMktGFXfdnw/dl5cGaxWFtsadGqbNvW5ySsiT
         ZDMHrXgcIpZITd3cyU14VgmwF81u28bIyt8g/f6RqA1mWNnTs7tJj2uFLymf2iSBMxpG
         ClHMocN9gjVVCEfCb8AEmqZ1+cATqvOToLCzw=
Received: by 10.236.184.197 with SMTP id s45mr2442403yhm.157.1312137312123;
 Sun, 31 Jul 2011 11:35:12 -0700 (PDT)
Received: by 10.147.181.2 with HTTP; Sun, 31 Jul 2011 11:35:12 -0700 (PDT)
In-Reply-To: <1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178268>

On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
>
> @@ -69,13 +71,18 @@ bisect_start() {
> =A0 =A0 =A0 =A0orig_args=3D$(git rev-parse --sq-quote "$@")
> =A0 =A0 =A0 =A0bad_seen=3D0
> =A0 =A0 =A0 =A0eval=3D''
> + =A0 =A0 =A0 BISECT_UPDATE_REF=3D
> =A0 =A0 =A0 =A0while [ $# -gt 0 ]; do
> =A0 =A0 =A0 =A0 =A0 =A0arg=3D"$1"
> =A0 =A0 =A0 =A0 =A0 =A0case "$arg" in
> =A0 =A0 =A0 =A0 =A0 =A0--)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift; break ;;

Please don't change this. We try to avoid having many instructions on
the same line like this.

> + =A0 =A0 =A0 =A0 =A0 --no-checkout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BISECT_UPDATE_REF=3DHEAD; shift ;;

Perhaps:

                   test -z "$BISECT_UPDATE_REF" && BISECT_UPDATE_REF=3D=
HEAD

so that "--update-ref=3Dsomeref --no-checkout" works the same as
"--no-checkout --update-ref=3Dsomeref".

> + =A0 =A0 =A0 =A0 =A0 --update-ref=3D*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BISECT_UPDATE_REF=3D${arg#--update-ref=3D=
}; shift ;;
> + =A0 =A0 =A0 =A0 =A0 --*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(eval_gettext "unrecognised optio=
n: '\$arg'")" ;;
> =A0 =A0 =A0 =A0 =A0 =A0*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev=3D$(git rev-parse -q --verify "$ar=
g^{commit}") || {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0test $has_double_dash -eq 1 &&

Thanks,
Christian.
