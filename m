From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add pretty format %aN which gives the author name, respecting
 .mailmap
Date: Sat, 12 Jul 2008 00:28:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120027330.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <alpine.DEB.1.00.0807112238350.8950@racer> 
 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>  <alpine.DEB.1.00.0807112310140.8950@racer> <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com> <alpine.DEB.1.00.0807120000580.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 12 01:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHS3C-0007gd-Sd
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbYGKX2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbYGKX2U
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:28:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753557AbYGKX2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:28:20 -0400
Received: (qmail invoked by alias); 11 Jul 2008 23:28:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp010) with SMTP; 12 Jul 2008 01:28:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T/AYBGaPTeM2hZi5VMo2X62zFLKXAGylLOKOI65
	GlqcEDuv4DYVdp
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807120000580.8950@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88198>


The pretty format %an does not respect .mailmap, but gives the exact
author name recorded in the commit.  Sometimes it is more desirable,
however, to look if the email has another name mapped to it in .mailmap.

This commit adds %aN (and %cN for the committer name) to do exactly that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 12 Jul 2008, Johannes Schindelin wrote:

	> On Sat, 12 Jul 2008, Sverre Rabbelier wrote:
	> 
	> > On Sat, Jul 12, 2008 at 12:11 AM, Johannes Schindelin
	> > <Johannes.Schindelin@gmx.de> wrote:
	> > > The mechanism is this: you look up the email in .mailmap 
	> > > (actually you parse that once, but the idea stays the same), and if 
	> > > there is a name for it, you use that _instead of_ the given author 
	> > > name.
	> > 
	> > Ah, so you suggest changing "format:%ae" to "format:%ae %an" 
	> > and falling back to the latter id specified on that line if the 
	> > former is not in .mailmap? That would work I guess, I'll put it on my 
	> > TODO list :).
	> 
	> Hmm.  I missed the fact that you used pretty formats.  Seems 
	> like %an does not respect .mailmap; I'm on it.

 Documentation/pretty-formats.txt |    2 ++
 pretty.c                         |   27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 69e6d2f..c11d495 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -101,6 +101,7 @@ The placeholders are:
 - '%P': parent hashes
 - '%p': abbreviated parent hashes
 - '%an': author name
+- '%aN': author name (respecting .mailmap)
 - '%ae': author email
 - '%ad': author date
 - '%aD': author date, RFC2822 style
@@ -108,6 +109,7 @@ The placeholders are:
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
 - '%cn': committer name
+- '%cN': committer name (respecting .mailmap)
 - '%ce': committer email
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
diff --git a/pretty.c b/pretty.c
index 8eb39e9..862364b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -3,6 +3,8 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
+#include "path-list.h"
+#include "mailmap.h"
 
 static char *user_format;
 
@@ -288,6 +290,25 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
+static int mailmap_name(struct strbuf *sb, const char *email)
+{
+	static struct path_list *mail_map;
+	char buffer[1024];
+
+	if (!mail_map) {
+		mail_map = xcalloc(1, sizeof(*mail_map));
+		read_mailmap(mail_map, ".mailmap", NULL);
+	}
+
+	if (!mail_map->nr)
+		return -1;
+
+	if (!map_email(mail_map, email, buffer, sizeof(buffer)))
+		return -1;
+	strbuf_addstr(sb, buffer);
+	return 0;
+}
+
 static size_t format_person_part(struct strbuf *sb, char part,
                                const char *msg, int len)
 {
@@ -309,10 +330,12 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	if (end >= len - 2)
 		goto skip;
 
-	if (part == 'n') {	/* name */
+	if (part == 'n' || part == 'N') {	/* name */
 		while (end > 0 && isspace(msg[end - 1]))
 			end--;
-		strbuf_add(sb, msg, end);
+		if (part != 'N' || !msg[end] || !msg[end + 1] ||
+				mailmap_name(sb, msg + end + 2) < 0)
+			strbuf_add(sb, msg, end);
 		return placeholder_len;
 	}
 	start = ++end; /* save email start position */
-- 
1.5.6.2.509.g109edf
