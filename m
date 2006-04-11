From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-* --with-raw
Date: Mon, 10 Apr 2006 17:35:11 -0700
Message-ID: <7vr7456jb4.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5x7zh3.fsf@assigned-by-dhcp.cox.net>
	<7v3bgl7z80.fsf@assigned-by-dhcp.cox.net>
	<20060411002311.GW27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 02:35:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6qm-0000wT-RN
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWDKAfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWDKAfQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:35:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23794 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932205AbWDKAfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 20:35:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411003513.SEWT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 20:35:13 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060411002311.GW27689@pasky.or.cz> (Petr Baudis's message of
	"Tue, 11 Apr 2006 02:23:11 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18606>

Petr Baudis <pasky@suse.cz> writes:

> git-diff-* output is by default the raw format, and with the --with-raw
> option you tell it to furthermore include the raw format... sounds
> wrong, doesn't it? ;-) I'd call it --patch-with-raw or -P.

Since --raw-with-raw would be oximoron, I would say --with-raw
would naturally mean --patch-with-raw, but that's fine.

> Also, it would be nice to handle the -c case as well. Not strictly
> necessary for cg-log right now, but other cg-Xfollowrenames users might
> want to have that for merges... (Potentially, this might break renames
> detection but the case is really obscure.)

This would cover that request, comes on top of the previous one.

--

diff --git a/combine-diff.c b/combine-diff.c
index eb0d757..748dc30 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -832,6 +832,7 @@ const char *diff_tree_combined_merge(con
 
 	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diffopts.with_raw = 0;
 	diffopts.recursive = 1;
 
 	/* count parents */
@@ -858,6 +859,15 @@ const char *diff_tree_combined_merge(con
 			num_paths++;
 	}
 	if (num_paths) {
+		if (opt->with_raw) {
+			opt->output_format = DIFF_FORMAT_RAW;
+			for (p = paths; p; p = p->next) {
+				if (show_combined_diff(p, num_parent, dense,
+						       header, opt))
+					header = NULL;
+			}
+			opt->output_format = DIFF_FORMAT_PATCH;
+		}
 		for (p = paths; p; p = p->next) {
 			if (show_combined_diff(p, num_parent, dense,
 					       header, opt))
