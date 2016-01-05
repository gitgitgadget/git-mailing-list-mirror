From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v4] git-svn: add support for prefixed globs in config
Date: Tue, 5 Jan 2016 08:15:13 +0000
Message-ID: <20160105081513.GA32695@dcvr.yhbt.net>
References: <1451470149-14735-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqq60zfehyb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 09:15:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMlz-0000rA-4k
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbcAEIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:15:16 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45943 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbcAEIPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:15:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D02420208;
	Tue,  5 Jan 2016 08:15:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq60zfehyb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283366>

Junio C Hamano <gitster@pobox.com> wrote:
> Victor Leschuk <vleschuk@gmail.com> writes:
> > +	branches = branches/release_*:refs/remotes/project-a/branches/release_*
> 
> Hmph, if you are going this route, I wonder if there is a reason to
> limit yourself only to "prefix".  Would allowing something like this:
> 
> 	branches = branches/pre*post:refs/remotes/project-a/branches/*
> 
> i.e., loosening the rule to allow at most one asterisk anywhere on
> the left hand side of the colon, and require the same number of
> asterisks as the left hand side has on the right hand side of the
> colon, be too lax and hurt the users?

Seems doable.  Not sure about the consequences, yet...

I also think the $1 truthiness check was unnecessary and even
problematic if we need to encounter a "0" as a path component.
And using the path component will need to be quoted as we do below
with the brace case (showing with diff -U6)

Perhaps this? (untested)

diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index a136090..7961a78 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -12,16 +12,17 @@ sub new {
 				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
 	for my $part (split(m|/|, $glob)) {
 		if ($pattern_ok && $part =~ /[{}]/ &&
 			 $part !~ /^\{[^{}]+\}/) {
 			die "Invalid pattern in '$glob': $part\n";
 		}
-		if ($part =~ /(\w*)\*/) {
+		if ($part =~ /(\w*)\*(\w*)/) {
+			my ($l, $r) = ($1, $2);
 			die $die_msg if $state eq "right";
 			$state = "pattern";
-			my $pat = $1 ? "${1}[^/]+" : "[^/]*";
+			my $pat = quotemeta($l) . '[^/]*'. quotemeta($r);
 			push(@patterns, $pat);
 		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
 			my $p = quotemeta($1);
 			$p =~ s/\\,/|/g;
-- 
EW
