From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 6 Jan 2011 12:00:51 -0600
Message-ID: <20110106180051.GC11346@burratino>
References: <4D25E818.5050909@gmail.com>
 <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 19:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pau98-0007ZV-K4
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 19:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab1AFSBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 13:01:04 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56790 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1AFSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 13:01:03 -0500
Received: by vws16 with SMTP id 16so6891018vws.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 10:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=54kA9itOY2WI/u9CJzC6mxuHOpqJ0Nck69536vLyOYQ=;
        b=UeKeUO2gdnQQWAtFlYQD8LY1LFSvd6AwGrehjHXaiQjHvUnepY6NQRBmAFVESs71Qi
         8JCXQ/rv6PZc/m/ftdit2WPz8bDYLg5pIQOITvUphqRYF8IXr/BJzmUcaqAzsCHmU3RN
         Be2nWJDsAX6I7hkRWUUiTY+EE3cmimj991VGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bCk3bzkRjsAOcoA+pkK2hfIhMF9nlOWHetarvKYXN6R7AKcg3h7sNxewjb4QO1Bjiw
         yXnf2dL3EteRDhHmNIgXkUutBnUW7vGYNTk6Cigvt7au7b3LZdfECtSMT79lmUIa0ZqX
         7DbIOlCdJpWpQIP5AIRUj5AtcFTDBe4c8o04A=
Received: by 10.220.98.200 with SMTP id r8mr7298163vcn.122.1294336862101;
        Thu, 06 Jan 2011 10:01:02 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id a6sm1765924vcm.22.2011.01.06.10.00.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 10:01:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D25F9C5.6030503@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164650>

If svn is built against one version of SQLite and run against
another, svnadmin (needlessly) errors out during t9010:

 <<< Started new transaction, based on original revision 1
      * adding path : branches ... done.
      * adding path : trunk ... done.
 svnadmin: Couldn't perform atomic initialization
 svnadmin: Couldn't perform atomic initialization
 svnadmin: SQLite compiled for 3.7.4, but running with 3.7.3

Work around this by putting the svn invocations into a single test
that builds a repo to compare the test-svn-fe result against.  This
test would always pass but only set the new SVNREPO test prereq if svn
succeeds; and the test using that repo gets an SVNREPO prerequisite so
it only runs with working svn installations.

This seems like the right thing to, anyway: the test script is meant
to test the version of git just built, not the installed svn.

As a side effect, earlier tests will run now even if svn is not
installed.  Remove the svn_cmd () helper to decrease the temptation to
run svn from those tests.

Works-around: http://bugs.debian.org/608925
Reported-by: A Large Angry SCM <gitzilla@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks.  Does this patch work for you?

 t/t9010-svn-fe.sh |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index c96bf2f..88a9751 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -4,22 +4,6 @@ test_description='check svn dumpfile importer'
 
 . ./test-lib.sh
 
-if ! svnadmin -h >/dev/null 2>&1
-then
-	skip_all='skipping svn-fe tests, svn not available'
-	test_done
-fi
-
-svnconf=$PWD/svnconf
-export svnconf
-
-svn_cmd () {
-	subcommand=$1 &&
-	shift &&
-	mkdir -p "$svnconf" &&
-	svn "$subcommand" --config-dir "$svnconf" "$@"
-}
-
 reinit_git () {
 	rm -fr .git &&
 	git init
@@ -41,10 +25,21 @@ test_expect_success 'v3 dumps not supported' '
 	test_cmp empty stream
 '
 
-test_expect_success 't9135/svn.dump' '
-	svnadmin create simple-svn &&
-	svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
-	svn_cmd export "file://$PWD/simple-svn" simple-svnco &&
+test_expect_success 'set up svn repo' '
+	svnconf=$PWD/svnconf &&
+	mkdir -p "$svnconf" &&
+
+	if
+		svnadmin -h >/dev/null 2>&1 &&
+		svnadmin create simple-svn &&
+		svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
+		svn export --config-dir "$svnconf" "file://$PWD/simple-svn" simple-svnco
+	then
+		test_set_prereq SVNREPO
+	fi
+'
+
+test_expect_success SVNREPO 't9135/svn.dump' '
 	git init simple-git &&
 	test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
 	(
-- 
1.7.4.rc1
