From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Ignore end-of-line style when computing similarity score
 for rename detection
Date: Wed, 27 Jun 2007 19:39:44 -0700
Message-ID: <46831F70.2060403@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'git' <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 04:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3jv9-0004CM-6f
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 04:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762050AbXF1Cjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 22:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759112AbXF1Cjp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 22:39:45 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:45734
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1761639AbXF1Cjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 22:39:44 -0400
Received: (qmail 1292 invoked from network); 28 Jun 2007 02:39:43 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=i/STPdl317H1AGgvC5PKIF01DurHKcG/wmsR/Fzsv8GqLt7TsvKnvMU8fKp+JV+L  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 28 Jun 2007 02:39:43 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51074>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
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
@@ -143,9 +143,12 @@ static struct spanhash_top *hash_chars(unsigned 
char *buf, unsigned int sz)
                unsigned int c = *buf++;
                unsigned int old_1 = accum1;
                sz--;
-               accum1 = (accum1 << 7) ^ (accum2 >> 25);
-               accum2 = (accum2 << 7) ^ (old_1 >> 25);
-               accum1 += c;
+               /* Ignore \r\n vs. \n when computing similarity. */
+               if (c != '\r') {
+                       accum1 = (accum1 << 7) ^ (accum2 >> 25);
+                       accum2 = (accum2 << 7) ^ (old_1 >> 25);
+                       accum1 += c;
+               }
                if (++n < 64 && c != '\n')
                        continue;
                hashval = (accum1 + accum2 * 0x61) % HASHBASE;
-- 
1.5.2.2.571.ge134
