From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 17:03:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903241655210.3032@localhost.localdomain>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain> <49C94B02.5010604@mycircuit.org> <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain> <49C961D0.4010704@mycircuit.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Jeff Layton <jlayton@redhat.com>,
	Steve French <sfrench@us.ibm.com>
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGfP-0006BW-UU
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbZCYAGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbZCYAGb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:06:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46339 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755532AbZCYAG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:06:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2P03NKa026275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2009 17:03:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2P03Mhr024065;
	Tue, 24 Mar 2009 17:03:23 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <49C961D0.4010704@mycircuit.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114520>



On Tue, 24 Mar 2009, Peter wrote:
>
> Thanks a lot , I will check that out tomorrow, in the meantime, this is the
> result of your patch being applied:
> 
> $ git add <big stuff>
> 
> fatal: error when closing sha1 file (Bad file descriptor)

Ok, that's probably cifs_writepages() doing

                        open_file = find_writable_file(CIFS_I(mapping->host));
                        if (!open_file) {
                                cERROR(1, ("No writable handles for inode"));
                                rc = -EBADF;
			} else {
				..

so yeah, looks like it's the fchmod() that triggers it.

I suspect this would be a safer - if slightly slower - way to make sure 
the file is read-only. It's slower, because it is going to look up the 
filename once more, but I bet it is going to avoid this particular CIFS 
bug.

			Linus
---
 http-push.c |    2 +-
 sha1_file.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index 48e5f38..ba4fa4d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -748,8 +748,8 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		fchmod(request->local_fileno, 0444);
 		close(request->local_fileno); request->local_fileno = -1;
+		chmod(request->tmpfile, 0444);
 
 		if (request->curl_result != CURLE_OK &&
 		    request->http_code != 416) {
diff --git a/sha1_file.c b/sha1_file.c
index 4563173..8268da7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2285,9 +2285,8 @@ static void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
-	fchmod(fd, 0444);
 	if (close(fd) != 0)
-		die("unable to write sha1 file");
+		die("error when closing sha1 file (%s)", strerror(errno));
 }
 
 /* Size of directory component, including the ending '/' */
@@ -2384,6 +2383,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	close_sha1_file(fd);
 	free(compressed);
 
+	chmod(tmpfile, 0444);
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
