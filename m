Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432CB1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeBWUl3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:41:29 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40290 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeBWUl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:41:27 -0500
Received: by mail-lf0-f68.google.com with SMTP id 37so14123094lfs.7
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ij9kmHdNB2PXgBgtvjEZNsYjgxoNsbcAnAtvnG3m5M8=;
        b=k8lQpHY5cZgBEn04g0OqnBl5J3LpUtmJ4yPsmxnk8g/kyXqiLlUr+iyZ2rT1j29U8C
         LdlymRQXNpLqhPBWfccgTuFZ+vNp9jxPdvRHQyEiP+fLzG6h+5dsGLp84LFyo0tu9rgm
         lls13MZVkfPT8sxWoOp8qyVHQOI7wRv67sIbyPSayrYraZzPKm3Zz/k7FxokXQQ9wWc2
         vVNXGM39n3pVfDWYKDhK4SDxZms3FrTpZ5JZbj0aWNqnks+miMOaUKpK7ThXj+Oi48b5
         0zF9JlOjkojg2pIz84zCpfj4QLo/5OZXQCVkulQPaOYL65Jxvhfx6Ku4oLF0SoKULH5g
         zEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ij9kmHdNB2PXgBgtvjEZNsYjgxoNsbcAnAtvnG3m5M8=;
        b=B91Z8wNQ1UHvBmnZ84k0jOAH4oePM9yPzbGiZAVNeT+gvNQ6Sm44njHjslcf8eGxYE
         Brw6y68Rah33JFlzc6aRo+xKo45A1FUQSEuJOD1cRQr4id47XqOo4gLNW7F/MNwR7E2L
         3h5ybkvaE4cunTUFilqkzs02VTk0un44gUSESxMRwXwlRa1LXDuck6C/a/VSLXx33St6
         tbm6MbhrsFUt41PLnmkWfaXNSUKvzgBzw+rzFWOJSDJ0vurDAIOrMIMMmxXns6C6Fwma
         JE4K7qtNw831uGwnh8Y2kv6rV88xFXuAbFi8EfIgrlpewgS/wUQSHclifvxq5HkrLZLx
         v3dg==
X-Gm-Message-State: APf1xPCoVrj5x0zNsmFKclwyYcJtrrkNlCuhirmXQuk9zpxYZ0RLSku3
        ANd8T+GTUNrWAvysbwizGUNsF2u+TYU/Z9Ipzbn+SDVp
X-Google-Smtp-Source: AG47ELt3fmN6AdthbA94FSLJlWTdUtWf3fCrfRhoAyKsa63I1D7iW0bxi5bB1nsJCbP250KMlAas+AxHdNhfrRIBhbU=
X-Received: by 10.25.201.76 with SMTP id z73mr2275963lff.74.1519418485922;
 Fri, 23 Feb 2018 12:41:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.85.134 with HTTP; Fri, 23 Feb 2018 12:41:25 -0800 (PST)
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Fri, 23 Feb 2018 15:41:25 -0500
Message-ID: <CADfK3RVJ9pYtpX9x2=CZSKLVy2qxBKeyyGA_S=jo8K-Fa4FOqA@mail.gmail.com>
Subject: [PATCH v2] subtree: fix add and pull for GPG-signed commits
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Avery Pennarun <apenwarr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If log.showsignature is true (or --show-signature is passed) while
performing a `subtree add` or `subtree pull`, the command fails.

toptree_for_commit() calls `log` and passes the output to `commit-tree`.
If this output shows the GPG signature data, `commit-tree` throws a
fatal error.

This commit fixes the issue by adding --no-show-signature to `log` calls
in a few places, as well as using the more appropriate `rev-parse`
instead where possible.

Signed-off-by: Stephen R Guglielmo <srg@guglielmo.us>
---
 contrib/subtree/git-subtree.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..9594ca4b5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -297,7 +297,7 @@ find_latest_squash () {
  main=
  sub=
  git log --grep="^git-subtree-dir: $dir/*\$" \
- --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
+ --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
  while read a b junk
  do
  debug "$a $b $junk"
@@ -341,7 +341,7 @@ find_existing_splits () {
  main=
  sub=
  git log --grep="^git-subtree-dir: $dir/*\$" \
- --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+ --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
  while read a b junk
  do
  case "$a" in
@@ -382,7 +382,7 @@ copy_commit () {
  # We're going to set some environment vars here, so
  # do it in a subshell to get rid of them safely later
  debug copy_commit "{$1}" "{$2}" "{$3}"
- git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
+ git log --no-show-signature -1
--pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
  (
  read GIT_AUTHOR_NAME
  read GIT_AUTHOR_EMAIL
@@ -462,8 +462,8 @@ squash_msg () {
  oldsub_short=$(git rev-parse --short "$oldsub")
  echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
  echo
- git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
- git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
+ git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
+ git log --no-show-signature --pretty=tformat:'REVERT: %h %s'
"$newsub..$oldsub"
  else
  echo "Squashed '$dir/' content from commit $newsub_short"
  fi
@@ -475,7 +475,7 @@ squash_msg () {

 toptree_for_commit () {
  commit="$1"
- git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+ git rev-parse --verify "$commit^{tree}" || exit $?
 }

 subtree_for_commit () {
-- 
2.16.2
