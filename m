From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: honor --abbrev=<n> when doing --pretty=oneline
Date: Thu, 06 Apr 2006 18:29:22 -0700
Message-ID: <7v64lmuqa5.fsf@assigned-by-dhcp.cox.net>
References: <20060407004455.GF15743@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 03:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRfn1-0002E6-1A
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 03:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWDGB3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 21:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDGB3Y
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 21:29:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22460 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932278AbWDGB3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 21:29:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407012923.DNLB20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Apr 2006 21:29:23 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060407004455.GF15743@hand.yhbt.net> (Eric Wong's message of
	"Thu, 6 Apr 2006 17:44:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18489>

Eric Wong <normalperson@yhbt.net> writes:

> Note that --abbrev=DEFAULT_ABBREV was on by default before, but
> it only affected the printing of the Merge: header).  Let me
> know if anybody doesn't want the default behavior to change.

I've never felt need for abbreviating commit object names, so I
only had the abbrev variable to determine how the merge parents
are shown.  If you want to abbreviate the commit object names as
well, you _could_ do independent precision for parents and
commits, but that would be overkil.  So I'd rather see a switch
to turn abbreviation for commits on, perhaps like this:

        $ git-rev-list --pretty=oneline --abbrev-commit -n 3 master
        454a35b Add documentation for git-imap-send.
        ba3c937 blame.c: fix completely broken ancestry traversal.
        6cbd5d7 Tweaks to make asciidoc play nice.

        $ git-rev-list --pretty=oneline --abbrev=4 --abbrev-commit -n 3 master
        454a Add documentation for git-imap-send.
        ba3c9 blame.c: fix completely broken ancestry traversal.
        6cbd5 Tweaks to make asciidoc play nice.

Otherwise you might break Porcelains and people's scripts that
read from --pretty or --header output.

-- >8 --
diff --git a/rev-list.c b/rev-list.c
index 22141e2..1301502 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -30,6 +30,7 @@ static const char rev_list_usage[] =
 "    --unpacked\n"
 "    --header | --pretty\n"
 "    --abbrev=nr | --no-abbrev\n"
+"    --abbrev-commit\n"
 "  special purpose:\n"
 "    --bisect"
 ;
@@ -39,6 +40,7 @@ struct rev_info revs;
 static int bisect_list = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
+static int abbrev_commit = 0;
 static int show_timestamp = 0;
 static int hdr_termination = 0;
 static const char *commit_prefix = "";
@@ -52,7 +54,10 @@ static void show_commit(struct commit *c
 		fputs(commit_prefix, stdout);
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
-	fputs(sha1_to_hex(commit->object.sha1), stdout);
+	if (abbrev_commit && abbrev)
+		fputs(find_unique_abbrev(commit->object.sha1, abbrev), stdout);
+	else
+		fputs(sha1_to_hex(commit->object.sha1), stdout);
 	if (revs.parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
@@ -317,6 +322,14 @@ int main(int argc, const char **argv)
 		}
 		if (!strcmp(arg, "--no-abbrev")) {
 			abbrev = 0;
+			continue;
+		}
+		if (!strcmp(arg, "--abbrev")) {
+			abbrev = DEFAULT_ABBREV;
+			continue;
+		}
+		if (!strcmp(arg, "--abbrev-commit")) {
+			abbrev_commit = 1;
 			continue;
 		}
 		if (!strncmp(arg, "--abbrev=", 9)) {
