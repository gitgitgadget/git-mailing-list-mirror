From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: "prune" prone to clock skew (Re: t3306 failure with v1.7.5-rc1)
Date: Fri, 08 Apr 2011 09:41:53 +0200
Message-ID: <4D9EBC41.4080501@drmicha.warpmail.net>
References: <4D9ECF7C.6010709@drmicha.warpmail.net> <4D9EB406.5080302@viscovery.net> <4D9EB57D.1060402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:42:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q86KP-0001in-VP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab1DHHl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:41:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37355 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756426Ab1DHHlz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 03:41:55 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 007FF20A11;
	Fri,  8 Apr 2011 03:41:54 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 08 Apr 2011 03:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6LuQZV0f5Dz0B9524s+5KACfXc8=; b=PR096T5wd+9ooZZNx2H5dsODzqRu08h6kT9/ekQThgPPvyE7s8O0GCRI6VLuSBZq4bnKcnwb9ZHQGEbvxCLd5q1d2IxKaFf3/ulDhar+QYYzbTZz1JQQf2H/Mx5yAOjwSJA9tsN09/BjcD2v2QbbW3PtXUd/v4diYQbiszFmCgI=
X-Sasl-enc: PveQ4/jJ92tWeuh1HdwHYm00lHsilWmTiUoNzHwUrFQT 1302248514
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 58CA3409DC2;
	Fri,  8 Apr 2011 03:41:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9EB57D.1060402@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171114>

Michael J Gruber venit, vidit, dixit 08.04.2011 09:13:
> Johannes Sixt venit, vidit, dixit 08.04.2011 09:06:
>> Am 4/8/2011 11:03, schrieb Michael J Gruber:
>>> I get this stupid test failure in test 3 of t3306. The problem is that a
>>> dangling commit does not get pruned away when it should:
>>>
>>> 3rd
>>> test_must_fail: command succeeded: git cat-file -p
>>> 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
>>> not ok - 4 verify that commits are gone
>>>
>>> It's a system where make complains about funny clock (I dunno why) but

(I know now.)

>>> can we make this more robust? The following helps with "sleep 5" but not
>>> with "sleep 4". test_tick does not help. What's going on?

Adding one more observation from that system:

rm GIT-VERSION-FILE ;date; sh ./GIT-VERSION-GEN; date; ls -l --full-time
GIT-VERSION-FILE

Fri Apr  8 09:27:40 CEST 2011
GIT_VERSION = 1.7.5.rc1
Fri Apr  8 09:27:41 CEST 2011
-rw-r----- 1 mjg mjg 24 2011-04-08 09:27:47.000000000 +0200 GIT-VERSION-FILE

Note that the second "date" happens after the creation of
GIT-VERSION-FILE. I can even do this with a simple

rm a;date; touch a; date; ls -l --full-time a
Fri Apr  8 09:31:04 CEST 2011
Fri Apr  8 09:31:04 CEST 2011
-rw-r----- 1 mjg mjg 0 2011-04-08 09:31:11.000000000 +0200 a

Suffice it to say that this is on NFS, and of course the creation date
comes from the NFS server, the "date" from the client... OK, I got that.
Scary.

EXPLANATION:

I guess "prune" looks at some file time stamps (rather than parsing the
commit time proper) so that it is prone to the same client/server clock
skew problems when the repo is not on the local file system.

PROBLEM (?):

I really hope this does not go both ways - imagine a messed server
turning it's clock a few weeks back by accident, and running "git prune"
on the client, or a messed client turning the clock forward... Do we do
proper checks before removing something?

I mean, there's a difference between missing that something is stale and
missing that it is not...

Michael
