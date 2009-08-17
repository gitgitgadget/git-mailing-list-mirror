From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-config: Parse config files leniently
Date: Mon, 17 Aug 2009 20:47:20 +0200
Message-ID: <4A89A5B8.9040405@drmicha.warpmail.net>
References: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com> <a812f567b4541ce55e9c60037a047488a0893c36.1250262273.git.git@drmicha.warpmail.net> <7veirejhqq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7Fg-0004VZ-6C
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZHQSrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZHQSrh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:47:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48590 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752509AbZHQSrf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 14:47:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8CD495198E;
	Mon, 17 Aug 2009 14:47:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 Aug 2009 14:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=k5Dt77XP9d/CFfFcNrjGduGJz90=; b=Whhrt4wVuvltkFaHMQcwVUMowFPq0ZOzcgEFgscp+qN+GST9z4h4lD1H3j5zNgCvZMKMXQ/9dnOhLHlvylMr7SdO2o2rgMn2Qe8EUrxVGFY7V15AuG28hj0KIiM5XzGvet0BLhRtgTnIWuseK07kGYKhi4lpKZmQBmTTjnAlFnU=
X-Sasl-enc: dRtYwJ2Eg69CCKkiqsK3QletUvzg0RWr+GzclTOA+xBr 1250534855
Received: from localhost.localdomain (p5DCC1853.dip0.t-ipconnect.de [93.204.24.83])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9A08191C7;
	Mon, 17 Aug 2009 14:47:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090814 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <7veirejhqq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126252>

Junio C Hamano venit, vidit, dixit 14.08.2009 21:52:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, git config dies as soon as there is a parsing error. This is
>> especially unfortunate in case a user tries to correct config mistakes
>> using git config -e.
>>
>> Instead, issue a warning only and treat the rest of the line as a
>> comment (ignore it). This benefits not only git config -e users.
> 
> ... a broken sentence in the middle?  I would have expected the "not only"
> followed by "but also"; the question is "but also what?"

I don't see any broken sentence here. "Benefit" is a verb as well as a noun.

"not only git config -e users" but also everyone else: Unparseable lines
are ignored, the rest is parsed.

> 
> Hopefully the benefit is not that it now allows all the other commands to
> cause unspecified types of damage to the repository by following iffy
> settings obtained from a broken configuration file.

The only possible problem that I see is when a section heading is not
parsed because of a forgotten "[", say, and the following settings are
put in the wrong section because of that.

>> Reported-by: David Reitter <david.reitter@gmail.com>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
>> Test had to be adjusted as well.
> 
> The change to the test demonstrates the issue rather well.  The check()
> shell function does not check the exit value from "git config --get", but
> in a real script that cares to check and stop on error, this change will
> now let the script go on, leaving the breakage unnoticed.  I suspect
> command implemented in C, that call git_config(), will also have the same
> issue, and I cannot convince myself this is a good change in general,
> outside the scope of helping "git config -e".
> 
> But I may be being overly cautious.

My first version had the lenient mode for "git config -e" only, which
required a new global int (or, alternatively, changing all callers).

One could issue a warning and return -1 rather than success. I'm afraid
git_config() callers don't check return values but rely on git_config()
dieing in case there are parsing problems.

> 
> By the way, why did you have to change s/echo/printf/?  Can't you give two
> lines in a single argument without "\n" escape?

Because "printf" is more portable then "echo -e". At least I hope so ;)
[ One could use a "here document", of course. Is that preferable? ]

Michael
