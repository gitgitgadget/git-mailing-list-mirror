From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Silent File Mods Being Committed
Date: Wed, 22 Mar 2006 21:13:21 -0800
Message-ID: <7vek0t68we.fsf@assigned-by-dhcp.cox.net>
References: <E1FMH3o-0001B5-Dw@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 06:13:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMI8a-0008HR-M3
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 06:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWCWFNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 00:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWCWFNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 00:13:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28880 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932533AbWCWFNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 00:13:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323051323.UJPG17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 00:13:23 -0500
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FMH3o-0001B5-Dw@jdl.com> (Jon Loeliger's message of "Wed, 22
	Mar 2006 22:04:32 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17853>

Jon Loeliger <jdl@jdl.com> writes:

> However, 'git status' didn't show that output....
>
> And that is because it is driven by the diffcore instead!
> So I _think_ diff_resolve_rename_copy() has to be consulted
> to get that DIFF_STATUS_MODIFIED indicator.  Except that it is
> shared with the SHA1 compare too:
>
>                 else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
>                          p->one->mode != p->two->mode)
>                         p->status = DIFF_STATUS_MODIFIED;
>
> But I haven't tracked it back to see how to propagate that
> status back up to show_modified() in diff-files.c yet...

I think the cleanest way would be either

 (1) define another output format to diffcore similar to
     --name-status, let that format perform most of what
     DIFF_FORMAT_NAME_STATUS does, and update
     diff.c:diff_flush_raw() to show the mode change as M+ (old
     was not executable but new is) or M- (the other way); or

 (2) audit all the scripts to make sure they do not get upset if
     we add trailing +/- to the status letter, and do that
     unconditionally, like the attached patch does.

If you go the latter route, you would get something like this:

        $ ./git-diff-files --abbrev
        :100644 100755 c0548ee... 0000000... M+	diff.c
	$ ./git-diff-files --name-status
        M+	diff.c

---
diff --git a/diff.c b/diff.c
index c0548ee..09b8f7e 100644
--- a/diff.c
+++ b/diff.c
@@ -1034,6 +1034,10 @@ static void diff_flush_raw(struct diff_f
 		status[0] = p->status;
 		status[1] = 0;
 	}
+
+	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode)
+		strcat(status, (p->two->mode & 01) ? "+" : "-");
+
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
 	case DIFF_STATUS_RENAMED:
