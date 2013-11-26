From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Prevent buffer overflows when path is too long
Date: Tue, 26 Nov 2013 19:39:23 +0100
Message-ID: <1385491163-18407-1-git-send-email-apelisse@gmail.com>
References: <CACsJy8AooiUNRfnqDLBmx=KPnztjdNuF4bYY2b=Egs3gdiW6KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBD3NZH6HQMJBB2WV2OKAKGQEJNCC4DI@googlegroups.com Tue Nov 26 19:39:40 2013
Return-path: <msysgit+bncBD3NZH6HQMJBB2WV2OKAKGQEJNCC4DI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBB2WV2OKAKGQEJNCC4DI@googlegroups.com>)
	id 1VlNXv-0000k7-5q
	for gcvm-msysgit@m.gmane.org; Tue, 26 Nov 2013 19:39:39 +0100
Received: by mail-wg0-f55.google.com with SMTP id x13sf652470wgg.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 26 Nov 2013 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Do+yneVpF4Z4dyM8NvoMbKsbszpalHpbf2Vcb8VVJdQ=;
        b=YGnY/LNHlmFmRocwY2AoL1ISl1Y+Rn7atU8MUNsy0SudtXt0133XRwfKJVBkGQdRhd
         ei0z3J3eF3UWCpAGkh6HJhjsUmdBmlMpDmL9KlI9IkGZFGWiZujWAFsHyPnPCGPajkXP
         zBt05u2zxPXRoHEtNU1W9zM20wL5QVf2VbcjSjkOUQEjmS0vGVTxoCzmQx/B+OscEjGN
         Mdx7A4as137WM7NgJTNXXvIp5tylylP1dmDB3QRCAGa8z/GAZzFFvCj8FmvHHZZS7+t4
         qJIZS7eLxU3CIrr1ewyqznDoS5vmzKPg3t75yIwEZmhOHxRbFo0lT54ONh3fKyWipF88
         f0DA==
X-Received: by 10.180.75.170 with SMTP id d10mr149520wiw.11.1385491178844;
        Tue, 26 Nov 2013 10:39:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.72.206 with SMTP id f14ls719909wiv.47.canary; Tue, 26 Nov
 2013 10:39:37 -0800 (PST)
X-Received: by 10.180.126.2 with SMTP id mu2mr7920651wib.4.1385491177858;
        Tue, 26 Nov 2013 10:39:37 -0800 (PST)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id f7si1267414wib.1.2013.11.26.10.39.37
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 10:39:37 -0800 (PST)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:400c:c05::235 as permitted sender) client-ip=2a00:1450:400c:c05::235;
Received: by mail-wi0-f181.google.com with SMTP id hq4so6086836wib.8
        for <msysgit@googlegroups.com>; Tue, 26 Nov 2013 10:39:37 -0800 (PST)
X-Received: by 10.180.97.5 with SMTP id dw5mr19213336wib.42.1385491177772;
        Tue, 26 Nov 2013 10:39:37 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id je17sm62650543wic.4.2013.11.26.10.39.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 10:39:36 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc3.1.ga0b6b91
In-Reply-To: <CACsJy8AooiUNRfnqDLBmx=KPnztjdNuF4bYY2b=Egs3gdiW6KA@mail.gmail.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:400c:c05::235
 as permitted sender) smtp.mail=apelisse@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238386>

Some buffers created with PATH_MAX length are not checked when being
written, and can overflow if PATH_MAX is not big enough to hold the
path.

Some of the use-case are probably impossible to reach, and the program
dies if the path looks too long. When it would be possible for the user
to use a longer path, simply use strbuf to build it.

Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 abspath.c        | 10 ++++++++--
 diffcore-order.c | 14 +++++++++-----
 unpack-trees.c   |  2 ++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/abspath.c b/abspath.c
index e390994..29a5f9d 100644
--- a/abspath.c
+++ b/abspath.c
@@ -216,11 +216,16 @@ const char *absolute_path(const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
+
+	if (pfx_len >= PATH_MAX)
+		die("Too long prefix path: %s", pfx);
+
 #ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
+	if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX)
+		die("Too long path: %s", path);
 #else
 	char *p;
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
@@ -228,7 +233,8 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 		pfx_len = 0;
 	else if (pfx_len)
 		memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
+	if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX)
+		die("Too long path: %s", path);
 	for (p = path + pfx_len; *p; p++)
 		if (*p == '\\')
 			*p = '/';
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..87193f8 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -73,20 +73,24 @@ struct pair_order {
 static int match_order(const char *path)
 {
 	int i;
-	char p[PATH_MAX];
+	struct strbuf p = STRBUF_INIT;
 
 	for (i = 0; i < order_cnt; i++) {
-		strcpy(p, path);
-		while (p[0]) {
+		strbuf_reset(&p);
+		strbuf_addstr(&p, path);
+		while (p.buf[0]) {
 			char *cp;
-			if (!fnmatch(order[i], p, 0))
+			if (!fnmatch(order[i], p.buf, 0)) {
+				strbuf_release(&p);
 				return i;
-			cp = strrchr(p, '/');
+			}
+			cp = strrchr(p.buf, '/');
 			if (!cp)
 				break;
 			*cp = 0;
 		}
 	}
+	strbuf_release(&p);
 	return order_cnt;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 35cb05e..f93565b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -918,6 +918,8 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			int processed;
 
 			len = slash - name;
+			if (len + prefix_len >= PATH_MAX)
+				die("Too long path: %s", prefix);
 			memcpy(prefix + prefix_len, name, len);
 
 			/*
-- 
1.8.5.rc3.1.ga0b6b91

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
