Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF8D1F576
	for <e@80x24.org>; Wed, 14 Feb 2018 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967140AbeBNKXz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 05:23:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:38779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967123AbeBNKXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 05:23:52 -0500
Received: from [192.168.4.62] ([134.19.74.231]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7DVi-1eYNHP3bks-00x06B; Wed, 14
 Feb 2018 11:23:49 +0100
From:   =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Regression in memory consumption of git fsck
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com
Message-ID: <b1a4d7ed-79b6-1f6b-1f0f-85536e943cef@gmx.de>
Date:   Wed, 14 Feb 2018 11:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LW8NX/x5k9iMDBLGL/qU3xjAZUjvV2KxD2vM3rOuxqm2YwziBdm
 5xojcL4R9n/9KOw3IHZHMmm4h9Ft+9ByAcHxqS1JcCN/vQwZqxB9xcaWUsYGgy2EJFgFe5M
 RPZWaPmWBlYzIIhdPT/Zof2nYVwuh84FKlx0g1xW9lFqoPwbhJBbytys6YfkoyaGo3y6TvM
 alJvAg/tGJ/nkux4hn6iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wAwnvJSwk3M=:JuDofsdgxr6MU1Z7opR52K
 jXBl+5Ru0yjfpktfu8O2BE9RAEwl20NIe7QFx8b9alWei7lIAf1uuHGGASrnq8X2WGZSshGJW
 arjHDvmnv4GPdCoLtQtiqQJRDufMGNmjmLHU694bztRS8FsSMfTwx85P6z7T347DrGZLs2zrg
 fv993Otw1w+6iLgrq4EDJbvFYx3a65lL0JGgBxYr8go4pO6hNFAOcs1ayZ6vBRerf6LqZ7b8h
 nbfQli462WQVa5OdtjoMDjsukKj2MtDSlFuWFZUeN2NtdilSYbsK2B0I5qEbsmpemYQpNlpg1
 9jtDqRSnwlixkQeZ11aqIJk2OLul7W88YoGt2b9yyMcb4mdUQo8c1K5ujayK1wb8YjEs2ymdp
 8WvUCdgBDHlKbRX2loaWRTDLijubrzPuVBn6vcln4snpY5QYWECqNAdnj4NaTjhGOeScpGjne
 M9WOEf/ohwOoOvvkVzj/Xx5LdEUx27maQWDBoNXDGWs+YFdAYOFJH22vFyxBOzFK9Lieg9GNg
 MsJNjslNZpIdf2K/0Kvrh3C/wBJrqagBddHM6/br3mNtPww83CBQyCgQbEFYtqEPFvyvYBsrS
 fkbMnOTuDO7Q8/YLBaZ+rAClls44qv9T1PrPcmpbXqQ23wnollC72Cp15t5sbURj0ZuKp8MQN
 r47LyRfiLOSOb17vWEhMnn6Y/9laqYz1GMP92Wlyg50U6x0aBoaoad1vepyn+9NRdDUQ+L3Y/
 lX8DDdxadQNR5Xl9JW1ImE3PyUAiG0VnzOHoJqQmvvUaAVFcR2EefFAGSBj8whbeYCjG3bO9r
 Sn0jnuXt7VERzJQOLBtEsWSuWtBemhvofYa/fqejBxE8O67xR8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've noticed that recent versions of git consume a lot of memory during
"git fsck", to the point where I've regularly had git fall victim to
Linux's OOM killer.

For example, if I clone torvalds/linux.git, and then run "git fsck
--connectivity-only" in the newly cloned repository, git will consume
more than 6GB of physical memory, while older versions peak at about 2GB.

I've managed to bisect this down to this commit in v2.14:

ad2db4030e42890e569de529e3cd61a8d03de497
fsck: remove redundant parse_tree() invocation

If I revert that commit (on top of current master) the memory
consumption goes down to 2GB again. The change looks relatively harmless
to me, so does anyone know what's going on here?


Thanks,

Dominic
