X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Set permissions of each new file before "cvs add"ing it.
Date: Mon, 4 Dec 2006 17:51:49 +0100
Organization: Dewire
Message-ID: <200612041751.49652.robin.rosenberg.lists@dewire.com>
References: <87ac24zrk0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 16:49:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <87ac24zrk0.fsf@rho.meyering.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33203>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrH0h-0006JI-FT for gcvg-git@gmane.org; Mon, 04 Dec
 2006 17:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937131AbWLDQtb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 11:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937135AbWLDQtb
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 11:49:31 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13119 "EHLO
 torino.dewire.com" rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
 id S937131AbWLDQta convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 11:49:30 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 44EBC802ABB; Mon,  4 Dec 2006 17:45:41 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 28890-07; Mon,  4 Dec
 2006 17:45:40 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id E409F802AA9; Mon,  4 Dec 2006 17:45:38 +0100 (CET)
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

s=F6ndag 03 december 2006 20:51 skrev Jim Meyering:
> Without the following patch, git-cvsexportcommit would fail to propag=
ate
> permissions of files added in git to the CVS repository.  I.e., when =
I
> added an executable script in coreutils' git repo, then tried to prop=
agate
> that addition to the mirroring CVS repository, the script ended up ad=
ded
> not executable there.

The patch to cvsexportcommit I sent a couple of weeks ago fixes the exe=
cution=20
bit, along with most other flaws. Jounio had some objections that I hav=
en't=20
fixed yet. Hacking the Eclipse plugin was much more fun :)

I added this test case just to verify it on top of my previous patch.=20

-- robin

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 75b9f38..63eafc8 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -195,4 +195,19 @@ test_expect_success \
       ! git-cvsexportcommit -c $id
       )'

+test_expect_success \
+     'Retain execute bit' \
+     'mkdir G &&
+      echo executeon >G/on &&
+      chmod +x G/on &&
+      echo executeoff >G/off &&
+      git add G/on &&
+      git add G/off &&
+      git commit -a -m "Execute test" &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c HEAD
+      test -x G/on &&
+      ! test -x G/off
+      )'
+
