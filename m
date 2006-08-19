From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] adding support for md5
Date: Sat, 19 Aug 2006 04:35:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608190416370.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
 <9e4733910608181452x65ca937aqbfde55caa98ff6da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 04:36:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEGgr-0000Xa-6t
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 04:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWHSCf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 22:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWHSCf5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 22:35:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:58596 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750754AbWHSCf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 22:35:57 -0400
Received: (qmail invoked by alias); 19 Aug 2006 02:35:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 19 Aug 2006 04:35:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608181452x65ca937aqbfde55caa98ff6da@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25705>

Hi,

On Fri, 18 Aug 2006, Jon Smirl wrote:

> If I have two repositories each with 100M objects in them and I merge 
> them, what is the probability of a object id collision with MD5 (128b) 
> versus SHA1 (160b)?

Assuming a uniform distribution of the hashes over our data, this is the 
birthday problem:

http://mathworld.wolfram.com/BirthdayProblem.html

(In short, given a number of days in the year, how many people do I need 
to pick randomly until at least two of them have the same birthday?)

In our case, we want to know how many objects we need in order to probably 
have a clash in 2^128 (approx. 3.4e38) and 2^160 (approx. 1.5e48) hashes, 
respectively.

Mathworld tells us that a good approximation of the probability is

p = 1 - (1-n/(2d))^(n-1)

where n is the number of objects, and d is the total number of hashes. If 
you have 100M = 1e5 objects, you probably want the probability of a clash 
below 1/1e5 = 1e-5, so let's take 1e-10. Assuming n is way lower than d, 
we can approximate

p = 1 - (1 - (n - 1 over 1) * n/(2d)) = n(n-1)/2d

and therefore (approximately)

n = sqrt(2pd)

which amounts to 2.6e14 in the case of a 128-bit hash, and 1.7e19 in the 
case of a 160-bit hash, both well beyond your 100M objects. BTW the 
addressable space of a 64-bit processor is about 1.9e19.

If you want to know the probability of a clash, you can use the same 
approximation:

For 100M objects: p = 1.5e-59 for 128-bit, and p = 3.3e-69 for 160-bit. 
This is so low as to be incomprehensible.

Remember that all these approximations are really crude, so do not rely on 
the precise numbers. But they'll give you good ballpark figures (if I did 
not make a mistake...).

Hth,
Dscho
