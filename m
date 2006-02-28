From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: war on whitespace -- finishing touches.
Date: Tue, 28 Feb 2006 01:13:57 -0800
Message-ID: <7vu0ajonfu.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060227011832.78359f0a.akpm@osdl.org>
	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
	<20060227153702.375db751.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:14:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0vl-0001bV-Jl
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 10:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWB1JN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 04:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWB1JN7
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 04:13:59 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:13247 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932106AbWB1JN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 04:13:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228091026.OCOL17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 04:10:26 -0500
To: git@vger.kernel.org
In-Reply-To: <20060227153702.375db751.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 27 Feb 2006 15:37:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16926>

Andrew Morton <akpm@osdl.org> writes:

> I'd suggest that git have options to a) generate trailing-whitespace
> warnings, b) generate trailing-whitespace errors and c) strip trailing
> whitespace while applying.   And that the as-shipped default be a).

I've done this and will be pushing it out to "master" branch on
my next git day (Wednesday, west coast US); "maint" branch will
have the same for v1.2.4 sometime by the end of this week.

There is one thing.  By making --whitespace=warn the default,
the diffstat output people would see after "git pull" would also
show the warning message.  I personally do not think this is a
problem (you will know how dirty a tree you are merging into
your tree), but it might not be a bad idea to explicitly squelch
it by making it not to warn when we are not applying.

-- >8 --

This changes the default --whitespace policy to nowarn when we
are only getting --stat, --summary etc. IOW when not applying
the patch.  When applying the patch, the default is warn (spit
out warning message but apply the patch).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 apply.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

f21d6726150ec4219e94ea605f27a4cd58eb3d99
diff --git a/apply.c b/apply.c
index c4ff418..9deb206 100644
--- a/apply.c
+++ b/apply.c
@@ -75,6 +75,15 @@ static void parse_whitespace_option(cons
 	die("unrecognized whitespace option '%s'", option);
 }
 
+static void set_default_whitespace_mode(const char *whitespace_option)
+{
+	if (!whitespace_option && !apply_default_whitespace) {
+		new_whitespace = (apply
+				  ? warn_on_whitespace
+				  : nowarn_whitespace);
+	}
+}
+
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
  * we've seen, and the longest filename. That allows us to do simple
@@ -1955,9 +1964,11 @@ int main(int argc, char **argv)
 		if (fd < 0)
 			usage(apply_usage);
 		read_stdin = 0;
+		set_default_whitespace_mode(whitespace_option);
 		apply_patch(fd, arg);
 		close(fd);
 	}
+	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
 		apply_patch(0, "<stdin>");
 	if (whitespace_error) {
-- 
1.2.3.g1da2
