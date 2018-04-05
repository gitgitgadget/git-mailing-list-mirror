Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10EA1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 12:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDEMDY convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 5 Apr 2018 08:03:24 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63934 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeDEMDX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 08:03:23 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w35C3IJD002699
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Apr 2018 08:03:18 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Olaf Hering'" <olaf@aepfle.de>
Cc:     <git@vger.kernel.org>, "'Jeff King'" <peff@peff.net>
References: <20180405092358.569e0315.olaf@aepfle.de> <874lkq11ug.fsf@evledraar.gmail.com> <20180405104948.276de0ca.olaf@aepfle.de> <8737092929.fsf@evledraar.gmail.com>
In-Reply-To: <8737092929.fsf@evledraar.gmail.com>
Subject: RE: How to undo previously set configuration?
Date:   Thu, 5 Apr 2018 08:03:11 -0400
Message-ID: <000f01d3ccd6$15239f00$3f6add00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ5Ftr0QFWbJRUo7WVTTNL2VN6JVAIEF42zApD2bH0CWPmEBKJwC69w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 5, 2018 7:21 AM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Apr 05 2018, Olaf Hering wrote:
> 
> > Am Thu, 05 Apr 2018 10:42:15 +0200
> > schrieb Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> >
> >> I've been meaning to work on this but haven't figured out a good syntax
> for it (suggestions welcome!).
> >
> > Just prefix the knob with something like "no." or "-" or whatever to indicate
> that it never happened.
> 
> Those wouldn't work, respectively, because:
> 
>  a) For 'no.' there would be no way to override three-level keys,
>     because prefixing such a key with "no" would introduce a 4th nesting
>     level, which would be incompatible with existing config parsers.
> 
>  b) Similarly a prefix of - dies in git now. Unless I misunderstand
>     you. I'm assuming you mean something like:
> 
>         [user]
>         # This is an error
>         -email
> 
>     Although I see we don't ignore or error out on:
> 
>         [user "-email"]
>         foo=bar
> 
>    But that's back to problem a), and also looks ugly since you need
>    something like the extra foo=bar so we'll pay attention to it.
> 
> Also it's important that the syntax leaves room for item #1 that I mentioned,
> 
> I.e. not just ignore stuff like user.email, but being able to specify where from
> you'd like to ignore that. Sometimes your local sysadmin is overzealous with
> his /etc/gitconfig settings and you'd like to quarantine just that, but pay
> attention to everything else in ~/.gitconfig, or similarly in
> /some/repo/.git/config ignore your usual custom sendemail.* from
> ~/.gitconfig but not /etc/gitconfig, so the semantics can't just be "clear
> existing".
> 
> But of course, you might say that it *should* be a syntax error because if you
> rely on this feature and downgrade, you don't want to suddenly pay
> attention to the sendemail.* config again.
> 
> I think that's an acceptable failure mode, and better than the syntax error,
> because that's exactly what we have now, so this is similar to e.g. the
> conditional include directive which was understood but just copmletely
> ignored by older versions.
> 
> So we're OK with getting different config between versions with new
> releases, but at all costs don't want to have new releases introduce
> constructs that older gits error out on, and let's say hypothetically we
> supported something like:
> 
>     [user "-email"]
>     [user]
>         email = ...
> 
> Even `git config -l` on older version won't show that "user.-email", and it's
> better if older tools at least understand the syntax, even though they don't
> pick up on the magic.

I may be missing something but..

Another completely different approach to "undoing" configurations is to consider using git for this. Have a repository set up for your ~ directory, ignoring content other than .*, so you would ignore any sub-repositories at this level. Then manage your configuration as any other repo.

For configurations that are not user-specific, use in-repository configurations instead of system and global, so your undo is also handled by git. However, you can version control your /etc directory as well. We do that to detect changes (as a practical example, we have /etc/.git with some bits ignored but critical things involving rc.d, and the system git configurations are managed content in that repository. This implies our Ops team has to use git to make changes - a good thing - and 'git status' and 'git log' tells me immediately if someone changed something.

Undo becomes a git operation in both situations.

This may be complete OT, but I thought it might help

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



