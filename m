From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Optionally parse author information
Date: Fri, 14 Jan 2011 15:46:38 +0530
Message-ID: <20110114101636.GA22970@kytes>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
 <20110113032300.GB9184@burratino>
 <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
 <20110114080554.GA1735@kytes>
 <20110114082931.GC11343@burratino>
 <F0299861-B36C-459C-972E-856212A92615@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joe Corneli <holtzermann17@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Love =?iso-8859-1?Q?H=F6rnquist_=C5strand?= <lha@kth.se>
X-From: git-owner@vger.kernel.org Fri Jan 14 11:16:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdghQ-0008D1-3u
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 11:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1ANKP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 05:15:58 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64195 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1ANKP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 05:15:57 -0500
Received: by iyj18 with SMTP id 18so2366463iyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bsgvPsGM7qx89uBCzJtTJ2P7f+4qrXeZIH7LRTqzMQI=;
        b=xc5LBFWnDcZfE19RroKYgY+fiwwrnTeLMEWdCBY+hbJNnVz39/roxlV81KfH+5Glpa
         AkLefeCkbmrP85EU4h9LKx8QM8P6VeNWFKFP45x0YOURAj4UrbNolfwHh08cA76iifXi
         fa/IBjG7XnmDYZoy+n1pjTgoHTWCqLLC03sQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mkHseAXCmWsZMlwyIfV6IBmUcGjU5PrNZsVW4hISI+Bp6Np4plwU9dx7QPkN/To/Wc
         Ptb+pOGRrfsMA7uJ0DczI+PBl7ECr3it5wdiXwyKtuCSubq6AekpMWYBtRt/+N268yXq
         luv19NWPx3StGrmTRaPJZRN1Y3nPRJSFGxM3Y=
Received: by 10.42.178.74 with SMTP id bl10mr602318icb.335.1295000156727;
        Fri, 14 Jan 2011 02:15:56 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id gy41sm852656ibb.17.2011.01.14.02.15.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 02:15:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <F0299861-B36C-459C-972E-856212A92615@kth.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165089>

When creating a new commit, instead of picking up the SVN author from
the committer's email, pick it up from the author's email, when
possible. Also add a new command-line switch '--ignore-author' to
force older behavior for backward compatibilty.

Noticed-by: Joe Corneli <holtzermann17@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git2svn |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/git2svn b/git2svn
index 2380775..8ef55f1 100755
--- a/git2svn
+++ b/git2svn
@@ -36,7 +36,7 @@ use Pod::Usage;
 my $IN;
 my $OUT;
 
-my ($help, $verbose, $keeplogs, $no_load);
+my ($help, $verbose, $keeplogs, $no_load, $ignore_author);
 
 # svn
 my $svntree = "repro";
@@ -200,6 +200,7 @@ $result = GetOptions ("git-branch=s" => \$branch,
 		      "svn-prefix=s" => \$basedir,
 		      "keep-logs" => \$keeplogs,
 		      "no-load" => \$no_load,
+		      "ignore-author" => \$ignore_author,
 		      "verbose+" => \$verbose,
 		      "help" => \$help) or pod2usage(2);
 
@@ -261,12 +262,15 @@ COMMAND: while (!eof(IN)) {
 	    $commit{Mark} = $1;
 	    $next = next_line($IN);
 	}
-	if ($next =~ m/author +(.*)/) {
-	    $commit{Author} = $1;
+	if ($next =~ m/author +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
+	    $commit{AuthorName} = $1;
+	    $commit{AuthorEmail} = $2;
+	    $commit{AuthorWhen} = $3;
+	    $commit{AuthorTZ} = $4;
 	    $next = next_line($IN);
 	}
 	unless ($next =~ m/committer +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
-	    die "missing comitter: $_";
+	    die "missing committer: $_";
 	}
 
 	$commit{CommitterName} = $1;
@@ -291,11 +295,15 @@ COMMAND: while (!eof(IN)) {
 	    strftime("%Y-%m-%dT%H:%M:%S.000000Z", 
 		     gmtime($commit{CommitterWhen}));
 
-	my $author = "(no author)";
+	my $author = "git2svn-dump";
 	if ($commit{CommitterEmail} =~ m/([^@]+)/) {
 	    $author = $1;
 	}
-	$author = "git2svn-dump" if ($author eq "(no author)");
+	unless ($ignore_author) {
+	    if ($commit{AuthorEmail} =~ m/([^@]+)/) {
+	        $author = $1;
+	    }
+	}
 
 	my $props = "";
 	$props .= prop("svn:author", $author);
@@ -486,6 +494,11 @@ match the default GIT branch (master).
 
 Don't load the svn repository or update the syncpoint tagname.
 
+=item B<--ignore-author>
+
+Ignore "author" lines in the fast-import stream. Use "committer"
+information instead.
+
 =item B<--keep-logs>
 
 Don't delete the logs in $CWD/.data on success.
-- 
1.7.4.rc1.7.g2cf08.dirty
