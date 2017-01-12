Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0E420798
	for <e@80x24.org>; Thu, 12 Jan 2017 06:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750751AbdALGB1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:01:27 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35552 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdALGBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:01:02 -0500
Received: by mail-io0-f193.google.com with SMTP id m98so1420830iod.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 22:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rDSvv0nyMGc6t1MUR2SfAAiUTBrPV0/JANpRRJmi7FY=;
        b=I+47PwBtNZEhUbS+EfrfO4GnCWrLj9YG/Rylma5I9bRCryt4Lr7U8osoPaA63Ds61a
         3nVNf4di+jwg8NWVbhJ7t6+1GW7p6wOXfW6/LxdRQ78VQ3Qa8iNM5zmlp7pGKVmHeObL
         0y4ohJ/jVtfHSU1yWcV8S7SloKbh66Vqnz2eoqmvsoDVLjfpzvypPZIiymI0+GXgCRnv
         DfK3Ni9aX5tUl6wJHHD/4YeHljSC1YeJ9ivttIDgLYRoenEJ7IFunKhuW2/lBcCHnyX7
         cGc67iI/NWvDXMyMt9DNiIUf3eLxOC+gBNARjzHwMBEgB+RuL0g1PtReXWxqArllvS24
         oMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rDSvv0nyMGc6t1MUR2SfAAiUTBrPV0/JANpRRJmi7FY=;
        b=uj2N+E7NaBwuG+CVOvU49Qx4t5b8YcA2gtiEPpARNHbL8W/27nivp8lUOfe+qnS1Vr
         YKY9GTbJy7R0QLzr25J+0eC4PAkkUtVXxsFVTGLicmCU2DM93+TlVGD1riMIrvNbYmBo
         Eus6C4gFhixhZxPv13eVMk6rJfrVV9HEblGUxb2X8GF+N2Qpz+/BOQ0+vyRSB0a8usB2
         vAXjzKK1sy7dKy//n1xNoh81Ja8Nc17g8VyDoQoWcmV95WS3lmaMm/BdqituImLOCAZS
         /tQjo+jyA6GyaRcUHhMzTE6F5SvxnJLMQ8gN7umyzFK4mU72ZIg4MiBKgITHa2F4FvwP
         v3kw==
X-Gm-Message-State: AIkVDXJvdf+m3x+mR0rkry6ujC0HjUws1NxWpSVP9s5WLWT4HmGFaDitoS59nAbG8gOk8Q==
X-Received: by 10.107.163.19 with SMTP id m19mr11189274ioe.222.1484200385160;
        Wed, 11 Jan 2017 21:53:05 -0800 (PST)
Received: from d-212-11-228.eecs.umich.edu ([141.212.11.228])
        by smtp.gmail.com with ESMTPSA id r20sm4350888ioi.10.2017.01.11.21.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 21:53:04 -0800 (PST)
From:   Pat Pannuto <pat.pannuto@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Pat Pannuto <pat.pannuto@gmail.com>
Subject: [PATCH 0/2] Use env for all perl invocations
Date:   Thu, 12 Jan 2017 00:51:38 -0500
Message-Id: <20170112055140.29877-1-pat.pannuto@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I spent a little while debugging why git-format-patch refused to believe
that SSL support was installed (Can't locate Net/SMTP/SSL.pm in @INC...)
Turns out that it was installed for my system's preferred /usr/local/bin/perl,
but not for git-format-patch's hard-coded /usr/bin/perl; changing the shebang
allowed git format-patch to work as expected.

This patch set converts all perl invocations in git to use env so that the
user-preferred perl interpreter is always used.

Pat Pannuto (2):
  Convert all 'perl -w' to 'perl' + 'use warnings;'
  Use 'env' to find perl instead of fixed path

 Documentation/build-docdep.perl               | 2 +-
 Documentation/cat-texi.perl                   | 4 +++-
 Documentation/cmd-list.perl                   | 4 +++-
 Documentation/fix-texi.perl                   | 4 +++-
 Documentation/lint-gitlink.perl               | 2 +-
 compat/vcbuild/scripts/clink.pl               | 3 ++-
 compat/vcbuild/scripts/lib.pl                 | 3 ++-
 contrib/buildsystems/engine.pl                | 3 ++-
 contrib/buildsystems/generate                 | 3 ++-
 contrib/buildsystems/parse.pl                 | 3 ++-
 contrib/contacts/git-contacts                 | 2 +-
 contrib/credential/netrc/git-credential-netrc | 2 +-
 contrib/credential/netrc/test.pl              | 2 +-
 contrib/diff-highlight/diff-highlight         | 2 +-
 contrib/examples/git-remote.perl              | 3 ++-
 contrib/examples/git-rerere.perl              | 2 +-
 contrib/examples/git-svnimport.perl           | 2 +-
 contrib/fast-import/git-import.perl           | 2 +-
 contrib/fast-import/import-directories.perl   | 2 +-
 contrib/fast-import/import-tars.perl          | 2 +-
 contrib/hooks/setgitperms.perl                | 2 +-
 contrib/hooks/update-paranoid                 | 2 +-
 contrib/long-running-filter/example.pl        | 2 +-
 contrib/mw-to-git/git-mw.perl                 | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl   | 2 +-
 contrib/mw-to-git/t/test-gitmw.pl             | 5 ++++-
 contrib/stats/mailmap.pl                      | 2 +-
 contrib/stats/packinfo.pl                     | 2 +-
 git-add--interactive.perl                     | 2 +-
 git-archimport.perl                           | 2 +-
 git-cvsexportcommit.perl                      | 2 +-
 git-cvsimport.perl                            | 2 +-
 git-cvsserver.perl                            | 2 +-
 git-difftool.perl                             | 2 +-
 git-relink.perl                               | 2 +-
 git-send-email.perl                           | 2 +-
 git-svn.perl                                  | 2 +-
 gitweb/gitweb.perl                            | 2 +-
 t/Git-SVN/Utils/can_compress.t                | 2 +-
 t/Git-SVN/Utils/fatal.t                       | 2 +-
 t/check-non-portable-shell.pl                 | 2 +-
 t/gitweb-lib.sh                               | 2 +-
 t/perf/aggregate.perl                         | 2 +-
 t/perf/min_time.perl                          | 2 +-
 t/t0202/test.pl                               | 2 +-
 t/t4034/perl/post                             | 2 +-
 t/t4034/perl/pre                              | 2 +-
 t/t9000/test.pl                               | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh        | 2 +-
 t/t9700/test.pl                               | 2 +-
 t/test-terminal.perl                          | 2 +-
 51 files changed, 66 insertions(+), 51 deletions(-)

-- 
2.11.0

