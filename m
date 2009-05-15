From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [MAKESHIFT PATCH] Cope better with a _lot_ of packs
Date: Fri, 15 May 2009 20:52:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905152040590.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52WR-0006Jq-IQ
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbZEOSwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZEOSwh
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:52:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:48793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbZEOSwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:52:36 -0400
Received: (qmail invoked by alias); 15 May 2009 18:52:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 15 May 2009 20:52:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rC4dTY9Fr492Xt1G556juY22GVv3AulFkCOCj7E
	29nGrYIyb+xXeZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmy9etey8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119277>


You might end up with a situation where you have tons of pack files, e.g.
when using hg2git.  In this situation, all kinds of operations may 
end up with a "too many files open" error.  Let's recover gracefully from 
that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 15 May 2009, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > if you need a chuckle, like me, you might appreciate this 
	> > story: in one of my repositories, "git gc" dies with
	> >
	> > 	unable to open object pack directory: ...: Too many open files
	> >
	> > turns out that there are a whopping 1088 packs in that 
	> > repository...
	> 
	> Isn't it a more serious problem than a mere chuckle?

	Well, it was kind of morbid humor, I guess.  So much so that I 
	just had to send off that mail when I encountered the problem.

	> How would one recover from such a situation (other than
	> "mv .git/objects/pack-*; for p in pack-*.pack; do git unpack-objects
	> <$p; done")?

	Very easy: one writes a patch.

	I am sure that I did not catch all problematic sites, but this 
	patch works almost, at least.

	Another issue is how to include a test for this... I cannot think
	of a non-expensive way.

 sha1_file.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 28bd908..bd5edd8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -720,6 +720,8 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("packfile %s index unavailable", p->pack_name);
 
 	p->pack_fd = open(p->pack_name, O_RDONLY);
+	while (p->pack_fd < 0 && errno == EMFILE && unuse_one_window(p, -1))
+		p->pack_fd = open(p->pack_name, O_RDONLY);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 
@@ -937,6 +939,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 	sprintf(path, "%s/pack", objdir);
 	len = strlen(path);
 	dir = opendir(path);
+	while (!dir && errno == EMFILE && unuse_one_window(packed_git, -1))
+		dir = opendir(path);
 	if (!dir) {
 		if (errno != ENOENT)
 			error("unable to open object pack directory: %s: %s",
@@ -2339,6 +2343,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
+	while (fd < 0 && errno == EMFILE && unuse_one_window(packed_git, -1))
+		fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
-- 
1.6.3.1.10.g12b3.dirty
