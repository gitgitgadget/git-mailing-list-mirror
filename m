From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 8 Jan 2009 20:55:11 +0100
Message-ID: <20090108195511.GA8734@chistera.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Transfer-Encoding: 8bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL0zl-0001QN-1n
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 20:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbZAHTzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 14:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZAHTzS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 14:55:18 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4114
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbZAHTzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 14:55:16 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A7860801BF68;
	Thu,  8 Jan 2009 20:55:12 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LL0yF-0002Pe-OO; Thu, 08 Jan 2009 20:55:11 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Linus Torvalds [Fri, 02 Jan 2009 08:42:04 -0800]:

> Yes, this one is a real patience diff change, but it's also the same one 
> that I've seen in the google fanboi findings. What google did _not_ show 
> was any real-life examples, or anybody doing any critical analysis.

This comes a bit late and maybe it's redundant, but somebody just sent
to a Debian mailing list a patch that was hard to read, and patience
improved it. (I realize it's quite similar in spirit to the "toy
patience example" that google returns, but this at list is a *real*
example where patience helped me read a patch.)

I'm also attaching bzr diff output, because it's still more readable
IMHO. (I realize that's independent of patience, as you explained, but
I'm making a point that it'd be nice to have this addressed by somebody
knowledgeable.)

Thanks,

-- 
Adeodato Simó                                     dato at net.com.org.es
Debian Developer                                  adeodato at debian.org
 
- Are you sure we're good?
- Always.
                -- Rory and Lorelai

--n8g4imXOkfNTN/H1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git.diff"

diff --git util_sock.c util_sock.c
index e20768e..f7b9145 100644
--- util_sock.c
+++ util_sock.c
@@ -1037,40 +1037,109 @@ NTSTATUS read_data(int fd, char *buffer, size_t N)
 }
 
 /****************************************************************************
- Write data to a fd.
+ Write all data from an iov array
 ****************************************************************************/
 
