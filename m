From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/9] trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
Date: Mon, 28 Jul 2014 19:03:07 +0700
Message-ID: <1406548995-28549-2-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjeo-0002r7-O9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbaG1MDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:03:53 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:48514 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:03:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9859001pdj.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NTTX2Nsyj3zkQigE45cy2fJrws2YkTpgvGFR8azrlGA=;
        b=qypdi0cZCyE3V2+uz1AXRXHeoUIUxzyg7iS4rDnlIUi22UXuZbcy+56zVulbBx1wlS
         RfS+cAQd3S9BHPKxib6ie36tavLvEBToWKCwPTkwlhde1tf9+LbnvDVnsP9InKW5iaFC
         uGcWY0VCQquG6VOt08VOYDXnLDmTSroUnHFDDGDyvOta0EEE6PFKtc5qbOwcCdum8RkK
         WlfOGiyhPtw0yIo2SYQSvZ2tXaAFas7UssWWxZMvBtNaMAq+xbrNkhd3TEL0z/tPZScP
         WFAV2gg7/JI7XtPvLN7R1E/EcTtbqBXc2sjtsxJynsmcFGnR7Q7yCm1ClwKfySuF55kZ
         +9ag==
X-Received: by 10.70.133.167 with SMTP id pd7mr38336421pdb.31.1406549032627;
        Mon, 28 Jul 2014 05:03:52 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id be7sm23999792pdb.37.2014.07.28.05.03.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:03:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:03:55 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254315>

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
index a0f1ede..a124612 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -946,6 +946,9 @@ Unsetting the variable, or setting it to empty, "0"=
 or
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
index fcb511d..1c84227 100644
--- a/cache.h
+++ b/cache.h
@@ -1502,4 +1502,6 @@ void stat_validity_update(struct stat_validity *s=
v, int fd);
=20
 int versioncmp(const char *s1, const char *s2);
=20
+void report_pack_stats(struct trace_key *key);
+
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 9c49519..6a6a8a8 100644
--- a/git.c
+++ b/git.c
@@ -614,6 +614,7 @@ int main(int argc, char **av)
 	git_setup_gettext();
=20
 	trace_command_performance(argv);
+	trace_stats();
=20
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
diff --git a/sha1_file.c b/sha1_file.c
index 3f70b1d..21a487b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -467,6 +467,7 @@ static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
 static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
+static unsigned int pack_access_nr;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
@@ -492,6 +493,28 @@ void pack_report(void)
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
@@ -2086,6 +2109,7 @@ static void write_pack_access_log(struct packed_g=
it *p, off_t obj_offset)
 	static struct trace_key pack_access =3D TRACE_KEY_INIT(PACK_ACCESS);
 	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
 			 p->pack_name, (uintmax_t)obj_offset);
+	pack_access_nr++;
 }
=20
 int do_check_packed_object_crc;
diff --git a/trace.c b/trace.c
index e583dc6..c52da0f 100644
--- a/trace.c
+++ b/trace.c
@@ -426,3 +426,16 @@ void trace_command_performance(const char **argv)
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
index ae6a332..9c06e82 100644
--- a/trace.h
+++ b/trace.h
@@ -18,6 +18,7 @@ extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
+extern void trace_stats(void);
=20
 #ifndef HAVE_VARIADIC_MACROS
=20
--=20
2.1.0.rc0.66.gb9187ad
