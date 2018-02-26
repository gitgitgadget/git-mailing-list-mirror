Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 282121F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBZLAF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:00:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbeBZLAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:00:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 499FDABB2;
        Mon, 26 Feb 2018 11:00:00 +0000 (UTC)
Subject: Re: [PATCH] Call timegm and timelocal with 4-digit year
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Ryuichi Kokubo <ryu1kkb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180223172045.32090-1-bwiedemann@suse.de>
 <87tvu6dntx.fsf@evledraar.gmail.com>
From:   "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Message-ID: <81704602-1c81-f46c-f306-968147327e74@suse.de>
Date:   Mon, 26 Feb 2018 11:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87tvu6dntx.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-02-24 23:28, Ævar Arnfjörð Bjarmason wrote:
> My Time::Local 1.2300 on perl 5.024001 currently interprets "69" here as
> 1969, but after this it'll be 2069.

on one hand, there is already
perl -e 'use Time::Local;
  print scalar gmtime(Time::Local::timegm(0,0,0,1,0,68))'
Sun Jan  1 00:00:00 2068

The problem here is the 'currently', because in 11 months from now, 69
will be interpreted as 2069 by Time::Local, too.

faketime 2019-01-01 perl -e 'use Time::Local;
   print scalar gmtime(Time::Local::timegm(0,0,0,1,0,69))'
Tue Jan  1 00:00:00 2069


We could compromize for
$y+=100 if $y<69;

to freeze the behaviour to what Time::Local does in 2018, but then there
might not be actual repos with such 2-digit year timestamps.

There are definitely CVS repos from before 1999 and without this change,
those might be misinterpreted in 2049 (or before, depending on age)
