From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Don't leak file descriptors from unavailable pack files.
Date: Fri, 02 Feb 2007 21:33:06 -0800
Message-ID: <7vzm7vbyb1.fsf@assigned-by-dhcp.cox.net>
References: <20070202080003.GA21094@spearce.org>
	<7vbqkdhs4d.fsf@assigned-by-dhcp.cox.net>
	<20070202085343.GD20832@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 06:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDDWW-00044Y-Ny
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 06:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946341AbXBCFdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 00:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946349AbXBCFdJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 00:33:09 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:44053 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946341AbXBCFdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 00:33:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203053307.HMGW1349.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 3 Feb 2007 00:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JtZ61W0041kojtg0000000; Sat, 03 Feb 2007 00:33:06 -0500
In-Reply-To: <20070202085343.GD20832@spearce.org> (Shawn O. Pearce's message
	of "Fri, 2 Feb 2007 03:53:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38551>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I agree leaking fd is not nice, but I wonder if that should be
>> dealt with by the caller.
>> 
>> Originally it did not matter as open_packed_git() died, but
>> shouldn't it be closing the fd and marking p->pack_fd with -1, as
>> you made it return instead of die?
>
> Yea, I thought of that when I wrote that evil patch...
>
> But open_packed_git has 12 things that can cause it to return
> an error.  That's basically a rewrite of the function.  This was
> 4 lines added to the only caller which didn't die().

Well, you can let the compiler to do the job, like this,
perhaps, if you really want to be lazy.  There won't be any
overhead from the extra call level, as there is only one caller
of open_packed_git_1() which will be inlined ;-).

diff --git a/sha1_file.c b/sha1_file.c
index 2eff14a..45e410e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -552,7 +552,11 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-static int open_packed_git(struct packed_git *p)
+/*
+ * Do not call this directly as this leaks p->pack_fd on error return;
+ * call open_packed_git() instead.
+ */
+static int open_packed_git_1(struct packed_git *p)
 {
 	struct stat st;
 	struct pack_header hdr;
@@ -608,6 +612,17 @@ static int open_packed_git(struct packed_git *p)
 	return 0;
 }
 
+static int open_packed_git(struct packed_git *p)
+{
+	if (!open_packed_git_1(p))
+		return 0;
+	if (p->pack_fd != -1) {
+		close(p->pack_fd);
+		p->pack_fd = -1;
+	}
+	return -1;
+}
+
 static int in_window(struct pack_window *win, unsigned long offset)
 {
 	/* We must promise at least 20 bytes (one hash) after the
