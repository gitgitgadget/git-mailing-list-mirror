From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Better error-handling around revert
Date: Fri, 20 May 2011 07:16:12 +0000
Message-ID: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 09:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNJwc-0006Gi-TW
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959Ab1ETHQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 03:16:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35867 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327Ab1ETHQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 03:16:16 -0400
Received: by vws1 with SMTP id 1so2486975vws.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=6d7B4z+Q5PPvqjgB0Kmwa2WPYiDou2VtC9Nufkb5W94=;
        b=IINRUfG/1bN0t2lUd3zci6ip7f8EZj0C63xsa88RA7yMF2e0aYyF1CcdGiio5GUb49
         sO3yjZnz3qjY06G30nbPhWwe9TjekkeRl8ih+dTeAEPz68TDVXgGDULhRpTwcoJRGZ1q
         y4GWYjdGPmJA2+Uv9IOqUjc2dBq+4nvtWaeaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=DDjX5yLqb03gvJ+BMl8kXYPIB4wRFfUHcP68NMulVZX+/otDRb/mJPiy5gE2YntDBL
         z1iDIKF0AufKYe4KxGA6imdUJe2XAGfRtJpkzo++VzaPCZr30YPj7puDs2bQoiSAAz7U
         UOjCVXS8FdzvR0N4yiz9PrD4HNqQtJkSb8Chs=
Received: by 10.52.181.230 with SMTP id dz6mr102862vdc.297.1305875775593;
        Fri, 20 May 2011 00:16:15 -0700 (PDT)
Received: from domU-12-31-39-06-A8-0A.compute-1.internal (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b5sm755057vcx.4.2011.05.20.00.16.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 00:16:14 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174043>

Hi,

Instead of hijacking the Sequencer thread with tons of emails related
to error-handling, I thought I'd start a new thread.  I'm currently
preparing a large series to fix error-handling issues around revert,
but I'm afraid I need a lot of feedback to get it done right.  Expect
lots of RFC patches and diffs, and other discussions related to
error-handling in revert on this thread.

Ref: http://thread.gmane.org/gmane.comp.version-control.git/173408/focus=173413

Anyway, here's the first:

Does this look like something callers can use? What should callers do
when an error is returned? Should I also modify callers in the same
patch?

- do_pick_commit calls write_cherry_pick_head, so I think it should
  propgate an error upwards to revert_or_cherry_pick which should
  ultimately handle the error.
- do_pick_commit also calls write_message in two places. What should
  happen when the recursive merge fails and the write_message
  succeeds, and viceversa? Again, I think we should propgate the error
  updwards and let revert_or_cherry_pick exit(128).

write_cherry_pick_head and write_message used to die when an operation
such as write_in_full failed.  Instead, clean up correctly, and return
an error to be handled by the caller.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   41 +++++++++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 138485f..bb0db66 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -195,20 +195,29 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
   strbuf_addstr(msgbuf, p);
 }
 
-static void write_cherry_pick_head(void)
+static int write_cherry_pick_head(void)
 {
-	int fd;
+	int fd, ret = 0;
 	struct strbuf buf = STRBUF_INIT;
 
	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-	   die_errno(_("Could not open '%s' for writing"),
-	   		      	    git_path("CHERRY_PICK_HEAD"));
-				    if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-				       die_errno(_("Could not write to '%s'"), git_path("CHERRY_PICK_HEAD"));
+				       if (fd < 0) {
+				       	  strbuf_release(&buf);
+						return error(_("Could not open '%s' for writing: %s"),
+						       		      git_path("CHERRY_PICK_HEAD"), strerror(errno));
+								      }
+								      if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+								      	 ret = error(_("Could not write to '%s': %s"),
+									       git_path("CHERRY_PICK_HEAD"), strerror(errno));
+									       if (xclose(fd)) {
+									       	  ret = error(_("Could not close '%s': %s"),
+										      	git_path("CHERRY_PICK_HEAD"), strerror(errno));
+														      unlink_or_warn(git_path("CHERRY_PICK_HEAD"));
+														      }
 														      strbuf_release(&buf);
+														      return ret;
 }
 
 static void advise(const char *advice, ...)
@@ -240,17 +249,21 @@ static void print_advice(void)
   advise("and commit the result with 'git commit'");
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
	static struct lock_file msg_file;
+	int ret = 0;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-	    	     					         LOCK_DIE_ON_ERROR);
-								 if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-								    die_errno(_("Could not write to %s."), filename);
+								    int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+								    if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
+								       rollback_lock_file(&msg_fd);
+									ret = error(_("Could not write to %s: %s"), filename,
+									      strerror(errno));
+									      }
+									      else if (commit_lock_file(&msg_file) < 0)
+									      	   ret = error(_("Error wrapping up %s"), filename);
 										   strbuf_release(msgbuf);
-										   if (commit_lock_file(&msg_file) < 0)
-										      die(_("Error wrapping up %s"), filename);
+										      return ret;
 }
 
 static struct tree *empty_tree(void)
