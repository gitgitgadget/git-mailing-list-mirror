From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 20:07:44 +0200
Message-ID: <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7lc-0002iR-NL
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934047Ab1ESSPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 14:15:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51258 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934095Ab1ESSPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 14:15:45 -0400
Received: by pwi15 with SMTP id 15so1345418pwi.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GEEi/Y0EKSUAZp1gJIkuYcc1jqRorvW0FEB4xTwHe2Y=;
        b=U6VJuYR73NWxjds9NsM/nC/IUZOXBpwXAAN9JYjTir7ZGnEUyWE+ksuIUTHol2p5DB
         PxfNyJefgpwMs3kqKX72p/1GCekf5HTaBW5i1XNnXBSPerSsTw6O6uzcYRVwI2Gvd5oB
         0V66eaaZfKSqtzBpnZxnkpUhWgxox8z0wCTs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=tLpteRVl9UTny53Zh93105O1y7AjW+nc6/yUKDduQ5NZ9uOPNIJk42rBjrNiEe6nlN
         pzgh451NBOsvXwj0zIHjoEpp7MYseE1YO36jd5mNnWAE1nUX91lAkdAhUnuF36Tcqcgt
         bIhhb6hnWC6y6efs09fLk/FnLj17K72xEpQwQ=
Received: by 10.68.20.163 with SMTP id o3mr5479419pbe.366.1305828484034; Thu,
 19 May 2011 11:08:04 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 11:07:44 -0700 (PDT)
In-Reply-To: <7v62p68ut0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173987>

On Thu, May 19, 2011 at 7:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Rafael Gieschke <rafael@gieschke.de> writes:
>
>>> Windows doesn't have /dev/tty, but the logic in this version handle=
s
>>> that by using stdin/stderr instead. The signal-stuff has a comment
>>> that indicates it might not even be correct. tcgetattr/tcsetattr is=
n't
>>> supported on Windows, but it's not needed if we use getch (as the
>>> version in compat/mingw.c does). POSIX/curses getch respects the
>>> echo-setting, while Windows getch never echo.
>
> Probably a properly abstracted common version would look like a funct=
ion
> that calls four platform-dependent helper funcions in this order:
>
> =A0 =A0 =A0 =A00. prompt
> =A0 =A0 =A0 =A01. start "noecho" mode
> =A0 =A0 =A0 =A02. get whole line
> =A0 =A0 =A0 =A03. exit "noecho" mode
>
> where Windows may use stderr for 0, have noop() implementation for 1 =
and
> 3, use _getch() that does not echo for 2, while POSIX may write to
> /dev/tty for 0, use tc[gs]etattr() with perhaps some signal settings
> sprinkled in for 1 and 3.
>
> So I don't see a need for Windows to emulate tc[g]setattr nor curses =
in
> order to get a generic getpass() abstraction between two platforms.
>

When I think about it a bit more, it feels a bit pointless:
0. is identical (fputs)
1. is different (tc[gs]etattr vs nop)
2. is different (getc vs _getch)
3. is different (tcsetattr vs nop)

So there's probably not much code to share here. There's a bit of
logic, but I'm not entirely sure this should be the same either,
because on Windows we have to take care of '\r' (since we open stdin
in binary mode at start-up).

But looking at the implementations, there's one thing that strike me:
both the netbsd and uclibc implementations fill a static buffer, while
our windows-version returns an allocated buffer. Reading POSIX, it's
not entirely clear if the returned pointer should be free'd or not:
http://pubs.opengroup.org/onlinepubs/007908799/xsh/getpass.html

But there is a hint: the limit of PASS_MAX bytes indicate that the
buffer is expected to be statically allocated. So perhaps we should do
this to prevent a leak?

diff --git a/compat/mingw.c b/compat/mingw.c
index 878b1de..dba3e64 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1668,17 +1668,19 @@ int link(const char *oldpath, const char *newpa=
th)

 char *getpass(const char *prompt)
 {
-	struct strbuf buf =3D STRBUF_INIT;
+	static char buf[PASS_MAX];
+	int i;

 	fputs(prompt, stderr);
-	for (;;) {
+	for (i =3D 0; i < PASS_MAX - 1; ++i) {
 		char c =3D _getch();
 		if (c =3D=3D '\r' || c =3D=3D '\n')
 			break;
-		strbuf_addch(&buf, c);
+		buf[i] =3D c;
 	}
+	buf[i] =3D '\0';
 	fputs("\n", stderr);
-	return strbuf_detach(&buf, NULL);
+	return buf;
 }

 pid_t waitpid(pid_t pid, int *status, unsigned options)
diff --git a/compat/mingw.h b/compat/mingw.h
index 62eccd3..e37d557 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -48,6 +48,8 @@ typedef int socklen_t;
 #define EAFNOSUPPORT WSAEAFNOSUPPORT
 #define ECONNABORTED WSAECONNABORTED

+#define PASS_MAX 512
+
 struct passwd {
 	char *pw_name;
 	char *pw_gecos;
