Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E736C20374
	for <e@80x24.org>; Mon, 15 Apr 2019 22:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfDOWeQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 15 Apr 2019 18:34:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20759 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOWeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:34:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x3FMY9vL079218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Apr 2019 18:34:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "Bill Honaker" <bhonaker@xid.com>
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>     <874l71fxmg.fsf@evledraar.gmail.com>    <20190413214736.GD15936@szeder.dev>     <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com> <87ef63ezt9.fsf@igel.home>
In-Reply-To: <87ef63ezt9.fsf@igel.home>
Subject: RE: [BUG] GIT_SSH_COMMAND is not being decomposed
Date:   Mon, 15 Apr 2019 18:34:02 -0400
Message-ID: <008101d4f3db$56c20410$04460c30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGpuMnQep3MvtsjO/08o+Xas343GAFQ9z8cANXpddoBVDFx7wLm7MIxpmEy9kA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 15, 2019 17:14, Andreas Schwab wrote:
> On Apr 15 2019, "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> 
> > on virtually any platform at my disposal (Windows, Ubuntu, MacOS, the
> > older NonStop variant), and have that work with no problem. Somewhere
> > after get_ssh_command(), the command is being interpreted it its parts
> > either as a shell or something else (still trying to find that).
> 
> See run-command.c:prepare_shell_cmd, if the command contains shell meta
> characters it is passed to sh -c without further quoting.
> 
> Andreas.

Well crap. That explains far too much about what is happening. 😊. One of the special parameters is specified as -S \$ZSSH2 (example, referring to the process name - which begin with $ and have to be escaped with \). This obviously triggers the alternate path and has been problematic. On the older systems, we found fewer (a.k.a just about none) uses of this parameter, so never encountered it. On the newer systems, virtually everyone is using -S. Ergo, behavioural differences. That explains a whole lot of why we need a wrapper script. Thanks for the pointer to the strcspn() reference. I can stop obsessing about this (thanks too Johannes, Szeder, Ævar) for the help.

As a suggestion, with people who know how to escape stuff properly (or not), perhaps we can select the alternate behaviour explicitly using a core.sshIgnoreEscape=true/false option. Thoughts on that?

Regards,
Randall

