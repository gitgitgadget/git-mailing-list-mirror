Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F2B20193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757251AbcKBWhI (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:37:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:37733 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754186AbcKBWhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:37:08 -0400
Received: (qmail 24089 invoked by uid 109); 2 Nov 2016 22:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 22:37:07 +0000
Received: (qmail 7343 invoked by uid 111); 2 Nov 2016 22:37:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:37:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 18:37:05 -0400
Date:   Wed, 2 Nov 2016 18:37:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: RFE: Discard hunks during `git add -p`
Message-ID: <20161102223705.qycdo3j2bvndi7ev@sigill.intra.peff.net>
References: <alpine.LSU.2.20.1611021435280.21207@nerf40.vanv.qr>
 <20161102221113.peur2zyfs66bdchm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102221113.peur2zyfs66bdchm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 06:11:14PM -0400, Jeff King wrote:

> > Being able to discard hunks (reset working copy to index contents) 
> > during add-p would alleviate the (quite broad) hard reset.
> 
> As Konstantin pointed out, you can already discard interactively with
> "git checkout -p". It might be nice to be able to do both in the same
> run, and turn the "yes/no" decision into "yes/no/discard".
> 
> In theory it should be easy, as the same code drives the hunk selector
> for both commands. It's just a matter of which command we feed the
> selected hunks to. I don't know if there would be corner cases around
> hunk-editing and splitting, though. The "add" phase should never touch
> the working tree file itself, so any hunks present from the initial list
> should still apply cleanly during the "discard" phase.

The patch is something like the one below, which worked for me in a very
trivial test. I won't be surprised if there are some corner cases it's
missing. At the very least, coalesce_overlapping_hunks() needs to learn
about the differences between "apply" and "discard" hunks (and not
coalesce them!).

I don't have immediate plans for this, so if somebody wants to pick it
up and run with it, be my guest.

-Peff

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ee3d81269..43651435a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -109,6 +109,7 @@ my %patch_modes = (
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
+		DISCARD => sub { apply_patch 'apply -R', @_; },
 	},
 	'stash' => {
 		DIFF => 'diff-index -p HEAD',
@@ -1325,6 +1326,11 @@ sub patch_update_file {
 		my ($prev, $next, $other, $undecided, $i);
 		$other = '';
 
+		my $discard = exists $patch_mode_flavour{DISCARD};
+		if ($discard) {
+			$other .= ',D';
+		}
+
 		if ($num <= $ix) {
 			$ix = 0;
 		}
@@ -1384,6 +1390,9 @@ sub patch_update_file {
 			elsif ($line =~ /^n/i) {
 				$hunk[$ix]{USE} = 0;
 			}
+			elsif ($discard && $line =~ /^D/) {
+				$hunk[$ix]{USE} = -1;
+			}
 			elsif ($line =~ /^a/i) {
 				while ($ix < $num) {
 					if (!defined $hunk[$ix]{USE}) {
@@ -1539,9 +1548,12 @@ sub patch_update_file {
 
 	my $n_lofs = 0;
 	my @result = ();
+	my @discard = ();
 	for (@hunk) {
-		if ($_->{USE}) {
+		if ($_->{USE} > 0) {
 			push @result, @{$_->{TEXT}};
+		} elsif ($_->{USE} < 0) {
+			push @discard, @{$_->{TEXT}};
 		}
 	}
 
@@ -1552,6 +1564,13 @@ sub patch_update_file {
 		refresh();
 	}
 
+	if (@discard) {
+		my @patch = reassemble_patch($head->{TEXT}, @discard);
+		my $apply_routine = $patch_mode_flavour{DISCARD};
+		&$apply_routine(@patch);
+		refresh();
+	}
+
 	print "\n";
 	return $quit;
 }
