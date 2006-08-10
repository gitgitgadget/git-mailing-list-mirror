From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Wed, 09 Aug 2006 22:43:57 -0700
Message-ID: <7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	<20060810033448.GH8776@1wt.eu>
	<7vu04lxjsv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 07:44:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB3Ku-00039V-IL
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 07:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWHJFoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 01:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWHJFn7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 01:43:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42411 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932387AbWHJFn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 01:43:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810054358.YUGF12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 01:43:58 -0400
To: Willy Tarreau <w@1wt.eu>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25154>

Junio C Hamano <junkio@cox.net> writes:

> Willy Tarreau <w@1wt.eu> writes:
>
>> I encountered a problem in 1.4.1 and 1.4-git about 2 weeks ago
>> (I've not tried 1.4.2-rc4 yet). When applying a git patch which
>> contains a symlink, the symlink created on the filesystem sometimes
>> has a wrong name with some chars appended to its end.
>
> Thanks.  I can reproduce this, and am looking into it.

Found it.  The patch application mechanism uses a counted string
(char *buf with ulong size) to hold the result, and the code
stupidly threw the buf to symlink(2), without making it NUL
terminated.


diff --git a/builtin-apply.c b/builtin-apply.c
index f8c6763..c159873 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1698,6 +1698,14 @@ static int apply_data(struct patch *patc
 	desc.buffer = buf;
 	if (apply_fragments(&desc, patch) < 0)
 		return -1;
+
+	/* NUL terminate the result */
+	if (desc.alloc <= desc.size) {
+		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
+		desc.alloc++;
+	}
+	desc.buffer[desc.size] = 0;
+
 	patch->result = desc.buffer;
 	patch->resultsize = desc.size;
 
@@ -2040,6 +2048,9 @@ static int try_create_file(const char *p
 	int fd;
 
 	if (S_ISLNK(mode))
+		/* Although buf:size is counted string, it also is NUL
+		 * terminated.
+		 */
 		return symlink(buf, path);
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
