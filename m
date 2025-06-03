Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B12213237
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992058; cv=none; b=Xkiqx+bTw7DTv6ipupiwgvnRVYdXQqACmE8pP99ue1k//JZK1QwFvVbmVEdTa8tymLpOlLOP1AwztPBTT5WXb3Ni10FtXYBFOXqkI3oYu0MTMgAwu9K7zfhaS0fOlc7p6NrPHRcdg7ktiTOpEJ+ipZXyyE+YAc/uWSbaJ3s4hHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992058; c=relaxed/simple;
	bh=fDXKMI6SWD36dC6XHKaonI2NQ19yu2v8gr9jEa/7Rp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw4PABhlrzeQTNTEJHq6CLMcMfuIbustSeRHfcecmFRXk7YBEKVaOdtuJpHT+HyJaUnHNLNxBN+0Uc34mTFo48sqGsXQ+4GKX52593DaIgV0/ZqWZH27A5BaYQhJaCD8mchrWU55GJIFgbMfDVN6zO7zOKiKfRgp3OLnirnwPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1uMajF-001FHd-0t;
	Tue, 03 Jun 2025 23:07:33 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1uMaj8-009kGN-2q;
	Wed, 04 Jun 2025 08:07:26 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/4] Fix comma warnings with clang on Windows
Date: Wed,  4 Jun 2025 08:06:45 +0900
Message-ID: <20250603230646.2322671-3-mh@glandium.org>
X-Mailer: git-send-email 2.50.0.rc1.593.g042f21cb9b
In-Reply-To: <20250603230646.2322671-1-mh@glandium.org>
References: <20250603230646.2322671-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e.g.
```
  compat/mingw.c:723:24: error: possible misuse of comma operator here [-Werror,-Wcomma]
    723 |                 return errno = ENOSYS, -1;
        |                                      ^
  compat/mingw.c:723:10: note: cast expression to void to silence warning
    723 |                 return errno = ENOSYS, -1;
        |                        ^~~~~~~~~~~~~~
        |                        (void)(       )
  /usr/x86_64-w64-mingw32/include/stdlib.h:155:15: note: expanded from macro 'errno'
    155 | #define errno (*_errno())
        |               ^
```

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 compat/mingw.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8a9972a1ca..cd54937ebd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -501,8 +501,10 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	DWORD create = (oflags & O_CREAT) ? OPEN_ALWAYS : OPEN_EXISTING;
 
 	/* only these flags are supported */
-	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
-		return errno = ENOSYS, -1;
+	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
+		errno = ENOSYS;
+		return -1;
+	}
 
 	/*
 	 * FILE_SHARE_WRITE is required to permit child processes
@@ -2497,12 +2499,14 @@ static int start_timer_thread(void)
 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
 	if (timer_event) {
 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
-		if (!timer_thread )
-			return errno = ENOMEM,
-				error("cannot start timer thread");
-	} else
-		return errno = ENOMEM,
-			error("cannot allocate resources for timer");
+		if (!timer_thread) {
+			errno = ENOMEM;
+			return error("cannot start timer thread");
+		}
+	} else {
+		errno = ENOMEM;
+		return error("cannot allocate resources for timer");
+	}
 	return 0;
 }
 
@@ -2535,13 +2539,15 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 	static const struct timeval zero;
 	static int atexit_done;
 
-	if (out)
-		return errno = EINVAL,
-			error("setitimer param 3 != NULL not implemented");
+	if (out) {
+		errno = EINVAL;
+		return error("setitimer param 3 != NULL not implemented");
+	}
 	if (!is_timeval_eq(&in->it_interval, &zero) &&
-	    !is_timeval_eq(&in->it_interval, &in->it_value))
-		return errno = EINVAL,
-			error("setitimer: it_interval must be zero or eq it_value");
+	    !is_timeval_eq(&in->it_interval, &in->it_value)) {
+		errno = EINVAL;
+		return error("setitimer: it_interval must be zero or eq it_value");
+	}
 
 	if (timer_thread)
 		stop_timer_thread();
@@ -2561,12 +2567,14 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 
 int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
-	if (sig != SIGALRM)
-		return errno = EINVAL,
-			error("sigaction only implemented for SIGALRM");
-	if (out)
-		return errno = EINVAL,
-			error("sigaction: param 3 != NULL not implemented");
+	if (sig != SIGALRM) {
+		errno = EINVAL;
+		return error("sigaction only implemented for SIGALRM");
+	}
+	if (out) {
+		errno = EINVAL;
+		return error("sigaction: param 3 != NULL not implemented");
+	}
 
 	timer_fn = in->sa_handler;
 	return 0;
-- 
2.50.0.rc1.593.g042f21cb9b

