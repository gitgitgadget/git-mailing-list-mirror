From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: do not attempt to coalesce mode changes
Date: Sat, 15 Aug 2009 10:17:11 -0400
Message-ID: <20090815141710.GA15978@sigill.intra.peff.net>
References: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru>
 <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, Kirill Smelkov <kirr@mns.spb.ru>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 15 16:17:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McK4N-00020l-LX
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 16:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZHOORM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 10:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbZHOORM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 10:17:12 -0400
Received: from peff.net ([208.65.91.99]:44447 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbZHOORL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 10:17:11 -0400
Received: (qmail 21116 invoked by uid 107); 15 Aug 2009 14:17:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 15 Aug 2009 10:17:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Aug 2009 10:17:11 -0400
Content-Disposition: inline
In-Reply-To: <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126005>

On Sat, Aug 15, 2009 at 03:56:39PM +0200, Thomas Rast wrote:

> In 0392513 (add-interactive: refactor mode hunk handling, 2009-04-16),
> we merged the interaction loops for mode changes and hunk staging.
> This was fine at the time, because 0beee4c (git-add--interactive:
> remove hunk coalescing, 2008-07-02) removed hunk coalescing.
> 
> However, in 7a26e65 (Revert "git-add--interactive: remove hunk
> coalescing", 2009-05-16), we resurrected it.  Since then, the code
> would attempt in vain to merge mode changes with diff hunks,
> corrupting both in the process.

Thanks for the writeup; I bisected the problem to 7a26e65, as well, but
hadn't yet figured out what was going on. :)

> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -841,6 +841,10 @@
>  	my ($last_o_ctx, $last_was_dirty);
>  
>  	for (grep { $_->{USE} } @in) {
> +		if ($_->{TYPE} ne 'hunk') {
> +			push @out, $_;
> +			next;
> +		}
>  		my $text = $_->{TEXT};
>  		my ($o_ofs) = parse_hunk_header($text->[0]);
>  		if (defined $last_o_ctx &&

Hmm. I am not too familiar with the coalesce_overlapping_hunks code, but
it looks like we peek at $out[-1] based on $last_o_ctx, assuming that
$last_o_ctx comes from the last hunk pushed (either because we just
pushed it, or we merged into it).  So a non-hunk in the middle of some
coalescing hunks is going to violate that assumption.

As it is now, I think we always put the 'mode' hunk at the very
beginning, so that shouldn't happen (and IIRC, that order is preserved
throughout). So maybe it is not worth worrying about. But an alternate
patch is below.

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a06172c..c859bb4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -838,21 +838,26 @@ sub coalesce_overlapping_hunks {
 	my (@in) = @_;
 	my @out = ();
 
-	my ($last_o_ctx, $last_was_dirty);
+	my ($last_o_ctx, $last_was_dirty, $last_hunk);
 
 	for (grep { $_->{USE} } @in) {
+		if ($_->{TYPE} ne 'hunk') {
+			push @out, $_;
+			next;
+		}
 		my $text = $_->{TEXT};
 		my ($o_ofs) = parse_hunk_header($text->[0]);
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&
 		    !$last_was_dirty) {
-			merge_hunk($out[-1], $_);
+			merge_hunk($last_hunk, $_);
 		}
 		else {
 			push @out, $_;
+			$last_hunk = $_;
 		}
-		$last_o_ctx = find_last_o_ctx($out[-1]);
+		$last_o_ctx = find_last_o_ctx($last_hunk);
 		$last_was_dirty = $_->{DIRTY};
 	}
 	return @out;
