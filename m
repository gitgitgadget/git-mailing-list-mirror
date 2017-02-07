Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB7A1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdBGL4F convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 7 Feb 2017 06:56:05 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:51573 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdBGL4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:56:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 338371E2CF8
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 12:56:01 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6ZwVnwSK64zP for <git@vger.kernel.org>;
        Tue,  7 Feb 2017 12:56:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id B5B211E2D92
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 12:56:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZcDk54bA3Vci for <git@vger.kernel.org>;
        Tue,  7 Feb 2017 12:56:00 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 89CD01E2C35
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 12:56:00 +0100 (CET)
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [RFC] mailmap.blob overrides default .mailmap
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
Date:   Tue, 7 Feb 2017 12:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

 I was reading into the mailmap handling today and I'm a bit puzzled by the overriding behavior.

This is what the documentation says about precedence (emphasis mine):
-------------
mailmap.file
    The location of an augmenting mailmap file. The default mailmap, located
    in the root of the repository, is loaded first, then the mailmap file
    pointed to by this variable. The location of the mailmap file may be in a
    repository subdirectory, or somewhere outside of the repository itself.
    See git-shortlog(1) and git-blame(1).

mailmap.blob
    Like mailmap.file, but consider the value as a reference to a blob in the
    repository. If both mailmap.file and mailmap.blob are given, both are
!!! parsed, with _entries from mailmap.file taking precedence_. In a bare
    repository, this defaults to HEAD:.mailmap. In a non-bare repository, it
    defaults to empty.
------------

So from the doc I would have expected that files always get precedence over the blob. IOW entries from .mailmap override entries from mailmap.blob. However, this is not the case.

The code shows why (mailmap.c):
	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
	if (startup_info->have_repository)
		err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);


Apparently this is not an oversight, because there is an explicit test for this overriding behavior (t4203 'mailmap.blob overrides .mailmap').

So I wonder: what is the rationale behind this? I find this mixed overriding behavior hard to explain and difficult to understand.

