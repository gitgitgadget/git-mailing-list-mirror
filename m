From: Sam Hocevar <sam@zoy.org>
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Thu, 5 Mar 2009 18:23:33 +0100
Message-ID: <20090305172332.GF25693@zoy.org>
References: <20090304215438.GA12653@zoy.org> <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 18:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfHik-0000Go-Bg
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 18:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbZCERtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbZCERtZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 12:49:25 -0500
Received: from poulet.zoy.org ([80.65.228.129]:37990 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbZCERtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 12:49:24 -0500
X-Greylist: delayed 1549 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2009 12:49:24 EST
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 59C421206F9; Thu,  5 Mar 2009 18:23:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112323>

On Thu, Mar 05, 2009, thestar@fussycoder.id.au wrote:

> >   The current git-p4 way of concatenating strings performs in O(n^2)
> >and is therefore terribly slow with large files because of unnecessary
> >memory copies. The following patch makes the operation O(n).
> 
> The reason why it uses simple concatenation is to cut down on memory usage.
>  - It is a tradeoff.
> 
> I think the modification you have made below is reasonable, however be  
> aware that memory usage could double, which substantially reduce the  
> size of the changesets that git-p4 would be able to import /at all/,  
> rather than to merely be slow.

   Uhm, no. The memory usage could be an additional X, where X is the
size of the biggest file in the commit. Remember that commit() stores
the complete commit data in memory before sending it to fast-import.
Also, on my machine the extra memory is already used because at some
point, "text += foo" calls realloc() anyway and often duplicates the
memory used by text.

   The ideal solution is to use a generator and refactor the commit
handling as a stream. I am working on that but it involves deeper
changes, so as I am not sure it will be accepted, I'm providing the
attached compromise patch first. At least it solves the appaling speed
issue. I tuned it so that it never uses more than 32 MiB extra memory.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 contrib/fast-import/git-p4 |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3832f60..151ae1c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -984,11 +984,19 @@ class P4Sync(Command):
         while j < len(filedata):
             stat = filedata[j]
             j += 1
+            data = []
             text = ''
             while j < len(filedata) and filedata[j]['code'] in ('text', 'unicod
e', 'binary'):
-                text += filedata[j]['data']
+                data.append(filedata[j]['data'])
                 del filedata[j]['data']
+                # p4 sends 4k chunks, make sure we don't use more than 32 MiB
+                # of additional memory while rebuilding the file data.
+                if len(data) > 8192:
+                    text += ''.join(data)
+                    data = []
                 j += 1
+            text += ''.join(data)
+            del data

             if not stat.has_key('depotFile'):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))

-- 
Sam.
