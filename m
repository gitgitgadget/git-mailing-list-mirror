From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] print_wrapped_text(): allow hard newlines
Date: Wed, 23 Sep 2009 22:34:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqYWG-0007JZ-4m
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 22:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbZIWUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 16:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZIWUcm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 16:32:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:38786 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbZIWUcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 16:32:42 -0400
Received: (qmail invoked by alias); 23 Sep 2009 20:32:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 23 Sep 2009 22:32:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196Exlsuyd62zr3i+IBnGPmUeJvkKkT5rDBfSVZmh
	2EWnVISX9DuI/Z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128995>


print_wrapped_text() will insert its own newlines. Up until now, if the
text passed to it contained newlines, they would not be handled properly
(the wrapping got confused after that).

The strategy is to replace a single new-line with a space, but keep double
new-lines so that already-wrapped text with empty lines between paragraphs
will be handled properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 utf8.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index db706ac..589876b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -310,6 +310,8 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 		if (!c || isspace(c)) {
 			if (w < width || !space) {
 				const char *start = bol;
+				if (!c && text == start)
+					return w;
 				if (space)
 					start = space;
 				else
@@ -317,13 +319,23 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
 				fwrite(start, text - start, 1, stdout);
 				if (!c)
 					return w;
-				else if (c == '\t')
-					w |= 0x07;
 				space = text;
+				if (c == '\t')
+					w |= 0x07;
+				else if (c == '\n') {
+					space++;
+					if (*space == '\n') {
+						putchar('\n');
+						goto new_line;
+					}
+					else
+						putchar(' ');
+				}
 				w++;
 				text++;
 			}
 			else {
+new_line:
 				putchar('\n');
 				text = bol = space + isspace(*space);
 				space = NULL;
-- 
1.6.4.297.gcb4cc
