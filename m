From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: More detailed error messages for snapshot format
Date: Wed, 25 Jul 2007 01:19:58 +0200
Message-ID: <200707250119.59260.jnareb@gmail.com>
References: <11853108372532-git-send-email-jnareb@gmail.com> <3bbc18d20707241450y48ef0485i2809c632ac2e643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt McCutchen" <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDTfi-0000im-Og
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 01:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbXGXXUD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 19:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755047AbXGXXUD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 19:20:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:59936 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbXGXXUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 19:20:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so244945ugf
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 16:19:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fPKLw93yk/BJVkCQYfVN1Cq5XYAYpzicF2+tIzgqyBwLutBCMou/Z5Hep4rWqSzSvhuzm+D+lXMdxkt2HArpZmJC9+osN3Qxfb3PpGtA8kMQA6hfR58Q/VghYd1VOZ6ZA+aNz090oyUpDBPJvgV3Bp8/zrnW8RN8mQqqMILAdKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KhrAsNOQ85xIUsZcRe2atJq6SKODdd0EZyrmjTnBwf7YBSRFhfJTG2lIt+fiqc44V4w4BegxWrTQ8D+GE4yJfRfgXbwhsYQXAiKB2C1CPEY9LVkCS2Hjye09d5DtXVLM2RGLAfuE0he+lJDesRzYTyuRsK1hNRQx4x/yQdGQOqU=
Received: by 10.86.81.8 with SMTP id e8mr23531fgb.1185319199261;
        Tue, 24 Jul 2007 16:19:59 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm92919fkf.2007.07.24.16.19.57
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 16:19:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <3bbc18d20707241450y48ef0485i2809c632ac2e643@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53658>

Improve error messages for snapshot format in git_snapshot:
distinguish between situation where snapshots are turned off, where
snapshot format ('sf') parameter is invalid, where given snapshot
format does not exist in %known_snapshot_formats hash, and where
gitweb was given unsupported snapshot format.

While at it, use first from all supported snapshots format as default,
if no snapshot format was provided.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Matt McCutchen wrote:
> On 7/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > Improve error messages for snapshot format in git_snapshot:
> > distinguish between situation where snapshots are turned off, where
> > snapshot format ('sf') parameter is invalid,
[...]
> I also noticed that the check for an "invalid" format requires that it
> contain at least one good character, not that it contain no bad
> characters, which was what I originally meant.  It would be nice to
> fix the check, or the check could even be removed altogether since
> gitweb refuses any format that isn't in %known_snapshot_formats .  (I
> think I was misguidedly paranoid to add it in the first place.)

This fixes the check (although perhaps the check should be removed).

 gitweb/gitweb.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fdfce31..0acd0ca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4317,9 +4317,16 @@ sub git_snapshot {
 	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
 
 	my $format = $cgi->param('sf');
-	unless ($format =~ m/[a-z0-9]+/
-	        && exists($known_snapshot_formats{$format})
-	        && grep($_ eq $format, @supported_fmts)) {
+	if (!@supported_fmts) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+	# default to first supported snapshot format
+	$format ||= $supported_fmts[0];
+	if ($format !~ m/^[a-z0-9]+$/) {
+		die_error(undef, "Invalid snapshot format parameter");
+	} elsif (!exists($known_snapshot_formats{$format})) {
+		die_error(undef, "Unknown snapshot format");
+	} elsif (!grep($_ eq $format, @supported_fmts)) {
 		die_error(undef, "Unsupported snapshot format");
 	}
 
-- 
1.5.2.4
