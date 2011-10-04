From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v3 3/4] enter_repo: do not modify input
Date: Tue, 4 Oct 2011 13:55:27 -0400
Message-ID: <CABURp0qDsxHwsuyvB6-KvKPrKuUT0-Fpr730TD_TxxFY7fotpA@mail.gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com> <1317329963-6656-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	gitster@pobox.com, rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 19:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB9Df-0003JF-RT
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 19:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232Ab1JDRzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 13:55:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50401 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab1JDRzs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 13:55:48 -0400
Received: by wyg34 with SMTP id 34so831474wyg.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x5Hx7X25Pp09wem4LXdz5PklqnNNiajVx85v8eKOHQ0=;
        b=W+qTP/DjCQSKjk6znEHRGPxdd3wWJfJ1EH/zK7K5FqB4ANOAkOPfJA23vYT1N5ornJ
         nxe/4dsO6scFa5/Pp8A/ZYZv3tme6vJuLyYts0N4rXETjTED4gtWY6fWWpO5O0lPeT/+
         okVhMsGNnCcObuT0TWLlDCsYnlUqjKe3oMDdE=
Received: by 10.216.159.12 with SMTP id r12mr5831064wek.87.1317750947147; Tue,
 04 Oct 2011 10:55:47 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 10:55:27 -0700 (PDT)
In-Reply-To: <1317329963-6656-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182782>

On Thu, Sep 29, 2011 at 4:59 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> entr_repo(..., 0) currently modifies the input to strip away
> trailing slashes. This means that we some times need to copy the
> input to keep the original.

I'm also modifying enter_repo() so I'm looking a bit closer at this pat=
ch now.

> Change it to unconditionally copy it into the used_path buffer so
> we can safely use the input without having to copy it.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
[...]
> =A0*/
> -char *enter_repo(char *path, int strict)
> +const char *enter_repo(const char *path, int strict)
> =A0{
> =A0 =A0 =A0 =A0static char used_path[PATH_MAX];
> =A0 =A0 =A0 =A0static char validated_path[PATH_MAX];
> @@ -297,14 +297,15 @@ char *enter_repo(char *path, int strict)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len =3D strlen(path);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int i;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((1 < len) && (path[len-1] =3D=3D=
 '/')) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path[len-1] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((1 < len) && (path[len-1] =3D=3D=
 '/'))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (PATH_MAX <=3D len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (path[0] =3D=3D '~') {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *newpath =3D expan=
d_user_path(path);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(used_path, path, len);

When len < strlen(path), this will will leave used_path unterminated.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (used_path[0] =3D=3D '~') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *newpath =3D expan=
d_user_path(used_path);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!newpath || (PATH_=
MAX - 10 < strlen(newpath))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(n=
ewpath);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 NULL;
> @@ -316,24 +317,21 @@ char *enter_repo(char *path, int strict)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * anyway.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(used_path, newp=
ath); free(newpath);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(validated_path, =
path);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path =3D used_path;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcpy(validated_path, =
used_path);

The point of 'validated_path' is to keep the original unmolested,
unexpanded path string (plus DWIM suffix), but here you've just
replaced validated_path with a copy of the expanded_user_path.  On the
other hand, we seem always to strcpy(validated_path , path), so we
might as well get that done up-front.

I'll re-roll these changes in in a minute.  Stand by.

Phil
