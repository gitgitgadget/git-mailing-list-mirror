From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 18:24:30 +0300
Message-ID: <4819E0AE.40602@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 17:25:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jraet-0002YL-Uk
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYEAPYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755809AbYEAPYb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:24:31 -0400
Received: from smtp106.biz.mail.re2.yahoo.com ([206.190.52.175]:31073 "HELO
	smtp106.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755124AbYEAPYb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 11:24:31 -0400
Received: (qmail 63638 invoked from network); 1 May 2008 15:24:29 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp106.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 15:24:29 -0000
X-YMail-OSG: CALUeMkVM1n6SD6V7jQtXhJh4vUox6LwCse47iiJztMilhpHZmUFzsGcOGjLuxLcdCwTwnqXJtLqn795qh8a9x0CNZLiBEbuL2OUR4.BzgRpILds7ebdrRphUOdmSC1y7Yr4P19T9ZrHFmykzvG9Mp5f
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <4819DCF1.7090504@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80919>

Btw, this happened to me in a real use case. I wanted to restructure a 
source tree. So I put it under git and started to happily move things 
around, always committing after a move. I thought that git will 
correctly identify these moves and show me the differences I made after 
(in a separate commit). But it doesn't, and now that I want to prepare a 
summary of the changes I've made, I'm stuck with a huge diff that is 
hard to make sense of.

Ittay

Ittay Dror wrote:
> But it doesn't work across directories :-(.
>
> Try:
> >mkdir foo
> >echo "hello" > foo/A
> >git add foo/A
> >git commit -m 'foo/A'
> >mkdir bar
> >git mv foo/A bar
> >git commit -m 'bar/A'
> >echo "world" >> bar/A
> >git add bar/A
> >git commit -m 'bar/A world'
> >git diff HEAD^^..HEAD^ | cat
> diff --git a/foo/A b/bar/A
> similarity index 100%
> rename from foo/A
> rename to bar/A
> > git diff HEAD^^.. | cat
> diff --git a/bar/A b/bar/A
> new file mode 100644
> index 0000000..94954ab
> --- /dev/null
> +++ b/bar/A
> @@ -0,0 +1,2 @@
> +hello
> +world
> diff --git a/foo/A b/foo/A
> deleted file mode 100644
> index ce01362..0000000
> --- a/foo/A
> +++ /dev/null
> @@ -1 +0,0 @@
> -hello
>
>
>
>
>
> Jeff King wrote:
>> On Thu, May 01, 2008 at 05:10:24PM +0300, Ittay Dror wrote:
>>
>>  
>>> Say I have a file A, I rename to 'B', commit, then change file B 
>>> and  commit. Does 'git diff -M HEAD^^..' detect that? From what I 
>>> see now, it  will show 'B' as new (all of it with '+' prefix in the 
>>> output). Am I right?
>>>     
>>
>> Yes, it should find it, assuming the changes to B leave it recognizable.
>> Try:
>>
>>   mkdir repo && cd repo && git init
>>   cp /usr/share/dict/words A
>>   git add . && git commit -m added
>>   mv A B && git add B && git commit -a -m rename
>>   echo change >>B && git commit -a -m change
>>   git diff -M HEAD^^.. | head -n 7
>>
>> You should see something like:
>>
>>   diff --git a/A b/B
>>   similarity index 99%
>>   rename from A
>>   rename to B
>>   index 8e50f11..6525618 100644
>>   --- a/A
>>   +++ b/B
>>
>> However, note the similarity index. If you change B so much that it
>> doesn't look close to the original A, then the rename is not detected
>> (and intentionally so -- the argument is that it is no longer a rename
>> in that context, but a rewritten file).
>>
>> -Peff
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>   
>

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
