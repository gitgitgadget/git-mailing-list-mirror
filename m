From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax
	mean.
Date: Mon, 20 Aug 2007 01:52:21 -0400
Message-ID: <20070820055221.GA22993@coredump.intra.peff.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 07:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0CC-0002gy-1A
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 07:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbXHTFw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 01:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXHTFw1
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 01:52:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbXHTFw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 01:52:27 -0400
Received: (qmail 17128 invoked by uid 111); 20 Aug 2007 05:52:36 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 01:52:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 01:52:21 -0400
Content-Disposition: inline
In-Reply-To: <46C90C46.1030000@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56171>

On Mon, Aug 20, 2007 at 11:36:38AM +0800, Steven Grimm wrote:

> The git-rev-parse manpage talks about the :$n:path notation (buried deep in
> a list of other syntax) but it just says $n is a "stage number" -- someone
> who is not familiar with the internals of git's merge implementation is
> never going to be able to figure out that "1", "2", and "3" mean what Junio
> said.

I often forget which number corresponds to which source. I seem to
recall somebody proposing :ours:$path a while ago, but I couldn't find
any reference in the archive, so perhaps I just dreamed it.

Am I the only one who messes this up? If not, patch is below.

-- >8 --
sha1_name: allow human-readable stage aliases

This adds the alias ":ours:$path" to mean the same thing as ":2:$path",
as well as "base" (for 1) and "theirs" (for 2), for those of us who
merge infrequently and forget which is which.

The parsing is as strict as possible in order to minimize impact on
filenames with colons. However, for some (presumably unlikely)
filenames, the behavior is changed. Previously, you could look at stage
0 of any file beginning with the string "ours:" as simply "git-show
:ours:foo". Now, because of the parsing conflict, you must use "git-show
:0:ours:foo".

---

 sha1_name.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..eaa6bd7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -664,6 +664,7 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	/* sha1:path --> object name of path in ent sha1
 	 * :path -> object name of path in index
 	 * :[0-3]:path -> object name of path in index at stage
+	 * :base|ours|theirs:path -> same as :[1-3]:path
 	 */
 	if (name[0] == ':') {
 		int stage = 0;
@@ -671,14 +672,36 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 		int pos;
 		if (namelen > 2 && name[1] == '/')
 			return get_sha1_oneline(name + 2, sha1);
-		if (namelen < 3 ||
-		    name[2] != ':' ||
-		    name[1] < '0' || '3' < name[1])
-			cp = name + 1;
-		else {
-			stage = name[1] - '0';
+		if (!strncmp(name+1, "0:", 2)) {
+			stage = 0;
+			cp = name + 3;
+		}
+		else if (!strncmp(name+1, "1:", 2)) {
+			stage = 1;
+			cp = name + 3;
+		}
+		else if (!strncmp(name+1, "base:", 5)) {
+			stage = 1;
+			cp = name + 6;
+		}
+		else if (!strncmp(name+1, "2:", 2)) {
+			stage = 2;
 			cp = name + 3;
 		}
+		else if (!strncmp(name+1, "ours:", 5)) {
+			stage = 2;
+			cp = name + 6;
+		}
+		else if (!strncmp(name+1, "3:", 2)) {
+			stage = 3;
+			cp = name + 3;
+		}
+		else if (!strncmp(name+1, "theirs:", 7)) {
+			stage = 3;
+			cp = name + 8;
+		}
+		else
+			cp = name + 1;
 		namelen = namelen - (cp - name);
 		if (!active_cache)
 			read_cache();
