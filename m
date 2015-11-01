From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/9] trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
Date: Sun,  1 Nov 2015 14:42:41 +0100
Message-ID: <1446385369-8669-2-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zssv2-0008FE-HR
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbKANnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:31 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34352 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbKANn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:29 -0500
Received: by wikq8 with SMTP id q8so36503857wik.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M/QC597XiCPs0hSJ9fn1mYsMy2R/gkuDZVLXiKOPCU8=;
        b=IRd7O2o+YZddsYFKrHwS40hW/f60PL/fQDym8HYOYpAC3MjSTlwQY0Y6+4QTI88/P6
         NMnAXG5l0oHhKiWEAa0kHM9CnBGjb7Z0wDqrKnM81+UT/Mq2XbON1tZiMfv1CJHeLxu1
         isyWsI88JSXeKkS/GtC2wDog68XmTxAnFw81EQ84Y03YODbBiFxci3WauPtt0qQhUPY1
         ALg2Rt6/moBRNceCTSIXTil1m7XRUDJT4RHsf2Ten/0NAILm+9uGvqNGDpMpP9UGqllg
         RtGNNgrr0i32+I7kJL7OPvFnlTK245trSrwQN6rbueEccdtwH0dTIeXxAyLqcNw3brmM
         LUxA==
X-Received: by 10.194.190.19 with SMTP id gm19mr20883648wjc.0.1446385408438;
        Sun, 01 Nov 2015 05:43:28 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280618>

trace_stats() is intended for GIT_TRACE_*_STATS variable group and
GIT_TRACE_PACK_STATS is more like an example how new vars can be added.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |  3 +++
 cache.h               |  2 ++
 git.c                 |  1 +
 sha1_file.c           | 24 ++++++++++++++++++++++++
 trace.c               | 13 +++++++++++++
 trace.h               |  1 +
 6 files changed, 44 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4585103..1086ced 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1045,6 +1045,9 @@ of clones and fetches.
 	time of each Git command.
 	See 'GIT_TRACE' for available trace output options.
=20
+'GIT_TRACE_PACK_STATS'::
+	Print various statistics.
+
 'GIT_TRACE_SETUP'::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
diff --git a/cache.h b/cache.h
index 3ba0b8f..8791dbc 100644
--- a/cache.h
+++ b/cache.h
@@ -1747,4 +1747,6 @@ void stat_validity_update(struct stat_validity *s=
v, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
=20
+void report_pack_stats(struct trace_key *key);
+
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 6ed824c..f4018c5 100644
--- a/git.c
+++ b/git.c
@@ -644,6 +644,7 @@ int main(int argc, char **av)
 	git_setup_gettext();
=20
 	trace_command_performance(argv);
+	trace_stats();
=20
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
diff --git a/sha1_file.c b/sha1_file.c
index c5b31de..1d3508d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -517,6 +517,7 @@ static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
 static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
+static unsigned int pack_access_nr;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
@@ -542,6 +543,28 @@ void pack_report(void)
 		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
 }
=20
+void report_pack_stats(struct trace_key *key)
+{
+	trace_printf_key(key, "\n"
+			 "pack_report: getpagesize()            =3D %10" SZ_FMT "\n"
+			 "pack_report: core.packedGitWindowSize =3D %10" SZ_FMT "\n"
+			 "pack_report: core.packedGitLimit      =3D %10" SZ_FMT "\n"
+			 "pack_report: pack_used_ctr            =3D %10u\n"
+			 "pack_report: pack_mmap_calls          =3D %10u\n"
+			 "pack_report: pack_open_windows        =3D %10u / %10u\n"
+			 "pack_report: pack_mapped              =3D "
+			 "%10" SZ_FMT " / %10" SZ_FMT "\n"
+			 "pack_report: pack accesss             =3D %10u\n",
+			 sz_fmt(getpagesize()),
+			 sz_fmt(packed_git_window_size),
+			 sz_fmt(packed_git_limit),
+			 pack_used_ctr,
+			 pack_mmap_calls,
+			 pack_open_windows, peak_pack_open_windows,
+			 sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped),
+			 pack_access_nr);
+}
+
 /*
  * Open and mmap the index file at path, perform a couple of
  * consistency checks, then record its information to p.  Return 0 on
@@ -2244,6 +2267,7 @@ static void write_pack_access_log(struct packed_g=
it *p, off_t obj_offset)
 	static struct trace_key pack_access =3D TRACE_KEY_INIT(PACK_ACCESS);
 	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
 			 p->pack_name, (uintmax_t)obj_offset);
+	pack_access_nr++;
 }
=20
 int do_check_packed_object_crc;
diff --git a/trace.c b/trace.c
index 4aeea60..b1d0885 100644
--- a/trace.c
+++ b/trace.c
@@ -432,3 +432,16 @@ void trace_command_performance(const char **argv)
 	sq_quote_argv(&command_line, argv, 0);
 	command_start_time =3D getnanotime();
 }
+
+static struct trace_key trace_pack_stats =3D TRACE_KEY_INIT(PACK_STATS=
);
+
+static void print_stats_atexit(void)
+{
+	report_pack_stats(&trace_pack_stats);
+}
+
+void trace_stats(void)
+{
+	if (trace_want(&trace_pack_stats))
+		atexit(print_stats_atexit);
+}
diff --git a/trace.h b/trace.h
index 179b249..52bda4e 100644
--- a/trace.h
+++ b/trace.h
@@ -19,6 +19,7 @@ extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
 extern void trace_verbatim(struct trace_key *key, const void *buf, uns=
igned len);
+extern void trace_stats(void);
=20
 #ifndef HAVE_VARIADIC_MACROS
=20
--=20
2.2.0.513.g477eb31
