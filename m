From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] git stash pop results in conflict
Date: Wed, 24 Mar 2010 11:34:42 +0100
Message-ID: <4BA9EAC2.4020707@drmicha.warpmail.net>
References: <SNT124-W41E7349234C70B82E8D6BFC4250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 11:37:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuNxx-0005mP-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 11:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0CXKhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 06:37:31 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47288 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800Ab0CXKha (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 06:37:30 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5CA5BE9AFB;
	Wed, 24 Mar 2010 06:37:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 24 Mar 2010 06:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Z1S0xJi1xmXK34mNZzrrtYvCb6Q=; b=BkSXe+mVK3nXIqwRkQeLtowYam16H1C7NoBUAha7fNN0yE7WzB9hUlHirNFvVAnGNn2Z20igmuBYNoU1Eo1wREpP6QYdvJ5tsw2pyGTJrbBKco+Am6ZYxru+T/Qtq57GyUIjHEcDZ0BvUR7I5nFqQOShQw5HrnWCFsBFOkmRPmI=
X-Sasl-enc: iu/3eJ988QmaGCaXw1nrZlO4Cy3P0+U7kiH2JfO+Yue5 1269427050
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C83AF2C1DF;
	Wed, 24 Mar 2010 06:37:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <SNT124-W41E7349234C70B82E8D6BFC4250@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143080>

Tim Mazid venit, vidit, dixit 24.03.2010 03:01:
> 
> Hi,
>  
> I'm not sure if this is a bug or if it should be thus.
>  
> Basically, a 'git stash --keep-index' followed immediately by a 'git stash pop' (no changes made) will result in a conflict.
>  
> Steps to reproduce:
>  
>  
> Put
>  
> "AAA
> BBB
> CCC"
>  
> into file 'test'
>  
> $ git add test
> $ git commit -m "A"
>  
> Append lines
>  
> "DDD
> EEE
> FFF
> GGG"
>  
> into file 'test'
>  
> $ git add -p
>  
> Press 'e' and remove the "FFF" and "GGG" files from the patch, to stage only the "DDD" and "EEE" files.
>  
> $ git stash --keep-index

Right here, git stash show -p shows that the recorded stash is a merge diff:

diff --cc test
index 7b0e998,988cecb..83b9202
--- a/test
+++ b/test
@@@ -1,3 -1,5 +1,7 @@@
  AAA
  BBB
  CCC
+ DDD
+ EEE
++FFF
++GGG

The index still has the following (git diff --staged):

diff --git c/test i/test
index 7b0e998..988cecb 100644
--- c/test
+++ i/test
@@ -1,3 +1,5 @@
 AAA
 BBB
 CCC
+DDD
+EEE

> $ git stash pop
>  
> CONFLICT
>  
>  
> I hope that's clear enough.

git diff shows the conflict:

diff --cc test
index 988cecb,83b9202..0000000
--- i/test
+++ w/test
@@@ -3,3 -3,5 +3,8 @@@ BB
  CCC
  DDD
  EEE
++<<<<<<< Updated upstream
++=======
+ FFF
+ GGG
++>>>>>>> Stashed changes

According to the example in the man page, I would have thought that
committing between save and pop would help, but it produces the same
problem. pop --index doesn't help either. Do you happen to know whether
this used to work?

Michael
