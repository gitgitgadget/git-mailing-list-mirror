From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Wed, 29 Sep 2010 09:03:35 +0200
Message-ID: <4CA2E4C7.305@drmicha.warpmail.net>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com> <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net> <20100929051640.GA26324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 09:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0qhP-0004Xd-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0I2HD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:03:26 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52679 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602Ab0I2HD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 03:03:26 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 515AA7DC;
	Wed, 29 Sep 2010 03:03:25 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Sep 2010 03:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gj74PRUojposbrSjCnP2A1VG2KM=; b=I72o0cz/qlI1WIo3xo4XmBwwP7AjS0+rU1xv6K5x/YkjAXJnDqZ18vu6oZxiHN/Uq1wjfZ7/t+iz04cwCsdd3s9+msE0s03odgMAFi8vlv3vKiOntB0rs2hVcSacL/wdUKxP8cNVQmWFp5CeXo/349YTwmFCJI3YcaKew69R7cI=
X-Sasl-enc: BOxziAOoc2y1rd/65PHdw4KzFyKDN4p2WMoxsJouOTKt 1285743805
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1FE25406813;
	Wed, 29 Sep 2010 03:03:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20100929051640.GA26324@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157537>

Jeff King venit, vidit, dixit 29.09.2010 07:16:
> On Tue, Sep 28, 2010 at 10:38:04PM +0200, Michael J Gruber wrote:
> 
>> +help:
>> +	@awk '/^# Help:/ { l=substr($$0,8); \
>> +		getline; \
>> +		j=index(l,":"); \
>> +		print substr(l,1,j-1), substr($$0,1,index($$0,":")), substr(l,j+2); \
>> +		}' <Makefile | sort | while read category target text; \
>> +	do \
>> +		test "$$category" = "$$currcat" || printf "$$category targets:\n"; \
>> +		currcat="$$category"; \
>> +		printf "    %-20s%s\n" "$$target" "$$text"; \
>> +	done
> 
> Surely this is why we have perl?

I don't speak perl.

Honestly, this is slowly going on my nerves. Maybe it's because I'm
reading too many "can't we do it this way" responses in one go and
without being coffeinated, and without seeing how "different" is better.
[I've been heeding all advise on portability and readability, as you can
see.]

So far we've been using neither awk nor perl in the Makefile, but sed.

> help:
> 	@perl -n0777 \
> 	  -e 'push @{$$h{$$1}}, [$$3, $$2] while /^# Help: (.*?): (.*)\n(.*?):/mg;' \

On top of everything else, you're even slashing mg! (See, I'm less
grumpy already...)

> 	  -e 'for (sort keys(%h)) {' \
> 	  -e '  print "$$_:\n";' \
> 	  -e '  printf("    %-20s%s\n", @$$_) for (@{$$h{$$_}});' \
> 	  -e '}' Makefile
> 

How portable are the regexps and the array/dictionary push?

> Note that mine will actually print the targets in a heading in the order
> in which they appear in the Makefile, which I consider slightly more
> useful (especially in that we can tweak the order easily).

I don't think Makefile order would be useful. If you know exactly what
you're looking for you need no sorting, you can just search for that
term. (I would do a 'grep -A20 "^target:" Makefile' or hit "/^target" in
my vim but I'm sure there's a different way of doing it in perl...)

If you're trying to find your way around you guess a generic term and
look for that, and that's easier to do when the categories are sorted
alphabetically.

Michael
