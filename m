From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the difference between `git show branch:file | diff -u
 - file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 17:34:50 +0200
Message-ID: <4E53C89A.9000604@drmicha.warpmail.net>
References: <loom.20110823T091132-107@post.gmane.org>   <4E537AF0.9070604@drmicha.warpmail.net> <1314096731.15017.2.camel@n900.home.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 17:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvt0V-0004Pm-7E
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 17:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab1HWPfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 11:35:00 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53620 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959Ab1HWPex (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 11:34:53 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3C65320AD7;
	Tue, 23 Aug 2011 11:34:52 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 23 Aug 2011 11:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=PeaNkzlz3nvEtE33zv9XIW
	/hTZs=; b=m6bjY9jCdsdmsPRFF04kMtNXt3HxgfoCUpC+36b5uMDC+5OCiLhrMk
	FlfjXcEDrvEe2pLBa8vWwRAj9XiIuYfQa1p+ukSi0zgtQSc3HfR7SX89bQyCHbhs
	cJ2vInfkIszeJLydJyxqBYvM5WFnRb2zA0EJfyxQyKw7PNQ21ImUI=
X-Sasl-enc: +kYVLSzdRqL88ymNVG2N3xR6Vmg8HNVbAMWq5AT/vZK4 1314113691
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B724E90152A;
	Tue, 23 Aug 2011 11:34:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1314096731.15017.2.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179941>

Marat Radchenko venit, vidit, dixit 23.08.2011 12:52:
>> Is that a very large tree or a very slow file system?
> Tree is large (500k files), file system is irrelevant since all time is spend on CPU.
> 
>> Do we enumerate all
>> differing files and only then limit diff output by path??
> 
> Dunno, that's why I am asking why it is so slow.

Well, we have to read the full tree before diffing. But I can't
reproduce the extreme difference which you observed (0.003s vs. 30s),
only a factor of ten or so for a repo with 100k files:

git init
seq 0 100000|while read n ; do echo a > a$n;done
git add .
git commit -m m
echo b > a0

On a ramdisk, I get:

time git diff  > /dev/null

real    0m0.160s
user    0m0.064s
sys     0m0.190s

time git diff -- a0 > /dev/null

real    0m0.070s
user    0m0.051s
sys     0m0.021s

time git diff HEAD > /dev/null

real    0m0.266s
user    0m0.145s
sys     0m0.212s

time git diff HEAD -- a0 > /dev/null

real    0m0.171s
user    0m0.136s
sys     0m0.033s

time git show HEAD:a0  > /dev/null

real    0m0.018s
user    0m0.009s
sys     0m0.007s

time git show HEAD:a0 | diff -u - a0 > /dev/null

real    0m0.019s
user    0m0.010s
sys     0m0.008s

Stumped.

In your case, do you have a lot of differing files besides the one you
are limitting to? Anyway, that does not seem to make a huge difference
in my timings. (Just tried.) Still Stumped.

Michael
