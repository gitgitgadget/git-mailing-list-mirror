From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: t7800-difftool.sh failure on pu
Date: Tue, 03 Apr 2012 18:53:14 +0100
Message-ID: <4F7B390A.7050007@ramsay1.demon.co.uk>
References: <4F74A604.3040402@ramsay1.demon.co.uk> <7v7gy3qesv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tim.henigan@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF7wU-00059w-DS
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 19:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab2DCRyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 13:54:46 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:45883 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481Ab2DCRyp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 13:54:45 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SF7wJ-0001co-Wr; Tue, 03 Apr 2012 17:54:44 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v7gy3qesv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194636>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> The first option is to (effectively) revert commit 0440ed72 ("difftool: replace
>> system call with Git::command_noisy", 22-03-2012), like so:
>>
>> -- >8 --
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index e1754ff..49613b1 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -237,5 +237,7 @@ if (defined($dirdiff)) {
>>  
>>  	$ENV{GIT_PAGER} = '';
>>  	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
>> -	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
>> +	my @command = ('git', 'diff', @ARGV);
>> +	my $rc = system(@command);
>> +	exit($rc | ($rc >> 8));
>>  }
>> -- 8< --
> 
> I would prefer this, regardless of the issue.

Me too! ;-P

I noticed this afternoon (using my isp's web-mail interface) that Tim has
already sent a patch fixing this issue along these lines. [Thanks Tim]

However, just for the record, all three of the platforms I test on failed
in more-or-less the same way. [the exit code on cygwin was 2 (No such File
or Directory) rather than 9.]

Note that the failure occurred (on Linux, cygwin and MinGW) when pu was at
commit e5471b396660313b172e102b50939c9c35d4c637 (v1.7.10-rc2-260-ge5471b3).
However, on Linux, having fetched an updated pu which is now at commit
ae98c9308d3a79f2b22de2f6dae614f700f7ce0c (v1.7.10-rc3-272-gae98c93), then
test t7800 now reliably passes!

[when I say it reliably passes (fails), I mean it passes (fails) each time
on ten consecutive runs.]

I created a diff of git-difftool.perl between these two commits and applied
the patch, in reverse, to effectively revert that file. Having done so, then
t7800 once again reliably fails! Looking at the diff, I have no idea why!
[I've included the diff below, just for completeness.]

ATB,
Ramsay Jones

dt.diff:
-- >8 --
diff --git a/git-difftool.perl b/git-difftool.perl
index e1754ff..78e93a6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -14,14 +14,16 @@
 use 5.008;
 use strict;
 use warnings;
-use File::Basename qw(dirname basename);
+use File::Basename qw(dirname);
 use File::Copy;
+use File::Find;
 use File::stat;
 use File::Path qw(mkpath);
 use File::Temp qw(tempdir);
 use Getopt::Long qw(:config pass_through);
 use Git;
 
+my @tools;
 my @working_tree;
 
 sub usage
@@ -38,17 +40,32 @@ USAGE
 	exit($exitcode);
 }
 
+sub filter_tool_scripts
+{
+	if (-d $_) {
+		if ($_ ne ".") {
+			# Ignore files in subdirectories
+			$File::Find::prune = 1;
+		}
+	} else {
+		if ((-f $_) && ($_ ne "defaults")) {
+			push(@tools, $_);
+		}
+	}
+}
+
 sub print_tool_help
 {
 	my ($cmd, @found, @notfound);
 	my $gitpath = Git::exec_path();
 
-	for (glob "$gitpath/mergetools/*") {
-		my $tool = basename($_);
-		next if ($tool eq "defaults");
+	find(\&filter_tool_scripts, "$gitpath/mergetools");
 
-		$cmd  = '. "$(git --exec-path)/git-mergetool--lib"';
+	foreach my $tool (@tools) {
+		$cmd  = "TOOL_MODE=diff";
+		$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
 		$cmd .= " && get_merge_tool_path $tool >/dev/null 2>&1";
+		$cmd .= " && can_diff >/dev/null 2>&1";
 		if (system('sh', '-c', $cmd) == 0) {
 			push(@found, $tool);
 		} else {
@@ -57,10 +74,10 @@ sub print_tool_help
 	}
 
 	print "'git difftool --tool=<tool>' may be set to one of the following:\n";
-	print "\t$_\n" for (@found);
+	print "\t$_\n" for (sort(@found));
 
 	print "\nThe following tools are valid, but not currently available:\n";
-	print "\t$_\n" for (@notfound);
+	print "\t$_\n" for (sort(@notfound));
 
 	print "\nNOTE: Some of the tools listed above only work in a windowed\n";
 	print "environment. If run in a terminal-only session, they will fail.\n";
-- 8< --
