From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Better error-handling around revert
Date: Fri, 20 May 2011 07:28:47 +0000
Message-ID: <20110520072846.GB6755@domU-12-31-39-06-A8-0A.compute-1.internal>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 09:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNK8u-0004WF-Dt
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934212Ab1ETH2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 03:28:54 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:32953 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933995Ab1ETH2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 03:28:51 -0400
Received: by qyk7 with SMTP id 7so121195qyk.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+vvntNPa+0yD3N3SIsI/VyoYFjD/on/zR812V4tQiao=;
        b=rkrgJCrsL+ZNrwgeoI3DTXlGScuL19vb/ykvaQvLMrNzsvksEoDldUQtCzpZjVjm01
         CFtq5kEwYnXosM38CpfuXbizvmaKHcmcVOiThJ0oOpANnBFhqlNJwaVp1KHMc+1gXKAY
         ZtDxPnVNUOa0nwTBC3WiXkIp/0UixD3Uze2EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZSds3cDEQMyGRhp0ccKlH6AX+EVcApTPG1nwL78lyR3AzRpSlN49Ntg1mrU0orNq86
         orrcAFafxvE4WyVdQNjKJxvo50si+d7t/IZnq3Grh4DIR4/3DYvg2UVkhTS5q55yv8ca
         ff0TzBp4Fryq4DI8D8hwnZwqp76ixivzL6Jn8=
Received: by 10.224.215.70 with SMTP id hd6mr3039392qab.266.1305876530423;
        Fri, 20 May 2011 00:28:50 -0700 (PDT)
Received: from domU-12-31-39-06-A8-0A.compute-1.internal (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id f5sm2095186qck.8.2011.05.20.00.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 00:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174044>

Hi,

Ugh, sorry about the whitespace breakage. Here's a fresh diff:

    write_cherry_pick_head and write_message used to die when an operation
    such as write_in_full failed.  Instead, clean up correctly, and return
    an error to be handled by the caller.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

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
-int fd;
+int fd, ret = 0;
struct strbuf buf = STRBUF_INIT;
 
strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
-if (fd < 0)
-die_errno(_("Could not open '%s' for writing"),
	    -  git_path("CHERRY_PICK_HEAD"));
-if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-die_errno(_("Could not write to '%s'"), git_path("CHERRY_PICK_HEAD"));
+if (fd < 0) {
+strbuf_release(&buf);
+return error(_("Could not open '%s' for writing: %s"),
	       +git_path("CHERRY_PICK_HEAD"), strerror(errno));
+}
+if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+ret = error(_("Could not write to '%s': %s"),
	      +git_path("CHERRY_PICK_HEAD"), strerror(errno));
+if (xclose(fd)) {
+ret = error(_("Could not close '%s': %s"),
	      +git_path("CHERRY_PICK_HEAD"), strerror(errno));
+unlink_or_warn(git_path("CHERRY_PICK_HEAD"));
+}
strbuf_release(&buf);
+return ret;
 }
 
 static void advise(const char *advice, ...)
@@ -240,17 +249,21 @@ static void print_advice(void)
advise("and commit the result with 'git commit'");
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
static struct lock_file msg_file;
+int ret = 0;
 
-int msg_fd = hold_lock_file_for_update(&msg_file, filename,
						   -       LOCK_DIE_ON_ERROR);
-if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-die_errno(_("Could not write to %s."), filename);
+int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
+rollback_lock_file(&msg_fd);
+ret = error(_("Could not write to %s: %s"), filename,
	      +strerror(errno));
+}
+else if (commit_lock_file(&msg_file) < 0)
+ret = error(_("Error wrapping up %s"), filename);
strbuf_release(msgbuf);
-if (commit_lock_file(&msg_file) < 0)
-die(_("Error wrapping up %s"), filename);
+return ret;
 }
 
 static struct tree *empty_tree(void)
