Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229F61F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeJZIHl (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:41 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:43355 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJZIHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:40 -0400
Received: by mail-yb1-f201.google.com with SMTP id c6-v6so6876569ybm.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AVaboUMQrDQEcJvQHGNvju2g1A+oI4XM1VDQkjDem4o=;
        b=AVR5cXr1FHVfhri8aevqDwKX6k7T9zQUkmPVjRJrwZWJ1g574THHOnlpNk7PVvF7Rm
         IPl6TKWz8L41iWtQxIbQm1Kla9sVQpAtpFwBUC8x8GRsMJPV622p7JlcOw7Oj9Y1vj1I
         XcQtV0drsFBb5vTUepgl25T5idflAZhq+sf7+W6xeoSkjTip+SOjp9kz0OCVDr3tm35S
         0oi8Cf5BELY2kB6QjD7/5l5oFkjNbucK+tppOFCb6w5izXBZiXn0A768+kCiCaqcsF2y
         5Cz3fzjy3OHaCRGQMIvJr9LdRoI3Pgu894Zpc3eCgMRH9DYt8BbqgUAAVEC9GzNLudHo
         qAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AVaboUMQrDQEcJvQHGNvju2g1A+oI4XM1VDQkjDem4o=;
        b=aula5nP4bIEebiWuRBsjHkehnCRBmBAGCMRP2dJ0abzWD9uvVaQ/4+vCbGQudQweiE
         ugv2oJ2cjICxmSzkwtb/MRRjMDIgr+i45F4bVrXtOvTgZjxEeJZahs9DYAPUNi4v+l0G
         hjOxBMCRGgO2zmByAsEsUqxcfaCj+wniqEvFY9GUpjKa2hQ7fkT3DAI/pvBy2XkYo7pD
         TvLIffKUBWk87Ko5ntvltTcoI/UA0jDCJXvsmn++jNUcZrx4prQvPGWgoxhayyXXgcdG
         RVJRboPeTU8mymTgUVsEx4wWP0P3KDW58Ry7kal9cu8gNlESNUCHs9hrd+l8oTFULchb
         Qj3w==
X-Gm-Message-State: AGRZ1gIWp06f86YbKaU9gAlMjmv7sycBkBMn40lsfD9opdAUfIn3SU5F
        pcKsk+PQQkCjbLL56IDcYGY7X+RkbMjQ
X-Google-Smtp-Source: AJdET5dxhmLZINYxdL5sExDWQLx3vqbgVySJcjb1Oc2Z5UqClt8YGCUufy/rU09rd99xo1fSfQst+iVJLS6Q
X-Received: by 2002:a25:bb13:: with SMTP id z19-v6mr903918ybg.23.1540510382472;
 Thu, 25 Oct 2018 16:33:02 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:31 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 10/10] builtin/fetch: check for submodule updates in any ref update
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit, the code review tool, has a different workflow than our mailing
list based approach. Usually users upload changes to a Gerrit server and
continuous integration and testing happens by bots. Sometimes however a
user wants to checkout a change locally and look at it locally. For this
use case, Gerrit offers a command line snippet to copy and paste to your
terminal, which looks like

  git fetch https://<host>/gerrit refs/changes/<id> &&
  git checkout FETCH_HEAD

For Gerrit changes that contain changing submodule gitlinks, it would be
easy to extend both the fetch and checkout with the '--recurse-submodules'
flag, such that this command line snippet would produce the state of a
change locally.

However the functionality added in the previous patch, which would
ensure that we fetch the objects in the submodule that the gitlink pointed
at, only works for remote tracking branches so far, not for FETCH_HEAD.

Make sure that fetching a superproject to its FETCH_HEAD, also respects
the existence checks for objects in the submodule recursion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  8 ++------
 t/t5526-fetch-submodules.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95c44bf6ff..f39012d7c2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -700,8 +700,6 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
@@ -715,8 +713,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
@@ -729,8 +725,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
@@ -826,6 +820,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				ref->force = rm->peer_ref->force;
 			}
 
+			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
+				check_for_new_submodule_commits(&rm->old_oid);
 
 			if (!strcmp(rm->name, "HEAD")) {
 				kind = "";
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5a75b57852..799785783f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -631,4 +631,28 @@ test_expect_success "fetch new submodule commits on-demand outside standard refs
 	)
 '
 
+test_expect_success 'fetch new submodule commits on-demand in FETCH_HEAD' '
+	# depends on the previous test for setup
+
+	C=$(git -C submodule commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/2 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/2 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/2 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 test_done
-- 
2.19.0

