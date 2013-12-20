From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option parsing
Date: Fri, 20 Dec 2013 09:46:41 +0100
Message-ID: <CAP8UFD1Otpm209EGL0XWS5sCDXev9HqZT2BZ9+Sk285J-sZ-yg@mail.gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-3-git-send-email-pclouds@gmail.com>
	<52B3E8D4.1030805@viscovery.net>
	<20131220070449.GA29717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 20 09:46:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtvjL-0005S7-CE
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 09:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab3LTIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 03:46:43 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61971 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3LTIqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 03:46:42 -0500
Received: by mail-vc0-f177.google.com with SMTP id hq11so1257975vcb.36
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 00:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kfPOb9wLFAEVgbdwg1sto4ORq/QruLJc/pvPFacS4PU=;
        b=Rgq6Sn5BL3h2o2mCbe6uhEMQMXrPTJAknFDadUadLjQfA85G5wYGo7mPCd3HH+7J3c
         hzyI0xfvFnsjmZcqOmzObsa8sFzCwd9Cit9KsX94CRFZG2Wr7ap+yy/ulnKkz6GYcYwg
         8YUUJF2dR/pKSuWRVby3DZT5SaJsoHxIjkdU7t7NoodoXfQL7EczAaiKeRIOU/lRwTla
         p0kRtjy6S/uTYnrId76TsqralQ4kGjREhp2L0taKwVoHxQ+11/4I8KQRRHIa4XXiDsHG
         2BAN0elFJ1hYhDc+CyYGpN86fMI5xvYd8Z0HRQUAnrKG1NJ0bOA93oWAl6h4xhkVc0+S
         SE0w==
X-Received: by 10.220.184.70 with SMTP id cj6mr635812vcb.23.1387529201583;
 Fri, 20 Dec 2013 00:46:41 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Fri, 20 Dec 2013 00:46:41 -0800 (PST)
In-Reply-To: <20131220070449.GA29717@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239565>

On Fri, Dec 20, 2013 at 8:04 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 20, 2013 at 07:51:00AM +0100, Johannes Sixt wrote:
>
>> >     for (i = 1; i < argc && *argv[i] == '-'; i++) {
>> >             const char *arg = argv[i];
>> > +           const char *optarg;
>> >
>> > -           if (starts_with(arg, "--upload-pack=")) {
>> > -                   args.uploadpack = arg + 14;
>> > +           if ((optarg = skip_prefix(arg, "--upload-pack=")) != NULL) {
>> > +                   args.uploadpack = optarg;
>>
>> Quite frankly, I do not think this is an improvement. The old code is
>> *MUCH* easier to understand because "starts_with" is clearly a predicate
>> that is either true or false, but the code with "skip_prefix" is much
>> heavier on the eye with its extra level of parenthesis. That it removes a
>> hard-coded constant does not count much IMHO because it is very clear
>> where the value comes from.
>
> Yeah, I agree that is unfortunate.

I agree too.

> Maybe we could have the best of both
> worlds, like:
>
>   if (starts_with(arg, "--upload-pack=", &optarg))
>           ... use optarg ...
>
> Probably we do not want to call it just "starts_with", as quite a few
> callers to do not care about what comes next, and would just pass NULL.
> I cannot seem to think of a good name, though, as the "with" means that
> obvious things like "starts_with_value" naturally parse as a single
> (nonsensical) sentence.  Something like "parse_prefix" would work, but
> it is not as clearly a predicate as "starts_with" (but we have at least
> gotten rid of the extra parentheses).
>
> Elsewhere in the thread, the concept was discussed of returning the full
> string to mean "did not match", which makes some other idioms simpler
> (but IMHO makes the simple cases like this even harder to read). My
> proposal splits the "start of string" out parameter from the boolean
> return, so it handles both cases naturally:
>
>   /* here we care if we saw the prefix, as above */
>   if (parse_prefix(foo, prefix, &the_rest))
>       ...
>
>   /*
>    * and here we do not care, and just want to optionally strip the
>    * prefix, and take the full value otherwise; we just have to ignore
>    * the return value in this case.
>    */
>   parse_prefix(foo, prefix, &foo);

Yeah, I agree that the function signature you suggest is better, but I
like the "skip_prefix" name better.
Or perhaps "remove_prefix"?

Thanks,
Christian.
