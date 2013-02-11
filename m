From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 18:21:58 +0100
Message-ID: <CABPQNSYtvXED_uj6m02N1-RWEdz3iMUUXUaNZquzy8GqQ2BnLw@mail.gmail.com>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
 <7v7gmeok2e.fsf@alter.siamese.dyndns.org> <20130211171957.GG16402@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x5r-00018Z-NG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189Ab3BKRWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:22:40 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:49164 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004Ab3BKRWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:22:40 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so6680863iaz.30
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=566Dp3Gbet0FP16UmyEI31J7yTmF5SJxO7IGWj4CPIg=;
        b=L9SCe6vwZYJrjV3zmvOgVccOTS/rSEf6LK7oHpbnkhQh2RoMC1lY8tJRa6arjJCXCw
         ZZQ+yFLL9rgUfLc7cwbjR9JoPIc2+rx2P58GiWBaFvDmpsnOU41qsCurmIFXvul0lExd
         wd/Hi+l5Fkd5lI3xaY99EF7RWypDRxIHvE9f/np5YG2kMsnOvShr5nFrjCYNpNYbCsUO
         QFGvmYnCOhJDlBFkbQEmCL2JYnfQTH4IgZpX6t02jlVl3APdc+dduwf3JDHpe+MTp4mE
         4oOyeQnkX0tmJw2JqhFdvIacUesOgFUOw8AOxhTGOgNn8HlDLHT8WAVGfJuyHeLY84Cj
         uS6A==
X-Received: by 10.50.151.176 with SMTP id ur16mr13021373igb.30.1360603359542;
 Mon, 11 Feb 2013 09:22:39 -0800 (PST)
Received: by 10.64.164.139 with HTTP; Mon, 11 Feb 2013 09:21:58 -0800 (PST)
In-Reply-To: <20130211171957.GG16402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216064>

On Mon, Feb 11, 2013 at 6:19 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 11, 2013 at 09:07:53AM -0800, Junio C Hamano wrote:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>> > However, since git only looks at one byte at the time for
>> > short-options, it ends up reporting a partial UTF-8 sequence
>> > in such cases, leading to corruption of the output.
>>
>> Isn't it a workable, easier and more robust alternative to punt and
>> use the entire ctx.argv[0] as unrecognized?
>
> Yes, but it regresses the usability:
>
>   [before]
>   $ git foobar -qrxs
>   unknown switch: x
>
>   [after]
>   $ git foobar -qrxs
>   unknown switch: -qrxs
>
> One is much more informative than the other, and you are punishing the
> common ascii case for the extremely uncommon case of utf-8. Maybe:
>
>   if (isascii(*ctx.opt))
>           error("unknown option `%c'", *ctx.opt);
>   else
>           error("unknown multi-byte short option in string: `%s'", ctx.argv[0]);
>
> which only kicks in in the uncommon case (and extends the error message
> to make it more clear why we are showing the whole string).

Yes. This is IMO a much better approach, and it doesn't involve trying
to figure out what encoding the string is. Thanks!
