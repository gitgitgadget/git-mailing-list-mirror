Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E9C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53E56134F
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhDQXqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 19:46:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57823 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhDQXqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 19:46:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF5181202AA;
        Sat, 17 Apr 2021 19:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        gJ9phjbWtO11hr5dH4ilOZryzg=; b=ggEv5nCzzZOUWGsTEmWzIKJgHaW95NVS0
        scRVIyvkva9LjuPiXJ7Rn/oUBhZBcq9B0nFTklujg6dAzzWray1QdUkJkyf0gRLN
        2mCJykvNehrKZropokPsjugYnFwB6tlEujKlo8Q1k+W6iQATl2GF66MpzKBOAIwO
        Ld9gVbWh3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Kx3
        hri6qUsartCecy5/o8Ph6HTFEyXCnqYfhJZmImnvOLkSRXTPzIzr/nT9g/8VBHIL
        aPOnxKs4gjWOqdmT41Bv0U3kl33MIygfj3GoUlSobXkU0E1wbkxPV29iwWHz1KU/
        cjTC5jskbOgCo7E1bffio8rzEcUIBSfseuCVsS6c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D92CE1202A9;
        Sat, 17 Apr 2021 19:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 075C31202A6;
        Sat, 17 Apr 2021 19:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [BUG?] 'git describe seen'?
Date:   Sat, 17 Apr 2021 16:45:59 -0700
Message-ID: <xmqq1rb8bhl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 113597EA-9FD7-11EB-9C3B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not seem a new problem at all, as v2.10.0 thru more recent
versions of "git describe" seem to give me the same answer.

Anyway, I am seeing a curious symptom.

$ git rev-list --count v2.31.0..seen
716
$ git rev-list --count v2.31.1..seen
687

The above means that 'seen' is closer to v2.31.1 than v2.31.0; there
are fewer commits that are not in v2.31.1 that are in 'seen', than
commits that are not in v2.31.0 that are in 'seen'.  

That is naturally expected.

$ git rev-list --count v2.31.0..v2.31.1
29

And that difference of 29 matches the difference, which is 716 - 687.

But here is what is puzzling.

$ git describe seen
v2.31.0-716-g7b65b53281

$ git rev-list --first-parent master..seen |
  while read v
  do
	d=$(git describe $v)
	echo $v $d
	case "$d" in v2.31.1-*) break ;; esac
  done
7b65b53281ae06ee25dd47dead4062125eb54427 v2.31.0-716-g7b65b53281
eec14f0fec886c909a29d63a94537df5a62be618 v2.31.0-714-geec14f0fec
...
103835562c64abef2319995716230f92092f87af v2.31.0-569-g103835562c
d4324831d9152b16e091646e22a6e03423a59c93 v2.31.1-516-gd4324831d9

Is there something tricky about the topic merged at 10383556 (Merge
branch 'jh/rfc-builtin-fsmonitor' into seen, 2021-04-17) to confuse
the counting done in "git describe"?

$ git log --first-parent --oneline master..103835562^2
14d50074ff t7527: test status with untracked-cache and fsmonitor--daemon
07dbff70ce p7519: add fsmonitor--daemon
436807f77a t7527: create test for fsmonitor--daemon
c826602412 fsmonitor: force update index when fsmonitor token advances
aaaf17ce60 fsmonitor--daemon: use a cookie file to sync with file system
71a0e07d79 fsmonitor--daemon:: introduce client delay for testing
9aedb0f1ea fsmonitor--daemon: periodically truncate list of modified files
d4ae16b416 fsmonitor--daemon: implement handle_client callback
94f826fd48 fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
25663103ea fsmonitor-fs-listen-macos: add macos header files for FSEvent
e504205db7 fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
5e207d2af6 fsmonitor--daemon: create token-based changed path cache
42f493472f fsmonitor--daemon: define token-ids
082b8085d3 fsmonitor--daemon: add pathname classification
d4f4c59e56 fsmonitor--daemon: implement daemon command options
aec39650b5 fsmonitor-fs-listen-macos: stub in backend for MacOS
100cb9e8ad fsmonitor-fs-listen-win32: stub in backend for Windows
404d7dbdb6 fsmonitor--daemon: implement client command options
1f2d717bd6 fsmonitor--daemon: add a built-in fsmonitor daemon
4b10913cfe fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
867611645c config: FSMonitor is repository-specific
6e74370ce4 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
ff338b5790 Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
