From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Mon, 17 Mar 2014 15:06:02 -0400
Message-ID: <CAPig+cTs23=j_1OsB4FUUb1PZWubhad+XBCa1iEx4jChZE2x4w@mail.gmail.com>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	<8738ijzbue.fsf@thomasrast.ch>
	<20140316020018.GA20019@sigill.intra.peff.net>
	<7v1ty14z8x.fsf@alter.siamese.dyndns.org>
	<7vtxax2v1q.fsf@alter.siamese.dyndns.org>
	<53270FC2.2030701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:06:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcrh-00057K-16
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbaCQTGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:06:05 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:39413 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaCQTGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:06:04 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so5762633yha.30
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mlmto0+E2cZ70uFKmku5/bZe7UdgYAE4KSWFnnHzNyI=;
        b=ElhITKSLcU/xfu3u4MH1I6vjq3sGQgzKtMnR+Io8FUujp9Wvkg9Qprg9plR5vRqb1R
         4/b5aXi8WYtotL5ucPS4k/eP1dGiFC1FfuUpIY6M66v3EBBf5n9kK328m4Y7Tkw6xwaF
         FyVJNrkF2W+XSM5lD6L+APvRvG8WtfLCJIDd36KVb/kwX+tq1Unj4dPvywpGfymJa3UV
         Cr9SQFaBnTolSAfHbFb2ht4LuZaCg+XDfu0LRkH+TSEDwsuFWLJmr5b0LLD6CDTE8NBo
         hCZBH4bUnjbpt5wjDP/iLTU+jeoQFRc51PlDAfMICtR//zgL7LMMalIDqIsmmNw6muSO
         Bq8A==
X-Received: by 10.236.137.8 with SMTP id x8mr12162276yhi.4.1395083162889; Mon,
 17 Mar 2014 12:06:02 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 12:06:02 -0700 (PDT)
In-Reply-To: <53270FC2.2030701@alum.mit.edu>
X-Google-Sender-Auth: aZjmoIS2JKrBHetRHJIycdnn7To
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244266>

On Mon, Mar 17, 2014 at 11:07 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/17/2014 07:33 AM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Would it make sense to go one step further to introduce two macros
>>> to make this kind of screw-up less likely?
> potential callers that I noticed, ALLOC_GROW() was used immediately
> before making space in the array for a new element.  So I suggest
> something more like
>
> +#define MOVE_DOWN(array, nr, at, count)        \
> +       memmove((array) + (at) + (count),               \
> +               (array) + (at),                         \
> +               sizeof((array)[0]) * ((nr) - (at)))

Each time I read these, my brain (for whatever reason) interprets the
names UP and DOWN opposite of the intended meaning, which makes them
confusing. Perhaps INSERT_GAP and CLOSE_GAP would avoid such problems,
and be more consistent with Michael's proposed ALLOC_INSERT_GAP.

> +#define ALLOC_INSERT_GAP(array, nr, at, count, alloc)               \
> +       do {                                                         \
> +               ALLOC_GROW((array), (nr) + (count), (alloc));        \
> +               MOVE_DOWN((array), (nr), (at), (count));             \
> +       } while (0)
>
> Also, count==1 is so frequent that this special case might deserve its
> own macro pair.
>
> I'm not inspired by these macro names, though.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
