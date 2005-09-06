From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] git-cvsimport-script: handling of tags
Date: Tue, 06 Sep 2005 10:36:01 -0700
Message-ID: <431DD381.4050709@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010503060308030708060903"
X-From: git-owner@vger.kernel.org Tue Sep 06 19:37:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EChN2-0002as-Au
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 19:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVIFRg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 13:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIFRg3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 13:36:29 -0400
Received: from terminus.zytor.com ([209.128.68.124]:21159 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750722AbVIFRg3
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 13:36:29 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j86Ha663012011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 10:36:07 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8134>

This is a multi-part message in MIME format.
--------------010503060308030708060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes git-cvsimport-script so that it creates tag objects 
instead of refs to commits, and adds an option, -u, to convert 
underscores in branch and tag names to dots (since CVS doesn't allow 
dots in branches and tags.)

Pullable tree at master.kernel.org:/home/hpa/git/cvsimport.git/

	-hpa

--------------010503060308030708060903
Content-Type: text/x-patch;
 name="git.tag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git.tag.patch"

diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -44,6 +44,9 @@ OPTIONS
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees. 
 
+-u::
+	Convert underscores in tag and branch names to dots.
+
 -o <branch-for-HEAD>::
 	The 'HEAD' branch from CVS is imported to the 'origin' branch within
 	the git repository, as 'HEAD' already has a special meaning for git.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -24,23 +24,24 @@ use Time::Local;
 use IO::Socket;
 use IO::Pipe;
 use POSIX qw(strftime dup2);
+use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_s,$opt_m,$opt_M);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_s,$opt_m,$opt_M);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
-       [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
-       [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ -i ] [ -k ] [-s subst] [ -m ] [ -M regex] [ CVS_module ]
+       [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT]
+       [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz]
+       [-i] [-k] [-u] [-s subst] [-m] [-M regex] [CVS_module]
 END
 	exit(1);
 }
 
-getopts("hivmko:d:p:C:z:s:M:") or usage();
+getopts("hivmkuo:d:p:C:z:s:M:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -628,13 +629,37 @@ my $commit = sub {
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if($tag) {
-		open(C,">$git_dir/refs/tags/$tag")
-			or die "Cannot create tag $tag: $!\n";
-		print C "$cid\n"
-			or die "Cannot write tag $branch: $!\n";
+		my($in, $out) = ('','');
+	        my($xtag) = $tag;
+		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
+		$xtag =~ tr/_/\./ if ( $opt_u );
+		
+		my $pid = open2($in, $out, 'git-mktag');
+		print $out "object $cid\n".
+		    "type commit\n".
+		    "tag $xtag\n".
+		    "tagger $author <$author>\n"
+		    or die "Cannot create tag object $xtag: $!\n";
+		close($out)
+		    or die "Cannot create tag object $xtag: $!\n";
+
+		my $tagobj = <$in>;
+		chomp $tagobj;
+
+		if ( !close($in) or waitpid($pid, 0) != $pid or
+		     $? != 0 or $tagobj !~ /^[0123456789abcdef]{40}$/ ) {
+		    die "Cannot create tag object $xtag: $!\n";
+	        }
+		
+
+		open(C,">$git_dir/refs/tags/$xtag")
+			or die "Cannot create tag $xtag: $!\n";
+		print C "$tagobj\n"
+			or die "Cannot write tag $xtag: $!\n";
 		close(C)
-			or die "Cannot write tag $branch: $!\n";
-		print "Created tag '$tag' on '$branch'\n" if $opt_v;
+			or die "Cannot write tag $xtag: $!\n";
+
+		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
 	}
 };
 

--------------010503060308030708060903--
