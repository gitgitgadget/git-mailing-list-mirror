From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 16/17] Create pack_report() as a debugging aid.
Date: Sat, 23 Dec 2006 02:34:47 -0500
Message-ID: <20061223073447.GQ9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1PD-0001vX-2c
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbWLWHew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbWLWHew
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38829 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbWLWHev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Oj-0003E8-7I; Sat, 23 Dec 2006 02:34:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E431B20FB65; Sat, 23 Dec 2006 02:34:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35296>

Much like the alloc_report() function can be useful to report on
object allocation statistics while debugging the new pack_report()
function can be useful to report on the behavior of the mmap window
code used for packfile access.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h     |    1 +
 sha1_file.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index b7855ef..bd73aab 100644
--- a/cache.h
+++ b/cache.h
@@ -398,6 +398,7 @@ extern void install_packed_git(struct packed_git *pack);
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1, 
 					 struct packed_git *packs);
 
+extern void pack_report();
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
diff --git a/sha1_file.c b/sha1_file.c
index a8a6c10..1a87f95 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -398,10 +398,34 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 }
 
 static unsigned int pack_used_ctr;
+static unsigned int pack_mmap_calls;
+static unsigned int peak_pack_open_windows;
+static unsigned int pack_open_windows;
+static size_t peak_pack_mapped;
 static size_t pack_mapped;
 static size_t page_size;
 struct packed_git *packed_git;
 
+void pack_report()
+{
+	fprintf(stderr,
+		"pack_report: getpagesize()            = %10lu\n"
+		"pack_report: core.packedGitWindowSize = %10lu\n"
+		"pack_report: core.packedGitLimit      = %10lu\n",
+		page_size,
+		packed_git_window_size,
+		packed_git_limit);
+	fprintf(stderr,
+		"pack_report: pack_used_ctr            = %10u\n"
+		"pack_report: pack_mmap_calls          = %10u\n"
+		"pack_report: pack_open_windows        = %10u / %10u\n"
+		"pack_report: pack_mapped              = %10lu / %10lu\n",
+		pack_used_ctr,
+		pack_mmap_calls,
+		pack_open_windows, peak_pack_open_windows,
+		pack_mapped, peak_pack_mapped);
+}
+
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
@@ -492,6 +516,7 @@ static int unuse_one_window(struct packed_git *current)
 			}
 		}
 		free(lru_w);
+		pack_open_windows--;
 		return 1;
 	}
 	return 0;
@@ -605,6 +630,12 @@ unsigned char* use_pack(struct packed_git *p,
 				die("packfile %s cannot be mapped: %s",
 					p->pack_name,
 					strerror(errno));
+			pack_mmap_calls++;
+			pack_open_windows++;
+			if (pack_mapped > peak_pack_mapped)
+				peak_pack_mapped = pack_mapped;
+			if (pack_open_windows > peak_pack_open_windows)
+				peak_pack_open_windows = pack_open_windows;
 			win->next = p->windows;
 			p->windows = win;
 		}
-- 
1.4.4.3.g87d8
