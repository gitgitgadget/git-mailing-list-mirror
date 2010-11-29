From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Mon, 29 Nov 2010 15:09:11 -0200
Message-ID: <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@apple.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 18:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7E6-0000Q2-12
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab0K2RJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 12:09:13 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51376 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0K2RJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 12:09:12 -0500
Received: by ywl5 with SMTP id 5so2152996ywl.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=72BFk85CP002mJgvyZNPE5FGFjBorRjtUjCtb9qNe+4=;
        b=NOdJRqNW/p2uPWmO92gjb9n5/QIlpdWvgrrZqoCB8BRXA5AVHq1Mf1a7D0JI9j0PE1
         MVUfx4zGP2hfQej1lrZ8voO9zvMMoM23+h8/IqwW+lv9vnfudNJT1ZcrHzBPq+gxMclv
         aLBIvd3kuEFh08s9AXPAjjq43Dm2sDeNnF86Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gJHdAzsbD6LdBupiHc/v/aRFUIJLiMqctxk2rxFiVAudIkJYAjLZ6Iulmgdw/64Cj+
         sv+38N1o55UtHs18ywmVTjycFU5pwhwXHFyFuXT6c9AygkEMCCaFSDpiKZoG5Kw3jNPc
         Qy7pDxWX4zMafTG1dimU0MVS5NQ94OdhYAGqY=
Received: by 10.204.59.81 with SMTP id k17mr4855749bkh.148.1291050551434; Mon,
 29 Nov 2010 09:09:11 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Mon, 29 Nov 2010 09:09:11 -0800 (PST)
In-Reply-To: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162404>

On Mon, Nov 29, 2010 at 2:57 PM, Jeremy Huddleston <jeremyhu@apple.com>=
 wrote:
>
> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
> Reviewed-by: Matt Wright <mww@apple.com>
> ---
> =C2=A0exec_cmd.c | =C2=A0 17 +++++++++++++++++
> =C2=A01 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index bf22570..1e24a8f 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -3,6 +3,10 @@
> =C2=A0#include "quote.h"
> =C2=A0#define MAX_ARGS =C2=A0 =C2=A0 =C2=A0 32
>
> +#if defined(__APPLE__) && defined(RUNTIME_PREFIX)
> +#include <mach-o/dyld.h>
> +#endif
> +
> =C2=A0extern char **environ;
> =C2=A0static const char *argv_exec_path;
> =C2=A0static const char *argv0_path;
> @@ -53,6 +57,19 @@ const char *git_extract_argv0_path(const char *arg=
v0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (slash >=3D argv0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv0_path =3D=
 xstrndup(argv0, slash - argv0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return slash +=
 1;
> +#ifdef __APPLE__

Why not #if defined(__APPLE__), like above?
