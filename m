Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26DC1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDCTA3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:00:29 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:55904 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752132AbeDCTA1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Apr 2018 15:00:27 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2018 15:00:27 EDT
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id B6F9E4445305
        for <git@vger.kernel.org>; Tue,  3 Apr 2018 21:53:10 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ur4LV98O9Y-rAoukNJs;
        Tue, 03 Apr 2018 21:53:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1522781590;
        bh=9wiiARBTQq8GvCLP5wzaOtRwJipmFcDobZX494T9290=;
        h=From:To:Subject:Message-Id:Date;
        b=lFq4Byq+Y7qCmLo319fPxkIIJvq9mQRbE88uOw1qmReZcwCdD6TqX2y6N1fmqnRXH
         PZ+4kxKtiYV25Uofgjlts7mO0RlEeNVuAm/ruh1MxtyZtzU1pbE3qE1OCjA2piEXyu
         RP1Z4f35/pRi6zE1QDcvTzX4v1S2Hm0X/vg88mh0=
Authentication-Results: mxback14g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by web3o.yandex.ru with HTTP;
        Tue, 03 Apr 2018 21:53:10 +0300
From:   Alex Ivanov <gnidorah@ya.ru>
Envelope-From: gnidorah@yandex.ru
To:     git@vger.kernel.org
Subject: Socket activation for GitWeb FastCGI with systemd?
MIME-Version: 1.0
Message-Id: <671541522781590@web3o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 03 Apr 2018 21:53:10 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
I want to use systemd as fastcgi spawner for gitweb + nginx. 
The traffic is low and number of users is limited + traversal bots. For that reason I've decided to use following mimimal services

gitweb.socket
[Unit]
Description=GitWeb Socket

[Socket]
ListenStream=/run/gitweb.sock
Accept=false

[Install]
WantedBy=sockets.target

gitweb.service
[Unit]
Description=GitWeb Service

[Service]
Type=simple
ExecStart=/path/to/gitweb.cgi --fcgi
StandardInput=socket

However this scheme is not resistant to simple DDOS.
E.g. traversal bots often kill the service by opening non existing path (e.g http://host/?p=repo;a=blob;f=nonexisting/path;hb=HEAD showing in browser 404 - Cannot find file) many times consecutively, which leads to
Apr 03 21:32:10 host systemd[1]: gitweb.service: Start request repeated too quickly.
Apr 03 21:32:10 host systemd[1]: gitweb.service: Failed with result 'start-limit-hit'.
Apr 03 21:32:10 host systemd[1]: Failed to start GitWeb service.
and 502 Bad Gateway in browser. I believe the reason is that gitweb.service dies on failure and if it happens too often, systemd declines to restart the service due to start limit hit.
So my question is how to correct systemd services for GitWeb to be resistant to such issue? I prefer to use single process to process all clients.
Thanks.
