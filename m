Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880A91F453
	for <e@80x24.org>; Fri, 28 Sep 2018 15:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeI1VfN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 17:35:13 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36317 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1VfN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 17:35:13 -0400
Received: by mail-qt1-f172.google.com with SMTP id e26-v6so7004463qtq.3
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EtbwpCAE60m2y25NW7hBTnQv+WBx9isislSTApbTRYA=;
        b=q9ouuUgzdjYY8GQ+fSy0JJzVERFnVc8UEQS0liNcy49p2ERW/RAi0LWDugX6dWLG5l
         I+3kTPlDmh0QmT2Z3u7HdXbMMKeRgeDMc2U0Q1udZ7cNF125vb8Fy9a7SRhfnoRSg9VQ
         4BbNVKrszLAG/YhiPWoDeHxVsn7t3FseEjOZu9SuZs+M+n+yfyQgkuTNTUYndOlniuij
         OMQyxMaquxQfexM4HYs1hyZwVvqxFnpv9Fw22wZTHmJDnq/I4OKNva7gvMg1VGlxQfl5
         5fEPfj9cBYI0OVBr/BS8kmtVN+EaRw1qChPXOR26v3+wCQGOQRV8CZKumAZhzJK88ub1
         zAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EtbwpCAE60m2y25NW7hBTnQv+WBx9isislSTApbTRYA=;
        b=AMgj/Nlt9wo8Kc04zWzACP+9eBa3AFQH0V9a83uCTM0RdLLWxXZkz/9zewZlVKokAR
         hn3tzH20au1vS6VRsDMDdaiK3Hw3T72gEpL5Pp58UtHa8F9LUBLMrxvmqb8gMsHUV9cj
         jCZi3Kin22NAHjbl39/MHQXzWfsT/794v8ygWYGC4PXFfL/MVqA60qKpWPMq/4cMAeVH
         Rz5GYwCeqVzKGUO8Hqt4+oAV0INc56ZlnMlkrz9cl9Y6wt3YeuW1yp7dJPg+DWyXMGzE
         gkefaAfKlduqYoYYUUwY3XIIqR4cA5Q2B7y98PzlI9WDGHlwqki2wJ6tuSy4FAIfLvLb
         x9/g==
X-Gm-Message-State: ABuFfojEp/9oK8Pq6HFlb/CCNhBROF5GLTonouTajkf8JX6wcibaMgY3
        vs064s1YE12iSc0NkhB/nB/MkUIs93CtRJyspAvB5tLYzJc=
X-Google-Smtp-Source: ACcGV62Uf8r7ELynzSGNf7j3kb1XEUPYu4U9gf95ugL7uLgBGiCqaWCXBj6ZL8hVY6TPxsVDw/xOr1Y3xB3+vWjJ2e4=
X-Received: by 2002:ac8:3d8a:: with SMTP id v10-v6mr13033595qtf.341.1538147460029;
 Fri, 28 Sep 2018 08:11:00 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Hubert <khubert@gmail.com>
Date:   Fri, 28 Sep 2018 11:10:49 -0400
Message-ID: <CAJoZ4U2G5rhZnOxsHjxByfYQvDCc-CJ=1-JjyrjW_B-CWForEA@mail.gmail.com>
Subject: [PATCH] Improvement to only call Git Credential Helper once
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling the Git Credential Helper that is set in the git config,
the get command can return a credential. Git immediately turns around
and calls the store command, even though that credential was just
retrieved by the Helper. This creates two side effects. First of all,
if the Helper requires a passphrase, the user has to type it in
twice. Secondly, if the user has a number of helpers, this retrieves
the credential from one service and writes it to all services.

This commit introduces a new field in the credential struct that
detects when the credential was retrieved using the Helper, and early
exits when called to store the credential.
---
 credential.c | 8 +++++++-
 credential.h | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index 62be651b0..79bf62d49 100644
--- a/credential.c
+++ b/credential.c
@@ -280,8 +280,10 @@ void credential_fill(struct credential *c)

  for (i = 0; i < c->helpers.nr; i++) {
  credential_do(c, c->helpers.items[i].string, "get");
- if (c->username && c->password)
+ if (c->username && c->password) {
+ c->retrieved = 1;
  return;
+ }
  if (c->quit)
  die("credential helper '%s' told us to quit",
      c->helpers.items[i].string);
@@ -300,6 +302,10 @@ void credential_approve(struct credential *c)
  return;
  if (!c->username || !c->password)
  return;
+ if (c->retrieved) {
+ c->approved = 1;
+ return;
+ }

  credential_apply_config(c);

diff --git a/credential.h b/credential.h
index 6b0cd16be..d99df2f52 100644
--- a/credential.h
+++ b/credential.h
@@ -8,7 +8,8 @@ struct credential {
  unsigned approved:1,
  configured:1,
  quit:1,
- use_http_path:1;
+ use_http_path:1,
+ retrieved:1;

  char *username;
  char *password;
