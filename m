From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Tue, 18 Mar 2014 17:36:33 -0400
Message-ID: <CAPig+cQaxLoJstV8sKvKb6+2JcZ967=f485Vp1938m+KwgvLqQ@mail.gmail.com>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
	<CAPig+cTodcfSVmHZeHuAj2kuE_CxuZqZuaNHv33hrhDmQuSmuA@mail.gmail.com>
	<loom.20140317T120153-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 22:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ1gd-0007w4-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 22:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbaCRVge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 17:36:34 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:49968 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaCRVgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 17:36:33 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so7651373yha.13
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=evep3/uU/L3jpbvmKQ7xyYTBBA6GGAg2rlofG2Wl/zA=;
        b=iUzSwc+FR2aIP9a0/pt4qn8bFTN0TjoLHk5sb/xdCsMwbydkUKUwRFovIK8Ud01/i6
         6gv62exSY3iduc4CeZpfZZE6MrcatHDFookCD+ad3GiO1+uapaZHV9BkZ/dDtUvkXQ9t
         TdjeEbgv9Hm3v6W6WXvK3eAvZvllBiRSzrAbtgn91xyVxPq0mr5fPplhe9MfpGdXdNJJ
         daS4ifvimNj+08Y0Uwlyhy2H3odDBKyXoDWGoHLixBtbR4x60pKcBDeJsOOeQYFRawoY
         O3GcejL9H39CRCAEwQL5/HtzwquuCpgiEgtssqZAIAuJaTBfOur/0kHfSq6E7M84exD+
         jSdw==
X-Received: by 10.236.137.8 with SMTP id x8mr20736960yhi.4.1395178593055; Tue,
 18 Mar 2014 14:36:33 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 14:36:33 -0700 (PDT)
In-Reply-To: <loom.20140317T120153-546@post.gmane.org>
X-Google-Sender-Auth: MI6zr3cRZUrXC5gHicW0n-2YNrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244384>

On Mon, Mar 17, 2014 at 7:46 AM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>> Matthieu already mentioned [2] that this sort of "lego" string
>> construction is not internationalization-friendly. See section 4.3 [3]
>> of the gettext manual for details.
>
> I was hoping to get away with using less memory by having only four entries
> in the table. I suppose that is not possible. The rebasing check can still
> be moved outside of the four if statements and calculate the index
> correctly. The strings would then have to be arranged in such a way to make
> this work.
>
> Using a multiple-dimension array as suggested in other submissions for this
> particular microproject would probably be better, but it has already been done.

If a multi-dimension table is indeed better than other alternatives,
then that's a good reason to choose it, even if others have already
used that approach in their submissions. It's more important that the
code is clean and easy to understand and maintain than to be clever.

If you're really interested in trying an approach not already
submitted by others, take a look at Jonathan's idea [1]. If you play
around with it and find that it actually does make the code clearer
and simpler, then perhaps it's worth submitting. If not, then not.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/198882/focus=198902

>> These hard-coded indexing constants (0, 1, 2, 3) are fragile and
>> convey little meaning to the reader. Try to consider how to compute
>> the index into verbose_prints[] based upon the values of
>> 'remote_is_branch' and 'origin'. What are the different ways you could
>> do so?
>
> I was going to do something like this: if !remote_is_branch the index goes
> incremented by 2, because the first two entries are of no interest and if
> !origin, the index is incremented by 1. This would correctly compute the
> index. It should also work with the rebasing check if the four
> rebasing-specific messages are at the end of the table and when rebasing the
> index is set to start at those messages.
>
> The reason I did not go with this is because I would still need the four ifs
> in order to keep the bug check part of the code. I might be able to find a
> work-around for it on the second attempt.

Since the result is just a number, its possible to compute it directly
without conditionals, however, it does start resembling a magical
incantation. (I'll comment further in your v2 submission.)

> I have seen N_() used in other code but I wasn't sure what its purpose was.
>
> Thank you very much for the review.
