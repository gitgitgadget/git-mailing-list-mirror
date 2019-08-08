Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510761F731
	for <e@80x24.org>; Thu,  8 Aug 2019 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbfHHBTg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 21:19:36 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21502 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388501AbfHHBTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 21:19:35 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2019 21:19:34 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1565224469; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=TiTMNch2tfsAbjyawDb4KvLQMtBgDPEgE0eDPFvr4XDqyCqXjauqkEaI2VvawK/9q2MGhoevOGLK8kY1OCl0S/IxRVq7uiVcGcG7zM5oeob2tl/oQ7K8rkNMiozng2S6QwkbWhqbhUZBBnDknAmag8zgyDz8kcvOAxqahmhkAIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565224469; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=bFLMQt2Yw4xc30Fue1DdIOkxJuqkSm8E9MpgFD7Psts=; 
        b=ffGqr93n5sEEfJJ6kD1JKfY0YP9N4QBakvVYs1WVU3d6+8evWBqx9VGvTjqNpMVUfddOXz7Qz8HwRkD93IJXKZTFy0A9Xa68+yLa3gkOXgNo53q5NMLS+WzUIVgkYk1RG7QhkctYup0ndtFmgEaco5owVJUp9gVN/Pb96W2cWjk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=danielkoning.com;
        spf=pass  smtp.mailfrom=dk@danielkoning.com;
        dmarc=pass header.from=<dk@danielkoning.com> header.from=<dk@danielkoning.com>
Received: from cornelius (99-181-52-220.lightspeed.rcsntx.sbcglobal.net [99.181.52.220]) by mx.zohomail.com
        with SMTPS id 1565224468430351.51475116680285; Wed, 7 Aug 2019 17:34:28 -0700 (PDT)
From:   Daniel Koning <dk@danielkoning.com>
To:     git@vger.kernel.org
Subject: [PATCH] blame: document actual range specifier behavior
Date:   Wed, 07 Aug 2019 19:10:20 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (darwin)
Message-ID: <m2ftmcijgk.fsf@danielkoning.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-blame(1) man page says that the .. range specifier can be used
to exclude changes "older than" a certain revision. It goes on to say
that it collapses all lines "not changed since the range boundary" into
the boundary revision. This is the same thing --since=<rev-date> would
do, and the man page even uses .. and --since in parallel as if to imply
that they're alternative means of achieving the same output.

In fact, this isn't true! On the git-rev-list(1) and gitrevisions(7) man
pages, it's explained that the .. specifier excludes all ancestors of
the commit, not all commits on an earlier date. 'blame' is not an
exception to this behavior; it uses the same functions as other commands
to parse a specifier and build a revision set.

If you execute:

----
#!/bin/sh

mkdir blame-test
pushd blame-test

git init
echo "line added at root" > foo
echo "another line added at root" >> foo
git add foo
git commit -am "#1 chronologically"

git checkout -b side
sed '2i\
    line added only on side branch
    ' foo > bar
mv bar foo
git commit -am "#2 chronologically"

git checkout master
echo "line added only on master branch" >> foo
git commit -am "#3 chronologically"
git tag boundary

git merge side -m "#4 chronologically"

git blame boundary.. foo

popd blame-test
----

then you'll see that 'blame' treats the range specifier as 'rev-list'
would: the second line is attributed to a commit which occured
chronologically before `boundary`.

(I guess a case could be made for an off-kilter interpretation of the
phrasing, under which "since the range boundary" includes any commits
not yet known to that boundary. But that would contradict the use of
"since" as the name of the other limiting option, which *does* perform
an absolute time cutoff.)

There is at least one porcelain in fairly wide use which takes this
passage of the manual at its word, so I'm not the only one who finds it
confusing. I think the phrasing in the following patch is both clearer
and more accurate.

Signed-off-by: Daniel Koning <dk@danielkoning.com>
---
 Documentation/git-blame.txt | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80e..91f3184e56 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -152,18 +152,26 @@ Also you can use a regular expression to specify the line range:

 which limits the annotation to the body of the `hello` subroutine.

-When you are not interested in changes older than version
-v2.6.18, or changes older than 3 weeks, you can use revision
-range specifiers  similar to 'git rev-list':
-
-	git blame v2.6.18.. -- foo
-	git blame --since=3.weeks -- foo
-
-When revision range specifiers are used to limit the annotation,
-lines that have not changed since the range boundary (either the
-commit v2.6.18 or the most recent commit that is more than 3
-weeks old in the above example) are blamed for that range
-boundary commit.
+When you are only interested in recent changes, you can use revision
+range specifiers and limiting options, just as with 'git rev-list'.
+
+You can limit the annotation to commits from the past 3 weeks:
+
+  git blame --since=3.weeks -- foo
+
+The oldest commit in that span of time will be given the blame for any
+lines that have not changed since.
+
+Or you can limit the annotation to commits that are not ancestors of
+v2.6.18:
+
+  git blame v2.6.18.. -- foo
+
+Unlike the --since option, the two-dot range specifier does not perform
+a date-based cutoff. If changes from branch `fix` were merged in after
+v2.6.18, the commits on `fix` which introduced those changes will appear
+in the output of 'git blame', even if those commits took place at an
+earlier time than v2.6.18.

 A particularly useful way is to see if an added file has lines
 created by copy-and-paste from existing files.  Sometimes this
--
2.20.1

