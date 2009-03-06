From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH v4] git-p4: improve performance with large files
Date: Fri, 6 Mar 2009 11:13:39 +0100
Message-ID: <20090306101339.GB12880@zoy.org>
References: <20090304215438.GA12653@zoy.org> <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au> <20090305172332.GF25693@zoy.org> <7vzlfzwiyn.fsf@gitster.siamese.dyndns.org> <1d48f7010903051725v510f99f0h2a05b9381ff75ac1@mail.gmail.com> <20090306085357.GA12880@zoy.org> <7vfxhrt2by.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 11:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfX5G-0003zf-P9
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZCFKNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 05:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbZCFKNn
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:13:43 -0500
Received: from poulet.zoy.org ([80.65.228.129]:53350 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbZCFKNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 05:13:42 -0500
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id C2A2B1203FC; Fri,  6 Mar 2009 11:13:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxhrt2by.fsf@gitster.siamese.dyndns.org>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112414>

On Fri, Mar 06, 2009, Junio C Hamano wrote:

> Sorry, but that's not a commit log message, so signing it off does not add
> much value to the patch.

   I'm sorry, for some reason git format-patch is eating my commit
messages (other commits appear just fine). As I'm doing this from a
Windows machine, I smell CR/LF issues in msysgit. Here is a clean
version:


git-p4: improve performance when importing huge files by reducing
the number of string concatenations while constraining memory usage.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 contrib/fast-import/git-p4 |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3832f60..db0ea0a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -984,11 +984,22 @@ class P4Sync(Command):
         while j < len(filedata):
             stat = filedata[j]
             j += 1
+            data = []
             text = ''
+            # Append data every 8192 chunks to 1) ensure decent performance
+            # by not making too many string concatenations and 2) avoid
+            # excessive memory usage by purging "data" often enough. p4
+            # sends 4k chunks, so we should not use more than 32 MiB of
+            # additional memory while rebuilding the file data.
             while j < len(filedata) and filedata[j]['code'] in ('text', 'unicod
e', 'binary'):
-                text += filedata[j]['data']
+                data.append(filedata[j]['data'])
                 del filedata[j]['data']
+                if len(data) > 8192:
+                    text += ''.join(data)
+                    data = []
                 j += 1
+            text += ''.join(data)
+            data = None

             if not stat.has_key('depotFile'):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-- 
Sam.
