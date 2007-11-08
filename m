From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git status: show relative paths when run in a subdirectory
Date: Thu, 8 Nov 2007 00:12:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080011170.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipv0n-00045U-0V
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbXKHAM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXKHAM3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:12:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:56672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754545AbXKHAM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:12:28 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:12:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 08 Nov 2007 01:12:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X/48+hmvXq63tDhyZMtcnDWuGv1dmnrDNv5cdMT
	mmpYrg7U3VzyRc
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63905>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This looks a bit ugly because quote_crlf() is now also called
	on the untracked files, which are not NUL terminated.

	Maybe someone has an idea how to do this more elegantly.

 builtin-runstatus.c |    1 +
 wt-status.c         |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 wt-status.h         |    1 +
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 2db25c8..8d167a9 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -14,6 +14,7 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 
 	git_config(git_status_config);
 	wt_status_prepare(&s);
+	s.prefix = prefix;
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--color"))
diff --git a/wt-status.c b/wt-status.c
index 03b5ec4..7386d41 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -82,16 +82,48 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
-static const char *quote_crlf(const char *in, char *buf, size_t sz)
+static const char *quote_crlf(const char *in, int len, char *buf, size_t sz,
+	const char *prefix)
 {
 	const char *scan;
 	char *out;
 	const char *ret = in;
+	int off = 0;
+
+	if (len < 0)
+		len = strlen(in);
+
+	if (prefix) {
+		while (prefix[off] && off < len && prefix[off] == in[off])
+			if (prefix[off] == '/') {
+				prefix += off + 1;
+				in += off + 1;
+				len -= off + 1;
+				off = 0;
+			} else
+				off++;
+		for (off = 0; *prefix; prefix++)
+			if (*prefix == '/') {
+				if (off + 4 >= sz) {
+					warning ("Could not prefix path: %s",
+						in);
+					return in;
+				}
+				strcpy(buf + off, "../");
+				off += 3;
+			}
+		ret = buf;
+	}
 
-	for (scan = in, out = buf; *scan; scan++) {
+	for (scan = in, out = buf + off; len; scan++, len--) {
 		int ch = *scan;
 		int quoted;
 
+		if (out - buf + 3 >= sz) {
+			warning ("Could not quote path: %s", in);
+			break;
+		}
+
 		switch (ch) {
 		case '\n':
 			quoted = 'n';
@@ -118,8 +150,8 @@ static void wt_status_print_filepair(struct wt_status *s,
 	const char *one, *two;
 	char onebuf[PATH_MAX], twobuf[PATH_MAX];
 
-	one = quote_crlf(p->one->path, onebuf, sizeof(onebuf));
-	two = quote_crlf(p->two->path, twobuf, sizeof(twobuf));
+	one = quote_crlf(p->one->path, -1, onebuf, sizeof(onebuf), s->prefix);
+	two = quote_crlf(p->two->path, -1, twobuf, sizeof(twobuf), s->prefix);
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
@@ -215,8 +247,8 @@ static void wt_status_print_initial(struct wt_status *s)
 	for (i = 0; i < active_nr; i++) {
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 		color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
-				quote_crlf(active_cache[i]->name,
-					   buf, sizeof(buf)));
+				quote_crlf(active_cache[i]->name, -1,
+					   buf, sizeof(buf), s->prefix));
 	}
 	if (active_nr)
 		wt_status_print_trailer(s);
@@ -254,6 +286,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 	const char *x;
 	int i;
 	int shown_header = 0;
+	char buf[PATH_MAX];
 
 	memset(&dir, 0, sizeof(dir));
 
@@ -291,8 +324,9 @@ static void wt_status_print_untracked(struct wt_status *s)
 			shown_header = 1;
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%.*s",
-				ent->len, ent->name);
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
+				quote_crlf(ent->name, ent->len,
+					buf, sizeof(buf), s->prefix));
 	}
 }
 
diff --git a/wt-status.h b/wt-status.h
index 7744932..f58ebcb 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -23,6 +23,7 @@ struct wt_status {
 	int workdir_untracked;
 	const char *index_file;
 	FILE *fp;
+	const char *prefix;
 };
 
 int git_status_config(const char *var, const char *value);
-- 
1.5.3.5.1597.g7191
