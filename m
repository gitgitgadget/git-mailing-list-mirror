From: David Turner <dturner@twopensource.com>
Subject: [PATCH 12/19] read-cache: allow index-helper to prepare shm before git reads it
Date: Wed,  9 Mar 2016 13:36:15 -0500
Message-ID: <1457548582-28302-13-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiyt-0007PD-DH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933870AbcCIShJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:37:09 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35787 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933831AbcCISgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:45 -0500
Received: by mail-qk0-f169.google.com with SMTP id o6so24104702qkc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hvguxj1nTz7dO01d5+Wol+vHiPLiq47FEE74UYnhw7U=;
        b=Ctbp/BbaMiHn3mJ0vps2YDNV5P/ddcnG2to68lh9CXRs3GtuSkPQXispMfcV3LgX8U
         X8QUgRFDCWp3GDedjrkfUGVILQ1YHRxkIx7cMnLkO2FFMIG0L44doKcklqWb6ZlptwSf
         x/I0B3GvT9Rk47kCdAX3t1dxFcvvjJ1LmeWixb/ZEAKmGbjQm6P5Y7Z06JS1bzfj/iuJ
         oVTczYLSEsb6xvOdIRUcEIEryqM7JBYkXeLpfNZg1xzSMEJpuzQ9jpxYCH8LAU+dCXsM
         ID1gLFzMe2X7z2ieZZ1GirZTzNa2v7ryV5eAH6DiMM9F98wa/lO34/ocvPq40+b3s+0d
         bGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hvguxj1nTz7dO01d5+Wol+vHiPLiq47FEE74UYnhw7U=;
        b=gVRqu3nMf9R0sntaNAHycyNC/lj3QKFT4dShzB0HP97gxapgmsN+Hgcccr6OVLHpM1
         Pj52QOoKtQ/CxGCxR+e9/1LvP14wN7jO1C/FKV/Ip+R3hDic7WLyS3SUidnc+zKo72+u
         bCwFYpRGb6lF1jJ8TM2Fgn/XvH2gg1yD8F49AUdEtAXPQHQ/sR1q4nAE27vSw34k5JhD
         G1PGDZD8bHK3ZzbGf4LXHyVrHpAmWAMotwZvohmR68cktmkX4phUkL6PG+iAlCk6XMYi
         IxbBxixSvCrlYeODEJshmo10i2lEO1dSYDTC55EM0b49n/fDtVBeV5pWfrJbW43CR0Dj
         N1zw==
X-Gm-Message-State: AD7BkJJ1wEuAcYtEWQu6iEHcTaoDuWd6mPzCqw3Zw9qH4PemQNXO0AVQuUvAEhLTyhqwsg==
X-Received: by 10.55.26.86 with SMTP id a83mr43942044qka.79.1457548604217;
        Wed, 09 Mar 2016 10:36:44 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288558>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

If index-helper puts 'W' before pid in $GIT_DIR/index-helper.pid, then
git will sleep for a while, expecting to be waken up by SIGUSR1 when
index-helper has done shm preparation, or after the timeout.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 85ef15b..57c5df9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1613,14 +1613,46 @@ static void do_poke(struct strbuf *sb, int refr=
esh_cache)
 	PostMessage(hwnd, refresh_cache ? WM_USER : WM_USER + 1, 0, 0);
 }
 #else
+
+static volatile int done_sleeping;
+
+static void mark_done_sleeping(int sig)
+{
+	done_sleeping =3D 1;
+}
+
+/*
+ * Send a message to the index-helper to let it know that we're going
+ * to read the index.  If refresh_cache is true, then the index-helper
+ * should re-read the index; otherwise, it should just stay alive.
+ *
+ * If the index-helper supports watchman, it will refresh the index
+ * before it hands it over.  Wait up to one second for a response
+ * indicating that the index has been successfully refreshed.
+ *
+ */
 static void do_poke(struct strbuf *sb, int refresh_cache)
 {
-	char	*start =3D sb->buf;
+	int	 wait  =3D sb->buf[0] =3D=3D 'W';
+	char	*start =3D wait ? sb->buf + 1 : sb->buf;
 	char	*end   =3D NULL;
 	pid_t	 pid   =3D strtoul(start, &end, 10);
+	int	 ret;
+	int	 count =3D 0;
+
+	done_sleeping =3D 0;
 	if (!end || end !=3D sb->buf + sb->len)
 		return;
-	kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+	if (!refresh_cache && wait)
+		signal(SIGHUP, mark_done_sleeping);
+	ret =3D kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+	if (!refresh_cache && wait) {
+		if (!ret)
+			while (!done_sleeping && count++ < 1000)
+				sleep_millisec(1);
+
+		sigaction(SIGHUP, NULL, NULL);
+	}
 }
 #endif
=20
--=20
2.4.2.767.g62658d5-twtrsrc