-ssize_t write_data(int fd, const char *buffer, size_t N)
+ssize_t write_data_iov(int fd, const struct iovec *orig_iov, int iovcnt)
 {
-	size_t total=0;
-	ssize_t ret;
-	char addr[INET6_ADDRSTRLEN];
+	int i;
+	size_t to_send;
+	ssize_t thistime;
+	size_t sent;
+	struct iovec *iov_copy, *iov;
 
-	while (total < N) {
-		ret = sys_write(fd,buffer + total,N - total);
+	to_send = 0;
+	for (i=0; i<iovcnt; i++) {
+		to_send += orig_iov[i].iov_len;
+	}
 
-		if (ret == -1) {
-			if (fd == get_client_fd()) {
-				/* Try and give an error message saying
-				 * what client failed. */
-				DEBUG(0,("write_data: write failure in "
-					"writing to client %s. Error %s\n",
-					get_peer_addr(fd,addr,sizeof(addr)),
-					strerror(errno) ));
-			} else {
-				DEBUG(0,("write_data: write failure. "
-					"Error = %s\n", strerror(errno) ));
+	thistime = sys_writev(fd, orig_iov, iovcnt);
+	if ((thistime <= 0) || (thistime == to_send)) {
+		return thistime;
+	}
+	sent = thistime;
+
+	/*
+	 * We could not send everything in one call. Make a copy of iov that
+	 * we can mess with. We keep a copy of the array start in iov_copy for
+	 * the TALLOC_FREE, because we're going to modify iov later on,
+	 * discarding elements.
+	 */
+
+	iov_copy = (struct iovec *)TALLOC_MEMDUP(
+		talloc_tos(), orig_iov, sizeof(struct iovec) * iovcnt);
+
+	if (iov_copy == NULL) {
+		errno = ENOMEM;
+		return -1;
+	}
+	iov = iov_copy;
+
+	while (sent < to_send) {
+		/*
+		 * We have to discard "thistime" bytes from the beginning
+		 * iov array, "thistime" contains the number of bytes sent
+		 * via writev last.
+		 */
+		while (thistime > 0) {
+			if (thistime < iov[0].iov_len) {
+				char *new_base =
+					(char *)iov[0].iov_base + thistime;
+				iov[0].iov_base = new_base;
+				iov[0].iov_len -= thistime;
+				break;
 			}
-			return -1;
+			thistime -= iov[0].iov_len;
+			iov += 1;
+			iovcnt -= 1;
 		}
 
-		if (ret == 0) {
-			return total;
+		thistime = sys_writev(fd, iov, iovcnt);
+		if (thistime <= 0) {
+			break;
 		}
+		sent += thistime;
+	}
+
+	TALLOC_FREE(iov_copy);
+	return sent;
+}
+
+/****************************************************************************
+ Write data to a fd.
+****************************************************************************/
+
+/****************************************************************************
+ Write data to a fd.
+****************************************************************************/
+
+ssize_t write_data(int fd, const char *buffer, size_t N)
+{
+	ssize_t ret;
+	struct iovec iov;
+
+	iov.iov_base = CONST_DISCARD(char *, buffer);
+	iov.iov_len = N;
+
+	ret = write_data_iov(fd, &iov, 1);
+	if (ret >= 0) {
+		return ret;
+	}
 
-		total += ret;
+	if (fd == get_client_fd()) {
+		char addr[INET6_ADDRSTRLEN];
+		/*
+		 * Try and give an error message saying what client failed.
+		 */
+		DEBUG(0, ("write_data: write failure in writing to client %s. "
+			  "Error %s\n", get_peer_addr(fd,addr,sizeof(addr)),
+			  strerror(errno)));
+	} else {
+		DEBUG(0,("write_data: write failure. Error = %s\n",
+			 strerror(errno) ));
 	}
-	return (ssize_t)total;
+
+	return -1;
 }
 
 /****************************************************************************

--n8g4imXOkfNTN/H1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git_patience.diff"

diff --git util_sock.c util_sock.c
index e20768e..f7b9145 100644
--- util_sock.c
+++ util_sock.c
@@ -1037,40 +1037,109 @@ NTSTATUS read_data(int fd, char *buffer, size_t N)
 }
 
 /****************************************************************************
+ Write all data from an iov array
+****************************************************************************/
+
+ssize_t write_data_iov(int fd, const struct iovec *orig_iov, int iovcnt)
+{
+	int i;
+	size_t to_send;
+	ssize_t thistime;
+	size_t sent;
+	struct iovec *iov_copy, *iov;
+
+	to_send = 0;
+	for (i=0; i<iovcnt; i++) {
+		to_send += orig_iov[i].iov_len;
+	}
+
+	thistime = sys_writev(fd, orig_iov, iovcnt);
+	if ((thistime <= 0) || (thistime == to_send)) {
+		return thistime;
+	}
+	sent = thistime;
+
+	/*
+	 * We could not send everything in one call. Make a copy of iov that
+	 * we can mess with. We keep a copy of the array start in iov_copy for
+	 * the TALLOC_FREE, because we're going to modify iov later on,
+	 * discarding elements.
+	 */
+
+	iov_copy = (struct iovec *)TALLOC_MEMDUP(
+		talloc_tos(), orig_iov, sizeof(struct iovec) * iovcnt);
+
+	if (iov_copy == NULL) {
+		errno = ENOMEM;
+		return -1;
+	}
+	iov = iov_copy;
+
+	while (sent < to_send) {
+		/*
+		 * We have to discard "thistime" bytes from the beginning
+		 * iov array, "thistime" contains the number of bytes sent
+		 * via writev last.
+		 */
+		while (thistime > 0) {
+			if (thistime < iov[0].iov_len) {
+				char *new_base =
+					(char *)iov[0].iov_base + thistime;
+				iov[0].iov_base = new_base;
+				iov[0].iov_len -= thistime;
+				break;
+			}
+			thistime -= iov[0].iov_len;
+			iov += 1;
+			iovcnt -= 1;
+		}
+
+		thistime = sys_writev(fd, iov, iovcnt);
+		if (thistime <= 0) {
+			break;
+		}
+		sent += thistime;
+	}
+
+	TALLOC_FREE(iov_copy);
+	return sent;
+}
+
+/****************************************************************************
+ Write data to a fd.
+****************************************************************************/
+
+/****************************************************************************
  Write data to a fd.
 ****************************************************************************/
 
 ssize_t write_data(int fd, const char *buffer, size_t N)
 {
-	size_t total=0;
 	ssize_t ret;
-	char addr[INET6_ADDRSTRLEN];
+	struct iovec iov;
 
-	while (total < N) {
-		ret = sys_write(fd,buffer + total,N - total);
+	iov.iov_base = CONST_DISCARD(char *, buffer);
+	iov.iov_len = N;
 
-		if (ret == -1) {
-			if (fd == get_client_fd()) {
-				/* Try and give an error message saying
-				 * what client failed. */
-				DEBUG(0,("write_data: write failure in "
-					"writing to client %s. Error %s\n",
-					get_peer_addr(fd,addr,sizeof(addr)),
-					strerror(errno) ));
-			} else {
-				DEBUG(0,("write_data: write failure. "
-					"Error = %s\n", strerror(errno) ));
-			}
-			return -1;
-		}
-
-		if (ret == 0) {
-			return total;
-		}
+	ret = write_data_iov(fd, &iov, 1);
+	if (ret >= 0) {
+		return ret;
+	}
 
-		total += ret;
+	if (fd == get_client_fd()) {
+		char addr[INET6_ADDRSTRLEN];
+		/*
+		 * Try and give an error message saying what client failed.
+		 */
+		DEBUG(0, ("write_data: write failure in writing to client %s. "
+			  "Error %s\n", get_peer_addr(fd,addr,sizeof(addr)),
+			  strerror(errno)));
+	} else {
+		DEBUG(0,("write_data: write failure. Error = %s\n",
+			 strerror(errno) ));
 	}
-	return (ssize_t)total;
+
+	return -1;
 }
 
 /****************************************************************************

--n8g4imXOkfNTN/H1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="bzr.diff"

--- util_sock.c
+++ util_sock.c
@@ -1037,40 +1037,109 @@
 }
 
 /****************************************************************************
+ Write all data from an iov array
+****************************************************************************/
+
+ssize_t write_data_iov(int fd, const struct iovec *orig_iov, int iovcnt)
+{
+	int i;
+	size_t to_send;
+	ssize_t thistime;
+	size_t sent;
+	struct iovec *iov_copy, *iov;
+
+	to_send = 0;
+	for (i=0; i<iovcnt; i++) {
+		to_send += orig_iov[i].iov_len;
+	}
+
+	thistime = sys_writev(fd, orig_iov, iovcnt);
+	if ((thistime <= 0) || (thistime == to_send)) {
+		return thistime;
+	}
+	sent = thistime;
+
+	/*
+	 * We could not send everything in one call. Make a copy of iov that
+	 * we can mess with. We keep a copy of the array start in iov_copy for
+	 * the TALLOC_FREE, because we're going to modify iov later on,
+	 * discarding elements.
+	 */
+
+	iov_copy = (struct iovec *)TALLOC_MEMDUP(
+		talloc_tos(), orig_iov, sizeof(struct iovec) * iovcnt);
+
+	if (iov_copy == NULL) {
+		errno = ENOMEM;
+		return -1;
+	}
+	iov = iov_copy;
+
+	while (sent < to_send) {
+		/*
+		 * We have to discard "thistime" bytes from the beginning
+		 * iov array, "thistime" contains the number of bytes sent
+		 * via writev last.
+		 */
+		while (thistime > 0) {
+			if (thistime < iov[0].iov_len) {
+				char *new_base =
+					(char *)iov[0].iov_base + thistime;
+				iov[0].iov_base = new_base;
+				iov[0].iov_len -= thistime;
+				break;
+			}
+			thistime -= iov[0].iov_len;
+			iov += 1;
+			iovcnt -= 1;
+		}
+
+		thistime = sys_writev(fd, iov, iovcnt);
+		if (thistime <= 0) {
+			break;
+		}
+		sent += thistime;
+	}
+
+	TALLOC_FREE(iov_copy);
+	return sent;
+}
+
+/****************************************************************************
+ Write data to a fd.
+****************************************************************************/
+
+/****************************************************************************
  Write data to a fd.
 ****************************************************************************/
 
 ssize_t write_data(int fd, const char *buffer, size_t N)
 {
-	size_t total=0;
 	ssize_t ret;
-	char addr[INET6_ADDRSTRLEN];
-
-	while (total < N) {
-		ret = sys_write(fd,buffer + total,N - total);
-
-		if (ret == -1) {
-			if (fd == get_client_fd()) {
-				/* Try and give an error message saying
-				 * what client failed. */
-				DEBUG(0,("write_data: write failure in "
-					"writing to client %s. Error %s\n",
-					get_peer_addr(fd,addr,sizeof(addr)),
-					strerror(errno) ));
-			} else {
-				DEBUG(0,("write_data: write failure. "
-					"Error = %s\n", strerror(errno) ));
-			}
-			return -1;
-		}
-
-		if (ret == 0) {
-			return total;
-		}
-
-		total += ret;
-	}
-	return (ssize_t)total;
+	struct iovec iov;
+
+	iov.iov_base = CONST_DISCARD(char *, buffer);
+	iov.iov_len = N;
+
+	ret = write_data_iov(fd, &iov, 1);
+	if (ret >= 0) {
+		return ret;
+	}
+
+	if (fd == get_client_fd()) {
+		char addr[INET6_ADDRSTRLEN];
+		/*
+		 * Try and give an error message saying what client failed.
+		 */
+		DEBUG(0, ("write_data: write failure in writing to client %s. "
+			  "Error %s\n", get_peer_addr(fd,addr,sizeof(addr)),
+			  strerror(errno)));
+	} else {
+		DEBUG(0,("write_data: write failure. Error = %s\n",
+			 strerror(errno) ));
+	}
+
+	return -1;
 }
 
 /****************************************************************************

--n8g4imXOkfNTN/H1--
