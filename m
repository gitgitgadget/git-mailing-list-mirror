From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Thu, 07 Apr 2011 13:09:20 +0200
Message-ID: <4D9D9B60.4030404@drmicha.warpmail.net>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org> <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com> <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 11:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7lDW-0004tK-KG
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 11:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab1DGJJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 05:09:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59066 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171Ab1DGJJY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 05:09:24 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0D63020945;
	Thu,  7 Apr 2011 05:09:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 07 Apr 2011 05:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hUsY6UliMMYyoN3kFEOGcSXf8aM=; b=IkkOiY1rsiYCJhkxSedvO+6QMRs6dvR74UNkp7ZE9asN8dsq/LuhcF9tzPk/WOKjQX1yHzxgku/QJyVbV+NO0A4cU0hHbAzbZ61nwFj0NeF3kypaMNDvyrLyi2yl83leV/oHgwYSwzbLFJrr0Hmy10VI01SKJN8QBC3fkVRL1z4=
X-Sasl-enc: LZmk+BFg5ak7rxcilNke7GrTm0rVRDuJshGP8PiYlnZN 1302167362
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1B7DD405511;
	Thu,  7 Apr 2011 05:09:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vfwpvjobl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171048>

Junio C Hamano venit, vidit, dixit 06.04.2011 19:13:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> 2011/4/6 Junio C Hamano <gitster@pobox.com>:
>>
>> I have started working on the conversion, but it may take a while
>> because in many places pathspec is still assumed a prefix (and handled
>> separately, which is not good for negative pathspec). Fundamental
>> support for magic pathspec and "top dir" notation probably do not need
>> get_pathspec() converted to struct pathspec.
> 
> I think you meant to say "If we only want to have 'top dir' magic,
> fundamental support and get_pathspec() conversion are unnecessary", and I
> agree 100%.
> 
> I am actually tempted to add Michael's hack to get_pathspec() only to
> support the "from the top" (and error out with any other magic---as the
> approach without a proper restructuring will not work with anything but
> that particular magic), to get the "add -u" topic going, and let you (or
> other people who are interested in the pathspec rationalization) later fix
> it up just a small part of existing issues.
> 

Junio, we're in rc phase ;)

> The extensible syntax I have in mind (we only parse in get_pathspec() in
> such a tentative version but anything other than the :/ will error out) is
> to use:
> 
>  (1) Colon, a run of selected non-alpha (i.e. magic signature), an
>      optional colon to terminate the magic signature, followed by the
>      path, e.g.
> 
>      - ":/hello.c" is a path from the top.
> 
>      - ":!/hello.c" is path from the top but no globbing.
> 
>      - ":/!hello.c" is the same as above.
> 
>      - ":/::hello.c" is ":hello.c" from the top, the second colon
>        terminates the magic signature and allows the funny file with a
>        leading colon to be named.
> 
>      - "::hello.c" does not have any magic, is the same as "hello.c".
> 
>  (2) Colon, open parenthesis, a comma separated list of words to name
>      magic, close parenthesis, followed by the path, e.g. these are the
>      long-hand counterparts to the examples in (1)
> 
>      - ":(top)hello.c"
>      - ":(top,noglob)hello.c"
>      - ":(noglob,top)hello.c"
>      - ":(noglob,top):hello.c"
>      - ":()hello.c"
> 

Do we need the parentheses? I guess we need them to have the magic start
with a non-alpha, otherwise we could do with ":top,noglob:hello.c"
(which I like but breaks those with a file named ":top:hello.c").

What about these:

:/(noglob)hello.c
:(top)!hello.c

I.e. do we allow combinations?

Do we need the the second colon at all then? I.e. we can declare ":"
non-magic after seeing it once so that ":(top):hello.c" would be
":hello.c" at top.

> At this point, I am not interested in building the repertoire of magic
> yet, but would want to nail a syntax that is
> 
>  - concise in common cases (e.g. "from the top, not a funny name" is ':/'
>    followed by the name);
>  - is extensible in the future; and
>  - easy to parse and error out on magic we do not understand.
> 

- and does dot break users with files named xyz.

Spelling out xyz would already nail down the syntax quite a bit. It
seems you accept to break people with files named ":(top)hello.c" but
not those with files named ":top:hello.c". Which is OK if it's a
conscious decision, of course.

Michael
