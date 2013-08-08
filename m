From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 8 Aug 2013 23:06:02 +0530
Message-ID: <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7U8l-0004lI-B5
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966001Ab3HHRgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:36:43 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:32844 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965963Ab3HHRgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:36:42 -0400
Received: by mail-ie0-f176.google.com with SMTP id 9so2267006iec.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NBaNmc7cIuugjCABqHStUQRR9sMcFxcDf4LF18oR6lA=;
        b=S2QxpAZup+L5lK31votANhqLbaGpAverDHU12lBH7t3smgo0ctW2mkIQwbaVWw0rSf
         qp73Lp5OYSwGR5//RH8XtbP/wNYCHBmi2YuqyimnMOd5ws1xDyPw8aC7WlSpAaBqxKQC
         WVknHIn0vDBZuNgqdtbjGRktFmGK1NzSdg2Ii1uSwWOMTtHAd1YLOEMsd7o0ByjsgGhS
         5NbWYf3TiGnJ6t71Z77YZquoSwBImtygP/EvphFbUQQaoC/PKlyhPAejMo8VOBMdunOD
         N3WigfcF9Fex2n7AvN7TcEHIG9yCRWx9H9vsKycgThAA+t4FHHE5eINcK/BmGbbslMmK
         LuVw==
X-Received: by 10.50.134.162 with SMTP id pl2mr2924864igb.55.1375983402223;
 Thu, 08 Aug 2013 10:36:42 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 8 Aug 2013 10:36:02 -0700 (PDT)
In-Reply-To: <7v61vgazp5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231907>

Junio C Hamano wrote:
> So I do not see how that question is "obvious".  The question
> obviously pointless and misses the mark by wide margin?  The
> question makes it obvious that whoever asks it does not understand
> how Git works?

Shall we all sit and mourn over the fact that I don't understand how
Git works, or are you willing to explain it to me?

> And of course we do not transfer objects that are not asked for from
> or to a repository over pack tranfer.
>
> Most importantly, it is not about butchering the pack machinery in
> such a way that we can create _only_ such "non history traversal"
> packs.

I asked you a very simple question: what happens when I do "git push"?
Instead of answering the question, you butchered the pack machinery to
"only" create packs with garbage in them (aka. stripped out the
reachability analysis code completely), and blamed me for doing it.

Explain it to me in plain English without getting agitated:

1. I'm on my terminal doing various repository operations: constantly
creating new objects and moving my refs around to create unreachable
objects. I have lots of loose objects.

2. I say "git push". What happens? A reachability analysis is
performed on my loose objects, and the ones reachable by the ref I'm
sending are packed up and sent over the network. Now, I no longer have
any loose objects.

3. After a few days of working, the gc heuristics figure out that I
have too much garbage and too many packs; a cleanup is required. The
gc --auto which doesn't tolerate fragmentation: it tries to put
everything into one large pack.

Loop.

We're talking about tackling the gc aggression problem in 3. And you
propose putting the young objects in a pack without performing
reachability analysis: I'm asking how this is going to benefit me;
when I say "git push" (or when gc decides to repack), won't I need to
explode the young pack into loose objects, do a reachability analysis,
and repack anyway?
