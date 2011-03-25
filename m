From: Jeff King <peff@peff.net>
Subject: Re: merge recursive and code movement
Date: Fri, 25 Mar 2011 07:12:25 -0400
Message-ID: <20110325111225.GC9047@sigill.intra.peff.net>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
 <20110325093758.GA9047@sigill.intra.peff.net>
 <20110325101204.GB9047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q34yd-0001eY-O4
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 12:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934511Ab1CYLOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 07:14:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52992
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934509Ab1CYLM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 07:12:29 -0400
Received: (qmail 12875 invoked by uid 107); 25 Mar 2011 11:13:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 07:13:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 07:12:25 -0400
Content-Disposition: inline
In-Reply-To: <20110325101204.GB9047@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169982>

On Fri, Mar 25, 2011 at 06:12:04AM -0400, Jeff King wrote:

> Ah, found it. In process_renames, we explicitly call remove_file() on
> the source, which is assuming the rename did not come from a broken
> pair. What we actually want to do, I think, is to just take the changes
> from the renaming side literally. There's no point in doing a 3-way
> merge because the other side's changes will end up applied to the rename
> destination.  It just happens that without break_opt, the renaming sides
> change is _always_ a deletion, or else it would not have been a rename
> candidate. So the current code is a special case for that rule.
> 
> Now, as far as how to do that, I haven't a clue. I've been staring at
> merge-recursive code for 30 minutes. ;)

So this is what I ended up with:

diff --git a/merge-recursive.c b/merge-recursive.c
index 8e82a8b..af42530 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -426,6 +426,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			    1000;
 	opts.rename_score = o->rename_score;
 	opts.show_rename_progress = o->show_rename_progress;
+	opts.break_opt = 0;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
@@ -706,6 +707,17 @@ static void update_file(struct merge_options *o,
 	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
+static int update_or_remove(struct merge_options *o,
+			    const unsigned char *sha1, unsigned mode,
+			    const char *path, int update_wd)
+{
+	if (is_null_sha1(sha1))
+		return remove_file(o, 1, path, !update_wd);
+
+	update_file_flags(o, sha1, mode, path, 1, update_wd);
+	return 0;
+}
+
 /* Low level file merging, update and removal */
 
 struct merge_file_info {
@@ -1049,7 +1061,10 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
+			update_or_remove(o,
+				ren1->src_entry->stages[renamed_stage].sha,
+				ren1->src_entry->stages[renamed_stage].mode,
+				ren1_src, renamed_stage == 3);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;

It passes my test, and it doesn't break anything in t/. Yay.

There's one other call to remove_file in process_renames. It's for the
case that both sides renamed the same file to the same destination.  I
think there we need to actually compare the two sides. If only one side
still has something at the source path, then we can take that side
(since the other side renamed away the file). But if they both have it
(i.e., they both installed a replacement), then we need to do the usual
3-way merge on that replacement. I'm not sure if we'd have to do that
ourselves, or if we can just punt and the rest of the merge machinery
will handle the entry. I'll have to write some tests, I think.

-Peff
