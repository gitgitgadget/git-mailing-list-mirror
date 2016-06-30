Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7596B20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 01:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbcF3B0B (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 21:26:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34819 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbcF3B0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 21:26:00 -0400
Received: by mail-pf0-f175.google.com with SMTP id c2so23585604pfa.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 18:25:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PJbFERTbnTuJHMVEl3AzNABRslTnbFQw/w20C1CdWAk=;
        b=gDp0FPQivZ00gQr/4jL/uSzt6dR+LRp4KuGsPSQCRtZiHTQglsDnwuQEtfoBkVch1O
         0b+1l755yJZffdsDjy6JlnqDq/fFxfuUSQb3n0NObA0uo9PFEy6+9vswY/POEDmV7XUo
         4DNMdkOwfOtKlfEK6CCG6S2V4Y5KXsfm/M53B08TdvZMB5/T6bFrTcoM6yI3fFmacmSJ
         bX/vQwYbXaAACMpSJyjsKCHazi+P6hrDY3GKu+vcD5YwU+YY6cS3P4Qa1z37z3EnElrB
         E1+XLhnk+phWiuMfgzeAdfXytPiWPDvhzxJE1IBH8J8vz2yt6F2Uu1NWNMynasulZPh0
         iXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PJbFERTbnTuJHMVEl3AzNABRslTnbFQw/w20C1CdWAk=;
        b=SG6wilF5x/u5BwgK03aTZ9BKW0p2Ng4+WzSIOweimkoK0uNC2Y5lPJZCKDdEfSZvBv
         bfz+u9a9YxWfKUPA8W8r7qwalOrDlEoRSumNDt+QW6o+hFCUgiikw0U0Lbahdta9FEqy
         KcXsMSHzqs+H+kXZ2T7dXjSqNA5b6M2NbhA9ZDc3pH+xQNeHC2y9dTvTXKJFIBfGVoAX
         uYZ8HNwvEe+S2M9fHmtQW09tDVDccOpwSienguXl6p7q42ErsTXzgxEN3KNF6ct+pOm8
         /llSYEZOD2b+SwErKOPpbQBk4bGKUmbq4QfSl8arCCVkQ41oPFJkxNmPRQ1sK1XDLvwl
         yLjg==
X-Gm-Message-State: ALyK8tL4U7EY/fqrkStPUQsn61WnAnqgnBnLVljqcV/uhwXUA6RYAn0jYPfPLfLDY7BRzTMk
X-Received: by 10.98.34.15 with SMTP id i15mr16855452pfi.29.1467248409971;
        Wed, 29 Jun 2016 18:00:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4c6d:bc1b:299f:eb0])
        by smtp.gmail.com with ESMTPSA id yo10sm754757pab.4.2016.06.29.18.00.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jun 2016 18:00:09 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, dwwang@google.com
Cc:	Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv1 0/4] Push options in C Git
Date:	Wed, 29 Jun 2016 17:59:47 -0700
Message-Id: <20160630005951.7408-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gdd65b60
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

When using a remote that is more than just a plain Git host (e.g. Gerrit,
Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
push options can instruct the server to:
* open a pull request
* send out emails asking for review
* (un)trigger continuous integration
* set priority for continuous integration (i.e. bots pushing may ask to be
  treated with lower priority compared to humans)
* ... 

Most of these actions can be done on the client side as well,
but in these remote-centric workflows it is easier to do that on the remote,
which is why we need to transport the information there.

More concrete examples:
* When you want a change in Gerrit to be submitted to refs/heads/master, you
  push instead to a magic branch refs/for/master and Gerrit will create a change
  for you (similar to a pull request). Instead we could imagine that you push
  to a magical refs/heads/master with a push option "create-change".
  
* When pushing to Gerrit you can already attach some of this information by
  adding a '%' followed by the parameter to the ref, i.e. when interacting with
  Gerrit it is possible to do things like[1]:
    
    git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
  
  This is not appealing to our users as it looks like hacks upon hacks to make
  it work. It would read better if it was spelled as:
  
  git push origin HEAD:refs/for/master \
      --push-option draft \
      --push-option topic=example \
      --push-option cc=jon.doe@example.org
      
  (with a short form that is even easier to type,
   but this is is more intuitive already)

This is a patch series to Git core, which is developed at the same time
as a change is proposed to JGit by Dan Wang, see [2].

This code is also available at [3].

Thanks,
Stefan

[1] Not all Gerrit '%' options are documented, so here is a link to source code instead :(
https://gerrit.googlesource.com/gerrit/+/refs/heads/master/gerrit-server/src/main/java/com/google/gerrit/server/git/ReceiveCommits.java#1141

[2] https://git.eclipse.org/r/#/c/74570/ 
 
[3] https://github.com/stefanbeller/git/tree/pushoptions

Stefan Beller (4):
  push options: {pre,post}-receive hook learns about push options
  receive-pack: implement advertising and receiving push options
  push: accept push options
  add a test for push options

 Documentation/config.txt                          |  7 +-
 Documentation/git-push.txt                        |  8 ++-
 Documentation/githooks.txt                        |  4 ++
 Documentation/technical/pack-protocol.txt         | 10 +--
 Documentation/technical/protocol-capabilities.txt |  8 +++
 builtin/push.c                                    | 16 ++++-
 builtin/receive-pack.c                            | 85 +++++++++++++++++++----
 send-pack.c                                       | 29 ++++++++
 send-pack.h                                       |  3 +
 t/t5544-push-options.sh                           | 85 +++++++++++++++++++++++
 transport.c                                       |  2 +
 transport.h                                       |  7 ++
 12 files changed, 242 insertions(+), 22 deletions(-)
 create mode 100755 t/t5544-push-options.sh

-- 
2.9.0.141.gdd65b60

