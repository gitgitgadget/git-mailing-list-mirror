From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Sat, 24 Mar 2012 21:53:26 +0100
Message-ID: <4F6E3446.9080001@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:53:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBXxa-0005dt-9O
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 21:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab2CXUxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 16:53:09 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:37111 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752812Ab2CXUxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 16:53:08 -0400
Received: (qmail invoked by alias); 24 Mar 2012 20:53:06 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.228]
  by mail.gmx.net (mp020) with SMTP; 24 Mar 2012 21:53:06 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1+tZvxnOcetOjtZP0IXSIamKJje2aWmTCsV2cXdrY
	XWSz+uwrQWjPUJ
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120321201722.GA15021@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193847>


>From c4bb55f9f27569faa368d823ca6fe4b236e37cd6 Mon Sep 17 00:00:00 2001
From: Ivan Todoroski <grnch@gmx.net>
Date: Sat, 24 Mar 2012 15:13:05 +0100
Subject: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin

---
 Documentation/git-fetch-pack.txt |    9 ++++++++
 builtin/fetch-pack.c             |   44 ++++++++++++++++++++++++++++++++++++--
 fetch-pack.h                     |    3 ++-
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index ed1bdaacd1..7cd7c785bc 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -32,6 +32,15 @@ OPTIONS
 --all::
 	Fetch all remote refs.
 
+--stdin::
+	Take the list of refs from stdin, one per line. If there
+	are refs specified on the command line in addition to this
+	option, then the refs from stdin are processed after those
+	on the command line.
+	If '--stateless-rpc' is specified together with this option
+	then the list of refs must be in packet format (pkt-line)
+	with a flush packet terminating the list.
+
 -q::
 --quiet::
 	Pass '-q' flag to 'git unpack-objects'; this makes the
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a4d3e90a86..3c4c193e45 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -23,7 +23,7 @@ static struct fetch_pack_args args = {
 };
 
 static const char fetch_pack_usage[] =
-"git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -896,7 +896,7 @@ static void fetch_pack_setup(void)
 
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, ret, nr_heads;
+	int i, ret, nr_heads, alloc_heads;
 	struct ref *ref = NULL;
 	char *dest = NULL, **heads;
 	int fd[2];
@@ -941,6 +941,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.fetch_all = 1;
 				continue;
 			}
+			if (!strcmp("--stdin", arg)) {
+				args.refs_from_stdin = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				args.verbose = 1;
 				continue;
@@ -972,6 +976,42 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!dest)
 		usage(fetch_pack_usage);
 
+	if (args.refs_from_stdin) {
+		char ref[1000];
+		/* copy refs from cmdline to new growable list */
+		int size = nr_heads * sizeof(*heads);
+		heads = memcpy(xmalloc(size), heads, size);
+		alloc_heads = nr_heads;
+		/* append refs from stdin to ones from cmdline */
+		for (;;) {
+			if (args.stateless_rpc) {
+				/* read using pkt-line in stateless RPC mode,
+				   flush packet signifies end of refs */
+				int n = packet_read_line(0, ref, sizeof(ref));
+				if (!n)
+					break;
+				if (ref[n-1] == '\n')
+					ref[n-1] = '\0';
+			}
+			else {
+				int n;
+				if (!fgets(ref, sizeof(ref), stdin)) {
+					if (ferror(stdin))
+						die_errno("cannot read ref");
+					if (feof(stdin))
+						break;
+				}
+				n = strlen(ref);
+				if (ref[n-1] == '\n')
+					ref[n-1] = '\0';
+				else if (!feof(stdin))
+					die("ref too long on stdin");
+			}
+			ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
+			heads[nr_heads++] = xstrdup(ref);
+		}
+	}
+
 	if (args.stateless_rpc) {
 		conn = NULL;
 		fd[0] = 0;
diff --git a/fetch-pack.h b/fetch-pack.h
index 0608edae3f..292d69389e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -13,7 +13,8 @@ struct fetch_pack_args {
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		refs_from_stdin:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
-- 
1.7.9.4.16.gd24fa.dirty
