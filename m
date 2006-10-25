X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Combined diff format documentation
Date: Thu, 26 Oct 2006 00:22:49 +0200
Organization: At home
Message-ID: <ehoo2k$1g6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 25 Oct 2006 22:22:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 179
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30111>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcr8r-0006Iv-6F for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965238AbWJYWW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWJYWW0
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:22:26 -0400
Received: from main.gmane.org ([80.91.229.2]:11735 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965238AbWJYWW0 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:22:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gcr8h-0006Hc-9J for git@vger.kernel.org; Thu, 26 Oct 2006 00:22:23 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 00:22:23 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 00:22:23 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

In Documentation/diff-format.txt we can find the following information about
combined diff format:

 combined diff format
 --------------------
 
 git-diff-tree and git-diff-files can take '-c' or '--cc' option
 to produce 'combined diff', which looks like this: 

 ------------
 diff --combined describe.c
 @@@ +98,7 @@@
    return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
   }
 
 - static void describe(char *arg)
  -static void describe(struct commit *cmit, int last_one)
 ++static void describe(char *arg, int last_one)
   {
  +     unsigned char sha1[20];
  +     struct commit *cmit;
 ------------

And it further goes how to read combined diff format, and how --cc
(condensed combined) differs from --combined.

There is no note about which of extended headers functions with combined
diff format, how they change, how chunk header changes.

From what I gathered, there are the following differences as compared to
ordinary (diff --git) git extended headers:

1. "git diff" header which looked like this

      diff --git a/file1 b/file2

    is now

      diff --combined file2

    (where instead of --combined we might have --cc). Not described in
    documentation.

2. the "index" extended header line changes from

     index <hash>..<hash> <mode>

   to
   
     index <hash>,<hash>..<hash>

   Mode information is put in separate line, only if mode changes, for
   example

     mode <mode>,<mode>..<mode>

   <mode> can be 000000 if file didn't exist in particular parent; if file
   was cerated by merge we have

     new file mode <mode>

   I haven't checked what happens if file is deleted, either by branch or by
   merge commit itself. Not described in documentation, I'm not sure about
   how this (wrt modes) works.

3. The "rename/copy" headers seems to be never present; see below.

4. From file/to file header _seems_ to function exactly like in ordinary
   diff format, namely

     --- a/file1
     +++ b/file2

   But it seems to function rather like in ordinary "git diff" header,
   i.e. we have a/file1 instead of /dev/null even for files created by
   merge. I have not checked if and how rename detection work here.

5. Hunk header is also modified: in ordinary diff we have

     @@ <from range> <to range> @@

   where <from range> is -<start line>,<number of lines>, and <to range>
   is +<start line>,<number of lines>. In combined diff format it changes
   similarly to "index" extended header, namely

     @@@ <from range> <from range> <to range> @@@

   It might be not obvoious that we have (number of parents + 1) '@'
   characters in chunk header for combined dif format.

   BTW. it is not mentioned in documentation that git diff uses hunk section
   indicator, and what regexp/expression it uses (and is it configurable).
   Not described in documentation.

6. Documentation/diff-format.txt explains combined and condensed combined
   format quite well, although it doesn't tell us if we can have plusses and
   minuses together in one line...


=====================================================================

Combined diff format an renames detection
-----------------------------------------

We have the following situation:
$ git ls-tree -r --abbrev HEAD
100644 blob 1ce3f81     greetings/goodbye.txt
100644 blob 980a0d5     greetings/hello.txt
$ git ls-tree -r --abbrev HEAD^1
100644 blob 980a0d5     greetings/hello.txt
$ git ls-tree -r --abbrev HEAD^2
100644 blob 1ce3f81     data/goodbye.txt
100644 blob 980a0d5     data/hello.txt

Below there are following diffs: with first parent, merge (with all parents)
with renames detection, combined, combined with rename detection. Is it all
expected?

$ git diff-tree -p HEAD^1 HEAD
diff --git a/greetings/goodbye.txt b/greetings/goodbye.txt
new file mode 100644
index 0000000..1ce3f81
--- /dev/null
+++ b/greetings/goodbye.txt
@@ -0,0 +1 @@
+Goodbye World!

$ git diff-tree -p -M -m HEAD
d0fdd886e3b768678832c8d826bb8b70f2ef7b8e
diff --git a/greetings/goodbye.txt b/greetings/goodbye.txt
new file mode 100644
index 0000000..1ce3f81
--- /dev/null
+++ b/greetings/goodbye.txt
@@ -0,0 +1 @@
+Goodbye World!
d0fdd886e3b768678832c8d826bb8b70f2ef7b8e
diff --git a/data/goodbye.txt b/greetings/goodbye.txt
similarity index 100%
rename from data/goodbye.txt
rename to greetings/goodbye.txt
diff --git a/data/hello.txt b/greetings/hello.txt
similarity index 100%
rename from data/hello.txt
rename to greetings/hello.txt

$ git diff-tree -p -c HEAD
d0fdd886e3b768678832c8d826bb8b70f2ef7b8e
diff --combined greetings/goodbye.txt
index 0000000,0000000..1ce3f81
new file mode 100644
--- a/greetings/goodbye.txt
+++ b/greetings/goodbye.txt
@@@ -1,0 -1,0 +1,1 @@@
++Goodbye World!

$ git diff-tree -p -c -M HEAD
d0fdd886e3b768678832c8d826bb8b70f2ef7b8e
diff --combined greetings/goodbye.txt
index 0000000,1ce3f81..1ce3f81
mode 000000,100644..100644
--- a/greetings/goodbye.txt
+++ b/greetings/goodbye.txt
@@@ -1,0 -1,1 +1,1 @@@
+ Goodbye World!

And to compare, latest with --cc (condensed combined) instead of -c:
$ git diff-tree -p --cc -M HEAD
d0fdd886e3b768678832c8d826bb8b70f2ef7b8e
diff --cc greetings/goodbye.txt
index 0000000,1ce3f81..1ce3f81
mode 000000,100644..100644
--- a/greetings/goodbye.txt
+++ b/greetings/goodbye.txt
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

