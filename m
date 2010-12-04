From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git submodule: Remove now obsolete tests before cloning a
 repo
Date: Sun, 05 Dec 2010 00:27:35 +0100
Message-ID: <4CFACE67.1080206@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de> <20101203071037.GA18202@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com,
	ben@ben.com, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 00:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP1ay-00064h-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 00:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab0LDX2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 18:28:55 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42736 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0LDX2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 18:28:55 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9C9EF17BA13B6;
	Sun,  5 Dec 2010 00:27:36 +0100 (CET)
Received: from [93.246.44.149] (helo=[192.168.178.51])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PP1Vw-0007zP-00; Sun, 05 Dec 2010 00:27:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101203071037.GA18202@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+u+DyQ61FIxzH47+v+kVxTBUpYe7NOymB0o4ab
	pD38hPo4BZ4BPP+4mFayQIRSLZSXg87yLgnBFQgTTC61/jv5Gp
	yDdKp26C0VahMxHXH3+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162923>

Since 55892d23 "git clone" itself checks that the destination path is not
a file but an empty directory if it exists, so there is no need anymore
for module_clone() to check that too.

Two tests have been added to test the behavior of "git submodule add" when
path is a file or a directory (A subshell had to be added to the former
last test to stay in the right directory).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 03.12.2010 08:10, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> Am 01.12.2010 19:50, schrieb Jonathan Nieder:
> 
>>>                                  Jens, any idea why git submodule
>>> is not using "clone --branch" directly?
>>
>> Nope, these lines date back to the time before I got involved in the
>> submodule business ... Seems like this "git checkout" was added in
>> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
>> that.
> 
> Ah, so the problem is that "clone --branch" did not exist.  Sorry for
> the noise.
> 
> Another question can be also be easily answered by history examination:
> the series of checks in module_clone are because 70c7ac22d:git-clone.sh
> did not have checks of its own for the target directory.
> 
> So there is some simplification within grasp.

Maybe something like this?


 git-submodule.sh           |   14 --------------
 t/t7400-submodule-basic.sh |   28 +++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 33bc41f..8085876 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -93,20 +93,6 @@ module_clone()
 	url=$2
 	reference="$3"

-	# If there already is a directory at the submodule path,
-	# expect it to be empty (since that is the default checkout
-	# action) and try to remove it.
-	# Note: if $path is a symlink to a directory the test will
-	# succeed but the rmdir will fail. We might want to fix this.
-	if test -d "$path"
-	then
-		rmdir "$path" 2>/dev/null ||
-		die "Directory '$path' exists, but is neither empty nor a git repository"
-	fi
-
-	test -e "$path" &&
-	die "A file already exist at path '$path'"
-
 	if test -n "$reference"
 	then
 		git-clone "$reference" -n "$url" "$path"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 782b0a3..2c49db9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -421,11 +421,29 @@ test_expect_success 'add submodules without specifying an explicit path' '
 		git commit -m "repo commit 1"
 	) &&
 	git clone --bare repo/ bare.git &&
-	cd addtest &&
-	git submodule add "$submodurl/repo" &&
-	git config -f .gitmodules submodule.repo.path repo &&
-	git submodule add "$submodurl/bare.git" &&
-	git config -f .gitmodules submodule.bare.path bare
+	(
+		cd addtest &&
+		git submodule add "$submodurl/repo" &&
+		git config -f .gitmodules submodule.repo.path repo &&
+		git submodule add "$submodurl/bare.git" &&
+		git config -f .gitmodules submodule.bare.path bare
+	)
+'
+
+test_expect_success 'add should fail when path is used by a file' '
+	(
+		cd addtest &&
+		touch file &&
+		test_must_fail	git submodule add "$submodurl/repo" file
+	)
+'
+
+test_expect_success 'add should fail when path is used by an existing directory' '
+	(
+		cd addtest &&
+		mkdir empty-dir &&
+		test_must_fail git submodule add "$submodurl/repo" empty-dir
+	)
 '

 test_done
-- 
1.7.3.2.657.g92628.dirty
