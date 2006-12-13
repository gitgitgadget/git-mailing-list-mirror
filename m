X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow subcommand.color and color.subcommand color configuration
Date: Wed, 13 Dec 2006 14:16:44 -0800
Message-ID: <7vodq7e90z.fsf@assigned-by-dhcp.cox.net>
References: <200612130913.28917.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 22:16:55 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612130913.28917.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 13 Dec 2006 09:13:28 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34239>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucPB-0007cE-Kr for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751660AbWLMWQq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWLMWQq
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:16:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58168 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751659AbWLMWQq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 17:16:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213221645.GXZB4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 17:16:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yNGw1V00Z1kojtg0000000; Wed, 13 Dec 2006
 17:16:56 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> While adding colour to the branch command it was pointed out that a
> config option like "branch.color" conflicts with the pre-existing
> "branch.something" namespace used for specifying default merge urls and
> branches.  The suggested solution was to flip the order of the
> components to "color.branch", which I did for colourising branch.
> ...
> Unfortunately git-svn reads "diff.color" and "pager.color"; which I
> don't like to change unilaterally.

I think doing the same makes sense.  Something like this?

-- >8 --
git-svn: allow both diff.color and color.diff

The list concensus is to group color related configuration under
"color.*" so let's be consistent.

Inspired by Andy Parkins's patch to do the same for diff/log
family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-svn.perl b/git-svn.perl
index ec92b44..2893e3b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -925,19 +925,38 @@ sub cmt_showable {
 
 sub log_use_color {
 	return 1 if $_color;
-	my $dc;
-	chomp($dc = `git-repo-config --get diff.color`);
+	my ($dc, $dcvar);
+	$dcvar = 'color.diff'
+	$dc = `git-repo-config --get $dcvar`;
+	if ($dc eq '') {
+		# nothing at all; fallback to "diff.color"
+		$dcvar = 'diff.color';
+		$dc = `git-repo-config --get $dcvar`;
+	}
+	chomp($dc);
 	if ($dc eq 'auto') {
-		if (-t *STDOUT || (defined $_pager &&
-		    `git-repo-config --bool --get pager.color` !~ /^false/)) {
+		my $pc;
+		$pc = `git-repo-config --get color.pager`;
+		if ($pc eq '') {
+			# does not have it -- fallback to pager.color
+			$pc = `git-repo-config --bool --get pager.color`;
+		}
+		else {
+			$pc = `git-repo-config --bool --get color.pager`;
+			if ($?) {
+				$pc = 'false';
+			}
+		}
+		chomp($pc);
+		if (-t *STDOUT || (defined $_pager && $pc eq 'true') {
 			return ($ENV{TERM} && $ENV{TERM} ne 'dumb');
 		}
 		return 0;
 	}
 	return 0 if $dc eq 'never';
 	return 1 if $dc eq 'always';
-	chomp($dc = `git-repo-config --bool --get diff.color`);
-	$dc eq 'true';
+	chomp($dc = `git-repo-config --bool --get $dcvar`);
+	return ($dc eq 'true');
 }
 
 sub git_svn_log_cmd {
