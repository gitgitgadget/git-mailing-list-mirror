Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D730CC3B1BE
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947142086A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgBNSzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:55:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:43826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728859AbgBNSzA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:55:00 -0500
Received: (qmail 23210 invoked by uid 109); 14 Feb 2020 18:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:55:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23983 invoked by uid 111); 14 Feb 2020 19:03:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 14:03:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:54:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: [PATCH] doc: move credential helper info into gitcredentials(7)
Message-ID: <20200214185459.GA1207370@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:32:00PM -0500, Jeff King wrote:

> This is talking about the git-credential tool itself, but the actual
> helper protocol documentation links to this. (As an aside, I notice that
> the protocol documentation recently got moved into credential.h along
> with the C API bits. Yuck. That probably should be in
> gitcredentials(7)).

I've been meaning to fix this for years, so let's do it while we're
thinking about it (this is orthogonal both semantically and textually to
the patch I was replying to, so it can be handled separately).

-- >8 --
Subject: doc: move credential helper info into gitcredentials(7)

The details of how credential helpers can be called or implemented were
originally covered in Documentation/technical/. Those are topics that
end users might care about (and we even referenced them in the
credentials manpage), but those docs typically don't ship as part of the
end user documentation, making them less useful.

This situation got slightly worse recently in f3b9055624 (credential:
move doc to credential.h, 2019-11-17), where we moved them into the C
header file, making them even harder to find.

So let's move put this information into the gitcredentials(7)
documentation, which is meant to describe the overall concepts of our
credential handling. This was already pointing to the API docs for these
concepts, so we can just include it inline instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitcredentials.txt | 89 ++++++++++++++++++++++++++++++-
 credential.h                     | 90 --------------------------------
 2 files changed, 88 insertions(+), 91 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index ea759fdee5..5b9d14fb1f 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -186,7 +186,94 @@ CUSTOM HELPERS
 --------------
 
 You can write your own custom helpers to interface with any system in
-which you keep credentials. See credential.h for details.
+which you keep credentials.
+
+Credential helpers are programs executed by Git to fetch or save
+credentials from and to long-term storage (where "long-term" is simply
+longer than a single Git process; e.g., credentials may be stored
+in-memory for a few minutes, or indefinitely on disk).
+
+Each helper is specified by a single string in the configuration
+variable `credential.helper` (and others, see linkgit:git-config[1]).
+The string is transformed by Git into a command to be executed using
+these rules:
+
+  1. If the helper string begins with "!", it is considered a shell
+     snippet, and everything after the "!" becomes the command.
+
+  2. Otherwise, if the helper string begins with an absolute path, the
+     verbatim helper string becomes the command.
+
+  3. Otherwise, the string "git credential-" is prepended to the helper
+     string, and the result becomes the command.
+
+The resulting command then has an "operation" argument appended to it
+(see below for details), and the result is executed by the shell.
+
+Here are some example specifications:
+
+----------------------------------------------------
+# run "git credential-foo"
+foo
+
+# same as above, but pass an argument to the helper
+foo --bar=baz
+
+# the arguments are parsed by the shell, so use shell
+# quoting if necessary
+foo --bar="whitespace arg"
+
+# you can also use an absolute path, which will not use the git wrapper
+/path/to/my/helper --with-arguments
+
+# or you can specify your own shell snippet
+!f() { echo "password=`cat $HOME/.secret`"; }; f
+----------------------------------------------------
+
+Generally speaking, rule (3) above is the simplest for users to specify.
+Authors of credential helpers should make an effort to assist their
+users by naming their program "git-credential-$NAME", and putting it in
+the `$PATH` or `$GIT_EXEC_PATH` during installation, which will allow a
+user to enable it with `git config credential.helper $NAME`.
+
+When a helper is executed, it will have one "operation" argument
+appended to its command line, which is one of:
+
+`get`::
+
+	Return a matching credential, if any exists.
+
+`store`::
+
+	Store the credential, if applicable to the helper.
+
+`erase`::
+
+	Remove a matching credential, if any, from the helper's storage.
+
+The details of the credential will be provided on the helper's stdin
+stream. The exact format is the same as the input/output format of the
+`git credential` plumbing command (see the section `INPUT/OUTPUT
+FORMAT` in linkgit:git-credential[1] for a detailed specification).
+
+For a `get` operation, the helper should produce a list of attributes on
+stdout in the same format (see linkgit:git-credential[1] for common
+attributes). A helper is free to produce a subset, or even no values at
+all if it has nothing useful to provide. Any provided attributes will
+overwrite those already known about by Git.  If a helper outputs a
+`quit` attribute with a value of `true` or `1`, no further helpers will
+be consulted, nor will the user be prompted (if no credential has been
+provided, the operation will then fail).
+
+For a `store` or `erase` operation, the helper's output is ignored.
+If it fails to perform the requested operation, it may complain to
+stderr to inform the user. If it does not support the requested
+operation (e.g., a read-only store), it should silently ignore the
+request.
+
+If a helper receives any other operation, it should silently ignore the
+request. This leaves room for future operations to be added (older
+helpers will just ignore the new requests).
 
 GIT
 ---
