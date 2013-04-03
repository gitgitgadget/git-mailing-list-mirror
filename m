From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Tue, 2 Apr 2013 19:31:29 -0600
Message-ID: <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 03:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNCYS-0002I0-98
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 03:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759992Ab3DCBbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 21:31:31 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34852 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227Ab3DCBba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 21:31:30 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so962735lab.37
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=VpDqWADE6h2hM733Y47WL+VTIVmOG4CjGhVs5gDl2Og=;
        b=Nxz0JobS8uzHKM1jCXVAxVbElsNam0pchCfoLbRdgvTT9c3ArZJZTmfGHbAP7L0NgQ
         Ec8t96vOOVQKEL2HnZ6OWinmM+ABTSMPJ0DycoAAvm+TG+qgklU1lXdc+A685DXjDcpg
         ikOldxu7nvVYwKhyaxRo9pMYPFe+HbQ2VRU6Wu8KsylaBR5jjVR6kj4y6UMLi9SqtYa7
         blgaZcJQQj9B9JffRECuZyaq+RO4anDoVaeLgM5uPY6RBhQPAPtnTufbgQSsvnhloU/5
         O4zhff+J0ArfSFdqEMD7qGL4J2oMUsUATOMEl0RAS9BJrEm693GDfkhyFnDw1jpr4Fac
         Gpbw==
X-Received: by 10.112.143.10 with SMTP id sa10mr74578lbb.36.1364952689196;
 Tue, 02 Apr 2013 18:31:29 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Tue, 2 Apr 2013 18:31:29 -0700 (PDT)
In-Reply-To: <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219909>

On Tue, Apr 2, 2013 at 4:23 PM, Max Horn <max@quendi.de> wrote:
>
> On 02.04.2013, at 22:09, John Keeping wrote:
>
>> On Tue, Apr 02, 2013 at 01:02:49PM -0600, Felipe Contreras wrote:
>>> Here is the next round of patches for remote-hg, some which have been
>>> contributed through github.
>>>
>>> Fortunately it seems to be working for the most part, but there are some
>>> considerable issues while pushing branches and tags.
>>
>> How does this compare to the current state of gitifyhg[1]?  That's built
>> on top of this git-remote-hg script but seems to have been more actively
>> developed recently.

I only learned about it recently, I've looked at the history and to me
it seems rather chaotic, and a lot of the code was simply copied from
git-remote-hg without comment.

> * added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)

I ran these test-cases with remote-hg, and the same test-cases pass. I
only had to do minor modifications, most of the failures came from
subtle differences such as different strategies to sanitize authors,
and which branch to pick for HEAD.

> * improved handling of hg user names (remote-hg is not able to deal with some pathological cases, failing to import commits). Sadly, mercurial allows arbitrary strings as usernames, git doesn't...

I wouldn't call it improved. In some cases the remote-hg result is
better, in others gitifyhg is, but there's only a single case where
the author name becomes a significant problem. It's a trivial fix.

> * failed pushes to hg are cleanly rolled back (using mq.strip() from the mq extension), instead of resulting in inconsistent internal state. This is quite important in real life, and has bitten me several times with remote-hg (and was the initial reason why I switched to gitifyhg). A typical way to reproduce this is to push to a remote repository that has commits not yet in my local clone.

This is not an issue in remote-hg any more since now we force the
push. It's not nice, but there's no other way to push multiple
bookmarks (aka git branches) to the same branch (aka commit label).

I doubt these inconsistent states can happen any more, but if they do,
the plan in remote-hg is to simply ignore those revisions, and only
push the ones that have git refs. I have the code for that, but I'll
not be pushing it to git.git for the time being.

> * git notes are used to associate to each git commit the sha1 of the corresponding hg commit, to help users figure out that mapping

This is a minor feature. I've had the code for this for quite some
time, but for the moment I think there are higher priorities.

> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.

I doubt this makes any difference (except for more wasted space).

> * Better handling of various hg errors, see e.g. [2]. More work is still needed there with both tools, though [3].

This is literally a three lines fix, and it simply makes one error
nicer. Hardly worth mentioning.

> * Support for creating hg tags from git (i.e. pushing light git tags to heavy hg tags)

remote-hg has the same.

> * The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
> In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg

I've personally checked against multiple versions of Mercurial. It's
possible that some error might slip by, but it would get quickly
noticed.

> * Renaming a gitifyhg remote just works [5]. Doing that with remote-hg triggers a re-clone of the remote repository (if it works at all, I don't remember).

Yeah, now you can change the alias of the remote, but you can't change
the remote url. This is not really an advantage, simply an almost
imperceptible different choice.

I still don't see any good reason why a user might prefer gitifyhg,
even more importantly, why gitifyhg developers don't contribute to
remote-hg.

Also, unlike remote-hg, which basically passes all the tests of
gitifyhg, gitifyhg barely passes any tests of remote-hg (three).

Cheers.

-- 
Felipe Contreras
