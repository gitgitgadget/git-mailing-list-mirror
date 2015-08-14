From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 11:12:49 -0700
Message-ID: <xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 20:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQJTO-0008UE-HA
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 20:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbHNSMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 14:12:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36558 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbHNSMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 14:12:51 -0400
Received: by pacrr5 with SMTP id rr5so65086273pac.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oPTrgdfKrq0aU40YOJeVwrjGYkeoaJ2rh2PqqCmI6RY=;
        b=Orr+ikvwXqzmzehLYx14/i7n2nN9DiWQUSlc7fCBKRfYheeNUjDRVvGgy3zR4A1d8p
         pQYVDRNT53LENUxzw3qQkMmN6PUEX6k4c1yclH8yIWJP7e4EF2n8HFYnANT1UMLaktHw
         8k3NK1XqsaNxaS+GJOynuM0vLCP25lWAGJRcBCVz0V6LlDvAZHdEZ719JZLvK4j+s4mk
         XSc82AL8rEuMUFWcZdfx4Ml9kNcpSRTeZFx/aiZdTcvgdrEQHv5JI8WVaZGRqmOlILHu
         6KPNwGSOTNh1aYIXsqJmUbtUkM3k+oKEMjRZJe2ZL5Zj3FRPODd0MiEJc4tcCIIhrAxq
         c+qA==
X-Received: by 10.68.234.34 with SMTP id ub2mr89208757pbc.101.1439575970747;
        Fri, 14 Aug 2015 11:12:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id hi1sm6737043pbc.47.2015.08.14.11.12.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 11:12:50 -0700 (PDT)
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Thu, 13 Aug 2015 15:00:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275922>

Dave Borowitz <dborowitz@google.com> writes:

> Remembering to pass --signed to git push on every push is extra typing that is
> easy to forget, and just leads to annoyance if the remote has a hook that makes
> signed pushes required. Add a config option push.gpgSign, analogous to
> commit.gpgSign, allowing users to set this flag by default.
>
> Since --signed push will simply fail on any remote that does not advertise a
> push cert nonce, actually setting this to true is not very useful (except for
> the super-paranoid who would never want to push to a server that does not
> support signed pushes). So, add a third state to this boolean, "if-possible",
> to sign the push if and only if supported by the server. To keep parity between
> the config and command line options, add a --signed-if-possible flag to git
> push as well.
>
> The "if-possible" name and weird tri-state boolean is basically a straw man,
> and I am happy to change if someone has a clearer suggestion.

Yes, it looks somewhat strange.  Let me go on a slight tangent to
explain why I think it is OK for "push --signed".

First imagine the case where we were talking an optional setting for
"git tag -a" and what our reaction would be.

Because the reason "git tag -s" would fail when "git tag -a" can
succeed can only be because you do not have a working GPG set-up
(i.e. correctly built and installed GPG with a usable key of your
own to sign), I would say "please sign this tag if I can, but do not
bother failing, an unsigned annotated tag is also OK for me" is not
a sensible request.  In such a case, you'd better get your act
together and make yourself ready to sign before doing the "tag -s"
thing.  Otherwise you'd never get around to do it.  So I'd say "git
tag --sign-if-possible" would not make sense.

But "push --signed" can fail even if you have a perfectly good
GPG set-up.  It will not succeed until the receiving end becomes
ready to accept a signed push, and often you would not be in control
of the receiving end.

More importantly, the meaning and the purose of the GPG signature in
signed tags and signed pushes are vastly different.  In the former
case, you are attesting that the signed objects were made by you to
help yourself.  If somebody else created a tag or a commit and
claimed it is from you, you can say "that signature does not match,
it is not mine".

But "signed push" is not about helping you.  It is about helping the
receiving end by allowing them to be more credible when they say
"This is what David Borowitz said he wanted to put at the tip of
this branch" to other people.  Currently, they can only make a weak
claim "Well, you know, the push was made after we authenticated a
pusher with our own authentication methond, and here is the log that
says the pusher was David".  The log entries could be faked, and the
general public cannot audit.  With a signed push, they can say "Here
is the push certificate, dated and signed by David Borowitz", and
the general public can check without trusting the receiving end
(i.e. hosting site).  If the receiving end does not offer signed
pushes, it just means that they are not ready to be helped by you,
and you should have the option of pushing without helping them,
which is what your "if-possible" is about.

Because of the above reasoning, I think a weaker "I want to do a
signed push if the recipient is capable of accepting one, but
otherwise just pushing there is OK" is a perfectly reasonable
request.

So I am fine as long as "if-possible" turns a failure to make signed
push into a success _only_ when the reason of the failure is because
we did not see the capability supported by the receiving end.  If
the reason why you cannot do a signed push is because you cannot
sign push certificate, "if-possible" should still fail.

Thanks.
