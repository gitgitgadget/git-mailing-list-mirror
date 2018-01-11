Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07601FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 14:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934402AbeAKOpz (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 09:45:55 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10415 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934389AbeAKOpy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 09:45:54 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0BEjqlu051678
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 09:45:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [BUG] Weird breakages in t1450 #2 on NonStop
Date:   Thu, 11 Jan 2018 09:45:46 -0500
Message-ID: <003601d38aea$e0e08ff0$a2a1afd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdOK5xVtXEff9WZESC+JndRRxUmtsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one has me scratching my head:

The object file name being reported below in t1450, subtest 2 is corrupt,
but I can't figure out why the script might be generating this condition -
there's nothing apparent, but it looks like the git commit -m C step is
reporting or using a bad name. This breakage was not present in 2.8.5 (now
at 7234152 (2.13.5) and is persistent (i.e. always happens). This is the
only test in all of git where I have observed this particular situation.
Adding set -x to test_commit is unrevealing. The git fsck in this test is
never executed because the test_commit fails with a non-zero git commit
completion code. There is no rn---- (actual r n 252 252 252 252) in the
objects directory - even the 'rn' does not correspond to anything.. I am
suspecting an unterminated string that ran into freed memory somewhere, but
that's speculative. 

Does anyone have a perspective on this - was it subsequently fixed?

Thanks,
Randall

Initialized empty Git repository in /home/git/git/t/trash
directory.t1450-fsck/another/.git/
error: object directory /home/git/git/t/trash
directory.t1450-fsck/another/.git/objects/rn---- does not exist; check
.git/objects/info/alternates.
[master (root-commit) 1aac250] C
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileC
error: object directory /home/git/git/t/trash
directory.t1450-fsck/another/.git/objects/rn---- does not exist; check
.git/objects/info/alternates.
--- empty       2018-01-11 13:57:30 +0000
+++ actual      2018-01-11 13:57:40 +0000
@@ -0,0 +1 @@
+error: object directory /home/git/git/t/trash
directory.t1450-fsck/another/.git/objects/rn---- does not exist; check
.git/objects/info/alternates.
not ok 2 - loose objects borrowed from alternate are not missing
#
#               mkdir another &&
#               (
#                       cd another &&
#                       git init &&
#                       echo ../../../.git/objects
>.git/objects/info/alternates &&
#                       test_commit C fileC one &&
#                       git fsck --no-dangling >../actual 2>&1
#               ) &&
#               test_cmp empty actual
#

Ls -l of the objects directory:
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 .
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 ..
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 13
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 56
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 bd
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 c9
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 f7
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 info
drwxrwxr-x 1 randall ITUGLIB 4096 Jan 11 08:26 pack
from find:
./13
./13/4756353796a5439d93586be27999eea3807a34
./56
./56/26abf0f72e58d7a153368ba57db4c673c0e171
./bd
./bd/04fbdc74c1ad468ee1cc86d49860490ab3e6c7
./c9
./c9/145d6720f85544cc4bb6009a2e541660aa156b
./c9/176b0dd1a95c80ad8de21784b1eeffd3681f49
./f7
./f7/19efd430d52bcfc8566a43b2eb655688d38871
./info
./pack

