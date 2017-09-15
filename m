Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FAF620A25
	for <e@80x24.org>; Fri, 15 Sep 2017 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdIORIb (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 13:08:31 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:48279 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdIORIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 13:08:30 -0400
Received: by mail-qk0-f175.google.com with SMTP id a128so2655272qkc.5
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 10:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gOWvhMybe/KDr6W4AFkRNeF4Als/wiak/K2skxzwXbs=;
        b=EFx65qvxomCGVNY5MEozZU6zS6xhfGjHx27MoToL/pCl0OSWXQP5Lbf20uz073tAFe
         DIKf+kNCwKJ7dwp8KajZEVC1CwTkA/7m5dJexk9P84HeL+vH1+fzf/QF93yYPTXPf0u5
         vX2+cg+ZI1IRSqFw47sJCdQ0dcQTlg1SHl39WqccoPor9TUl0fSD+uYo2mb38t9vPP/W
         6vZrkm0EJMgVeu8+kq8ki64huAIuGqyxh3jhHUXTQI48gb6iWHA2A+jKLu5lq6YsIktd
         rjQrOGXKWs29V0jHPTAFYh8Osszi4cw55W7BvOdR/J1oqMfr7Y6e3WOpKdKBF0AxyZvj
         8dqQ==
X-Gm-Message-State: AHPjjUiLPjyFpA92yxIYvoKpC1RBJOtvQbZTEkTWamWlr/uZon7oHlNE
        xsgy32XV77emNcG4FqNJAg==
X-Google-Smtp-Source: AOwi7QAbvdewLtKiadDyH6whvW5KXeFxMxmKl0sSFHe0cC00dOEOBfNbPJKLn8T81hNUPvZAsWXQPg==
X-Received: by 10.55.43.226 with SMTP id r95mr8858497qkr.0.1505495309296;
        Fri, 15 Sep 2017 10:08:29 -0700 (PDT)
Received: from orpheus.redhat.com (209-6-90-240.s1774.c3-0.smr-ubr1.sbo-smr.ma.cable.rcncustomer.com. [209.6.90.240])
        by smtp.gmail.com with ESMTPSA id n88sm851073qki.49.2017.09.15.10.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Sep 2017 10:08:27 -0700 (PDT)
From:   Jason Merrill <jason@redhat.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, aldyh@redhat.com,
        Jason Merrill <jason@redhat.com>
Subject: [PATCH] Fix merge parent checking with svn.pushmergeinfo.
Date:   Fri, 15 Sep 2017 13:08:18 -0400
Message-Id: <20170915170818.27390-1-jason@redhat.com>
X-Mailer: git-send-email 2.13.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this fix, svn dcommit of a merge with svn.pushmergeinfo set would
get error messages like "merge parent <X> for <Y> is on branch
svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
svn+ssh://jason@gcc.gnu.org/svn/gcc!"

* git-svn.perl: Remove username from rooturl before comparing to branchurl.

Signed-off-by: Jason Merrill <jason@redhat.com>
---
 git-svn.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-svn.perl b/git-svn.perl
index fa42364785..1663612b1c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -931,6 +931,7 @@ sub cmd_dcommit {
 		# information from different SVN repos, and paths
 		# which are not underneath this repository root.
 		my $rooturl = $gs->repos_root;
+	        Git::SVN::remove_username ($rooturl);
 		foreach my $d (@$linear_refs) {
 			my %parentshash;
 			read_commit_parents(\%parentshash, $d);
-- 
2.13.5

