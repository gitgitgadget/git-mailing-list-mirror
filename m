X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: clarify refname disambiguation rules.
Date: Thu, 26 Oct 2006 01:17:06 -0700
Message-ID: <7vhcxrqynx.fsf_-_@assigned-by-dhcp.cox.net>
References: <E1Gck2K-0003H4-00@dvr.360vision.com>
	<7v1wowm46j.fsf@assigned-by-dhcp.cox.net>
	<7vwt6okpgr.fsf@assigned-by-dhcp.cox.net>
	<200610260814.05957.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 08:17:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610260814.05957.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 26 Oct 2006 08:14:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30148>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0QL-0006WY-2u for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752118AbWJZIRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWJZIRJ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:17:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43493 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1752118AbWJZIRH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:17:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026081706.IGTY13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 04:17:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ewGp1V00C1kojtg0000000 Thu, 26 Oct 2006
 04:16:49 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Nobody should create ambiguous refs (i.e. have tag "foobar" and branch
"foobar" at the same time) that need to be disambiguated with these
rules to keep sanity, but the rules are there so document them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  >> Heh, I spoke too fast.
  >>
  >> 	"git log origin..master"
  >>
  >> If you do not have none of .git/origin, .git/refs/origin,
  >> .git/refs/tags/origin, .git/refs/heads/origin, nor
  >> .git/refs/remotes/origin, then .git/refs/remotes/origin/HEAD is
  >> what "origin" means (see get_sha1_basic() in sha1_name.c).

  Something like this.

 Documentation/git-rev-parse.txt |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5d42570..ed938aa 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -122,14 +122,30 @@ blobs contained in a commit.
   your repository whose object name starts with dae86e.
 
 * An output from `git-describe`; i.e. a closest tag, followed by a
-  dash, a 'g', and an abbreviated object name.
+  dash, a `g`, and an abbreviated object name.
 
 * A symbolic ref name.  E.g. 'master' typically means the commit
   object referenced by $GIT_DIR/refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
+  When ambiguous, a `<name>` is disambiguated by taking the
+  first match in the following rules:
 
-* A suffix '@' followed by a date specification enclosed in a brace
+  . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
+    useful only for `HEAD`, `FETCH_HEAD` and `MERGE_HEAD`);
+
+  . otherwise, `$GIT_DIR/refs/<name>` if exists;
+
+  . otherwise, `$GIT_DIR/refs/tags/<name>` if exists;
+
+  . otherwise, `$GIT_DIR/refs/heads/<name>` if exists;
+
+  . otherwise, `$GIT_DIR/refs/remotes/<name>` if exists;
+
+  . otherwise, `$GIT_DIR/refs/remotes/<name>/HEAD` if exists.
+
+* A ref followed by the suffix '@' with a date specification
+  enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
   of the ref at a prior point in time.  This suffix may only be
@@ -146,8 +162,9 @@ blobs contained in a commit.
 * A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
-  equivalent to rev{caret}{caret}{caret} which is equivalent to\
-  rev{caret}1{caret}1{caret}1.
+  equivalent to rev{caret}{caret}{caret} which is equivalent to
+  rev{caret}1{caret}1{caret}1.  See below for a illustration of
+  the usage of this form.
 
 * A suffix '{caret}' followed by an object type name enclosed in
   brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
-- 
1.4.3.3.g43f1
