Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DE11F597
	for <e@80x24.org>; Fri,  3 Aug 2018 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHCM7Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 08:59:25 -0400
Received: from ao2.it ([92.243.12.208]:56268 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeHCM7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 08:59:24 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flXqW-0000d0-VF; Fri, 03 Aug 2018 13:02:13 +0200
Date:   Fri, 3 Aug 2018 13:03:34 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option
 to the 'config' sub command
Message-Id: <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
In-Reply-To: <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
        <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 02 Aug 2018 11:57:14 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > Add a --stage option to the 'submodule--helper config' command so that
> > the .gitmodules file can be staged without referring to it explicitly by
> > its file path.
> 
> Sorry, but I have no clue what the above is trying to say.
>

You got me :), this was one of the changes I was having the more doubts
about, basically about the user interface, and it must have showed in
the commit message.

> The original 's--h config <name> [<value>]' is quite understandable.  It
> is like "git config <name> [<value>]", i.e. either get the current value
> for the name, or  set a new value to the name.
> 
> What does this 's--h config --stage' that does not take any option
> do?  "git add .gitmodules"?  Something else?  In what meaning is the
> word "stage" used?  Is it used as a verb "to stage"?
>

"s--h config --stage" is meant to replace "git add -f .gitmodules" as
shown in patch 07, maybe the two patches might have been merged to give
more context, but I kept the changes separate to follow how things were
done with patches 04 and 05.

The rationale behind the change is to close the circle started with 04
and 05 and stop referring to .gitmodules explicitly by file path in git
commands. The change is not strictly needed for the series, it's for
consistency sake.

The name "stage" is meant as a verb and was inspired by the "git stage"
command and by the stage_updated_gitmodules() function, I used an
option flag with no arguments because I saw this has been done for
verbs before, e.g. "git config --list". I did not know about
"gitcli.txt", sorry, I'll check it out.

Maybe a better name could be "submodule--helper config --add"?

The commit message clearly needs improvements.

> In a series that lets us use the data in the .gitmodules file without
> materializing the file in the working tree, I would have expected
> that you would want an option to specify which .gitmodules among
> (1) the one in the working tree (i.e. the only option we currently
> have), (2) the one in the index, and (3) the one in the HEAD, and
> when I saw the title, I would have expected that
> 
> 	git submodule--helper config --stage name
> 
> may be a way to read from the .gitmodules in the index to find the
> value for name (however, we we follow the option naming convention
> in gitcli.txt, it should be called --cached, I would think).
>

For my use case the automatic behavior of falling back to
HEAD:.gitmodules is enough, so I focused on that to have the
functionality merged.

The option you suggest may be useful but I'd leave that as a possible
future addition in case someone else needed it.

> > In practice the config will still be written to .gitmodules, there are
> > no plans to change the file path, but having this level of indirection
> > makes it possible to perform additional checks before staging the file.
> 
> Again, a claim without explanation or justification.
> 
> If you are planning to something like
> 
>  - prepare trial contents in .gitmodules.new file
>  - do whatever "additional checks" on .gitmodules.new
>  - add the contents to it to the index as a new .gitmodules blob
> 
> Then you do not need such an option.  "submodule--helper" is purely
> a helper for scripts, and not for human consumption, so scripts can
> just hash-object the blob contents out and update-index --cacheinfo
> to register the blob at any location of choice.
> 
> But as I said, this step is way under-explained, so my guess above
> may not match what you really wanted to do.

As stated, the motivation for now is just syntactical: remove hardcoded
references to .gitmodules in scripts.

No new "additional checks" are added as of now, the commit message is
misleading indeed.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
