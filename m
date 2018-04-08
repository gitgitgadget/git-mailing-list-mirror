Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5374C1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 18:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDHS0L (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 14:26:11 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeDHS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 14:26:10 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LzWX0-1eRB220QZG-014lRD; Sun, 08
 Apr 2018 20:26:08 +0200
Date:   Sun, 8 Apr 2018 20:26:07 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 0/1] completion: Dynamic completion loading
Message-ID: <20180408182552.26289-1-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:o5pXe159JtULGPR/ku/Cmuoi93nhYJ/KPPmVwMgen9ebu2SpDqF
 hxmZ5iUaKc9jQ0Or2Twt6uFLGSx+xsE4WdJtb0k3wa3PgEXtvRKHPCyw7CtdC0J1W+LmMx2
 Uo+tpeWi5cJDc1o6k9AwMt/C/vInZQn09qWKaqgdgBuUlH91yBWVr+Gya4khoILFSL0zEn2
 guWm3z+Dnmtg2ouVOLfDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zEOn3Kcr1RQ=:omAYWxw2fv/EFCniooQrl8
 TtNU3jHA3VA5OF3BopnWEfD3OJ3e5qpk9sqtfkS3+VyJFQOtHj95QAvHFEM1oa34FvwPMXq2M
 sJiC1M7lHmg6q8oEpKfd26JrP6Y86ZsqA/dInf6u//oMrpfSuRaon2iUGuOTLfovVEfmzXORU
 BP0BFjdj16tQs/7Bh9U+ny4/HGsUlXYu7HwMgNopsCWuUXSplpOxrx07phajnn+wpr6acTcr/
 ZkEQhfqXVKbUE8/PjlaLGNVT/HyR4UFMO77y0EeOzxcufUD8I87LsfCjcfRI/bHx3ReM5NGSZ
 MqfSxWXqfgteNIKlN1DdPTnlC6H4oQiIFgZSi5aYhKR+5NzCs+WaEObf4qqvV/EZnKqWoB96M
 T92JAx0kNuWmsipXvkakD+hyXgS4wVyZjb6DkZahTspp5xu4wYgsafJWX3FLNWPETAQm3DYVl
 Y+LVsKt/h/cT+NafzYDQGBt9Yk052akpnNNRib3JmBfi1JXTPMCeXwhIv5rS8yeQJwEyoa0tm
 Sl3WHmuQ41u9ab4Foh8XpYE+0TBghW5jcvgbzi8qHKCegS3jK78vqUpg06h+bMptnnSP8Ir8z
 nhgDYn5ex+e0rr8jCqkxIb3ZRtqyvwof0TfPaU/l+PcZIsl0PZMg5gI1VoymDjG+IIhNkA5Xz
 jo4x+VpmdFS/CHqsMMvM/DPooPdQeU3TuGNYacwnNyv3S8o1YW0mcOqIPHuQThuufCYhO4oVg
 eC19jGc+sEJTUFgXBB+iMUhRkwUw4Zl2KO+Kfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this small patch I want to introduce a way to dynamically load completion 
scripts for external subcommands.

A few years ago, you would put a completion script (which defines a Bash 
function _git_foo for a custom git subcommand foo) into 
/etc/bash_completion.d, or save it somewhere in your $HOME and source it 
manually in your .bashrc.

Starting with bash-completion v2.0 (or, to be absolutely exact, the preview 
versions started at v1.90), completion scripts are not sourced at bash startup 
anymore. Rather, when typing in a command and trigger completion by pressing 
the TAB key, the new bash-completion's main script looks for a script with the 
same name as the typed command in the completion directory, sources it, and 
provides the completions defined in this script.

However, that only works for top level commands. After a completion script has 
been found, the logic is delegated to this script. This means, that the 
completion of subcommands must be handled by the corresponding completion 
script.

As it is now, git is perfectly able to call custom completion functions, iff 
they are already defined when calling the git completion. With my patch, git 
uses an already defined loader function of bash-completion (or continues 
silently if this function is not found), loads an external completion script, 
and provides its completions.

An example for an external completion script would be 
/usr/share/bash-completion/completions/git-foo for a git subcommand foo.

Florian Gamböck (1):
  completion: Load completion file for external subcommand

 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.16.1

