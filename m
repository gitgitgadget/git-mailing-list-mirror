From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash
Date: Sat, 31 May 2008 16:19:24 +0200
Message-ID: <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
References: <20080531130450.GI18781@machine.or.cz>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 16:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Rwg-0007Tb-6t
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYEaOTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYEaOTV
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:19:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33052 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbYEaOTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:19:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so323480fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=c7OZQ6KjSwvWdsU9uHusBlGhxBq3p4rSGJ2RGWFP19E=;
        b=lHHyjOrSK+IyNUCA4KM4ZTirJiI+r5mDxFYVJjv+QEKF1GGNjv0qdiyP5KnJu0HioIuhGQOXYOF2CpB9R3Bo8K1jSpUYhGqikQsxH9fQCSBBZQVNq5/XvzAGxZ8l9D1nhMLquZY+wZ3KmyI8s6qygr169GRsqi0FZ8gRrGWsHK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=tPYzIh72KBMJhJX2jOppt+6YZQ2WeFUESQUKKt3OfEdTNcOestd1AbsduWHCN+D4+Ea4cqd98/t+XSDyFfOOLoBsOSq220YzNLaIxuKGORYMgVFlfiFOFTxHs3+2AL4PliihQQUO2ryvIfo3KnraHTroHue2/OxVr8JV07rh3zg=
Received: by 10.86.70.8 with SMTP id s8mr2405277fga.31.1212243557815;
        Sat, 31 May 2008 07:19:17 -0700 (PDT)
Received: from fly ( [91.33.213.54])
        by mx.google.com with ESMTPS id 4sm1182888fgg.9.2008.05.31.07.19.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 07:19:17 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2RvY-0007q3-7j; Sat, 31 May 2008 16:19:24 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <20080531130450.GI18781@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83386>

This simplifies git_get_head_hash a lot; the method might eventually
even go away.

I haven't checked whether this causes an IO performance regression by
instantiating a new Git repository instance, but in the end
Git->repository will be as fast as possible and do no eager disk
accesses.  No benchmarking yet at this stage.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---

Per your request without the cleanup.  I won't submit the cleanup
patch separately, but I assume it will get cleaned up eventually when
someone touches that function.

 gitweb/gitweb.perl |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57a1905..0ed3d6e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -16,6 +16,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use Git;
 binmode STDOUT, ':utf8';
 
 BEGIN {
@@ -1508,20 +1509,11 @@ sub git_cmd_str {
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
 	my $project = shift;
-	my $o_git_dir = $git_dir;
-	my $retval = undef;
-	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
-		my $head = <$fd>;
-		close $fd;
-		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
-			$retval = $1;
-		}
-	}
-	if (defined $o_git_dir) {
-		$git_dir = $o_git_dir;
-	}
-	return $retval;
+	my $directory = "$projectroot/$project";
+	# Legacy side effect on $git_dir.  This will eventually go
+	# away as the global $git_dir is eliminated.
+	$git_dir = $directory if (!defined $git_dir);
+	Git->repository(Directory => $directory)->parse_rev("HEAD");
 }
 
 # get type of given object
-- 
1.5.5.GIT
