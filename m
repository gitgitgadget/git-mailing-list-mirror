From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Thu, 29 May 2014 14:34:33 -0700
Message-ID: <CAKpPgveDfNq+kxWCukULPqvn7H2XsfS8maC0ExzvHzFGiEAPbg@mail.gmail.com>
References: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com> <20140529201334.GA17355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 29 23:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq7yU-00067E-S5
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 23:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaE2Vez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 17:34:55 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:36704 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbaE2Vey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 17:34:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so1005359oag.2
        for <git@vger.kernel.org>; Thu, 29 May 2014 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sz+/DAUZuYDpDzimM3uAQ6250Ld874jD+SSu47L6egk=;
        b=yzwXCk+hoewcsiLXWjZ86WVjZ6YGyXXwexsVq0XKtvelFkp6KPpLqUoLdwsLW/PWLv
         IbhopNQeFhiJe/vwUUNWkl2nAWTTo5e+0gwK5Oke/icL+c3Fv2ieh5SVDRB8qOxQN193
         PBtWjLjjBo2KKM0mJJF5cllvFvHcZ6OoPoClBJBEuBgCqfmKNUl5Eebhod+0hVfhTHga
         6P0cdro0ff25SEmgDcpNkCKopEKLxd6OXdf4S3G2c774uCRVdNyy2rJ7OWHnRNuAx0V+
         heSwohFn+5K6GfWyOX8k0hQHQmIXPYKC8N2iK0cKxlbh5E77GzYXEvwUYHWz9U2swJpp
         XB5w==
X-Received: by 10.60.146.167 with SMTP id td7mr12136729oeb.6.1401399293847;
 Thu, 29 May 2014 14:34:53 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Thu, 29 May 2014 14:34:33 -0700 (PDT)
In-Reply-To: <20140529201334.GA17355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250408>

On Thu, May 29, 2014 at 1:13 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 28, 2014 at 04:45:57PM -0700, Pasha Bolokhov wrote:
>
>> Move backwards from the end of the string (more efficient for
>> lines which do not have trailing spaces or have just a couple).
>
> The original code reads the string from left to right. In theory, that
> means we could get away with not calling strlen() at all, over a
> right-to-left that must start with a call to strlen().
>
> That being said, I think we already have the length in the calling
> function, so you could probably avoid the strlen() altogether, which
> makes a right-to-left function more efficient.
>
> However, I doubt it makes that much of a difference in practice, so
> unless it's measurable, I would certainly go with the version that is
> more readable (and correct, of course).

    Sorry, just to recap, you would go with the existing version
(which needs correction), or with the one that is being suggested? (I
agree I can format the style a tiny bit better in the latter one)

     Tests should not be a big problem, although it's kind of clumsy
to test an internal function which does not really give any output
(you can only measure the outcome). Just again to stress, I have
tested both implementation extensively and the suggested new
implementation gives the correct answers for all your examples below
and all others. If I show this with explicit "t/" tests, will it
suffice then?

    Basically what I suggest is

-- either: improve the existing function such that it does correctly
that "text  \   " case, and also does not use 'strlen' since it anyway
moves left to right

-- or: use the new suggested implementation (and just brush the
formatting a bit), and perhaps borrow 'len' from the calling routine

And add tests in any case. What is the preference?


>
>> Slightly more rare occurrences of 'text  \    ' with a backslash
>> in between spaces are handled correctly.
>
> Can you add a test for this?
>
> Also, if you are refactoring this function, I think it makes sense to
> check that:
>
>   "foo\\ "
>
> and
>
>   "foo\\\ "
>
> match "foo\" and "foo\ ", respectively (I think they do with your patch,
> but it is a tricky case that is not immediately obvious).
>
> -Peff
