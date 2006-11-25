X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Use git-show-ref instead of git-peek-remote
Date: Sat, 25 Nov 2006 11:18:43 +0100
Message-ID: <11644499234152-git-send-email-jnareb@gmail.com>
References: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sat, 25 Nov 2006 10:17:23 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Fauc5v3T6dfKL9nguIOWDCYYeYZ1yfuPzk9JOTUj1UU0BUXtjdzd0Jghs4eAcxMQHzpqto2o2vVCdmgGDPrGwYM0fhbE/dgv16ta+XJsIHSYZl5oqu5GrSaRzkz5NwTQw2y181Va9qnePUZ5GlhsZAvGzvmT0L/Co351p8lEdGM=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32275>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnuau-0003UB-HW for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966393AbWKYKRI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966395AbWKYKRI
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:17:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58909 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966393AbWKYKRG
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:17:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so826605uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 02:17:04 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr5955572ugm.1164449824319; Sat, 25
 Nov 2006 02:17:04 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 55sm12114765ugq.2006.11.25.02.17.03; Sat, 25 Nov 2006 02:17:04 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAPAIi9U011487; Sat, 25 Nov 2006 11:18:44 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAPAIhpJ011485; Sat, 25 Nov 2006 11:18:43 +0100
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Use "git show-ref --dereference" instead of "git peek-remote
$projectroot/project" in git_get_references. git-show-ref is faster
than git-peek-remote (40ms vs 56ms user+sys for git.git repository);
even faster is reading info/refs file (if it exists), but the
information in info/refs can be stale; that and the fact that
info/refs is meant for dumb protocol transports, not for gitweb.

git-show-ref is available since v1.4.4; the output format is slightly
different than git-peek-remote output format.

While at it make git_get_references return hash in list context,
and reference to hash (as it used to do) in scalar and void contexts.

Additionally this change makes all git commands invocations (except
the one used to get version of git core tools) go through git_cmd()
subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Use "git show-ref --dereference" instead of "git peek-remote ." in
>> git_get_references. git-show-ref is faster than git-peek-remote; even
>> faster is reading info/refs file (if it exists), but the information
>> in info/refs can be stale.
> 
> More importantly, it is for dumb protocol transports, not for gitweb.

Mentioned in commit message.

> You forgot to mention that you fixed the last place that
> directly used "$GIT" to invoke the command, bypassing sub
> git_cmd.  That is a consistency clean-up worth mentioning.

This is not fix, this is change of style. The style was to use
  git peek-remote $projectroot/$project
instead of equivalent
  git --git-dir=$projectroot/$project peek-remote .

We don't have this choice with git-show-ref.

On the other hand that makes all command invocation (except the one
used for getting git core version) pass through git_cmd() subroutine.
So yes, it is consistency clean-up.

>> git-show-ref is available since v1.4.4; the output format is slightly
>> different than git-peek-remote output format.
> 
>> -		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
>> +		if ($line =~ m/^([0-9a-fA-F]{40}) refs\/($type\/?[^\^]+)/) {
> 
> I would rather do:
> 
> 	m|^([0-9a-f]{40})\srefs/($type/?[^^]+)|
> 
> which would catch both space and tab.

This addresses those concerns.

 gitweb/gitweb.perl |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f06cd3e..2ebd9d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1154,14 +1154,15 @@ sub git_get_last_activity {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
-	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
-	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
+	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
+	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
+	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
+		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
 		or return;
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
@@ -1170,7 +1171,7 @@ sub git_get_references {
 		}
 	}
 	close $fd or return;
-	return \%refs;
+	return wantarray ? %refs : \%refs;
 }
 
 sub git_get_rev_name_tags {
@@ -1293,8 +1294,9 @@ sub parse_commit {
 			$co{'author'} = $1;
 			$co{'author_epoch'} = $2;
 			$co{'author_tz'} = $3;
-			if ($co{'author'} =~ m/^([^<]+) </) {
-				$co{'author_name'} = $1;
+			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'author_name'}  = $1;
+				$co{'author_email'} = $2;
 			} else {
 				$co{'author_name'} = $co{'author'};
 			}
@@ -1303,7 +1305,12 @@ sub parse_commit {
 			$co{'committer_epoch'} = $2;
 			$co{'committer_tz'} = $3;
 			$co{'committer_name'} = $co{'committer'};
-			$co{'committer_name'} =~ s/ <.*//;
+			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
+				$co{'committer_name'}  = $1;
+				$co{'committer_email'} = $2;
+			} else {
+				$co{'committer_name'} = $co{'committer'};
+			}
 		}
 	}
 	if (!defined $co{'tree'}) {
-- 
1.4.4.1
