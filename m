Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3341F1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 06:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968407AbdD1Gh3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 02:37:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:41494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968279AbdD1Gh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 02:37:28 -0400
Received: (qmail 29447 invoked by uid 109); 28 Apr 2017 06:37:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 06:37:25 +0000
Received: (qmail 16987 invoked by uid 111); 28 Apr 2017 06:37:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 02:37:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 02:37:23 -0400
Date:   Fri, 28 Apr 2017 02:37:23 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Suggestion] Alternative way for displaying help menu of patch
 flow
Message-ID: <20170428063723.2ni2v6akosm4ldvy@sigill.intra.peff.net>
References: <b55bd985-be6a-7fd6-1744-7ffb9d8b4ce8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b55bd985-be6a-7fd6-1744-7ffb9d8b4ce8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 10:44:22AM +0530, Kaartic Sivaraam wrote:

> I guess it would be better to display the help menu in a separate flow, like
> when the user click the `?` option in the `patch` flow then the whole screen
> is cleared and the help menu is displayed in some appropriate place and
> after the user has viewed the help menu he could quit from the help screen
> (probably by using a key like `q`) to continue where he left off. I think it
> would be better because, in general, a user would want to see the help menu
> when he uses the `?` option in the patch flow, not the hunk that gets
> displayed after it.

I think it would be nicer to avoid modality in the interface. I.e.,
rather than having "?" switch you into "help mode", stay at the same
hunk prompt but just don't show the hunk again automatically. In most
cases it will still be visible on the screen anyway, and there probably
ought to be a "r"edisplay command if the user wants to see it from
scratch.

Something like the patch at the end of this message.

I think this problem does extend to other output we show in the patch
loop. For instance, if you hit 'j' and there is no, you get:

  $ git add -p
  diff --git a/foo b/foo
  index 3367afd..3e75765 100644
  --- a/foo
  +++ b/foo
  @@ -1 +1 @@
  -old
  +new
  Stage this hunk [y,n,q,a,d,/,e,?]? j
  No next hunk
  @@ -1 +1 @@
  -old
  +new
  Stage this hunk [y,n,q,a,d,/,e,?]? 

If the hunk is big, that message scrolls off the screen. We could
probably put it after the hunk, but I'd worry that the ordering would be
confusing (because it comes between the hunk and the "this hunk" prompt.

Or it could just not re-display the hunk all (like what my patch does
for help), and you'd get:

  @@ -1 +1 @@
  -old
  +new
  Stage this hunk [y,n,q,a,d,/,e,?]? j
  No next hunk
  Stage this hunk [y,n,q,a,d,/,e,?]? 

at which point you could "r" to redisplay it if you wanted to.

I also suspect that other menus in add--interactive have the same
issue. E.g., if you have a large number of files what does the
file-selection menu "git add -i" look like? Perhaps the issue is less
common there, though.

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6ce..81f62331b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1237,6 +1237,7 @@ k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
+r - redisplay the current hunk
 ? - print help
 EOF
 }
@@ -1385,6 +1386,7 @@ my %patch_update_prompt_modes = (
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
+	my $skip_hunk_display;
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
 	($head, my $mode, my $deletion) = parse_diff_header($head);
@@ -1451,8 +1453,13 @@ sub patch_update_file {
 		if ($hunk[$ix]{TYPE} eq 'hunk') {
 			$other .= ',e';
 		}
-		for (@{$hunk[$ix]{DISPLAY}}) {
-			print;
+
+		if ($skip_hunk_display) {
+			$skip_hunk_display = 0;
+		} else {
+			for (@{$hunk[$ix]{DISPLAY}}) {
+				print;
+			}
 		}
 		print colored $prompt_color,
 			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
@@ -1608,8 +1615,13 @@ sub patch_update_file {
 					splice @hunk, $ix, 1, $newhunk;
 				}
 			}
+			elsif ($line =~ /^r/) {
+				# do nothing; we'll show the hunk when we loop
+				next;
+			}
 			else {
 				help_patch_cmd($other);
+				$skip_hunk_display = 1;
 				next;
 			}
 			# soft increment
