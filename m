Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845CD1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeD2Qmv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 12:42:51 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeD2Qmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 12:42:50 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue005
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M8M5O-1eQky10W1K-00vy84; Sun, 29
 Apr 2018 18:42:43 +0200
Date:   Sun, 29 Apr 2018 18:42:39 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 0/1] completion: dynamic completion loading
Message-ID: <20180429164232.29337-1-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:JacmL3L5vQVAe374T5tBMT0Vyn2VCG0JGLYpYGqwR8KeNOL7aU6
 ZkN2RGFdHXxW7sNeyAkdDanhlDFVklEEV3SuQ7hiCVX/5wEZOnPQunacLvrXBC539SbGHF/
 w3PYz8wOVSMpbZ/21H9AkU53Of5a9XBJluqHo8tNDc8OLxC3fvuznnFaEr88oCflArVL5eE
 HQIRRpnem0r8U8+iDmkxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/t+pjCfEMwc=:WZJcmqpP1eGoPu54F12eoe
 0shZylrfDK2hChX2QtrG/VKEHVSA/4Wgh0PT9gxNW3ypT4hNltE8O7Y+e/t4GTy9IAckHmHab
 qxr+4nr/uMmWcM5US72IHqOC6BcvnAuamuI5f4dypq7SJrxYzZtc701YFz2JMNwIy7NXzVZc+
 2T4p3+so3MltRwnSelVbCI3PXZuelGXkjpj45G1p0htRs/1HoiGKPVspQyh+mvC/IwPL1q3ee
 s+9hxX3ILhpSFuoQ1XwX94Ca50KpiaaJ+vl49XrVXIbmiD7cGR8JIUK9uFjwXUa5ppuCnDaaN
 9mwofQ+X5rYplheGazzfVJvYPbgagEYu7DCLni250NJNJgt7XuWGa7YsYIEdqFFq3qBabEtte
 vrNSHErfHKSJznWi+RNnczx6pqlBKgnVcLzZaksH0l2Klnd0V2MtFbHRXufzYs2sEEncilGGS
 sNcrGzNMivMHa/+Ewd1rDq2vsZqHPUJTGB/ZpELMB1zm6/fEfefmaIVDsEiCqLeYxhzhua+o0
 3nygBJQpT/K39gcklD718yfJoVdn0+xn/Os6VMog9+Z5UhrMUjqVWxD9Wpu6dGDqIn+plkEZp
 0n36dhupG1Gwo6dRRi9MReu88yb5BCnvChQlDVJ2wP1ma7fkIROvLD0rMzkHfQv37naGvsyOr
 2EXz3UKuSnZ0w7Orqrxmr1rgiytbTckxSa/Zy0tK1zCE9iZBGZG7BbkrnmfMtzVFNmyw=
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

Changes since v2:

-   Replaced __load_completion with _completion_loader, which was introduced 
    way before the former and should therefor be available even in older 
    distributions

-   Updated commit message with explanations from Szeder Gábor

Changes since v1 (RFC):

-   Re-arranged if-fi statement to increase readability (suggested by Junio C 
    Hamano)

-   Re-worded commit message to include the exakt version of bashcomp that 
    introduced dynamic loading (suggested by Stefan Beller)

Florian Gamböck (1):
  completion: load completion file for external subcommand

 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.16.1

