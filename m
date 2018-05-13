Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4651F406
	for <e@80x24.org>; Sun, 13 May 2018 16:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeEMQwd (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 12:52:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60510
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751904AbeEMQwd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 May 2018 12:52:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,396,1520895600"; 
   d="scan'208";a="265048461"
Received: from zcs-store5.inria.fr ([128.93.142.32])
  by mail3-relais-sop.national.inria.fr with ESMTP; 13 May 2018 18:52:31 +0200
Date:   Sun, 13 May 2018 18:52:31 +0200 (CEST)
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Dannier Castro L <danniercl@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, jrnieder@gmail.com,
        bmwill@google.com
Message-ID: <191675463.13930902.1526230351223.JavaMail.zimbra@inria.fr>
In-Reply-To: <9e3a36eea5d34dc2941560b96046dc27@BPMBX2013-01.univ-lyon1.fr>
References: <9e3a36eea5d34dc2941560b96046dc27@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.192.142.118]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF59 (Linux)/8.7.11_GA_1854)
Thread-Topic: checkout.c: add strict usage of -- before file_path
Thread-Index: AQHT6mF66QnV7qFF9kOeXQeZNcpBGRT97bS9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dannier Castro L" <danniercl@gmail.com> wrote:

> Currently, <checkout> is a complex command able to handle both
> branches and files without any distintion other than their names,
> taking into account that depending on the type (branch or file),
> the functionality is completely different, the easier example:
> 
> $ git checkout <branch>  # Switch from current branch to <branch>.
> $ git checkout <file>    # Restore <file> from HEAD, discarding
>                         # changes if it's necessary.
> $ git checkout -- <file> # The same as the last one, only with an
>                         # useless '--'.

It's not really "useless".

In the first two commands you give, git guesses whether the first
argument is a branch or a file. In the 3rd, the -- indicates that it
must be a file.

> For GIT new users,

Nit: we write Git (for the system) or git (for the command-line tool),
but usually avoid the all-caps GIT.

> The solution consists in detect '--' into command args, allowing
> the discard of changes and considering the following names as
> file paths, otherwise, they are branch names.

This answers the "what?" question, but does not explain why this is a
good change. A good commit message should focus more on the "why?"
question.

While I agree that "git checkout" is a complex command, and would love
to see a simpler syntax at least for the most common operations, I do
not think that this is a good change for several reasons:

* If one considers that this "--" syntax is an issue, then this patch
  is a very partial solution only. Many other commands use the same
  convention (for example "git log <commit>" Vs "git log -- <file>"),
  so changing only one makes git less consistent. Also, note that this
  "--" convention is not git-specific. Try "touch --help" and "touch
  -- --help" for example.

* This breaks backward compatibility. People used to "git checkout
  <file>" won't be able to use it anymore. Scripts using it will
  break. Git avoids breaking backward compatibility, and when there's
  a good reason to do so we need a good transition plan. In this case,
  one possible plan would be to 1) issue a warning whenever "git
  checkout <file>" is used for a while, and then 2) actually forbid
  it. But following this path, I don't think step 2) would actually be
  useful.

> @@ -928,6 +931,7 @@ static int parse_branchname_arg(int argc, const char **argv,
> 	dash_dash_pos = -1;
> 	for (i = 0; i < argc; i++) {
> 		if (!strcmp(argv[i], "--")) {
> +			opts->discard_changes = 1;
> 			dash_dash_pos = i;

Wouldn't "dash_dash_pos != -1" be enough to know whether there's a --?

-- 
Matthieu Moy
https://matthieu-moy.fr/
