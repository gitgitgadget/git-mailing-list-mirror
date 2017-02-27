Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF2C1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbdB0Vd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:33:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:56119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdB0VdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:33:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaWlT-1c2Hdk1ejn-00mHqL; Mon, 27
 Feb 2017 22:31:39 +0100
Date:   Mon, 27 Feb 2017 22:31:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] Prepare for timestamps to use 64-bit signed types
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <d3bc8b3ad88e5d63c38b1eaa5054e6665d62d6d8.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1if7J3mQX1M6yV606ezBu+T6fx5iKRmBZ/lHc7ji4snf46esskG
 bZWNf1Rehl9rlz4At4pYRR6RKLHPVAYN8UVUnOClKvwS0YxJmq2gJftbTAT6YX6J1xATOzW
 TMVg6w1dl3/4mRq4rqtweOBxqvQt5LZBthw0KwXNBg3wOaChN27XFzcvyV4MeZ6fSRL+jws
 MMXNPyKvWq22sHIOupAwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ToNEREheKB4=:Y8KGitpCR+Q5grZIeXuNFS
 orcaK7gofns+YGg8F15KL/+b8gsQtxwaBrV3EDEVgXBvDEFFALi/kTkniw3nbbnkaz5Qln8HD
 RoM0ZFLdJMlU0HFoT2xsNl4xXbdYlHiyifOLfxvfODIRlHOFBigCvWP9qTZ9CalpXwwEf5wM7
 uSRvuk1i0phSiVRQDDXoA9tz4INOfriz05ujjSPEs/RkKEQGHpAUQyCXOizq1zji/L55aevoS
 3tOKumFSuBkzT9ZofILeSOyfwcbD7X1NyneS55h4GIXYEgKg9uVMIAqvvDBSDwo9btiOxN/fS
 k4pNbWIwRgXmbXWAIFdbn1DJDgDk7YjAcelEoY8XCu0Zo9C6liTKhPb7Aqc4e5i7TJrGY6pKE
 Ke/XDeFRhs1G8S2NEQ2umZzk/4HpRHrBMjZKcF2Bc8Q+wZtk/1ReH15R8yn/XYkQHocpFsL5d
 50aB01bUMG0Hzn1MGRn9tgtQ/503Xx3tv6iDPQxmYrt2FK60EJVx18FyoVJiWSwTAclIUHcSU
 BJOS6wUDU/AQlzobnANJxQeAtZxFVq3x23SZZS1eHr7lA760nZzbw7SJHJliR1WKsP2xDXPKz
 TW4wjsq4UA8iCLLbRwbPIG51mYHBIUqQTXK3i2EyZDhS+xHjDhQ0OqgN/C1XUwagyA0cY5lI4
 UI/2msoa5kFSLxxwLZFFIpH2fv/+UKKSQPu4uO9e0XgQC5jF1eXUYCQ3Il7vZQkB4ZcFNc5T3
 djdtnKBHOqXMxmoWoes78067fRRADqrZuC6F2dmt8OPxWAkhUxwvfvlvQpt3HmIThml0gXyo7
 yqW7ZD5st9Jo7Yy54xx7wWyN9i5ZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code uses the unsigned long type to represent
timestamps. However, this type is limited to 32-bit e.g. on 64-bit
Windows. Hence it is a suboptimal type for this use case.

In any case, we need to use the time_t type to represent timestamps
since we often send those values to system functions which are declared
to accept time_t parameters.

So let's prepare for the case where timestamps are represented as 64-bit
signed integers by introducing the Makefile option TIME_T_IS_INT64.

As we have to resort to using `strtoull()` (and casting the parsed,
unsigned value to an `int64_t`), the check in the `date_overflows()`
helper has to be relaxed: a value of ULLONG_MAX (cast to `int64_t`)
now *also* indicates an overflow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   | 4 ++++
 archive-tar.c              | 5 ++++-
 builtin/name-rev.c         | 2 +-
 builtin/prune.c            | 2 +-
 builtin/worktree.c         | 2 +-
 credential-cache--daemon.c | 2 +-
 date.c                     | 8 ++++----
 git-compat-util.h          | 7 +++++++
 ref-filter.c               | 2 +-
 9 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 8e4081e0619..0232cf62d33 100644