diff --git a/credential.h b/credential.h
index 5772d50577..a5a3ee9bb8 100644
--- a/credential.h
+++ b/credential.h
@@ -90,96 +90,6 @@
  * return status;
  * }
  * -----------------------------------------------------------------------
- *
- * Credential Helpers
- * ------------------
- *
- * Credential helpers are programs executed by Git to fetch or save
- * credentials from and to long-term storage (where "long-term" is simply
- * longer than a single Git process; e.g., credentials may be stored
- * in-memory for a few minutes, or indefinitely on disk).
- *
- * Each helper is specified by a single string in the configuration
- * variable `credential.helper` (and others, see Documentation/git-config.txt).
- * The string is transformed by Git into a command to be executed using
- * these rules:
- *
- *   1. If the helper string begins with "!", it is considered a shell
- *      snippet, and everything after the "!" becomes the command.
- *
- *   2. Otherwise, if the helper string begins with an absolute path, the
- *      verbatim helper string becomes the command.
- *
- *   3. Otherwise, the string "git credential-" is prepended to the helper
- *      string, and the result becomes the command.
- *
- * The resulting command then has an "operation" argument appended to it
- * (see below for details), and the result is executed by the shell.
- *
- * Here are some example specifications:
- *
- * ----------------------------------------------------
- * # run "git credential-foo"
- * foo
- *
- * # same as above, but pass an argument to the helper
- * foo --bar=baz
- *
- * # the arguments are parsed by the shell, so use shell
- * # quoting if necessary
- * foo --bar="whitespace arg"
- *
- * # you can also use an absolute path, which will not use the git wrapper
- * /path/to/my/helper --with-arguments
- *
- * # or you can specify your own shell snippet
- * !f() { echo "password=`cat $HOME/.secret`"; }; f
- * ----------------------------------------------------
- *
- * Generally speaking, rule (3) above is the simplest for users to specify.
- * Authors of credential helpers should make an effort to assist their
- * users by naming their program "git-credential-$NAME", and putting it in
- * the $PATH or $GIT_EXEC_PATH during installation, which will allow a user
- * to enable it with `git config credential.helper $NAME`.
- *
- * When a helper is executed, it will have one "operation" argument
- * appended to its command line, which is one of:
- *
- * `get`::
- *
- * 	Return a matching credential, if any exists.
- *
- * `store`::
- *
- * 	Store the credential, if applicable to the helper.
- *
- * `erase`::
- *
- * 	Remove a matching credential, if any, from the helper's storage.
- *
- * The details of the credential will be provided on the helper's stdin
- * stream. The exact format is the same as the input/output format of the
- * `git credential` plumbing command (see the section `INPUT/OUTPUT
- * FORMAT` in Documentation/git-credential.txt for a detailed specification).
- *
- * For a `get` operation, the helper should produce a list of attributes
- * on stdout in the same format. A helper is free to produce a subset, or
- * even no values at all if it has nothing useful to provide. Any provided
- * attributes will overwrite those already known about by Git.  If a helper
- * outputs a `quit` attribute with a value of `true` or `1`, no further
- * helpers will be consulted, nor will the user be prompted (if no
- * credential has been provided, the operation will then fail).
- *
- * For a `store` or `erase` operation, the helper's output is ignored.
- * If it fails to perform the requested operation, it may complain to
- * stderr to inform the user. If it does not support the requested
- * operation (e.g., a read-only store), it should silently ignore the
- * request.
- *
- * If a helper receives any other operation, it should silently ignore the
- * request. This leaves room for future operations to be added (older
- * helpers will just ignore the new requests).
- *
  */
 
 
-- 
2.25.0.796.gcc29325708

