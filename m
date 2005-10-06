From: Linus Torvalds <torvalds@osdl.org>
Subject: Allow "-u" flag to tag signing
Date: Thu, 6 Oct 2005 09:58:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 06 19:01:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENZ4Q-0002DL-AP
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 18:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJFQ6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 12:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJFQ6L
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 12:58:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751141AbVJFQ6J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 12:58:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96Gw44s027894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 09:58:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96Gw2No009447;
	Thu, 6 Oct 2005 09:58:03 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9774>


The current "git tag -s" thing always uses the tagger name as the signing 
user key, which is very irritating, since my key is under my email 
address, but the tagger key obviously contains the actual machine name 
too.

Now, I could just use "GIT_COMMITTER_EMAIL" and force it to be my real 
email, but I actually think that it's nice to see which machine I use for 
my work. 

So rather than force my tagger ID to have to match the gpg key name, just 
support the "-u" flag to "git tag" instead. It implicitly enables signing, 
since it doesn't make any sense without it. Thus:

	git tag -u <gpg-key-name> <tag-name> [<tagged-object>]

will use the named gpg key for signing.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
Not very well tested, but I re-did my v2.6.14-rc3 tag with this, since I'd 
messed up the comments (and called it v2.6.14-rc2 in there ;)

So it may even work.

diff --git a/git-tag.sh b/git-tag.sh
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -12,6 +12,7 @@ annotate=
 signed=
 force=
 message=
+username=
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
@@ -30,6 +31,12 @@ do
 	shift
 	message="$1"
 	;;
+    -u)
+	annotate=1
+	signed=1
+	shift
+	username="$1"
+	;;
     -*)
         usage
 	;;
@@ -70,8 +77,11 @@ if [ "$annotate" ]; then
     ( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n"; cat .tagmsg ) > .tmp-tag
     rm -f .tmp-tag.asc .tagmsg
     if [ "$signed" ]; then
-	me=$(expr "$tagger" : '\(.*>\)') &&
-	gpg -bsa -u "$me" .tmp-tag &&
+	{
+		[ "$username" ] ||
+		username=$(expr "$tagger" : '\(.*>\)')
+	} &&
+	gpg -bsa -u "$username" .tmp-tag &&
 	cat .tmp-tag.asc >>.tmp-tag ||
 	die "failed to sign the tag with GPG."
     fi
