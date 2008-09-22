From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] Use dashless git commands in setgitperms.perl
Date: Mon, 22 Sep 2008 07:30:08 -0400
Message-ID: <20080922113008.GO2939@inocybe.teonanacatl.org>
References: <20080919234234.GL2939@inocybe.teonanacatl.org>
 <gb1ej9$bg2$1@ger.gmane.org> <20080920004814.GM2939@inocybe.teonanacatl.org>
 <7v4p4b7gjr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 13:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhjdV-00020A-9S
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 13:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYIVLaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 07:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbYIVLaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 07:30:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYIVLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 07:30:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7333A63AC2;
	Mon, 22 Sep 2008 07:30:13 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id 9B5B963AC1; Mon, 22 Sep 2008 07:30:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4p4b7gjr.fsf@gitster.siamese.dyndns.org>
X-Listening-To: Ray LaMontagne - How Come
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: D289AADE-8899-11DD-8656-D0CFFE4BC1C1-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96473>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/hooks/setgitperms.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Junio C Hamano wrote:
> The patch is wrong on one point, and should be unnecessary.
> 
> First of all, you do not understand what "."  does in shell ;-)
> That is the "wrong" part.

Ugh, that was embarrassing to miss (bad enough to miss it on my own,
but worse to not notice it after Jakub questioned it).

> About the "unnecessary" part, a hook should run under an environment
> where exec-path is already added to the $PATH, so it should be able
> to find git-sh-setup just fine without your change.
> 
> But I think the politically correct way would be:
> 
> 	#!/bin/sh
> 	PATH=$(git --exec-path):$PATH
>       SUBDIRECTORY_OK=1 . git-sh-setup
> 	$GIT_DIR/hooks/setgitperms.perl -r
> 
> especially if we envision that somebody may run the script by
> itself, not from the hook.

Since that chunk is only in a comment explaining what to add to the
hook the user wants to run this script from, it seems like that really
is unnecessary.

I was in fact running .git/hooks/setgitperms.perl directly (to create
an initial .gitmeta file) which is why I noticed it used git-*
commands and was failing.  Using "git " makes that work for me.

> The change to the perl script should not be strictly necessary
> (because this is expected to be run from a hook), but to set a
> better example, I think it is a good idea to do these s/git-/git /
> substitutions.

Sounds good.  Here is a patch with just those changes.

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index dab7c8e..a577ad0 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -50,7 +50,7 @@ if ((@ARGV < 0) || !GetOptions(
 			      )) { die $usage; }
 die $usage unless ($read_mode xor $write_mode);
 
-my $topdir = `git-rev-parse --show-cdup` or die "\n"; chomp $topdir;
+my $topdir = `git rev-parse --show-cdup` or die "\n"; chomp $topdir;
 my $gitdir = $topdir . '.git';
 my $gitmeta = $topdir . '.gitmeta';
 
@@ -155,7 +155,7 @@ elsif ($read_mode) {
 	open (OUT, ">$gitmeta.tmp") or die "Could not open $gitmeta.tmp for writing: $!\n";
     }
 
-    my @files = `git-ls-files`;
+    my @files = `git ls-files`;
     my %dirs;
 
     foreach my $path (@files) {
-- 
1.6.0.2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Careful. We don't want to learn from this.
    -- Calvin
