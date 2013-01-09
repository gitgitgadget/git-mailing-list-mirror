From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed, 9 Jan 2013 10:43:20 -0800
Message-ID: <CANiSa6joBuAJVHkMfNbVMHFJ6BFOh7sGRw_txRO81CKudRwsfA@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-17-git-send-email-martinvonz@gmail.com>
	<20130109170119.GA5332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 19:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt0cn-0008GG-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 19:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab3AISnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 13:43:22 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:37991 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab3AISnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 13:43:21 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so1791347iab.21
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 10:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ksEv8IhBX8SkO8vaZVxaoXpPjqXE86g5QFxzD5wjoy8=;
        b=GagWQ8hCGnBGfY22tCmQLSoazv3W9NLdt2CbIm3EqsX+8+BZ5uwTLASE14eC/oJE7l
         GQbtrRu5IkhBc44GQG1sA+1Il0DMBSepGgJc8qnF4wJ7J2wyNEDR30Vf27sUXUkz7LvK
         rQat7aLTki67zYRnxVFIAohlaEbghFCYNnwNroZdHZLbzM1GAc7fyoS5Qoo1sDQUzid1
         bFpKHd+Fw5zuV2JCpauWdmLGknY0/3wZlX2Fl5dATGfNrYNazDRbOxIZZrMFxfF4OGiT
         Caqt62LJEX1oqzX8b0WuHRTO+qImq7jdL0b3xziUB4Q4M4IQfWB4IYDtWYGuLBglroQV
         MsmA==
Received: by 10.43.124.130 with SMTP id go2mr51902895icc.8.1357757001107; Wed,
 09 Jan 2013 10:43:21 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Wed, 9 Jan 2013 10:43:20 -0800 (PST)
In-Reply-To: <20130109170119.GA5332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213078>

On Wed, Jan 9, 2013 at 9:01 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 09, 2013 at 12:16:13AM -0800, Martin von Zweigbergk wrote:
>
>> "git reset [--mixed]" without --quiet refreshes the index in order to
>> display the "Unstaged changes after reset". When --quiet is given,
>> that output is suppressed, removing the need to refresh the index.
>> Other porcelain commands that care about a refreshed index should
>> already be refreshing it, so running e.g. "git reset -q && git diff"
>> is still safe.
>
> Hmm. But "git reset -q && git diff-files" would not be?

Right. Actually, "git reset -q && git diff" was perhaps not a good
example, because its analogous plumbing command would be "git reset -q
&& git diff-files -p", which is also safe. But, as you say, "git reset
-q && git diff-files" (without -p) might list files for which only the
stat information has changed.

> We have never been very clear about which commands refresh the index.

Yes, git-reset's documentation doesn't mention it.

> Since "reset" is about manipulating the index, I'd expect it to be
> refreshed afterwards. On the other hand, since we have never guaranteed
> anything, perhaps a careful script should always use "git update-index
> --refresh".

Since "git diff-files" is a plumbing command, users of it to a
hopefully a bit more careful than regular users, but you never know.

> I would not be too surprised if some of our own scripts are
> not that careful, though.

I didn't find any, but I might have missed something.

Regardless, this patch was tangential. The goal of this series can be
achieved independently of this patch, so if it's too risky, we can
drop easily drop it.

Also, even though it does make "git reset -q" faster, I'm not sure how
important that is in practice. Most use cases would probably refresh
the index afterwards anyway. In such cases, the improvement on warm
cache would still be there, but the relative improvement in the cold
cache case would be pretty much gone (since the entire tree would be
stat'ed by the following refresh anyway).


Martin
