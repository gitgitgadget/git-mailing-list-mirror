From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Wed, 3 Nov 2010 23:39:34 +0100
Message-ID: <AANLkTin6120QbxyxHt=UM9Dpk_3C-vaD2z8RaRuut76r@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
 <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:40:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDlzs-0004bm-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab0KCWj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 18:39:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51963 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab0KCWjz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 18:39:55 -0400
Received: by fxm16 with SMTP id 16so969038fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=t1XLPjdS0p/1BiLUlRvT9yYQy3TtGKoTNcMnsFr2nQ4=;
        b=KuMwfTIc4vqgVEB+Qhydpv1u6xLLniuU9nWRd3xzbo6b7U0X6zDiElsukoSupldgmp
         13B2N13Gv9IzSsNr1gpQdoVDLLo5HNyLknLDG0GDZuDOwaZzFYqBorszg9qRqshwRzGa
         e55MiLzyUj0izF2tYFL2KBtCcmQHhNfAh9SpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=rN+PDKpYU0CBbIgS80NsSAatgwNOCrz5oEC0uXitzDNHcN2gkn8f8SfiAfoY46TsyH
         4gwzRAwtVIe8LgSuGqJocHs60VWT9NyklnrL25/RuzChG3Abkt+qejhYU8xCBsW+Sy9q
         XEK1G3eO6SxrgkrLJfhBsZ+9ksy6Ayzcpt/Rg=
Received: by 10.223.83.133 with SMTP id f5mr8544328fal.29.1288823994696; Wed,
 03 Nov 2010 15:39:54 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 15:39:34 -0700 (PDT)
In-Reply-To: <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160647>

On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> Ah, thanks. For me it's leaking a variable amount of handles per
> ls-remote, but if I apply the following patch it's down to one. Need
> to find that one as well...
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index b780200..47e7d26 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1519,8 +1519,10 @@ pid_t waitpid(pid_t pid, int *status, unsigned=
 options)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect((HANDLE)pid, 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleObj=
ect((HANDLE)pid, 0)) {

AAAND the last one is right here as well:
-		if (WAIT_OBJECT_0 !=3D WaitForSingleObject((HANDLE)pid, 0))
+		if (WAIT_OBJECT_0 !=3D WaitForSingleObject(h, 0)) {
