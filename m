Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B21F1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJQFq (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 12:05:46 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:41574
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJQFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 12:05:46 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hwTsG-000as4-Lt
        for git@vger.kernel.org; Sat, 10 Aug 2019 18:05:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Gregory Szorc <gregory.szorc@gmail.com>
Subject: Non-robust lock files in containers can lead to repo corruption
Date:   Sat, 10 Aug 2019 09:05:33 -0700
Message-ID: <qimq0i$49gn$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
X-Mozilla-News-Host: news://news.gmane.org:119
Openpgp: preference=signencrypt
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tracked down a source of Git corrupting repositories to lock file
design not being robust when containers / PID namespaces are present.

In my case, the corruption stemmed from premature release of the `git
gc` lock in the gc.pid file. But since the lock file code for that file
is in gc.c, there could be other lock files in Git affected by the same
design limitation as well.

The lock design of gc.pid stores the current hostname and PID of the
locking process in the file. If another process comes along and its
hostname matches the stored hostname, it checks to see if the listed PID
exists. If the PID is missing, it assumes the lock is stale and releases
the lock.

A limitation with this approach is it isn't robust in the presence of
containers / PID namespaces. In containers, it is common for the
hostname to match the container host's hostname. Or the hostname will be
static string. In Kubernetes, all containers within a pod share the same
hostname. Containers (almost always) run in separate PID namespaces, so
PIDs from outside the container aren't visible to the container itself.
This means that if e.g. 2 `git gc` processes are running with the same
hostname in separate containers / PID namespaces, Git could prematurely
release the lock file because it thinks the "other" PID is dead and repo
corruption could ensue due to the 2 `git gc` processes racing with each
other.

The on-disk format of lock files obviously needs to be backwards
compatible with older clients. One backwards compatible solution is to
append something to the hostname to disambiguate containers / PID
namespaces. Mercurial appends the current PID namespace identifier to
the hostname [1] and my experience is that this is sufficient to
mitigate the issue. It is possible more robust solutions are achievable.

Gregory

[1] https://www.mercurial-scm.org/repo/hg/rev/1f151a33af8e

