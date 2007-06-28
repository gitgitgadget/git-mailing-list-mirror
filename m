From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Ignore end-of-line style when computing similarity score for rename detection
Date: Wed, 27 Jun 2007 19:46:03 -0700
Message-ID: <20070628024603.GA1534@midwinter.com>
References: <46831F70.2060403@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 04:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3k1I-00053y-Ja
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 04:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762579AbXF1CqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 22:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761466AbXF1CqE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 22:46:04 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:38954
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1760677AbXF1CqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 22:46:03 -0400
Received: (qmail 1683 invoked by uid 1001); 28 Jun 2007 02:46:03 -0000
Content-Disposition: inline
In-Reply-To: <46831F70.2060403@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51075>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
Okay, let's try this again with an MUA that won't change my tabs to
spaces -- sorry about that.

A couple of source files got checked into my code base with DOS-style
end-of-line characters. I converted them to UNIX-style (the convention
for this project) in my branch. Then later, I renamed a couple of them.

Meanwhile, back in the original branch, someone else fixed a bug in one
of the files and checked it in, still with DOS-style line endings.

When I merged that change into my branch, git didn't detect the rename
because the fact that every line has a change (the end-of-line
character) dropped the similarity score way too low.

This patch teaches git to ignore end-of-line style when looking for
potential rename candidates. A separate question, which I expect may be
more controversial, is what to do with conflict markers; with this
patch, the entire file is still marked as in conflict if the end-of-line
style changes (but it's still an improvement in that we at least detect
the rename now.)


 diffcore-delta.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7338a40..10bbf95 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -143,9 +143,12 @@ static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
 		unsigned int c = *buf++;
 		unsigned int old_1 = accum1;
 		sz--;
-		accum1 = (accum1 << 7) ^ (accum2 >> 25);
-		accum2 = (accum2 << 7) ^ (old_1 >> 25);
-		accum1 += c;
+		/* Ignore \r\n vs. \n when computing similarity. */
+		if (c != '\r') {
+			accum1 = (accum1 << 7) ^ (accum2 >> 25);
+			accum2 = (accum2 << 7) ^ (old_1 >> 25);
+			accum1 += c;
+		}
 		if (++n < 64 && c != '\n')
 			continue;
 		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
-- 
1.5.2.2.571.ge134
