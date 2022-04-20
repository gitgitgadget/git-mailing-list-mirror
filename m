Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC7C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378119AbiDTLcj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 Apr 2022 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378102AbiDTLch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 07:32:37 -0400
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 04:29:49 PDT
Received: from mx2.uni-regensburg.de (mx2.uni-regensburg.de [194.94.157.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0D2E82
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 04:29:48 -0700 (PDT)
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id C11DF6000052
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:24:15 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id A2CDF6000051
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:24:15 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 20 Apr 2022 13:24:16 +0200
Message-Id: <625FED5E020000A10004978D@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.0 
Date:   Wed, 20 Apr 2022 13:24:14 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Bug in 2.26.2 regading "git diff --cached"?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I just added interactively one hunk and committed it, just to find out that I wanted to include another hunk (that would need editing).
So I reset to the previous commit, added the two correct hunks again, and then did "git diff --cached".
I was surprised to find only one of the two hunks I've added in the diff.
The likely reason is that one of thoise hunks had been committed, but that commit was reset.

Some details:
(reflog)
ebd6e6c (HEAD -> rfc-5424-message) HEAD@{0}: reset: moving to ebd6e6c8af5b9eaa809a114ee6a972114b3f6a86
6997ce5 HEAD@{1}: commit: Remove call to Class::_fake_load(__PACKAGE__)
ebd6e6c (HEAD -> rfc-5424-message) HEAD@{2}: commit: Fix RE_day in lib/RFC_5424_Message.pm

So 6997ce5 was the incomplete commit.

> git status
On branch rfc-5424-message
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   lib/Message.pm
        modified:   lib/UnknownMessage.pm

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   lib/Message.pm
        modified:   lib/MessageLogFormat.pm
        modified:   lib/RFC_3164_Message.pm
        modified:   lib/RFC_5424_Message.pm
        modified:   syslogd.pl

So there are two files with changes to commit.
"git diff --cached -M" outputs only one chink, however:
diff --git a/lib/UnknownMessage.pm b/lib/UnknownMessage.pm
index eef8f25..d0246ef 100644
--- a/lib/UnknownMessage.pm
+++ b/lib/UnknownMessage.pm
@@ -114,8 +114,4 @@ sub parse_OK($$$$)
     return defined($class->new_parsed($lt, $peer_addr, $packet, 1));
 }

-BEGIN {
-    Class::_fake_load(__PACKAGE__);    # Tell Perl module is loaded already
-}
-
 1;
---------------
Interestingly the hunk shown is the one that was in the bad commit; the edited commit is missing.

The missing hunk should look like this:
---
diff --git a/lib/Message.pm b/lib/Message.pm
index 2c60960..abd3e8e 100644
--- a/lib/Message.pm
+++ b/lib/Message.pm
@@ -147,8 +147,19 @@ sub parse_OK($$$$)
     return undef;
 }

-BEGIN {
-    Class::_fake_load(__PACKAGE__);    # Tell Perl module is loaded already
-}

 1;
---

Now is that a bug, or is it a "pilot error"?

Regards,
Ulrich



