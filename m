From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Add "%w" to pretty formats, which rewraps the commit
 message
Date: Wed, 23 Sep 2009 22:34:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909232233590.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYWT-0007OS-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZIWUc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZIWUcz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:32:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:37604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752246AbZIWUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:32:55 -0400
Received: (qmail invoked by alias); 23 Sep 2009 20:32:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 23 Sep 2009 22:32:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cGTJd7LzcYfkwJG1A6Le63k3v2I/uK/M2oCCrpU
	uLXlHYN+f3F+SR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0909232233330.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128997>


Some repositories contain commit messages that are insanely long.
And not always is it an option to rewrite the commits with rewrapped
commit messages; just think of cvsimports or some such.

Now here is a remedy.

With "--pretty=format:%w(8,6,70)" you will get the commit messages
reformatted to width 70 where the first line has indent 8 and the
subsequent lines have indent 6.

The following command will output something similar to plain "git log
--color", except that the commit bodies will be rewrapped to fit inside
80 columns:

	git log --pretty=format:'%C(yellow)commit %H%C(reset)
	Author: %an <%ae>
	Date: %ad

	%w(4,4,80)'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..d727995 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,7 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%w(indent,indent2,width)': rewrapped subject and body
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f5983f8..639469e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,6 +595,30 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+static int rewrap_text(struct strbuf *sb, const char *params, const char *text)
+{
+	int indent = 4, indent2 = 4, width = 80, pacmanned = 1;
+
+	if (params[0] == '(') {
+		char *p;
+
+		indent = strtoul(params + 1, &p, 0);
+		if (*p == ',') {
+			indent2 = strtoul(p + 1, &p, 0);
+			if (*p == ',')
+				width = strtoul(p + 1, &p, 0);
+		}
+		if (*p != ')') {
+			error ("Invalid parameters: %.*s",
+					(int)(p - params), params);
+			return 0;
+		}
+		pacmanned = p + 1 - params;
+	}
+	strbuf_add_wrapped_text(sb, text, indent, indent2, width);
+	return pacmanned;
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -735,6 +759,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'b':	/* body */
 		strbuf_addstr(sb, msg + c->body_off);
 		return 1;
+	case 'w':	/* re-wrapped body */
+		return rewrap_text(sb, placeholder + 1,
+				msg + c->subject_off) + 1;
 	}
 	return 0;	/* unknown placeholder */
 }
-- 
1.6.4.297.gcb4cc
