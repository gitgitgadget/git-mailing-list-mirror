From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: partial svnimport [was: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines]
Date: Thu, 28 Sep 2006 22:44:57 +0300
Message-ID: <20060928194457.GE10617@sashak.voltaire.com>
References: <20060905184611.GB14732@sashak.voltaire.com> <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net> <20060905221754.GI14732@sashak.voltaire.com> <7v8xkxc2tr.fsf@assigned-by-dhcp.cox.net> <20060906125317.GA21645@sashak.voltaire.com> <20060906153314.GE6999@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:40:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1jf-0006jq-Rk
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWI1Tjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWI1Tjx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:39:53 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:26809 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1161026AbWI1Tjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:39:52 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Sep 2006 22:39:48 +0300
Received: by sashak (sSMTP sendmail emulation); Thu, 28 Sep 2006 22:44:57 +0300
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20060906153314.GE6999@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 28 Sep 2006 19:39:48.0344 (UTC) FILETIME=[DB95D780:01C6E335]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28041>

Hi,

On 17:33 Wed 06 Sep     , Matthias Urlichs wrote:
> Hi,
> 
> Sasha Khapyorsky:
> > At least I didn't succeed with reversed layout. With option
> > -T <trunk>/$project import works but only for trunk branch, attempts
> > to specify branch as -b <branches> or -b <branches>/$project don't help,
> > the same is with tags.
> > 
> That's true. The problem is that it wants the tag or branch name as the
> last component of the path.
> 
> A more generic solution would be to use wildcards in the branch/tag
> specification, to allow more than one wildcard, and to be able to
> specify the exact form of the branch or tag name on the git side.

Or perhaps just to specify path of the project (or sub-project) after
trunk/branches*/ . Like in this patch:


diff --git a/git-svnimport.perl b/git-svnimport.perl
index 988514e..86a6e8a 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,7 +31,8 @@ die "Need SVN:Core 1.2.1 or better" if $
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
+    $opt_P);
 
 sub usage() {
 	print STDERR <<END;
@@ -39,17 +40,19 @@ Usage: ${\basename $0}     # fetch/updat
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [-F] [SVN_URL]
+       [-m] [-M regex] [-A author_file] [-S] [-F] [-P project] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:Suv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
 my $trunk_name = $opt_T || "trunk";
 my $branch_name = $opt_b || "branches";
+my $project_name = $opt_P || "";
+$project_name = "/" . $project_name if ($project_name);
 
 @ARGV == 1 or @ARGV == 2 or usage();
 
@@ -356,11 +359,11 @@ sub revert_split_path($$) {
 	my $svnpath;
 	$path = "" if $path eq "/"; # this should not happen, but ...
 	if($branch eq "/") {
-		$svnpath = "$trunk_name/$path";
+		$svnpath = "$trunk_name$project_name/$path";
 	} elsif($branch =~ m#^/#) {
-		$svnpath = "$tag_name$branch/$path";
+		$svnpath = "$tag_name$branch$project_name/$path";
 	} else {
-		$svnpath = "$branch_name/$branch/$path";
+		$svnpath = "$branch_name/$branch$project_name/$path";
 	}
 
 	$svnpath =~ s#/+$##;
@@ -864,6 +867,20 @@ #	}
 	print "DONE: $revision $dest $cid\n" if $opt_v;
 }
 
+sub project_path($$)
+{
+	my ($path, $project) = @_;
+
+	$path = "/".$path unless ($path =~ m#^\/#) ;
+	return $1 if ($path =~ m#^$project\/(.*)$#);
+
+	$path =~ s#\.#\\\.#g;
+	$path =~ s#\+#\\\+#g;
+	return "/" if ($project =~ m#^$path.*$#);
+
+	return undef;
+}
+
 sub commit_all {
 	# Recursive use of the SVN connection does not work
 	local $svn = $svn2;
@@ -883,6 +900,10 @@ sub commit_all {
 	while(my($path,$action) = each %$changed_paths) {
 		($branch,$path) = split_path($revision,$path);
 		next if not defined $branch;
+		if ($project_name) {
+			$path = project_path($path, $project_name);
+			next if not defined $path;
+		}
 		$done{$branch}{$path} = $action;
 	}
 	while(($branch,$changed_paths) = each %done) {


(will submit if above is acceptable)

> All of this should be specified in the repository's git config file,
> not on the command line.

It is for incremental imports? So we will not need to reproduce exact
command line for each git-svnimport run? Good idea.

Sasha
