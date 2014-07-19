From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use xcalloc() to allocate zero-initialized memory
Date: Sat, 19 Jul 2014 15:56:26 +0200
Message-ID: <53CA790A.20402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 15:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8V88-0007pM-0w
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 15:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbaGSN4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 09:56:48 -0400
Received: from mout.web.de ([212.227.15.3]:51862 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbaGSN4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 09:56:47 -0400
Received: from [192.168.178.27] ([79.253.155.202]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MHY0i-1X7OfG2QBA-003R6W; Sat, 19 Jul 2014 15:56:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:hiFQBi0XxhyxzaXGIiS1kCBsXDnynd4j5/4T2IC3Um7rbUa/xz3
 TUgZIB3UKkJzV9Bd5wvmrXtL+tB8xmjrDDQOoQzhJ0YHO5/BaRNHf3f0qimjOr0YhvVjsiK
 1neKv4BtrAiLXrM25XEkI8vKc6uiBzZPTaVQvN4IAQErhr1hto4MuArjCKcQ/a9xwfdPDwr
 KlbUAVjXpBaMFHJjvtapQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253880>

Use xcalloc() instead of xmalloc() followed by memset() to allocate
and zero out memory because it's shorter and avoids duplicating the
function parameters.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clean.c      | 3 +--
 builtin/index-pack.c | 3 +--
 compat/mingw.c       | 3 +--
 pathspec.c           | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 27701d2..1032563 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -621,8 +621,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 				nr += chosen[i];
 		}
 
-		result = xmalloc(sizeof(int) * (nr + 1));
-		memset(result, 0, sizeof(int) * (nr + 1));
+		result = xcalloc(nr + 1, sizeof(int));
 		for (i = 0; i < stuff->nr && j < nr; i++) {
 			if (chosen[i])
 				result[j++] = i;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fc40411..5568a5b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -362,8 +362,7 @@ static void set_thread_data(struct thread_local *data)
 
 static struct base_data *alloc_base_data(void)
 {
-	struct base_data *base = xmalloc(sizeof(struct base_data));
-	memset(base, 0, sizeof(*base));
+	struct base_data *base = xcalloc(1, sizeof(struct base_data));
 	base->ref_last = -1;
 	base->ofs_last = -1;
 	return base;
diff --git a/compat/mingw.c b/compat/mingw.c
index 3baaa4d..ed4c61c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1230,8 +1230,7 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 	else
 		ai->ai_canonname = NULL;
 
-	sin = xmalloc(ai->ai_addrlen);
-	memset(sin, 0, ai->ai_addrlen);
+	sin = xcalloc(1, ai->ai_addrlen);
 	sin->sin_family = AF_INET;
 	/* Note: getaddrinfo is supposed to allow service to be a string,
 	 * which should be looked up using getservbyname. This is
diff --git a/pathspec.c b/pathspec.c
index 89f2c8f..9304ee3 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -389,8 +389,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (!(flags & PATHSPEC_PREFER_CWD))
 			die("BUG: PATHSPEC_PREFER_CWD requires arguments");
 
-		pathspec->items = item = xmalloc(sizeof(*item));
-		memset(item, 0, sizeof(*item));
+		pathspec->items = item = xcalloc(1, sizeof(*item));
 		item->match = prefix;
 		item->original = prefix;
 		item->nowildcard_len = item->len = strlen(prefix);
-- 
2.0.2
