From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 17:43:37 -0400
Message-ID: <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
	<CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
	<CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
	<20130312194306.GE2317@serenity.lan>
	<7vfw0073pm.fsf@alter.siamese.dyndns.org>
	<20130312210630.GF2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 12 22:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFWzN-0000EJ-T2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 22:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615Ab3CLVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 17:43:39 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35691 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933551Ab3CLVni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 17:43:38 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so303521pbc.30
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zkBkewkiNpqc0SK+3kO3nm/X53PTy4zfDPEJKaiw93Q=;
        b=GJavS+Mx7A9uALBjScqZD/u/Gvqlo8Dk0t2+KgIv/+C/cAEbkIzCm6GV5dG/bQe8NS
         5MCzG8DGG4BMS8Pgl1ZudVQGGSVFYU/aixXCrAl0hHW88oxXyggzoEoDB+Y3VlE5hcap
         NCx56BMpCCzg2+dkV/YegVK1KiukQfXgukbMtUu8q63xr2AJd3U6FNlniF2FBDqRYkVH
         9tzu3jNZbfKsSHCKSoZO0axaxubpOtoVxMNRggriXzeZCs2lFoJRH/1urZEcl6kvcznx
         rsglrtbtFmj4HuMZ61UhuhLNU64YHfrSdRf9cXzxKktEgLoM60YeimB7WR6K35pS3S3h
         /d3g==
X-Received: by 10.68.194.8 with SMTP id hs8mr17993675pbc.44.1363124617628;
 Tue, 12 Mar 2013 14:43:37 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Tue, 12 Mar 2013 14:43:37 -0700 (PDT)
In-Reply-To: <20130312210630.GF2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217999>

On Tue, Mar 12, 2013 at 5:06 PM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 12, 2013 at 01:39:17PM -0700, Junio C Hamano wrote:
>>
>> What is the situation when you do not want symbolic links?
>
> When you're not comparing the working tree.
>
> If we can reliably say "the RHS is the working tree" then it could be
> unconditional, but I haven't thought about how to do that - I can't see
> a particularly easy way to check for that;

Agreed. From what I can see, the only form of the diff options that
compares against the working tree is

    git difftool -d [--options] <commit> [--] [<path>...]

At first, I thought that the following cases were also working tree
cases, but actually they use the HEAD commit.

    git difftool -d commit1..
    git difftool -d commit1...

> is it sufficient to say
> "there is no more than one non-option to the left of '--' and '--cached'
> is not among the options"?

An alternative approach would be to reuse git-diff's option parsing
and make it tell git-difftool when git-diff sees the working tree
case. At this point, I haven't seen an obvious place in the source
where git-diff makes that choice, but if someone could point me in the
right direction, I think I'd actually prefer that approach. What do
you think?

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
