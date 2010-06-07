From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Mon, 7 Jun 2010 16:00:18 +0200
Message-ID: <AANLkTimd_l0uKHTqgS211fv30hxd-k0pR55YoY4xCua1@mail.gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com>
	<1275658871-1473-2-git-send-email-artagnon@gmail.com>
	<20100604182928.GB20909@progeny.tock>
	<AANLkTimzuJXjX4OJUkmQtLwjGDgHBaZUHSGA0xUUi6kY@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 16:00:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcsO-0000qw-5U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 16:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab0FGOAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 10:00:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45098 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0FGOAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 10:00:20 -0400
Received: by fxm8 with SMTP id 8so2096048fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Snu+V5BCaV7qpivEmKJhYqdHUjuNvQksCrnvZTi30HI=;
        b=EsFQCdm3JFrtcmAMKP0zY/Dcm2HZR0mOLmRenlPhh7TszV9Eck7e3URiHAX1zX9dXJ
         HKx17RaNkFmCRRjt1QgPMEgZfyZABPvSYgrdDSdQv4HeAmIsyoTCbPTHr5/THxdlJxrS
         MJiL7LMtpeBfuPG8Zn22f835fzQXIjE2zFYQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=jdq8aDAed8T91bY5F5Khk6riASO4LhuOJEXLKLP4a0T7ZYmN17LrgGPEzhUKVv2rZB
         karpRmFuM5FvnrxiA4G1dDF+RI3NbK3PAvsEAC/fkdA/OKpZWc2iTaXn5QYLoydI/FPf
         iCRJPnbPbvezSLZegLBnns+ffqAqMBuiVMhWM=
Received: by 10.204.81.225 with SMTP id y33mr2091844bkk.150.1275919218231; 
	Mon, 07 Jun 2010 07:00:18 -0700 (PDT)
Received: by 10.204.57.195 with HTTP; Mon, 7 Jun 2010 07:00:18 -0700 (PDT)
In-Reply-To: <AANLkTimzuJXjX4OJUkmQtLwjGDgHBaZUHSGA0xUUi6kY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148598>

On Mon, Jun 7, 2010 at 3:28 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
>> Probably an ignorant question, but why? =A0I do not think the win32 =
mmap
>> emulation in git currently supports sysconf().
>
> I'm not sure why the pool capacity should be dependent on the page si=
ze.
>

My guess would be that it's a performance-thing.

Adding a win32-implementation of sysconf for this purpose isn't
tricky, but perhaps it's a little bit overkill. Can't we just use some
large power of two number? Hopefully, we could chose a size that is a
multiple of the page-size on all systems...

Anyway, this is roughly what a Windows-implementation of sysconf would
look like (not tested - only checked that it compiles):

diff --git a/compat/mingw.c b/compat/mingw.c
index f90a114..526f0f9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1473,3 +1473,13 @@ struct dirent *mingw_readdir(DIR *dir)
 	return (struct dirent*)&dir->dd_dir;
 }
 #endif // !NO_MINGW_REPLACE_READDIR
+
+long mingw_sysconf(int name)
+{
+	SYSTEM_INFO si;
+	if (name !=3D _SC_PAGESIZE)
+		return errno =3D EINVAL,
+		    error("sysconf emulation only supports _SC_PAGESIZE");
+	GetSystemInfo(&si);
+	return si.dwPageSize;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 6c6cbda..db28b0d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -322,3 +322,7 @@ struct dirent *mingw_readdir(DIR *dir);
  * Used by Pthread API implementation for Windows
  */
 extern int err_win_to_posix(DWORD winerr);
+
+#define _SC_PAGESIZE 0
+long mingw_sysconf(int name);
+#define sysconf mingw_sysconf

--=20
Erik "kusma" Faye-Lund
