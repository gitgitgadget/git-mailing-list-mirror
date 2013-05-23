From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Thu, 23 May 2013 15:22:50 +0530
Message-ID: <CALkWK0kyRno4eMYHXC3RkJFCVZ6DJWgFX=pR+WCu8=Gaf9q=Mw@mail.gmail.com>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se> <20130522134212.GB13731@poseidon.cudanet.local>
 <20130522144531.GB2777@thunk.org> <7v8v36kiau.fsf@alter.siamese.dyndns.org>
 <20130522180403.GB20848@thunk.org> <7vvc6aj14r.fsf@alter.siamese.dyndns.org> <20130523021123.GA23155@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 11:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSDK-0007Ye-HK
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 11:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab3EWJxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 05:53:33 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58568 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887Ab3EWJxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 05:53:31 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so652818iea.37
        for <git@vger.kernel.org>; Thu, 23 May 2013 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VFrW+ugJ6QOmJmq8s03A3WmxVvLwDLfkC1j/726Ll0I=;
        b=DgiCy79LRBHJ5oyJC5Vur/h9rOQckQirfMk+gvZcRuQzBxkcwUzSY8ZmfA7IAkyX9R
         KEZpijuYliHAW8R3gYhUSDcoZT45OJMg4CaoeQHhCAkMAMGsuwvyBdt7SdVQWlZaCOJ8
         zcUmqQ9BT6NqNXrEEJ/ibI6ViUGD6TTAuRxPwUFNDysAydlQ71uVNRxgqJpKHFHZTR5n
         sktBt1CJuOJUT5Sn2rnqLzy01PlCe1J+qDdvsny29ZT08WjzgOQlEyC3T38SHPukvs2f
         uJNQMR8olIGfakGuoT83p4q6ZZGfpQ2k1p9Pr99aBdfgDFdl6liIFkLheLy4adfVdtwy
         QcWg==
X-Received: by 10.50.3.38 with SMTP id 6mr26390igz.44.1369302811007; Thu, 23
 May 2013 02:53:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 02:52:50 -0700 (PDT)
In-Reply-To: <20130523021123.GA23155@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225229>

Theodore Ts'o wrote:
> Right now I do this just by being careful, but if there was an
> automatic safety mechanism, it would save me a bit of work, since
> otherwise I might not catch my mistake until I do the "git push
> publish", at which point I curse and then start consulting the reflog
> to back the state of my tree out, and then reapplying the work I had
> to the right tree.

My scenario is a bit different, and I think this safety feature is
highly overrated.  It's not that "I'll never rewind some branches, but
rewind other branches", but rather "I might rewind anything at any
time, but I want immediate information so I can quickly inspect @{1}
to see if that was undesirable".  To put it another way, my philosophy
is not "auto-deny unintended changes", but rather "tell me immediately
about undesirable changes".  To this effect, my prompt looks like:

artagnon|push-current-head=:~/src/git$

The = indicates that I'm in sync with upstream, and that there's
nothing to push.  When I make some changes, that character changes to
>, which means that there are ff changes to push.  Finally,

artagnon|push-current-head<>:~/src/git$

has my immediate attention.  <> means that I've diverged from
upstream.  Since the prompt is present all the time, I catch the
divergence just-in-time.  Moreover, I push very frequently resetting
the prompt to = periodically.

So, do you still need this rewinding safety thing?

> So what I do is something like this:
>
> git push publish ; git push repo ; git push code

While we can definitely make the UI better for this (maybe push
--multiple?), there is no fundamental change: we have to re-initialize
all the refspecs, connect to the remote via the transport layer and
prepare a packfile to send.  In other words, it's impossible to make
it any faster than what you get with the above.

> where....
>
> [remote "publish"]
>         url = ssh://gitolite@ra.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
>         fetch = +refs/heads/*:refs/heads/*
>         push = next
>         push = master
>         push = maint
>         push = debian
>         push = +pu

So you're a batched-push person.  And the above makes it clear that
you don't want to explicitly differentiate between a push and push -f
(the +pu thing).  And this assumes that you never create any new
branches (I branch out all the time), otherwise you'd have rules for
refs/heads/*.  Just out of curiosity, do you ever have ref-renaming
requirements (like push = refs/heads/*:refs/heads/tt/*)?  We were
discussing that on another thread, but I haven't found an
implementation I'm happy with yet.
