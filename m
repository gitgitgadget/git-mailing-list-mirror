From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Prevent buffer overflows when path is too big
Date: Sat, 19 Oct 2013 12:52:34 +0200
Message-ID: <1382179954-5169-1-git-send-email-apelisse@gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBD3NZH6HQMJBBLOJRGJQKGQE5GN343A@googlegroups.com Sat Oct 19 12:53:36 2013
Return-path: <msysgit+bncBD3NZH6HQMJBBLOJRGJQKGQE5GN343A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f185.google.com ([209.85.215.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBBLOJRGJQKGQE5GN343A@googlegroups.com>)
	id 1VXUA2-0001a5-Q5
	for gcvm-msysgit@m.gmane.org; Sat, 19 Oct 2013 12:53:34 +0200
Received: by mail-ea0-f185.google.com with SMTP id k11sf441172eaj.12
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Oct 2013 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=a+DoFpNop0xaKonaCf7MgncZOzFZ7/3eDkLa20Nw+TQ=;
        b=dDY8lr95j9zUFKvpNScg77/Xe92NxiqvkEZUUJPMzT5vWcpD62nEfBj1i9r/Z0oFkn
         Cob7pckTMZMX793nPCxNHESaLftuRahh3fge6+jS51L0D2UmYYSLsU1vjT5xuCycHLrh
         JSDtSEjWyyQkhknrG66QdqPYbowmPfhz1c1vRZamPgAyo8HufSelkLAAFvFqGx5L5O7Q
         MAhX+iQ24a7eWayAXD9tcXLBUoFupOc+06GoHbXVKR17/evMxNzLy0gFLdJ1foMcDTyu
         S4TXPl5HFT/GU8n0xkpIr2xHtdKY1/6di1+Fgul/1IarufVB/POeMjaYj4AIoI35H4A3
         q9xQ==
X-Received: by 10.180.198.77 with SMTP id ja13mr39531wic.13.1382180014496;
        Sat, 19 Oct 2013 03:53:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.89.241 with SMTP id br17ls252335wib.19.gmail; Sat, 19 Oct
 2013 03:53:33 -0700 (PDT)
X-Received: by 10.204.237.6 with SMTP id km6mr1381936bkb.7.1382180013239;
        Sat, 19 Oct 2013 03:53:33 -0700 (PDT)
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com [2a00:1450:400c:c00::233])
        by gmr-mx.google.com with ESMTPS id c4si821726wie.1.2013.10.19.03.53.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 03:53:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:400c:c00::233 as permitted sender) client-ip=2a00:1450:400c:c00::233;
Received: by mail-wg0-f51.google.com with SMTP id l18so4688042wgh.6
        for <msysgit@googlegroups.com>; Sat, 19 Oct 2013 03:53:33 -0700 (PDT)
X-Received: by 10.180.104.34 with SMTP id gb2mr2801371wib.3.1382180012975;
        Sat, 19 Oct 2013 03:53:32 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id fr4sm35590385wib.0.2013.10.19.03.53.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Oct 2013 03:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.507.g9768648.dirty
In-Reply-To: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:400c:c00::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236395>

Currently, most buffers created with PATH_MAX length, are not checked
when being written, and can overflow if PATH_MAX is not big enough to
hold the path.

Fix that by using strlcpy() where strcpy() was used, and also run some
extra checks when copy is done with memcpy().

Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 abspath.c        | 10 +++++++---
 diffcore-order.c |  2 +-
 entry.c          | 14 ++++++++++----
 unpack-trees.c   |  2 ++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/abspath.c b/abspath.c
index 64adbe2..0e60ba4 100644
--- a/abspath.c
+++ b/abspath.c
@@ -216,11 +216,15 @@ const char *absolute_path(const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
+
+	if (pfx_len > PATH_MAX)
+		die("Too long prefix path: %s", pfx);
+
 #ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
+	strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len);
 #else
 	char *p;
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
@@ -228,8 +232,8 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 		pfx_len = 0;
 	else if (pfx_len)
 		memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
-	for (p = path + pfx_len; *p; p++)
+	strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len);
+	for (p = path + pfx_len; p < path + PATH_MAX && *p; p++)
 		if (*p == '\\')
 			*p = '/';
 #endif
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..f083c82 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -76,7 +76,7 @@ static int match_order(const char *path)
 	char p[PATH_MAX];
 
 	for (i = 0; i < order_cnt; i++) {
-		strcpy(p, path);
+		strlcpy(p, path, PATH_MAX);
 		while (p[0]) {
 			char *cp;
 			if (!fnmatch(order[i], p, 0))
diff --git a/entry.c b/entry.c
index acc892f..39bee42 100644
--- a/entry.c
+++ b/entry.c
@@ -50,17 +50,20 @@ static void remove_subtree(const char *path)
 	struct dirent *de;
 	char pathbuf[PATH_MAX];
 	char *name;
+	size_t pathlen;
 
 	if (!dir)
 		die_errno("cannot opendir '%s'", path);
-	strcpy(pathbuf, path);
-	name = pathbuf + strlen(path);
+	strlcpy(pathbuf, path, PATH_MAX);
+	pathlen = strlen(path);
+	name = pathbuf + pathlen;
 	*name++ = '/';
+	pathlen++;
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
-		strcpy(name, de->d_name);
+		strlcpy(name, de->d_name, PATH_MAX - pathlen);
 		if (lstat(pathbuf, &st))
 			die_errno("cannot lstat '%s'", pathbuf);
 		if (S_ISDIR(st.st_mode))
@@ -244,8 +247,11 @@ int checkout_entry(struct cache_entry *ce,
 	if (topath)
 		return write_entry(ce, topath, state, 1);
 
+	if (len > PATH_MAX + 1)
+		die("Too long path: %s", state->base_dir);
+
 	memcpy(path, state->base_dir, len);
-	strcpy(path + len, ce->name);
+	strlcpy(path + len, ce->name, PATH_MAX + 1 - len);
 	len += ce_namelen(ce);
 
 	if (!check_path(path, len, &st, state->base_dir_len)) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 1a61e6f..85473b1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -918,6 +918,8 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			int processed;
 
 			len = slash - name;
+			if (len + prefix_len >= PATH_MAX)
+				len = PATH_MAX - prefix_len - 1;
 			memcpy(prefix + prefix_len, name, len);
 
 			/*
-- 
1.8.4.1.507.g9768648.dirty

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