--- a/Makefile
+++ b/Makefile
@@ -1518,6 +1518,10 @@ ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
 
+ifdef TIME_T_IS_INT64
+	BASIC_CFLAGS += -DTIME_T_IS_INT64
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/archive-tar.c b/archive-tar.c
index 380e3aedd23..695339a2369 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -27,9 +27,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
  */
 #if ULONG_MAX == 0xFFFFFFFF
 #define USTAR_MAX_SIZE ULONG_MAX
-#define USTAR_MAX_MTIME ULONG_MAX
 #else
 #define USTAR_MAX_SIZE 077777777777UL
+#endif
+#if TIME_MAX == 0xFFFFFFFF
+#define USTAR_MAX_MTIME TIME_MAX
+#else
 #define USTAR_MAX_MTIME 077777777777UL
 #endif
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cd89d48b65e..a0f16407b93 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -145,7 +145,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
-	unsigned long taggerdate = ULONG_MAX;
+	unsigned long taggerdate = TIME_MAX;
 
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
diff --git a/builtin/prune.c b/builtin/prune.c
index 8f4f0522856..1e5eb0292b1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -111,7 +111,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	};
 	char *s;
 
-	expire = ULONG_MAX;
+	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	check_replace_refs = 0;
 	ref_paranoia = 1;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 831fe058a53..3df95e112e5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -131,7 +131,7 @@ static int prune(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	expire = ULONG_MAX;
+	expire = TIME_MAX;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 46c5937526a..b298ac01e4f 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -52,7 +52,7 @@ static int check_expirations(void)
 	static unsigned long wait_for_entry_until;
 	int i = 0;
 	unsigned long now = time(NULL);
-	unsigned long next = (unsigned long)-1;
+	unsigned long next = TIME_MAX;
 
 	/*
 	 * Initially give the client 30 seconds to actually contact us
diff --git a/date.c b/date.c
index 97ab5fcc349..23dee2964c1 100644
--- a/date.c
+++ b/date.c
@@ -659,7 +659,7 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 	if (*date < '0' || '9' < *date)
 		return -1;
 	stamp = parse_timestamp(date, &end, 10);
-	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
+	if (*end != ' ' || stamp == TIME_MAX || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
 	ofs = strtol(date, &end, 10);
@@ -762,7 +762,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 		 * of the past, and there is nothing from the future
 		 * to be kept.
 		 */
-		*timestamp = ULONG_MAX;
+		*timestamp = TIME_MAX;
 	else
 		*timestamp = approxidate_careful(date, &errors);
 
@@ -1184,8 +1184,8 @@ int date_overflows(unsigned long t)
 {
 	time_t sys;
 
-	/* If we overflowed our unsigned long, that's bad... */
-	if (t == ULONG_MAX)
+	/* If we overflowed our timestamp data type, that's bad... */
+	if ((uintmax_t)t >= TIME_MAX)
 		return 1;
 
 	/*
diff --git a/git-compat-util.h b/git-compat-util.h
index 4365012c536..5cf1133532d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,8 +319,15 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+#ifdef TIME_T_IS_INT64
+#define PRItime PRId64
+#define parse_timestamp strtoull
+#define TIME_MAX INT64_MAX
+#else
 #define PRItime "lu"
 #define parse_timestamp strtoul
+#define TIME_MAX ULONG_MAX
+#endif
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
diff --git a/ref-filter.c b/ref-filter.c
index 6fab0db5e0d..07c1f372351 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -638,7 +638,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if (!eoemail)
 		goto bad;
 	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
-	if (timestamp == ULONG_MAX)
+	if (timestamp == TIME_MAX)
 		goto bad;
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
-- 
2.11.1.windows.1.379.g44ae0bc


