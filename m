Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA3B20A25
	for <e@80x24.org>; Fri, 15 Sep 2017 21:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdIOVr1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:47:27 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:53053 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdIOVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:47:25 -0400
Received: by mail-qk0-f181.google.com with SMTP id o77so3243768qke.9
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfCCbu3LGrkaNZ/+vWuWevgwjdJ3nvEnGnNIYaGaVCI=;
        b=CBdmjkCS9YE8gWM/m9O9GNbTzRfkfJbAZj26IXp6++uSXrhi55B454FZfCWenk3NQ1
         uojMLNWTZNroqSVbcWxbUCNVuryCkO/9WJx6420A7XFTHA7eT8JCeuf2EI1GKX44AAz+
         Kxtx2NhGFvE8l5HNHc5J1ud9aF/FDgpXNQ8f43YX0wXznJy/3f2B7rnwtv4Dny1AJvZX
         oPHWJsNBZRiOP1yJzIZlxsVamwQYQBQCMJm2G/SgIeN/N/Uf5i54qGq5iv8NjdshTsyg
         9IDMXOQgahoeE2t9jhC4WVLRS3ZfkqBblBKE/XP8otCjaiJImirIivGqdxbgafFcTrB7
         Wu8g==
X-Gm-Message-State: AHPjjUjzxq6P4NQPtdByin090bl/V79c27d91AgyJJpai2mxZm63Z4CW
        E2sYnInQM7xsodc/YkpZFg==
X-Google-Smtp-Source: AOwi7QBghrmPvQwnMn5cBLT0H9E0B/k1um67bcWWvFhhdv4dJ+m3VaYFUCPYjIN7vNc2dwAWirVinw==
X-Received: by 10.55.42.216 with SMTP id q85mr9636373qkq.337.1505512044609;
        Fri, 15 Sep 2017 14:47:24 -0700 (PDT)
Received: from orpheus.redhat.com (209-6-90-240.s1774.c3-0.smr-ubr1.sbo-smr.ma.cable.rcncustomer.com. [209.6.90.240])
        by smtp.gmail.com with ESMTPSA id v68sm1209516qkb.73.2017.09.15.14.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Sep 2017 14:47:24 -0700 (PDT)
From:   Jason Merrill <jason@redhat.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Eric Wong <e@80x24.org>,
        aldyh@redhat.com, Jason Merrill <jason@redhat.com>
Subject: [PATCH v2] git-svn: Fix svn.pushmergeinfo handling of svn+ssh usernames.
Date:   Fri, 15 Sep 2017 17:46:53 -0400
Message-Id: <20170915214653.14720-1-jason@redhat.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
References: <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, svn dcommit of a merge with svn.pushmergeinfo set would
get error messages like "merge parent <X> for <Y> is on branch
svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
svn+ssh://jason@gcc.gnu.org/svn/gcc!"

So, let's call remove_username (as we do for svn info) before comparing
rooturl to branchurl.

Signed-off-by: Jason Merrill <jason@redhat.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-svn.perl b/git-svn.perl
index fa42364785..3b95d67bde 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -931,6 +931,7 @@ sub cmd_dcommit {
 		# information from different SVN repos, and paths
 		# which are not underneath this repository root.
 		my $rooturl = $gs->repos_root;
+	        Git::SVN::remove_username($rooturl);
 		foreach my $d (@$linear_refs) {
 			my %parentshash;
 			read_commit_parents(\%parentshash, $d);
-- 
2.13.5

