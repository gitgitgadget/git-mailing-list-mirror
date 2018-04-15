Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8EB1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDOUV0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:21:26 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:10160 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbeDOUVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:21:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GaAwDzs9Na/wsxuIZchBc9eiiMR44nF?=
 =?us-ascii?q?HuQR4IhgUA7CyUGgQKDVgKCTzQYAQIBAQEBAQECAgJoHAyCZARLLC4BAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBGgINIjwBBTo/EAsYCSUPBSghhSAPpnOIO4IviVo/hBqDEQICg?=
 =?us-ascii?q?UiDRoIkAocnhXuKQgiFWYhXgT47hUoxhGKBFIFmhjKDfAGCdoElHDmBUk0gGIJ?=
 =?us-ascii?q?+CQqFaYZRhAM9MI5iAQE?=
X-IPAS-Result: =?us-ascii?q?A2GaAwDzs9Na/wsxuIZchBc9eiiMR44nFHuQR4IhgUA7CyU?=
 =?us-ascii?q?GgQKDVgKCTzQYAQIBAQEBAQECAgJoHAyCZARLLC4BAQEBAQEBAQEBAQEBAQEBG?=
 =?us-ascii?q?gINIjwBBTo/EAsYCSUPBSghhSAPpnOIO4IviVo/hBqDEQICgUiDRoIkAocnhXu?=
 =?us-ascii?q?KQgiFWYhXgT47hUoxhGKBFIFmhjKDfAGCdoElHDmBUk0gGIJ+CQqFaYZRhAM9M?=
 =?us-ascii?q?I5iAQE?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 15 Apr 2018 22:21:22 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1f7o9K-0001Th-BT; Sun, 15 Apr 2018 22:21:22 +0200
Date:   Sun, 15 Apr 2018 22:21:22 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Oleg Gubanov <oleg.gubanov@gmail.com>
Subject: Re: [PATCH 2/2] daemon: graceful shutdown of client connection
Message-ID: <20180415202122.GA4657@infogroep.be>
References: <20180412210757.7792-1-kgybels@infogroep.be>
 <20180412210757.7792-3-kgybels@infogroep.be>
 <nycvar.QRO.7.76.6.1804131440100.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804131440100.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (13/04/18 15:03), Johannes Schindelin wrote:
> I wonder whether you found a reliable way to trigger this? It would be
> nice to have a regression test for this.

On my system, it reproduced reliably using Oleg's example [1], below is my bash
version of it.

Script to generate repository with some history:

  $ cat example.sh
  #!/bin/bash
  
  git init example
  cd example
  
  git --help > foo.txt
  
  for i in $(seq 1 12); do
      cat foo.txt foo.txt > bar.txt
      mv bar.txt foo.txt
      git add foo.txt
      git commit -m v$i
  done
  
  $ ./example.sh
  Initialized empty Git repository in C:/git/bug/example/.git/
  [master (root-commit) 2e44b4a] v1
   1 file changed, 84 insertions(+)
   create mode 100644 foo.txt
  [master 9791332] v2
   1 file changed, 84 insertions(+)
  [master 524e672] v3
   1 file changed, 168 insertions(+)
  [master afec6ef] v4
   1 file changed, 336 insertions(+)
  [master 1bcd9cc] v5
   1 file changed, 672 insertions(+)
  [master 2f38a8e] v6
   1 file changed, 1344 insertions(+)
  [master 33382fe] v7
   1 file changed, 2688 insertions(+)
  [master 6c2cbd6] v8
   1 file changed, 5376 insertions(+)
  [master 8d0770f] v9
   1 file changed, 10752 insertions(+)
  [master 517d650] v10
   1 file changed, 21504 insertions(+)
  [master 9e12406] v11
   1 file changed, 43008 insertions(+)
  [master 4c4f600] v12
   1 file changed, 86016 insertions(+)

Server side:

  $ git daemon --verbose --reuseaddr --base-path=$(pwd) --export-all
  [4760] Ready to rumble
  [696] Connection from 127.0.0.1:2054
  [696] unable to set SO_KEEPALIVE on socket: No such file or directory
  [696] Extended attribute "host": 127.0.0.1
  [696] Request upload-pack for '/example'

Client side:

  $ git clone git://127.0.0.1/example
  Cloning into 'example'...
  remote: Counting objects: 36, done.
  remote: Compressing objects: 100% (24/24), done.
  fatal: read error: Invalid argument
  fatal: early EOF
  fatal: index-pack failed

System information:

  $ git --version --build-options
  git version 2.17.0.windows.1
  cpu: x86_64
  built from commit: e7621d891d081acff6acd1f0ba6ae0adce06dd09
  sizeof-long: 4
  
  $ cmd.exe /c ver
  
  Microsoft Windows [Version 10.0.16299.371]

Best regards,
Kim

[1] https://github.com/git-for-windows/git/issues/304#issuecomment-274266897
