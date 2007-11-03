From: Junio C Hamano <gitster@pobox.com>
Subject: Re: *[PATCH 2/2] Let git-add--interactive read colors from .gitconfig
Date: Fri, 02 Nov 2007 22:06:08 -0700
Message-ID: <7vy7dfyl33.fsf_-_@gitster.siamese.dyndns.org>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224111.7f7e165c@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 06:06:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoBDR-0005sd-Vp
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 06:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbXKCFGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 01:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbXKCFGX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 01:06:23 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:55174 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbXKCFGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 01:06:22 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 494CC2EF;
	Sat,  3 Nov 2007 01:06:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 43AF38FA03;
	Sat,  3 Nov 2007 01:06:33 -0400 (EDT)
In-Reply-To: <20071102224111.7f7e165c@paradox.zwell.net> (Dan Zwell's message
	of "Fri, 2 Nov 2007 22:41:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63204>

Dan Zwell <dzwell@zwell.net> writes:

> One thought is that is seems a bit sloppy to call "require Term::ANSIColor"
> within color_to_ansi_code(), but I can't really see a better way. After all,
> that is where the methods from that library are really needed. And I don't
> know why Git.pm should need to know whether color will end up being used.

How big is Term::ANSIColor, and how universally available is it?
Implementing the ANSI "ESC [ %d m" arithmetic color.c in Perl
ourselves does not feel too much effort, compared to the
potential hassle of dealing with extra dependencies and
potential drift between scripts and C implementation.

We may later want to update the C side to take colors from
terminfo, but that is a separate topic ;-)

Since your 2/2 updates on your 1/2, the diff is difficult to
comment on, so I'll comment on the combined effects.

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ac598f8..2bce5a1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,44 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
+
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
+	$use_color = "true";
+	# Grab the 3 main colors in git color string format, with sane
+	# (visible) defaults:
+	my $repo = Git->repository();
+	my $git_prompt_color =
+		Git::config($repo, "color.interactive.prompt")||"bold blue";
+	my $git_header_color =
+		Git::config($repo, "color.interactive.header")||"bold";
+	my $git_help_color =
+		Git::config($repo, "color.interactive.help")||"red bold";
+
+	$prompt_color = Git::color_to_ansi_code($git_prompt_color);
+	$header_color = Git::color_to_ansi_code($git_header_color);
+	$help_color   = Git::color_to_ansi_code($git_help_color);
+	$normal_color = Git::color_to_ansi_code("normal");
+}

If we are to still use Term::ANSIColor, then we might want to
protect ourselves from a broken installation:

        if ($color_config =~ /true|always/ ||
            -t STDOUT && $color_config =~ /auto/) {
                eval { require Term::ANSIColor; };
                if (!$@) {
                        $use_color = 1;
                        ... set up the colors ...
                }
                else {
                        $use_color = 0;
                }
        }

Then you can remove the require from Git::color_to_ansi_code().
Your current calling convention is to require the calling site
to be sure the module is availble; the suggested change merely
makes it responsible to also make sure the module is loaded.

Hmm?

By the way, coloring the diff text itself may be just the matter
of doing something like this (except that you now need to snarf
OLD, NEW, METAINFO and FRAGINFO colors for diff configuration as
well.

In addition to a small matter of testing, a more practical issue
would be to add PAGER support there, I think.

---

 git-add--interactive.perl |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 2bce5a1..1063a34 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -388,6 +388,27 @@ sub parse_diff {
 	return @hunk;
 }
 
+sub print_diff_hunk {
+	my ($text) = @_;
+	for (@$text) {
+		if (!$use_color) {
+			print;
+			next;
+		}
+		if (/^\+/) {
+			print_colored $new_color, $_;
+		} elsif (/^\-/) {
+			print_colored $old_color, $_;
+		} elsif (/^\@/) {
+			print_colored $fraginfo_color, $_;
+		} elsif (/^ /) {
+			print_colored $normal_color, $_;
+		} else {
+			print_colored $metainfo_color, $_;
+		}
+	}
+}
+
 sub hunk_splittable {
 	my ($text) = @_;
 
@@ -610,9 +631,7 @@ sub patch_update_cmd {
 	my ($ix, $num);
 	my $path = $it->{VALUE};
 	my ($head, @hunk) = parse_diff($path);
-	for (@{$head->{TEXT}}) {
-		print;
-	}
+	print_diff_hunk($head->{TEXT});
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -654,9 +673,7 @@ sub patch_update_cmd {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
-		for (@{$hunk[$ix]{TEXT}}) {
-			print;
-		}
+		print_diff_hunk($hunk[$ix]{TEXT});
 		print_colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
@@ -794,8 +811,7 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff-index -p --cached HEAD --),
-	       map { $_->{VALUE} } @them);
+	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
