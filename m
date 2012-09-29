From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Sat, 29 Sep 2012 13:13:32 +0700
Message-ID: <CACsJy8A1UroqCezJFjqOqBQg+puX=jc1Q-CMSB4f=CHULY=OyA@mail.gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org> <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com> <20120929053013.GB3330@sigill.intra.peff.net>
 <7vpq55idbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqKR-0001id-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab2I2GOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:14:05 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50699 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2I2GOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 02:14:03 -0400
Received: by ieak13 with SMTP id k13so8978370iea.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=InnTeJvJ7illfMoFyrROuiFUXHmSln4JKJp/4rEi8ig=;
        b=Z+WmgDAyrnrQUHRGA1/ncD/dzdhcFOaZIY+3nEFqBu7VaiL48qOwv3onyx3OoH2J7R
         txuk24GFWomfZeSwqsM7eXjlzBjEFaw58/qoYUkWj0bWyFNOflIKmENH877/OrLF6A9O
         JzLU/dUOYT0PYChzzgN+oiVC326lDloeqxnLVH4FrS97vSmv4Zid8HVeBWCFhRe1oo46
         MUE3VZZZYyRAeLxirfuTkvGuXIPWVKT8KTgawOxQ5M/WorskeYdNe66Y40ZRZmbjsIoU
         sKrmx4cUvKEX6cklCuYoVcPn5bhPtjaIupgyltCZwzIhOrdUwzMbEEvpLAvqG06r/x7e
         WCuQ==
Received: by 10.50.154.225 with SMTP id vr1mr697430igb.26.1348899242648; Fri,
 28 Sep 2012 23:14:02 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Fri, 28 Sep 2012 23:13:32 -0700 (PDT)
In-Reply-To: <7vpq55idbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206632>

On Sat, Sep 29, 2012 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I like how callers not doing a reflog walk do not have to pay the price
>> to do the extra allocating. We could further limit it to only when
>> --grep-reflog is in effect, but I guess that would mean wading through
>> grep_filter's patterns, since it could be buried amidst ANDs and ORs?
>>
>> One alternative would be to set a bit in the grep_opt when we call
>> append_header_grep_pattern. It feels a bit like a layering violation,
>> though. I guess the bit could also go into rev_info. It may not even be
>> a measurable slowdown, though. Premature optimization and all that.
>
> I do not think it is a layering violation.  compile_grep_exp()
> should be aware of the short-cut possibilities and your "our
> expression is interested in reflog so we need to read it" is very
> similar in spirit to the existing opt->extended bit.
>
> It will obviously allow us to avoid reading reflog information
> unnecessarily here.  I think it makes perfect sense.

reflog, in terms of both the number of commits and message length, is
usually short enough that slowdown does not really show, especially
when used with git-log, an interactive command.

Without the changes:

$ time git log -g --grep . >/dev/null

real    0m0.480s
user    0m0.451s
sys     0m0.025s

With the changes:

$ time ./git log -g --grep . >/dev/null

real    0m0.490s
user    0m0.471s
sys     0m0.018s

> We may also want to flag the use of the --grep-reflog option when
> the --walk-reflogs option is not in effect in setup_revisions() as
> an error, or something.

That's why I put "Ignored unless --walk-reflogs is given" in the
document. But an error would be fine too. I suppose an error is
preferable in case users do not read document carefully?
-- 
Duy
