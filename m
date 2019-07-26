Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63C81F462
	for <e@80x24.org>; Fri, 26 Jul 2019 02:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZCZH (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 22:25:07 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:40752
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 22:25:07 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hqpuq-000umY-W1
        for git@vger.kernel.org; Fri, 26 Jul 2019 04:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Gregory Szorc <gregory.szorc@gmail.com>
Subject: Warnings in gc.log can prevent gc --auto from running
Date:   Thu, 25 Jul 2019 19:18:57 -0700
Message-ID: <qhdnuh$5m5r$1@blaine.gmane.org>
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

I think I've found some undesirable behavior with regards to the
behavior of `git gc --auto`. The tl;dr is that a warning message written
to gc.log can result in `git gc --auto` effectively disabling itself for
gc.logExpiry. The problem is easier to trigger in 2.22 as a result of
enabling bitmap indices for bare repositories by default and the
behavior can easily result in performance degradation, especially on
servers.

`git gc --auto` will stop itself from running if a gc.log file newer
than gc.logExpiry (1 day by default) exists. The intention of this
behavior seems reasonable enough. However, it is relatively easy for a
relatively harmless gc.log file to exist and for that relatively
harmless gc.log file to effectively disable `git gc --auto`.

For example, if bitmap indices are being produced (this is the default
behavior for bare repositories in Git 2.22) and the user has taken any
action that would result in a `git gc` producing multiple packfiles
(setting gc.bigPackThreshold, setting pack.packSizeLimit, annotating a
packfile with a .keep file, etc) then a message like "warning: disabling
bitmap writing, as some objects are not being packed" or "warning:
disabling bitmap writing, packs are split due to pack.packSizeLimit" may
be written to gc.log. This warning message will result in the presence
of a gc.log file, which will cause `git gc --auto` to stop doing
meaningful work until gc.logExpiry has passed or the gc.log is cleaned
up out-of-band.

The practical impact of this behavior is that an environment having only
made minor tweaks to tweak packfile behavior may end up inadvertently
disabling `git gc --auto` and having excessive amounts of packfiles and
loose object files accumulate since `git gc --auto` isn't running. This
can result in performance degradation, especially for repositories
receiving hundreds or thousands of pushes a day - ask me how I know :)

I was able to work around this in a server environment by removing
gc.log if the contents were "harmless" warning messages, unblocking `git
gc --auto`. However, the solution is a bit brittle. As an end-user of
Git, I would prefer a `git gc --auto` execution mode that was less
sensitive to the presence of non-fatal messages in gc.log. Lowering the
value of gc.logExpiry is also a somewhat reasonable solution. I /think/
you could even make the value "now" to effectively disable the gc.log
check, but I haven't tested this. I don't feel great about that
workaround though, as if there is an actual gc/repack error, I'd like to
know about it instead of sweeping it under the rug by continuously
deleting the gc.log file. I'm also not keen on triggering `git gc --auto
--force` because --force will ignore lock files and I like respecting
lock files.

I don't prescribe to know the best way to solve this problem. I just
know it is a footgun sitting in the default Git configuration. And the
footgun became a lot easier to fire with the introduction of warning
messages related to bitmap indices and again when bitmap indices were
enabled by default for bare repositories in Git 2.22.

Gregory Szorc
gregory.szorc@gmail.com

