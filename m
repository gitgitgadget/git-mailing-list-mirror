From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 2/8] mingw: work around irregular failures of unlink on windows
Date: Tue, 14 Dec 2010 23:14:13 +0100
Message-ID: <AANLkTiksyVETuR8ftTojf=T2AhKGFtUAmqyj5u-00kW0@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <20101214221134.GC4084@sandbox>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSd94-000803-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab0LNWOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 17:14:36 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:33757 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758105Ab0LNWOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 17:14:35 -0500
Received: by fxm18 with SMTP id 18so1319044fxm.2
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 14:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Oh71pvXQ77oswaFGPEbfyZe7+E586ZZZiP32z/24uWo=;
        b=sACgGZSVaclis2Pp0SVUlSumY4fCsDqIrHEY18xnPU9FtWspeKMHfQH0I19Sa3FMRY
         p1gPtS2bkgGDxX99U3ShiMClXueNQI5TvJBjjNyePunAcOPfml9yRpsyK1H/tflO/BrF
         zmhu+JM+w0hypeoLcE6lKsxl1UMgwnHEW3guw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=X/eW8dVYx+4G1QD9ZWgsLuKTXcN1l2fPucOKx5X/94uh9USeR//7kp3yRxXpzNC/Cc
         LIbPJRyRJLL/ZPB3DVZvSLgTBDAWxAwjD9BR+QLBLWlF4Af4Z0ic1QLoFxjXUdmk471j
         AKSlQiw/82t+ZLG4Ebj0NOFVSxaW7+n/WQSXk=
Received: by 10.223.96.6 with SMTP id f6mr782662fan.132.1292364873803; Tue, 14
 Dec 2010 14:14:33 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Tue, 14 Dec 2010 14:14:13 -0800 (PST)
In-Reply-To: <20101214221134.GC4084@sandbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163695>

On Tue, Dec 14, 2010 at 11:11 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
> If a file is opened by another process (e.g. indexing of an IDE) for
> reading it is not allowed to be deleted. So in case unlink fails retr=
y
> after waiting for some time. This extends the workaround from 6ac6f87=
8.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> =A0compat/mingw.c | =A0 31 +++++++++++++++++++++++++++++--
> =A01 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a7e1c6b..52183a7 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -3,6 +3,8 @@
> =A0#include <conio.h>
> =A0#include "../strbuf.h"
>
> +static const int delay[] =3D { 0, 1, 10, 20, 40 };
> +
> =A0int err_win_to_posix(DWORD winerr)
> =A0{
> =A0 =A0 =A0 =A0int error =3D ENOSYS;
> @@ -116,12 +118,38 @@ int err_win_to_posix(DWORD winerr)
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> +static inline int is_file_in_use_error(DWORD errcode)
> +{
> + =A0 =A0 =A0 switch(GetLastError()) {

Why pass the error code in, just to ignore it? Shouldn't this switch
on "errcode" instead?
