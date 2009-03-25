From: Jeff Layton <jlayton@redhat.com>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 20:24:29 -0400
Message-ID: <20090324202429.130f33c3@tleilax.poochiereds.net>
References: <49C9246E.3030508@mycircuit.org>
	<alpine.LFD.2.00.0903241226570.3032@localhost.localdomain>
	<49C94B02.5010604@mycircuit.org>
	<alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
	<49C961D0.4010704@mycircuit.org>
	<alpine.LFD.2.00.0903241655210.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Steve French <sfrench@us.ibm.com>
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmH01-0003SM-4X
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbZCYA1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756825AbZCYA1m
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:27:42 -0400
Received: from mx2.redhat.com ([66.187.237.31]:40849 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbZCYA0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:26:21 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2P0OXJA010946;
	Tue, 24 Mar 2009 20:24:33 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2P0ORvH001158;
	Tue, 24 Mar 2009 20:24:27 -0400
Received: from tleilax.poochiereds.net (vpn-13-11.rdu.redhat.com [10.11.13.11])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2P0OWqO022198;
	Tue, 24 Mar 2009 20:24:32 -0400
In-Reply-To: <alpine.LFD.2.00.0903241655210.3032@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114525>

On Tue, 24 Mar 2009 17:03:22 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Tue, 24 Mar 2009, Peter wrote:
> >
> > Thanks a lot , I will check that out tomorrow, in the meantime, this is the
> > result of your patch being applied:
> > 
> > $ git add <big stuff>
> > 
> > fatal: error when closing sha1 file (Bad file descriptor)
> 
> Ok, that's probably cifs_writepages() doing
> 
>                         open_file = find_writable_file(CIFS_I(mapping->host));
>                         if (!open_file) {
>                                 cERROR(1, ("No writable handles for inode"));
>                                 rc = -EBADF;
> 			} else {
> 				..
> 
> so yeah, looks like it's the fchmod() that triggers it.
> 
> I suspect this would be a safer - if slightly slower - way to make sure 
> the file is read-only. It's slower, because it is going to look up the 
> filename once more, but I bet it is going to avoid this particular CIFS 
> bug.
>

Yeah, that should work around it. This CIFS patch should also fix it.
It's untested but it's reasonably simple.

Just out of curiosity, what sort of server are you mounting here?

--------------[snip]------------------

>From ea8dc9927fb9542bb1c73b1982cc44bf3d4a9798 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@redhat.com>
Date: Tue, 24 Mar 2009 19:50:17 -0400
Subject: [PATCH] cifs: flush data on any setattr

We already flush all the dirty pages for an inode before doing
ATTR_SIZE and ATTR_MTIME changes. There's another problem though -- if
we change the mode so that the file becomes read-only then we may not
be able to write data to it afterward.

Fix this by just going back to flushing all the dirty data on any
setattr call. There are probably some cases that can be optimized out,
but we need to take care that we don't cause a regression by doing that.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/cifs/inode.c |   58 ++++++++++++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a8797cc..f4e880d 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1792,20 +1792,21 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		goto out;
 	}
 
-	if ((attrs->ia_valid & ATTR_MTIME) || (attrs->ia_valid & ATTR_SIZE)) {
-		/*
-		   Flush data before changing file size or changing the last
-		   write time of the file on the server. If the
-		   flush returns error, store it to report later and continue.
-		   BB: This should be smarter. Why bother flushing pages that
-		   will be truncated anyway? Also, should we error out here if
-		   the flush returns error?
-		 */
-		rc = filemap_write_and_wait(inode->i_mapping);
-		if (rc != 0) {
-			cifsInode->write_behind_rc = rc;
-			rc = 0;
-		}
+	/*
+	 * Attempt to flush data before changing attributes. We need to do
+	 * this for ATTR_SIZE and ATTR_MTIME for sure, and if we change the
+	 * ownership or mode then we may also need to do this. Here, we take
+	 * the safe way out and just do the flush on all setattr requests. If
+	 * the flush returns error, store it to report later and continue.
+	 *
+	 * BB: This should be smarter. Why bother flushing pages that
+	 * will be truncated anyway? Also, should we error out here if
+	 * the flush returns error?
+	 */
+	rc = filemap_write_and_wait(inode->i_mapping);
+	if (rc != 0) {
+		cifsInode->write_behind_rc = rc;
+		rc = 0;
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
@@ -1903,20 +1904,21 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		return -ENOMEM;
 	}
 
-	if ((attrs->ia_valid & ATTR_MTIME) || (attrs->ia_valid & ATTR_SIZE)) {
-		/*
-		   Flush data before changing file size or changing the last
-		   write time of the file on the server. If the
-		   flush returns error, store it to report later and continue.
-		   BB: This should be smarter. Why bother flushing pages that
-		   will be truncated anyway? Also, should we error out here if
-		   the flush returns error?
-		 */
-		rc = filemap_write_and_wait(inode->i_mapping);
-		if (rc != 0) {
-			cifsInode->write_behind_rc = rc;
-			rc = 0;
-		}
+	/*
+	 * Attempt to flush data before changing attributes. We need to do
+	 * this for ATTR_SIZE and ATTR_MTIME for sure, and if we change the
+	 * ownership or mode then we may also need to do this. Here, we take
+	 * the safe way out and just do the flush on all setattr requests. If
+	 * the flush returns error, store it to report later and continue.
+	 *
+	 * BB: This should be smarter. Why bother flushing pages that
+	 * will be truncated anyway? Also, should we error out here if
+	 * the flush returns error?
+	 */
+	rc = filemap_write_and_wait(inode->i_mapping);
+	if (rc != 0) {
+		cifsInode->write_behind_rc = rc;
+		rc = 0;
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-- 
1.6.0.6
