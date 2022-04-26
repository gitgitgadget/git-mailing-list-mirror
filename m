Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B55C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 06:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbiDZGl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiDZGlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 02:41:55 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F7B1ADBC
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 23:38:45 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,290,1643670000"; 
   d="scan'208";a="33281382"
Received: from 209.56.68.91.rev.sfr.net (HELO [192.168.1.28]) ([91.68.56.209])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 08:38:44 +0200
Message-ID: <243b40ef-a720-46aa-6657-87ac8d3c3bdc@univ-lyon1.fr>
Date:   Tue, 26 Apr 2022 08:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge
 conflicts
Content-Language: en-US
To:     Guillaume Cogoni <cogoni.guillaume@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan <git.jonathan.bressat@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>
References: <xmqqfsmg97ac.fsf@gitster.g>
 <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
 <xmqqczh4vp6e.fsf@gitster.g>
 <fdd9f13d14e942f3a1572866761b9580@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <fdd9f13d14e942f3a1572866761b9580@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/22 00:28, Guillaume Cogoni wrote:
>   Junio C Hamano <gitster@pobox.com> writes:
> 
>> So, I am not sure if this is really a good idea to begin with.  It
>> certainly would make it slightly simpler in a trivial case, but it
>> surely looks like a dangerous behaviour change, especially if it is
>> done unconditionally.
> 
> Can we create a configuration variable to avoid this problem?
> We keep the old behavior by default, and make a configuration variable
> for people who wants to have this new behavior, but if the user set the variable
> a message informs it about the problem that you mention.
> 
> Or, we add an option like git pull --doSomething.
> 
> Maybe, we can think about another behaviour.
> When the user git pull and this error occurs:
> error: The following untracked working tree files would be overwritten by merge:
> file1.txt
> file2.txt
> Please move or remove them before you merge.
> Aborting
> We don't abort, but we prompt a yes/no for each file, if the user
> wants to remove it.

Git very rarely goes interactive like this (only a few special command 
like git send-email, git clean -i, git add -i/-p prompt the user).

Prompting the user in the middle of an operation has several drawbacks:

- When the command is launched from a script, the script may work most 
of the time, and sometimes pause on an interactive prompt which wasn't 
expected from the author of the script. This can be a bit nasty when the 
script isn't ran from a place where you can type to the standard input 
of the command or when its output is redirected.

- Asking for each individual file can be tedious when there are many 
files. Similarly, "rm -i" (plain rm, not "git rm") is a nice safety 
measure, but not really convenient to me at least.

In this particular case, actually, I can't imagine a sane behavior when 
the user wants a mix of "yes" / "no". If a single untracked file 
conflicts with what's being merged, the merge aborts, even if you're OK 
to replace other files. So I can only imagine a single yes/no answer. 
And then the question can be replaced with a suggestion to re-run with a 
command-line flag when all the conflicting files are unmodified.

-- 
Matthieu Moy
https://matthieu-moy.fr/
