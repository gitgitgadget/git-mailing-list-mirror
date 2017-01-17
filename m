Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360E020A17
	for <e@80x24.org>; Tue, 17 Jan 2017 05:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdAQFIG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 00:08:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:63184 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdAQFIE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 00:08:04 -0500
Received: from localhost ([81.170.136.231]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LslCb-1cZaIi3UZF-012Kr6 for
 <git@vger.kernel.org>; Tue, 17 Jan 2017 06:07:53 +0100
Date:   Tue, 17 Jan 2017 07:04:28 +0100
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     git@vger.kernel.org
Subject: "git fetch -p" incorrectly deletes branches
Message-ID: <20170117060428.nanqz5lr4hi6dum6@reimardoeffinger.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20161126 (1.7.1)
X-Provags-ID: V03:K0:K5HN+lmQLwtNVdPTXembTGNOubzvppzxziDQGUjg4BZCCsM6rVm
 lzNLXdik7jGUUhSKUyJMBilaYPjbf2dspqNV4siiFOeTComrjM/B/ODevjkqgrD/SJftQeC
 +jYliYs5stBbjNKsuuZK7jYeM6j1VHCvvfgeDA0k7enFnCaMsuh9q6tzJr2EN3b+6JNdgav
 lLe+F3MHT4TJg45UDdAmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YG6ketCo18s=:l36fyvhoMpT0demrjaQuD1
 Y3YvLrdjO/R9oxL4K/hzyi6qDR3Oev1eiloIxRViRBrywrVmKjqADIHwFJx0b3tT+ZqQY22AI
 dk8jRlsEsaG4P9sada5TzbjhKYKrS6548JsBAXHGkk+s5k37zgyt/bKJHtSkwybQmqvPz9ggK
 9IgvDnyiDpL9nJqOJgWr29GntrAwoGLuR9MEW8heMoBrzu9dkRSUGOrCUvGTLb8+RNy6NB8p2
 yGaPn/uOTOPYQwngqALz6E/+ztX6XWUgGYl2FwmQDPDXDNbe971GoLVMm3UUDK2zmyzpOlIIJ
 XOqmlQm7O8+ReIEL413YNiu5cowNZVuk4Eidowz1vLGW7w0n27+D2HnyUeMQNRbSAOG6TmebO
 qXAUgs3sWPMiyq0yEVCSStYqPhW52OBNMMQxzmoApcU6ubdrwbkuYAxIsTyuq9LdVbVNafeVP
 JXcZDMlS5lAf6QRMp303JVDBAelZXE0LIdOHi/YuZS5VPnAPvGwTFy1CBZMaCHIBME3HTiOiI
 m22fhCP+1SBQPMLYdDXN0i3inJrPlJZnbshpXqVsmG5KjhOUyzHZF7+I37miz+4NveTHbFhEH
 k92v70lweD5A9305IhmmsaItXSxQZP+ZjUCHGeN3vxut/DaLiSlpjRStNcOBAn/yoKX540OSS
 SE6ljVVzKzZanUFMc+RZuI7u9zzh+dKyN9uMcJ/Y6vBgMd4Zg4BIYFgPirTmUQnPY5yskmw0t
 qNF9jTRiRxxg1cCX6DA9YlDw6k/BRrYbZA4mNmP2/n++/rQ+WnDhVqzOTQg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!
The command:
git fetch -p -v origin master:refs/heads/test

Deletes refs/heads/test every second time when run repeatedly:

$ git fetch -p -v origin master:refs/heads/test
From https://github.com/git/git
 * [new branch]          master     -> test
 = [up to date]          master     -> origin/master
$ git fetch -p -v origin master:refs/heads/test
From https://github.com/git/git
 - [deleted]             (none)     -> test
 = [up to date]          master     -> test
 = [up to date]          master     -> origin/master

(the command is the result of cutting down the test case,
so yes it is rather silly, but the issue appears in much
less obviously silly cases and causes a lot of confusion)
This is specific to the case of specifying the origin branch
without "full path" AND the right side with.
Wild-guess on cause: "master" is auto-expanded into both
"refs/tags/master" and "refs/heads/master" and instead of
fetching either/merging the result, both are fetched.
Combined with a time-of-check/time-of-use style race condition
on the code that checks if a ref is "up to date" on top of it,
it would result in this behaviour.
Also note that this behaviour appears also when fetch.prune=yes
is set in the config (instead of -p on the command-line),
which makes it much less obvious and there is no option to turn
of prune just for that command to work-around this.
I hope someone has the time to make sure nobody else has to
debug this ever again ;-)

Regards,
Reimar Döffinger
