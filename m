Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54E11F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 10:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeCSKWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 06:22:00 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:14963 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbeCSKV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 06:21:59 -0400
Received: from [192.168.2.201] ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id xrvQe7fohlWlTxrvRe6Yr9; Mon, 19 Mar 2018 10:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521454918;
        bh=FzIIl815g8+41cybupXDYQpIPg5mlK7x7WszIwUu5Xk=;
        h=Reply-To:From:Subject:To:Date;
        b=n5kc5XEiATlK8ENzoKnKZ+z6LPPIQN5JhRuJ/H1Vxa60T5rUPwJIv8+oSppnzJipz
         4+2Nw6QNncutmez56vjWcAS/iXNjulxe55SIrm0FBCLleHGI7JNGZJq3sVBwkmcMqV
         /KQ+mmjNMb6B2BN8z48T+KEYpuNQV5psRjKpSKkU=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=5_Fvg_zHC6LVKqpH9eEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
From:   Phillip Wood <phillip.wood@talktalk.net>
Subject: [BUG] log --graph corrupts patch
To:     Git Mailing List <git@vger.kernel.org>
Message-ID: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
Date:   Mon, 19 Mar 2018 10:21:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFUqd424gBSWX17H+ixA3d9QWyFWZjlUZPxdvlV2PAJQXSe/ydibbvxHgJMRZ52ih7CNJ2FMn3OG+wqaBQfTj4S+brUlMcVEriDg095WHWaZpESETYF3
 qyToEN2jQuTB82DTQYk4SMb973ERN1LK3ba1ajxP5jOdL3uIEbFHSBYzkWag4sjCy5T6bRjjKyk9xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just been reviewing some patches with 'git log --graph --patch' and
came across what looked like a bug:

| @@ -272,6 +272,9 @@ do
|       --keep-empty)
|               keep_empty=yes
|               ;;
|       --allow-empty-message)
| +     --no-keep-empty)
| +             keep_empty=
| +             ;;
|               allow_empty_message=--allow-empty-message
|               ;;

However when I looked at the file it was fine, "--allow-empty-message)"
was actually below the insertions. 'git log --patch' gives the correct
patch:

@@ -272,6 +272,9 @@ do
        --keep-empty)
                keep_empty=yes
                ;;
+       --no-keep-empty)
+               keep_empty=
+               ;;
        --allow-empty-message)
                allow_empty_message=--allow-empty-message
                ;;

for some reason adding --graph causes the patch to get corrupted. I've
tried all combinations of --[no-]-indent-heuristic and
--diff-algorithm={patience|minimal|histogram|myers} and they all give
the same result. I've no idea what is going on, it happens with 2.16.2
and recent next and master. I've pushed the commit to github so anyone
who is interested can get it with

git fetch https://github.com/phillipwood/git.git log-graph-breaks-patch

Best Wishes

Phillip
