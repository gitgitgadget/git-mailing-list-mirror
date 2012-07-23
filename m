From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/5] difftool: Eliminate global variables
Date: Mon, 23 Jul 2012 08:13:51 +0200
Message-ID: <500CEB9F.4030406@gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com> <1343014940-16439-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StBuG-0002El-VY
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab2GWGN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:13:59 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45736 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab2GWGN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:13:57 -0400
Received: by wibhm11 with SMTP id hm11so2503117wib.1
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1XzQy6JK9awehB83O3Es5YPfCqyPg4SoGZlUCjmkpsM=;
        b=bdf91Q095K3jE69MvodgYv8Il+Jjm5tmVvNQJltqEp6VXKtImtSAv1G1+0JmmNbKnF
         yQpCLnLVW1eUQdu/zk3Oco9qOs7H86VT//HhX+Ue80UL/2vFHCr/R+37fDK8Jx5I7zew
         3Hom0A6wKP/rmPIGLhZkN7Tc/pgRaw5q/9pramqNiJx83cn/BEt0rHXlvvzKCYAh+Wft
         JL2Kruw/KWos1Y8upcpqIXV8yV7M7xPOXlf0WBKtzGJVeNgPbpWnDYD6mfh5cb5sD9lj
         XoKrsZ213fa8TQEgmd9D2oEeE5ta0qnZqKLvjJwiuRu1ISUVoUK2CGN8BVm9fW0B93sk
         TBfA==
Received: by 10.180.87.232 with SMTP id bb8mr10480307wib.0.1343024036009;
        Sun, 22 Jul 2012 23:13:56 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id de10sm15316316wib.7.2012.07.22.23.13.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 23:13:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1343014940-16439-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201906>

On 23.07.2012 05:42, David Aguilar wrote:

> Organize the script so that it has a single main() function which
> calls out to dir_diff() and file_diff() functions. This eliminates
> "dir-diff"-specific variables that do not need to be calculated when
> performing a regular file-diff.

Funny, I just have prepared a patch along the same lines so that one can 
call git-difftool -h and --tool-help also outside a repository, see 
below. Does you patch offer the same? If so, I'll drop mine.

---
  git-difftool.perl | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index ae1e052..e7b71c9 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -25,8 +25,9 @@ use Git;
  my @tools;
  my @working_tree;
  my $rc;
-my $repo = Git->repository();
-my $repo_path = $repo->repo_path();
+my $repo;
+my $repo_path;
+my $workdir;

  sub usage
  {
@@ -62,8 +63,6 @@ sub find_worktree
  	return $worktree;
  }

-my $workdir = find_worktree();
-
  sub filter_tool_scripts
  {
  	if (-d $_) {
@@ -293,6 +292,11 @@ if (defined($help)) {
  if (defined($tool_help)) {
  	print_tool_help();
  }
+
+$repo = Git->repository();
+$repo_path = $repo->repo_path();
+$workdir = find_worktree();
+
  if (defined($difftool_cmd)) {
  	if (length($difftool_cmd) > 0) {
  		$ENV{GIT_DIFF_TOOL} = $difftool_cmd;
-- 
1.7.11.msysgit.2
