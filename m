Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2479C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25A660E08
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbhJZTdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhJZTdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 15:33:31 -0400
Received: from viathinksoft.de (viathinksoft.de [IPv6:2001:1af8:4700:a07e:1::1337])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE64C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:31:06 -0700 (PDT)
Received: by viathinksoft.de (Postfix, from userid 114)
        id 0EDB561C71CB; Tue, 26 Oct 2021 21:31:04 +0200 (CEST)
Received: from webmail.viathinksoft.de (localhost [127.0.0.1])
        (Authenticated sender: daniel-marschall@viathinksoft.de)
        by viathinksoft.de (Postfix) with ESMTPA id 37EED61C71B2;
        Tue, 26 Oct 2021 21:30:39 +0200 (CEST)
MIME-Version: 1.0
Date:   Tue, 26 Oct 2021 21:30:39 +0200
From:   Daniel Marschall <info@daniel-marschall.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: git-svn bug: Output git directory has uncommitted changes
In-Reply-To: <20211026151442.65rndwsleyitxvvg@tb-raspi4>
References: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
 <20211025094139.GA22377@dcvr> <20211026151442.65rndwsleyitxvvg@tb-raspi4>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5be6fa92074fb40f3167901d203941bc@daniel-marschall.de>
X-Sender: info@daniel-marschall.de
Organization: ViaThinkSoft
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2021 17:14, schrieb Torsten Bögershausen:
> On Mon, Oct 25, 2021 at 09:41:39AM +0000, Eric Wong wrote:
>> Daniel Marschall <info@daniel-marschall.de> wrote:
>> > Hello,
>> >
>> > I have found following bug in the latest version of git-svn . I have this
>> > issue with the old version shipped in Debian stable, as well as with the
>> > latest version built from source.
>> >
>> >
>> > What did you do before the bug happened? (Steps to reproduce your issue)
>> >
>> > Extract the following SVN repository to GIT:
>> > https://svn.viathinksoft.com/svn/filter_foundry/
>> > The bug ONLY happens with this single SVN repository. All other SVN
>> > repositories from my server work perfectly.
>> >
>> > $ PERL5LIB=perl/ ./git-svn --authors-file="../../authors.txt" clone
>> > --trunk="trunk" "https://svn.viathinksoft.com/svn/filter_foundry/" "_test"
>> > $ cd _test
>> > $ git status
>> >
>> > What did you expect to happen? (Expected behavior)
>> >
>> > git status should show that nothing needs to be commited.
>> >
>> > What happened instead? (Actual behavior)
>> >
>> > You get a long list of files which need to be committed. The list is
>> > sometimes longer and sometimes shorter. So, the behavior is not
>> > deterministic. I have the feeling that the list often contains all files in
>> > the repo.
>> 
>> It seems like a CRLF vs LF vs CR issue; not something I'm
>> familiar with (not even in a git-only environment).
>> 
>> Running `git diff --ignore-space-change` says there aren't
>> non-space changes.
>> 
>> The presence of a .gitattributes file in the repo could be
>> confusing things, maybe, just a guess, I don't know...
>> 
>> Being a *nix-only person, I've never mucked with eol= attributes
>> at all.  Maybe somebody else experienced with such issues can
>> chime in; but eol stuff seems like a minefield of complexity I
>> don't ever want to step into :x
>> 
>> > Anything else you want to add:
>> >
>> > This SVN repository was cloned from a foreign server to my own server, and
>> > then continued there. I think this SVN repository has some specific
>> > properties that cause the bugs.
>> 
>> It's been a while since I've looked at SVN stuff.  From what I
>> remember, git-svn doesn't check the CRLF property on the SVN side.
> 
> Good point, Eric
> 
> After cloning the repo with git-svn, we can say that:
> The .gitattributes file is in conflict with the files commited under 
> Git
> Run
> git ls-files --eol
> to see what is going on
> [lots of output]
> 
> To give a simpler example, run it on only one file,
> which is changed in my clone:
> 
> git ls-files --eol telegraphics_common/tt/wind.c
> i/crlf  w/crlf  attr/text eol=crlf telegraphics_common/tt/wind.c
> 
> And what does this mean ?
> The file has CRLF in the index, CRLF in the working tree and "text"
> These settings are conflicting.
> The easiest solution may be to replace
> "text" with "text=auto"
> in .gitattributes
> 
> And, while looking at .gitignore: the "eol=cr" is not supported under 
> Git:
> *.afs text eol=cr
> (But Git does not complain)

Thank you for your replies.

I don't have much experience with .gitattributes, so I am not sure if I 
did everything correctly.

What I had in mind was the following:
I have files in my SVN repository which are CRLF, and some files are LF.
I wanted to tell GIT which line ending the files should have
so that they will have the exact same line endings after the repo is 
checked out. I think text=auto will also do this, maybe I should try 
that.

The "AFS" files are very special, though. Due to compatibility reasons, 
they must be in the ancient Macintosh format (CR) otherwise the program 
won't work. Do I need to state "eol=cr" then? Or will GIT automatically 
use the same line endings as in the files which I have added to SVN?

Thank you for your help!
