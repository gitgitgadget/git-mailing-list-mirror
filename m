From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 18:10:15 -0500
Message-ID: <20070130231015.GB10075@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 00:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC27b-0006C6-FI
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 00:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXA3XKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXA3XKV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 18:10:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4513 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752009AbXA3XKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 18:10:19 -0500
Received: (qmail 15749 invoked from network); 30 Jan 2007 18:10:42 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Jan 2007 18:10:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jan 2007 18:10:15 -0500
Content-Disposition: inline
In-Reply-To: <87odognuhl.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38213>

On Tue, Jan 30, 2007 at 12:13:26PM -0800, Carl Worth wrote:

> Also, if I'm willing to assume (or insist) that users have git 1.5 or
> newer, it'd be nice to be able to drop the "-b build" thing thanks to
> the new detached HEAD support. But if I suggest doing just:
> 
> 		git checkout origin/proposed-fix
> 
> the user is presented with the following message which is much more
> scary than useful in this situation:
> 
> 	warning: you are not on ANY branch anymore.
> 	If you meant to create a new branch from the commit, you need -b to
> 	associate a new branch with the wanted checkout.  Example:
> 	  git checkout -b <new_branch_name> origin/proposed-fix

I don't see any reason why we can't scare the user when making a commit,
instead of just checkout out to look around. Something like the patch
below. It needs a few things:
  - remove the old checkout message
  - we wrap the colorization over the multi-line message. Probably a
    color_printf_lines() function should be added
  - if colorization is enabled, print it using color.status.warning
    (default to red).

I'm happy to make all those happen if there is interest (Junio, please
comment).

diff --git a/wt-status.c b/wt-status.c
index 5567868..285c824 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,12 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
+static const char detach_warn[] =
+"# Any commits you make may become inaccessible if you checkout\n"
+"# another branch. To save them, you may create a new branch\n"
+"# from the current HEAD using:\n"
+"#   git checkout -b <new_branch_name>\n"
+"#";
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -303,16 +309,13 @@ void wt_status_print(struct wt_status *s)
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 
 	if (s->branch) {
-		const char *on_what = "On branch ";
-		const char *branch_name = s->branch;
-		if (!strncmp(branch_name, "refs/heads/", 11))
-			branch_name += 11;
-		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name = "";
-			on_what = "Not currently on any branch.";
+		const char *c = color(WT_STATUS_HEADER);
+		if (!strncmp(s->branch, "refs/heads/", 11))
+			color_printf_ln(c, "# On branch %s", s->branch+11);
+		else {
+			color_printf_ln(c, "# Not currently on any branch.");
+			color_printf_ln(c, detach_warn);
 		}
-		color_printf_ln(color(WT_STATUS_HEADER),
-			"# %s%s", on_what, branch_name);
 	}
 
 	if (s->is_initial) {
