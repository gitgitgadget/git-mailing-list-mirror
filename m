From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Thu, 23 Apr 2009 11:20:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904231119160.10279@pacific.mpi-cbg.de>
References: <20090419233051.GA17946@dingo.bne.redhat.com> <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302> <20090421074540.GA7885@dingo.redhat.com> <alpine.DEB.1.00.0904211047311.10279@pacific.mpi-cbg.de>
 <20090423034709.GA22244@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 11:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwv7e-0003be-Si
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbZDWJUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZDWJUA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:20:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:33692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752284AbZDWJT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:19:59 -0400
Received: (qmail invoked by alias); 23 Apr 2009 09:19:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 23 Apr 2009 11:19:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mdDNCyxbmGFYOWmAlEU2fkUq8r+tt2FpIX7ZzKj
	6L/m5IGkituCn2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090423034709.GA22244@dingo.bne.redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117313>

Hi,

On Thu, 23 Apr 2009, Peter Hutterer wrote:

> 'git submodule update --rebase' rebases your local branch on top of what
> would have been checked out to a detached HEAD otherwise.
> 
> In some cases, detaching the HEAD when updating a submodule complicates
> the workflow to commit to this submodule (checkout master, rebase, then
> commit).  For submodules that require frequent updates but infrequent
> (if any) commits, a rebase can be executed directly by the git-submodule
> command, ensuring that the submodules stay on their respective branches.
> 
> git-config key: submodule.$name.rebase (bool)
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> 
> I figured if we're waiting for 1.6.3 anyway I might as well add support
> for gitconfig to make this feature "complete".
> Test cases are updated as well.

Thanks.

With this squashed in, I actually would not be too opposed to put this 
into 1.6.3, as it _is_ an improvement.

-- snipsnap --
[PATCH] To be squashed in

This does three things:

- add .gitmodules support for rebase,
- use --bool for the git config calls for type checking, and
- rename ambiguous t7404 to t7406.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/gitmodules.txt                       |    3 +++
 git-submodule.sh                                   |    7 ++++++-
 ...bmodule-update.sh => t7406-submodule-update.sh} |   10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)
 rename t/{t7404-submodule-update.sh => t7406-submodule-update.sh} (88%)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..7c22c40 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,6 +30,9 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
+submodule.<name>.rebase::
+	Defines that the submodule should be rebased by default.
+
 
 EXAMPLES
 --------
diff --git a/git-submodule.sh b/git-submodule.sh
index 091cb2d..3176226 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -295,6 +295,11 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		test true != "$(git config -f .gitmodules --bool \
+			submodule."$name".rebase)" ||
+		git config submodule."$name".rebase true ||
+		die "Failed to register submodule path '$path' as rebasing"
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -344,7 +349,7 @@ cmd_update()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		rebase_module=$(git config submodule."$name".rebase)
+		rebase_module=$(git config --bool submodule."$name".rebase)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
diff --git a/t/t7404-submodule-update.sh b/t/t7406-submodule-update.sh
similarity index 88%
rename from t/t7404-submodule-update.sh
rename to t/t7406-submodule-update.sh
index d70bae1..3a474be 100755
--- a/t/t7404-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -127,4 +127,14 @@ test_expect_success 'submodule update - rebase false in .git/config' '
 	)
 '
 
+test_expect_success 'submodule init picks up rebase' '
+	(cd super &&
+	 git config submodule.rebasing.url git://non-existing/git &&
+	 git config submodule.rebasing.path does-not-mater &&
+	 git config submodule.rebasing.rebase true &&
+	 git submodule init rebasing &&
+	 test true = $(git config --bool submodule.rebasing.rebase)
+	)
+'
+
 test_done
-- 
1.6.2.1.613.g25746
