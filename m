From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] push: give early feedback
Date: Tue, 25 Jun 2013 00:54:17 +0530
Message-ID: <CALkWK0mEWkXpsaUtMLc4r6vufDdSSdsX_PARwmObCSPW1mgAmQ@mail.gmail.com>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
 <20130624182809.GA15296@sigill.intra.peff.net> <CALkWK0=d1wkKWngH+6gBd-2svj7r_tgC5=+zUbgJRDfUCzupSw@mail.gmail.com>
 <20130624185546.GA25306@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCNq-0007sC-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab3FXTY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:24:58 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58217 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3FXTY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:24:57 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so26390845iej.29
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2lVG5ry0fp+lVGClDkTJrE0yV4iAlFpEGMOyQV5OijU=;
        b=P+eoMXs4odwphyWdsEKgYapqfKEM8HVgRwQW28cHZFRI6NtLh4B4Tfm8G+JlaU4XJX
         eK3dJIbtLkqtIyuEtT7WU/4F9T90IHxYkaiQ7Or4Vp//EEEzk9m2JR5fnqHJbc4A5Dt3
         A03IJs/ZXZS2QFpTBj0YmUadiwu/e6sqIMIy76rRzXrxkmRuDuESSWt4IfGO14ZXWpKW
         mRFct9yVxufduD+o5Z0KTrQT6ttzZgx/WKHKPHEHbix+mCQaJsAU5JwVA1rw7qkWrciM
         WhEBBEWIUdwjNIIKSJ5qH9jm2uUo7h5vO2ARfLmWHOCGyzYeX2ayTNqsucsEd6W+oPPn
         fuWQ==
X-Received: by 10.42.76.5 with SMTP id c5mr9004113ick.91.1372101897293; Mon,
 24 Jun 2013 12:24:57 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 12:24:17 -0700 (PDT)
In-Reply-To: <20130624185546.GA25306@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228904>

Jeff King wrote:
> Leaving aside the transport API for a minute, you are always going to
> have this lack-of-information versus time problem. A refspec like ":"
> says nothing particularly useful, but it can only be expanded once
> contact is made with the other side (which is what takes time).

Right, and ':' is special in that aspect; it does not warrant slowing
down the expansion of refs/heads/*, for instance.  Besides, I suspect
':' can be resolved much faster than using push --dry-run.

> I do not personally think the "early" information is particularly
> useful. I don't have a problem with it as part of "-v" output (or
> enabled by config), but it seems useless for enough cases (e.g., user
> gave explicit refspecs, or refspecs are not useful without being
> expanded) that showing it by default is going to be considered noisy
> cruft by many users.
>
> Was the unconditional nature of your earlier patch meant to be part of
> the final version, or was it just illustrative?

Very much illustrative.  The finer details of when exactly we should
show it can be discussed later.

>> Yes, ^C is a hack, but it's useful in practice (there is ofcourse no
>> guarantee): I've been saved many times by it.  The only way to prevent
>> the race is to wait (either indefinitely for some user-input or for N
>> seconds), but I don't want to trade of speed.
>
> I have had the opposite experience. Many times I tried "rm -v" to keep
> an eye on what was being removed, but I do not recall once where I
> frantically reached for the keyboard in time to make a difference. But
> of course that is anecdotal, and push can be somewhat slower.

push is an all-or-nothing network operation that has significant
startup time (name resolution etc.), very much unlike "rm -v".  Again,
I'm talking about "in practice" *in the context of push*; not making
any statements about the general usefulness or correctness of ^C.

> Yes. I do not have any interest in such an interactive push, but the
> point is that a potential first step to any confirmation scheme, no
> matter what you want it to look like, is a hook. You don't seem to want
> a confirmation scheme, though, due to the wait (and I cannot blame you,
> as I would not want it either; but then I would not want the extra
> refspec message you propose, either).

I'm trying to figure out how to determine what a push will do without
actually pushing (or --dry-run, which is almost as expensive).  You
might like to put that information in your prompt instead of stdout,
but do you agree that the information is worth getting?
