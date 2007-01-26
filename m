From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Allow the tag signing key to be specified in the config file
Date: Fri, 26 Jan 2007 14:13:46 +0000
Message-ID: <200701261413.46823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 15:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARqK-0007Dt-BO
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965682AbXAZONw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965678AbXAZONv
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:13:51 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:24636 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965682AbXAZONv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:13:51 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 26 Jan 2007 14:16:49 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HARps-00082f-00
	for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:13:48 +0000
X-TUID: 15058985c61ac6d8
X-UID: 210
X-Length: 4124
Content-Disposition: inline
X-OriginalArrivalTime: 26 Jan 2007 14:16:49.0093 (UTC) FILETIME=[9E38CF50:01C74154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37856>

I did this:

  $ git tag -s test-sign
  gpg: skipped "Andy Parkins <andyparkins@gmail.com>": secret key not available
  gpg: signing failed: secret key not available
  failed to sign the tag with GPG.

The problem is that I have used the comment field in my key's UID
definition.

  $ gpg --list-keys andy
  pub   1024D/4F712F6D 2003-08-14
  uid                  Andy Parkins (Google) <andyparkins@gmail.com>

So when git-tag looks for "Andy Parkins <andyparkins@gmail.com>";
obviously it's not going to be found.

There shouldn't be a requirement that I use the same form of my name in
my git repository and my gpg key - I might want to be formal (Andrew) in
my gpg key and informal (Andy) in the repository.  Further I might have
multiple keys in my keyring, and might want to use one that doesn't
match up with the address I use in commit messages.

This patch adds a configuration entry "user.signingkey" which, if
present, will be passed to the "-u" switch for gpg, allowing the tag
signing key to be overridden.  If the entry is not present, the fallback
is the original method, which means existing behaviour will continue
untouched.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I've mentioned this problem before, but previously my patch was to make
it work in my specific case.  This patch covers every possibility by adding
a configuration variable so users can use whatever key they want for signing.

Personally I think this is better than the git-tag -u switch, because keys
change so rarely that it's being purposely inconvenient to make someone with
special needs use "-u" every time - and they'd probably have to look up their
chosen keyid each time.


 Documentation/config.txt  |    7 +++++++
 Documentation/git-tag.txt |   10 ++++++++++
 git-tag.sh                |    8 ++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3f2fa09..6ea7c76 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -469,6 +469,13 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See gitlink:git-commit-tree[1].
 
+user.signingkey::
+	If gitlink:git-tag[1] is not selecting the key you want it to
+	automatically when creating a signed tag, you can override the
+	default selection with this variable.  This option is passed
+	unchanged to gpg's --local-user parameter, so you may specify a key
+	using any method that gpg supports.
+
 whatchanged.difftree::
 	The default gitlink:git-diff-tree[1] arguments to be used
 	for gitlink:git-whatchanged[1].
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 13c7aef..3f01e0b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -70,6 +70,16 @@ OPTIONS
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
 
+CONFIGURATION
+-------------
+By default, git-tag in sign-with-default mode (-s) will use your
+committer identity (of the form "Your Name <your@email.address>") to
+find a key.  If you want to use a different default key, you can specify
+it in the repository configuration as follows:
+
+[user]
+    signingkey = <gpg-key-id>
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>,
diff --git a/git-tag.sh b/git-tag.sh
index 94499c9..01e6526 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -112,7 +112,11 @@ git-check-ref-format "tags/$name" ||
 object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
-: ${username:=$(expr "z$tagger" : 'z\(.*>\)')}
+
+keyid=$(git-repo-config user.signingkey)
+if [ -z "$keyid" ]; then
+	: ${keyid:=$(expr "z$tagger" : 'z\(.*>\)')}
+fi
 
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 
@@ -139,7 +143,7 @@ if [ "$annotate" ]; then
       cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
     rm -f "$GIT_DIR"/TAG_TMP.asc "$GIT_DIR"/TAG_FINALMSG
     if [ "$signed" ]; then
-	gpg -bsa -u "$username" "$GIT_DIR"/TAG_TMP &&
+	gpg -bsa -u "$keyid" "$GIT_DIR"/TAG_TMP &&
 	cat "$GIT_DIR"/TAG_TMP.asc >>"$GIT_DIR"/TAG_TMP ||
 	die "failed to sign the tag with GPG."
     fi
-- 
1.5.0.rc2.gc3537-dirty
