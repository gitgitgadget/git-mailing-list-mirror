From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 14:35:45 +0200
Message-ID: <CAETqRCh9frekD8yiR0bE+WQ7b_et1th8p_LsqrL8NhPnC8yaow@mail.gmail.com>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 14:35:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uleqd-0000Pn-4W
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 14:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab3FIMfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 08:35:47 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:55825 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab3FIMfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 08:35:46 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so14504172iec.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=plzo7HPHvj99Tz+fHLRH86irtTRgxlq0VpxeYPfTUFQ=;
        b=Lkezycl7Nb0F7/D9U9ppdkrYT9+4TJkdr1JnDkcIY/FrH2roM091FkHAwgEXbqN0tC
         rGY2Zu6ZROv0raFFkv9ICESBIxi7F0a6/mZHv+8K/fbvqk5cPzUOPig2j7KdmYkpypvU
         Il6kLklR0PCW7zUT6K3r3fAb/sMxhhyPTkVTTLs1LD0Dn5oZfHPjbsnQB05Wp0STRhCh
         POUktfgaCrx+Rk4L2aut4sW/jU/5KVX7bJ42awTI8oUoXhKxP+lyeUJ5Or3mD9eaxmk5
         HydMxo+JP663hFcl6WT0Mb3R2jCIfuRVkPaPN4gijVmnTXZYad+6+p4o4ZAqEKhU3gmH
         SPyw==
X-Received: by 10.50.39.76 with SMTP id n12mr555343igk.101.1370781345666; Sun,
 09 Jun 2013 05:35:45 -0700 (PDT)
Received: by 10.42.22.141 with HTTP; Sun, 9 Jun 2013 05:35:45 -0700 (PDT)
In-Reply-To: <20130609060807.GA8906@sigill.intra.peff.net>
X-Google-Sender-Auth: FeayU8lmN4Hyrf1xYsfGRmvG6qQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226958>

On 9 June 2013 08:08, Jeff King <peff@peff.net> wrote:
> I also wonder if it would be useful to be able to specify not only files
> in the filesystem, but also arbitrary blobs. So in 4b above, you could
> "git mw preview origin:page.mw" to see the rendered version of what
> upstream has done.

Hum, so `git mw preview origin:page.mw` would just do the get
request to the remote mediawiki, save it locally and - maybe - load it
in the browser ? Is it really better than just opening the browser and
typing the right URL ?

Currently, this URL is one click away when you have preview file loaded
in a web browser.

>> It works but a couple of points trouble me:
>> 1-  I had to copy two functions from `git-remote-mediawiki.perl`, I don't
>>     really know how we could "factorize" those things ? I don't think it makes
>>     much sense to create a package just for them ?
>
> You could make a Git::MediaWiki.pm module, but installing that would
> significantly complicate the build procedure, and potentially be
> annoying for users. One trick I have done in the past is to concatenate
> bits of perl script together in the Makefile, like this:
>
>   foo: common.pl foo.pl
>           { \
>             echo '$(PERL_PATH_SQ)' && \
>             for i in $^; do \
>               echo "#line 1 $src" && \
>                 cat $src \
>             done \
>           } >$@+
>           mv $@+ $@
>
> That would conflict a bit with the way we chain to git's Makefile,
> though. I suspect you could do something complicated like build "foo.pl"
> from "common.pl" and "foo-main.pl", then chain to git's Makefile to
> build "foo" from "foo.pl".

ok, thanks a lot.

>> 2-  The current behavior is to crash if the current branch do not have an
>>     upstream branch on a valid mediawiki remote. To find that specific remote,
>>     it runs `git rev-parse --symbolic-full-name @{upstream}` which will return
>>     something like `/refs/remotes/$remote_name/master`.
>>   2a-  maybe there is a better way to find that remote name ?
>
> If you just care about the remote name and not the name of the local
> branch, you can just ask for
>
>   my $curr_branch = `git symbolic-ref HEAD`;
>   my $remote = `git config "branch.$curr_branch.remote"`;
>   my $url = `git config "remote.$remote.url"`;
>
> Of course you would want some error checks and probably some chomp()s in
> there, too.

The fact is, `git symbolic-ref HEAD` result would have to be parsed in order
to extract the current branch name like I currently extract the remote name.
So, is it really better than `git rev-parse --symbolic-full-name @{upstream}` ?

>>   2b-  would it be useful to add a fallback if that search fails ? searching
>>        for a valid mediawiki remote url in all the remotes returned by
>>        `git remote` for instance ?
>
> That is probably OK as long as there is only one such remote, and it
> would help the case where you have branched off of a local branch (so
> your upstream remote is ".").  If there are two mediawiki remotes,
> though, it would make sense to simply fail, as you don't know which to
> use. But I'd expect the common case by far to be that you simply have
> one such remote.

Well, I thought that `git mw preview` could provide an interactive mode
where, if the first search fails, it would find all the mediawiki remotes, and
offers to the user a way to choose the remote ?

Benoit Person

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
