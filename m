Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666C11F462
	for <e@80x24.org>; Fri, 31 May 2019 18:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEaSQY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:16:24 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:35028 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbfEaSQY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 14:16:24 -0400
Received: from [2001:16b8:5c8e:5500:5015:4633:2bbd:77c7] (helo=adam-MS-7A63.fritz.box); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hWm4k-0002XQ-Af; Fri, 31 May 2019 20:16:22 +0200
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
To:     git@vger.kernel.org
Cc:     "Dr. Adam Nielsen" <admin@in-ici.net>
Subject: [PATCH] make slash-rules more readable
Date:   Fri, 31 May 2019 20:16:17 +0200
Message-Id: <20190531181617.24190-1-admin@in-ici.net>
X-Mailer: git-send-email 2.17.1
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1559326583;de7b961d;
X-HE-SMSGID: 1hWm4k-0002XQ-Af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/gitignore.txt | 75 ++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index b5bc9dbff0..ce944779a5 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,28 +89,36 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
+ - A slash `/` is used as a directory separator. A leading and trailing
+   slash have special meaning and are explained in the following.
+
+ - If the pattern ends with a slash, it would only find
    a match with a directory.  In other words, `foo/` will match a
-   directory `foo` and paths underneath it, but will not match a
-   regular file or a symbolic link `foo` (this is consistent
-   with the way how pathspec works in general in Git).
-
- - If the pattern does not contain a slash '/', Git treats it as
-   a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
-
- - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
-   anything except "`/`", "`?`" matches any one character except "`/`"
-   and "`[]`" matches one character in a selected range. See
-   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
-   description.
-
- - A leading slash matches the beginning of the pathname.
-   For example, "/{asterisk}.c" matches "cat-file.c" but not
-   "mozilla-sha1/sha1.c".
+   directory `foo`, but will not match a regular file or a
+   symbolic link `foo` (this is consistent with the way how
+   pathspec works in general in Git).
+
+ - If the pattern does not end with a slash, it would find a match
+   with a file or directory.
+
+ - The pattern is matched relative to the location of
+   the `.gitignore` file. Except if the pattern contains
+   no slash (or no slash but a trailing slash), then the pattern is
+   matched against all files and folders (recursively)
+   from the location of the `.gitignore` file.
+   For example, `doc/frotz/` matches `doc/frotz` directory, but not
+   a/doc/frotz`; however `frotz/` matches `frotz` and `a/frotz` that
+   is a directory (all paths are relative from the `.gitignore` file).
+
+ - A leading slash, if any, is implicitly removed before matching the
+   pattern with the pathname, but the pattern still counts as having
+   a non-trailing slash for the purpose of the above rule.
+
+ - An asterisk "`*`" matches anything except a slash.
+   The character "`?`" matches any one character except "`/`".
+   The range notation, e.g. `[a-zA-Z]`, can be used to match
+   one of the characters in a range. See fnmatch(3) and the
+   FNM_PATHNAME flag for a more detailed description.
 
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
@@ -152,6 +160,31 @@ To stop tracking a file that is currently tracked, use
 EXAMPLES
 --------
 
+ - The pattern `/bar` only matches the file or folder `bar`
+   but not `a/bar`, whereas the pattern `bar` would match both
+   (relative to the `.gitignore` file). That is because the
+   pattern `/bar` contains a non-trailing slash and thus matches
+   relative to the location of the `.gitignore` file.
+   Since `bar` has no slash, it matches recursively.
+
+ - The pattern 'hello.*' is not sufficient for the following rule:
+   "ignore any file whose name begins with 'hello' and in this
+   directory only, not in its subdirectories." because the pattern
+   does not have any slash. To work around this limitation,
+   you can prepend your pattern with a slash, i.e. '/hello.*';
+   the pattern now matches 'hello.txt', 'hello.c' but not
+   'a/hello.java'.
+
+ - The pattern `doc/frotz` and `/doc/frotz` have the same effect
+   in any `.gitignore` file. Both pattern contain a non-trailing
+   slash and thus match relative to the location of the
+   `.gitignore` file.
+
+ - The pattern "foo/*", matches "foo/test.json"
+   (a regular file), "foo/bar" (a diretory), but it does not match
+   "foo/bar/hello.c" (a regular file), as the asterisk in the
+   patter does not match "bar/hello.c" which has a slash in it.
+
 --------------------------------------------------------------
     $ git status
     [...]
-- 
2.17.1

