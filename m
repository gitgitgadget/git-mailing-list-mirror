From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Fri, 11 Jul 2014 18:43:18 +0900
Message-ID: <CAFT+Tg_Zkim8DJzdKHa5d7ibN3Za-fftd9m-cZDo3rizLdQ=xg@mail.gmail.com>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
	<20140709051040.GB2318@sigill.intra.peff.net>
	<CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com>
	<20140709061853.GA6731@sigill.intra.peff.net>
	<alpine.DEB.2.00.1407091142030.22132@ds9.cixit.se>
	<20140710201034.GB15615@sigill.intra.peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:43:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5XMV-0002Kr-6y
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 11:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbaGKJnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 05:43:21 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:46540 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaGKJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 05:43:19 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so795137iga.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CQNbZx1boI0l9g7QezMIs3OXzyVL78FBC11sFgHQBz8=;
        b=RIIGqR3UH2CLGgKjX29no4E6nO3SzXI6jMI/ZUKfp2/ZvFkUQf8bRIEXXJDeMQCDZe
         h5LNbdM+9Ym3+14jFT3JKTY28aUFs8QwqH1vSu1AgY6H4bJguvtqqtvgqvAWODWKs95/
         5TPfBBnB20i+dlrrRKL/jXG4i4002KUaGm3Y/hqi0hjeco5Yb3i0L2Ljq9zQWOp13fCi
         i74oqsJV6hz2cRzXoGNvE+nQ6qHZKGNWHqJj+VG8VA5ZffAUrfNKM/42G8icTWG0CWHr
         dsGGwjEvdYYPBYXvs8g9QONyN3rL0lRDLICjlUevNBQmSwiUvI3r6t03VqUmHGVCD0At
         4BvQ==
X-Received: by 10.43.53.199 with SMTP id vr7mr3233437icb.70.1405071798877;
 Fri, 11 Jul 2014 02:43:18 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Fri, 11 Jul 2014 02:43:18 -0700 (PDT)
In-Reply-To: <20140710201034.GB15615@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253267>

2014-07-11 5:10 GMT+09:00 Jeff King <peff@peff.net>:
> On Wed, Jul 09, 2014 at 11:46:14AM +0100, Peter Krefting wrote:
>
>> Jeff King:
>>
>> >I did some digging, and I think the public API is setlocale with a NULL
>> >parameter, like:
>> >
>> > printf("%s\n", setlocale(LC_MESSAGES, NULL));
>> >
>> >That still will end up like "en_US.UTF-8", though;
>>
>> And it only yields the highest-priority language, I think.
>
> I wasn't clear on whether POSIX locale variables actually supported
> multiple languages with priorities. I have never seen that, though the
> original commit message indicated that LANGUAGE=x:y was a thing (I
> wasn't sure if that was a made-up thing, or something that libc actually
> supported).
>
>> Debian's website has a nice writeup on the subject:
>> http://www.debian.org/intro/cn#howtoset
>
> That seems to be about language settings in browsers, which are a much
> richer set of preferences than POSIX locales (I think).
>
> It would not be wrong to have that level of configuration for git's http
> requests, but I do not know if it is worth the effort. Mapping the
> user's gettext locale into an accept-language header seems like a
> straightforward way to communicate to the other side what the client is
> using to show errors (so that errors coming from the server can match).

Thanks for you advice. I'll write a path to use both of
setlocale(LC_MESSAGES, NULL) and getenv("LANGUAGE") to get the user's
preferred language. setlocale(LC_MESSAGES, NULL) is quite nice way
because it takes LC_ALL, LC_MESSAGES and LANG into account, but not
LANGUAGE. I think we should take also LANGUAGE into account as gettext
does. [1]

[1]: http://www.gnu.org/software/gettext/manual/gettext.html#Locale-Environment-Variables
