From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fast-export: rename the signed tag mode 'ignore' to 'verbatim'
Date: Mon, 3 Dec 2007 22:44:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712032243450.27959@racer.site>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
 <7vabosse23.fsf@gitster.siamese.dyndns.org> <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712031109380.27959@racer.site> <7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712031838450.27959@racer.site> <7vwsrvh4vx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzK2h-000842-U0
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXLCWpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXLCWpG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:45:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:37039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750813AbXLCWpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:45:04 -0500
Received: (qmail invoked by alias); 03 Dec 2007 22:45:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp052) with SMTP; 03 Dec 2007 23:45:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UO+UiJVYUCygtDMGJBfE7V+PBbMaVtPLJBsHuzK
	9g3fYbApFhpEV3
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsrvh4vx.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66967>


The name 'verbatim' describes much better what this mode does with
signed tags.  While at it, fix the documentation what it actually
does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 3 Dec 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > But the original author already admitted that the original 
	> > naming was stupid...
	> 
	> Ok, send in updates, please.

	Alright...

 Documentation/git-fast-export.txt |    4 ++--
 builtin-fast-export.c             |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 073ff7f..fd3d571 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -26,14 +26,14 @@ OPTIONS
 	Insert 'progress' statements every <n> objects, to be shown by
 	gitlink:git-fast-import[1] during import.
 
---signed-tags=(ignore|warn|strip|abort)::
+--signed-tags=(verbatim|warn|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
 	after the export can change the tag names (which can also happen
 	when excluding revisions) the signatures will not match.
 +
 When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will be made
-unsigned, with 'ignore', they will be silently ignored (i.e. not exported)
+unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
 
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 72be45d..2136aad 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -23,15 +23,15 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { IGNORE, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
+static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
 {
 	if (unset || !strcmp(arg, "abort"))
 		signed_tag_mode = ABORT;
-	else if (!strcmp(arg, "ignore"))
-		signed_tag_mode = IGNORE;
+	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
+		signed_tag_mode = VERBATIM;
 	else if (!strcmp(arg, "warn"))
 		signed_tag_mode = WARN;
 	else if (!strcmp(arg, "strip"))
@@ -270,7 +270,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				warning ("Exporting signed tag %s",
 					 sha1_to_hex(tag->object.sha1));
 				/* fallthru */
-			case IGNORE:
+			case VERBATIM:
 				break;
 			case STRIP:
 				message_size = signature + 1 - message;
-- 
1.5.3.7.2120.g1a32
