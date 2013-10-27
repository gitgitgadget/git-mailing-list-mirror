From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] git clone: is an URL local or ssh
Date: Sun, 27 Oct 2013 14:31:24 -0400
Message-ID: <CAPig+cTCesnmj1z2H1ZkXAcRqZKQu-NLeLxfCYPYUZe45aadtQ@mail.gmail.com>
References: <201310262103.35770.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"pclouds@gmail.com" <pclouds@gmail.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 27 19:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaV7a-0001FV-A6
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 19:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab3J0Sb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Oct 2013 14:31:26 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:44654 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab3J0SbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Oct 2013 14:31:25 -0400
Received: by mail-la0-f54.google.com with SMTP id gx14so4557742lab.13
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=8pWy+sjcttiTH7iD7x0nRUheN7wtEfNkmSImQnG4v9A=;
        b=wArm7SuFeEh5O55XSfVK28k1R8al7Fuax1lIkY3tZwkpZI5jFdI3jcFVQ08JXIP0OB
         IrfUBAzFlZ/QwcUnkz/kfVya9Trz2y3zRkrDloMRFs3RH2fpyeefNiCfF+lvLg+DOsCH
         PKPLiX47drPfnNI6cTCH+TWJ90BdN/bR2Htgw2Ak1OlfOGVuB0cyDf4XWB45u2UCWprB
         91YNLs7vXP3/tKkj1VN6pzXrTvio9J/oAZwVMTIXzXyA5RvtFawAgzAxql95eaUvo4z4
         on6NRWGOm5fXYy2MWJCBjRuS5ANP/ghvVfk6ZYD5xFx4U2XDnWxidHdbnwmSQTaTtrh5
         xsOQ==
X-Received: by 10.152.42.139 with SMTP id o11mr4905212lal.16.1382898684158;
 Sun, 27 Oct 2013 11:31:24 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Sun, 27 Oct 2013 11:31:24 -0700 (PDT)
In-Reply-To: <201310262103.35770.tboegi@web.de>
X-Google-Sender-Auth: Ge5FfZUihEcF7iKtN-By2QS0_7k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236806>

On Saturday, October 26, 2013, Torsten B=F6gershausen wrote:
> diff --git a/connect.c b/connect.c
> index 06e88b0..903063e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -564,9 +574,9 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
>         char *url;
>         char *host, *path;
>         char *end;
> -       int c;
> +       int seperator;

s/seperator/separator/g

>         struct child_process *conn =3D &no_fork;
> -       enum protocol protocol =3D PROTO_LOCAL;
> +       enum protocol protocol =3D PROTO_LOCAL_OR_SSH;
>         int free_path =3D 0;
>         char *port =3D NULL;
>         const char **arg;
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 1d1c875..69af007 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -294,39 +294,93 @@ test_expect_success 'setup ssh wrapper' '
>         export TRASH_DIRECTORY
>  '
>
> -clear_ssh () {
> -       >"$TRASH_DIRECTORY/ssh-output"
> -}
> -
> -expect_ssh () {
> +i6501=3D0

Is this variable meant to be named after the test script t5601? If so:
s/i6501/i5601/g

> +# $1 url
> +# $2 none|host
> +# $3 path
> +test_clone_url () {
> +       i6501=3D$(($i6501 + 1))
> +       >"$TRASH_DIRECTORY/ssh-output" &&
> +       test_might_fail git clone "$1" tmp$i6501 &&
>         {
> -               case "$1" in
> +               case "$2" in
>                 none)
>                         ;;
>                 *)
> -                       echo "ssh: $1 git-upload-pack '$2'"
> +                       echo "ssh: $2 git-upload-pack '$3'"
>                 esac
>         } >"$TRASH_DIRECTORY/ssh-expect" &&
> -       (cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
> +       (cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output) && =
{
> +               rm -rf ssh-expect ssh-output
> +       }

Should the 'rm' be inside the (cd...) subshell? If not, are the braces
wrapping 'rm' needed, and wouldn't you want to prefix the paths with
$TRASH_DIRECTORY/?

>  }
>
> -test_expect_success 'cloning myhost:src uses ssh' '
> -       clear_ssh &&
> -       git clone myhost:src ssh-clone &&
> -       expect_ssh myhost src
> -'
