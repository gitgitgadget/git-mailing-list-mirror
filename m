From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Sat, 7 Feb 2015 23:19:31 +0100
Message-ID: <CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
References: <20150207131112.394.30858.chriscool@tuxfamily.org>
	<xmqq386hcw33.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 23:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKDiz-0001vY-B8
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 23:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750AbbBGWTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 17:19:33 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37870 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183AbbBGWTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 17:19:32 -0500
Received: by iebtr6 with SMTP id tr6so9002937ieb.4
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nTysjS9oRWtRAYg5U/aPVFG86r/LwdPiRgDVa59Xt/Q=;
        b=DiMIvx/XNLsisUWod1HlMm5yCORGNzVV8dJxvSiIwsUMlWOO8ChZy1XWDhqEZmExKo
         hjyzBemekS7eqFlruuyw4vh7SXs2dwOJIDJvb1gstDI01HprD22iS31rAAZS+GBZIucI
         oSBhfMbLartD10AlLJi4hS4m4SIzQYkTOK7Ew3mUdbVPKTM5++NccOlwSBgMkqSAKVTS
         DCDwrJKhHb7BpcupSo26JI/1ciQRiG5j3T//hveztx37kbWrt/L6amtM8juilk+L2Ngw
         YkLeNUxoO3p6QbQ6xL1OCRK2eytfjlOPzs0oqrBW4x1dhMbb0g7E4WJKYxWQ0wUAhwVq
         b5Wg==
X-Received: by 10.43.92.9 with SMTP id bo9mr19402844icc.54.1423347571913; Sat,
 07 Feb 2015 14:19:31 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Sat, 7 Feb 2015 14:19:31 -0800 (PST)
In-Reply-To: <xmqq386hcw33.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263458>

On Sat, Feb 7, 2015 at 9:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> This way people who always want trimed trailers
>> don't need to specify it on the command line.
>
> I sense that print_all() that cares about trimming illustrate a
> design mistake in the original code structure.  Why isn't the entire
> program structured like this instead?
>
>     - read input and split that into three parts:
>
>         struct {
>                 struct strbuf messsage_proper;
>
>                 struct trailers {
>                         int nr, alloc;
>                         struct strbuf *array_of_trailers[];
>                 } trailers;
>
>                 struct strbuf lines_after_trailers;
>         };

It is not designed like this because you only asked me to design it
like this after the facts, when there was another email thread about
conflicts blocks and one function you created could be used by the
trailer code too.

If you had asked this from the beginning I would certainly have done
it more like this (though I think the "struct trailers" part is too
simplistic). Rearchitecturing the code now would bring only small
performance improvements and a lot of code churn. And the performance
is not needed anyway if the code is not used in the first place, so
I'd rather first make sure that the code can be used.

I think that very few new features are now needed to make it possible
to use the code in other commands like commit, format-patch, am, etc,
but this patch implements one of the needed features.

>     - do "trailer stuff" by calling a central helper that does
>       "trailer stuff" a pointer to the middle, trailers, struct.
>
>       - when the trailer becomes a reusable subsystem, this central
>         helper will become the primary entry point to the API.
>
>       - "trailer stuff" will include adding new ones, removing
>         existing ones, and rewriting lines.  What you do in the
>         current process_command_line_args() and
>         process_trailers_lists() [*1*] would come here.
>
>     - write out the result, given the outermost struct.  This will
>       become another entry point in the API.
>
> Structured that way, callers will supply that outermost structure,
> and can trust that the trailers subsystem will not molest
> message_proper or lines_after_trailers part.

I don't think it is a big improvement because it is easy to see that
the current code doesn't molest the part before and after the
trailers.

> They can even process
> the parts that the trailer subsystem would not touch, e.g. running
> stripspace to the text in message_proper.

That could be worth the rearchitecturing if people really wanted that,
but I think for now more people have been interested in having ways to
change the trailer part, so I prefer to work on this first.

> Viewed that way, it would be clear that "strip empty ones" should be
> a new feature in the "trailer stuff", not just "filter out only
> during the output phase".  Having it in the output phase does not
> feel that the labor/responsibility is split in the right way.

My opinion is that having it in the output phase is best.

> Another problem I have with "filter out during the output phase"
> comes from the semantics/correctness in the resulting code, and I
> suspect that it would need to be done a lot earlier, before you
> allow the logic such as "if I have X, do this, but if there is no X,
> do this other thing".  If you have an X that is empty in the input,
> trimming that before such logic kicks in and trimming that in the
> final output phase would give different results, and I think the
> latter would give a less intuitive result.

I think it is much better in the output phase because it is very
natural for some projects to have a template message with empty
trailers like this:

Signed-off-by:
Reviewed-by:

Such a template message can for example remind contributors to the
project that they need to sign off their work and that they need to
have it reviewed by at least one person, and that to make it simpler
for everyone to review patches, the "Signed-off-by" trailers should
come before the "Reviewed-by" trailers in the commit message.

In this case, if you trim before you process command line trailers,
then, when you process some command line trailers that add sign offs,
the meaning of "where=after" cannot be based any more on the existing
empty "Signed-off-by:" in the template message.

> As this is the second time I have to point out that the data
> structure used by the current code to hold the trailers and other
> stuff to work on smells fishy, I would seriously consider cleaning
> up the existing code to make it easier to allow us to later create
> a reusable API and "trailer subsystem" out of it, before piling new
> features on top of it, if I were you.

I am not so sure that it would make it easier to allow us to later
create a reusable API and "trailer subsystem" out of it.
It is very difficult to predict what will be really needed in the
future and it is not clear at all to me that the current API is not
reusable.

If it was so clear that an API similar as what you describe was so
important, why didn't you point out that at the very beginning when I
started working on git interpret-trailers? And it's not like you
didn't have time to think about what I was working on as we discussed
many other aspects of the design and the developement happened over
one year.
