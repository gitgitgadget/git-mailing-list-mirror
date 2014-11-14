From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 21:44:41 -0800
Message-ID: <20141114054440.GA54304@gmail.com>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 06:44:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp9gj-0000XZ-8j
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 06:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbaKNFot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 00:44:49 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53346 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaKNFos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 00:44:48 -0500
Received: by mail-pa0-f47.google.com with SMTP id kx10so16850792pab.20
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 21:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IwqxzB659z81jIaxKwK+VTqoSUEEKKQ8y4FpWQhCnIk=;
        b=j7mtlMLuls6dpTbK9lm8dr9YV190tODLeDjfRTZb9/eRZI1vDEaDcc79WIeWM9C6Hr
         3Rxgq5/08+YwdaFl3e5gXNTDyDR1DgX6xtwFozvam8HHWJwDe7ZN4FwxDvJuZr9zJBy5
         kmNikbSiWbdbSWTytuMVpw12N/iqo2iL3ViJW3sEeLTRTjHs+/lcDmux7bEfdJzAxoks
         JAWbAkTrdYZuskresZR0EHVnDnMV6aNTTy979E/GeJHefQYhyNQNoNKQqZL17gw3zs3D
         dGPoMOONFbx4cGH35SIVR+UJKVubnzEWtcdMRibJb9S8M6fyY4q/Z8Af4+OSP9gG/ctu
         6OyQ==
X-Received: by 10.66.66.196 with SMTP id h4mr7585539pat.127.1415943887979;
        Thu, 13 Nov 2014 21:44:47 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id hc10sm2033203pbd.78.2014.11.13.21.44.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Nov 2014 21:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 09:21:49AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So just to be clear, the behavior we want is that:
> >
> >   echo foo >some-new-path
> >   git add some-new-path
> >   git checkout HEAD -- .
> >
> > will delete some-new-path (whereas the current code turns it into an
> > untracked file).
> 
> With the updated semantics proposed in the old thread, yes, that is
> what should happen.
> 
> >   git checkout HEAD -- some-new-path
> >
> > do in that case?
> 
> Likewise.  And if some-new-path were a directory, with existing path
> O and new path N both in the index but only the former in HEAD, the
> operation would revert some-new-path/O to that of HEAD and remove
> some-new-path/N.  That is the only logical thing we could do if we
> were to take the updated sematics.
> 
> That is one of the reasons why I am not 100% convinced that the
> proposed updated semantics is better, even though I was fairly
> positive in the old discussion and also I kept the topic in the
> "leftover bits" list.  The above command is a fairly common way to
> say "I started refactoring the existing path some-path/O and
> sprinkled its original contents spread into new files A, B and C in
> the same directory.  Now I no longer have O in the working tree, but
> let me double check by grabbing it out of the state recoded in the
> commit".  You expect that "git checkout HEAD -- some-path" would not
> lose A, B or C, knowing "some-path" only had O.  That expectation
> would even be stronger if you are used to the current semantics, but
> that is something we could fix, if we decide that the proposed
> updated semantics is better, with a careful transition plan.
> 
> It might be less risky if the updated semantics were to make the
> paths that are originally in the index but not in $tree untracked
> (as opposed to "reset --hard" emulation where they will be lost)
> unless they need to be removed to make room for D/F conflict issues,
> but I haven't thought it through.


Git has always been really careful to not lose data.

One way to avoid the problem of changing existing semantics is
to make the new semantics accessible behind a flag, e.g.
"git checkout --hard HEAD -- some-new-path".
-- 
David
