Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14203C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC95207BB
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHUNLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:11:25 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63700 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgHUNLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 09:11:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07LDB6ka052252
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Aug 2020 09:11:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Lukas Straub'" <lukasstraub2@web.de>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <cover.1597853634.git.lukasstraub2@web.de> <xmqqr1s2tswd.fsf@gitster.c.googlers.com> <04aa01d67659$2dc217b0$89464710$@nexbridge.com> <xmqqimdetpuw.fsf@gitster.c.googlers.com> <20200819201736.GA2511157@coredump.intra.peff.net> <xmqqa6yqtm03.fsf@gitster.c.googlers.com> <20200819203825.GA2511902@coredump.intra.peff.net> <20200820133445.2bd162a3@luklap> <20200820130125.GB2522289@coredump.intra.peff.net> <20200821143941.28f71287@luklap>
In-Reply-To: <20200821143941.28f71287@luklap>
Subject: RE: [RFC PATCH 0/2] Allow adding .git files and directories
Date:   Fri, 21 Aug 2020 09:11:00 -0400
Message-ID: <007101d677bc$87ed2130$97c76390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJUwsi1t0kYcCu+MG1WzKjrMbhjgQKo5EueAejmVwAB/vjPsAIQdRDrAko2jCYCkm7cHALLa0ztAcK4A2YCKqL93qekPX9w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 21, 2020 8:40 AM, Lukas Straub wrote:
> On Thu, 20 Aug 2020 09:01:25 -0400
> Jeff King <peff@peff.net> wrote:
> 
> > On Thu, Aug 20, 2020 at 01:34:45PM +0200, Lukas Straub wrote:
> >
> > > Yes, there are many workarounds and they work well in the CI
> > > usecase. However, for the arbitrary files usecase there is no good
> > > workaround. I currently use a script which iterates over the tree
> > > and renames .git -> dotgit before running any git command and back
> > > again afterwards, but it is slow and brittle. I toyed with the idea
> > > of writing a FUSE filesystem to do the renaming, but it is needlessly
> complex and hurts performance.
> > >
> > > Really, this problem should be solved in git itself.
> >
> > It is unclear to me why need to hold many sub-repositories within the
> > parent one, nor what Git operations you expect to perform over them.
> > And what disadvantages your script solution has.
> >
> > Perhaps you can give a more concrete use-case (but before you spend a
> > lot of time doing so, I'll warn you that I find it pretty unlikely
> > that it will cross the bar necessary to counter the downsides we've
> > discussed so far).
> >
> > -Peff
> 
> I store all my files in several git(-annex) repositories. By "files" I
mean
> anything you might find in your home directory across your devices,
anything
> on usb thumbdrives, sd cards and maybe your home NAS. And anything you
> would usually use google photos, iCloud, dropbox, etc. for.
> Concrete examples:
> I store the home directories (containing git repos) of two retired
machines in
> such a repository. I don't store the homes in a archive file as I want to
use
> git-annex's ability to only have the contents of files I need on my
laptop.
> I store my development directory containing several(130)
> git/svn/unversioned projects in another repo. This allows me to version
and
> sync everything (including WIPs) across my machines. I tried alternative
> workflows and they didn't work out.
> 
> In both cases, the script introduces a delay of ~10 seconds to every git
> command I run in the outer repository and I have to remember to use the
> script on these repos.
> Moreover, I can't use the git-annex assistant, which watches the repo and
> automatically commits and syncs file changes.
> In my opinion, I want to be able to set the allow-dotgit config and it'll
just
> work without the delay and without having to remember the script.
> 
> The downsides we discussed don't apply in this usecase. These are mostly
> personal files, so I wont upload them to any hosting site (not even
private
> ones). There is no security impact as I only sync with trusted devices.

Have you considered git clone --mirror? This might solve your situation in a
different way, but should keep your repositories in sync with each other. It
also allows you to have different .git/config files on different platforms
(rather important when doing multiplatform development particularly with
submodules).

Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



