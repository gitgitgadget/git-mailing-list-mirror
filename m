From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 14:07:33 +0200
Message-ID: <4D946E85.9030405@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <4D9454D9.6060406@viscovery.net> <4D945E3E.9010006@drmicha.warpmail.net> <4D94688B.1070703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Giw-0008Cy-BY
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab1CaMLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:11:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44880 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752005Ab1CaMLG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:11:06 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 96E0020983;
	Thu, 31 Mar 2011 08:11:04 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 08:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=waRkbzU2yTomXpg4rNOeXWg5+Io=; b=kigwog5WdD8HMuulIYkbkGduC/kdRLgJx0hWWg/uPG8MIZgF3fNgOV5StyuCgZR+dAg7/cg/zthajxJPbGgZuGsfKoMhau01GKB8Rm/Lfy+ItdP0clQ8SFth8kDFHwtk3VKcxLeo2Ox2Zvvas6gXUbLZOupQpaOikjtUn8MP5RA=
X-Sasl-enc: m5tK0eRffSY6/xfXITg9b2ejZ8Hf2Kse58MnRMilL//S 1301573464
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A908D449293;
	Thu, 31 Mar 2011 08:11:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D94688B.1070703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170478>

Johannes Sixt venit, vidit, dixit 31.03.2011 13:42:
> Am 3/31/2011 12:58, schrieb Michael J Gruber:
>> Johannes Sixt venit, vidit, dixit 31.03.2011 12:18:
>>> Am 3/31/2011 11:17, schrieb Michael J Gruber:
>>>> By design, "git show commit -- path" is not "git show commit:path", and
>>>> there is no reason to change that. But "git show commit -- path" simply
>>>> returns nothing at all "most of the time" because it prunes by pathspec
>>>> even though it does not walk commits. This is pretty useless.
>>>>
>>>> So, turn off pruning (but keep diff limiting of course) so that "git
>>>> show commit -- path" shows the commit message and the diff that the
>>>> commit introduces to path (filtered by path); only the diff will be
>>>> empty "most of the time".
>>>
>>> How does this interfere with git show --walk commit -- path? Will it now
>>> show all commits instead of just those that changed path?
>>
>> Hmpft,
>>
>> git show --walk origin/master
>> fatal: unrecognized argument: --walk
>>
>> No, that is without my patch ;)
>>
>> In other words: "ENOPARSEOPTS in revision.c", there is no "--walk".
> 
> 8-( Oops sorry, and thanks for doing research that I should have done. At
> first, I thought it's named --walk because we have --no-walk. But the name
> is --do-walk.
> 
> My question is then:
> 
> How does this interfere with git show --do-walk commit -- path?

Uh, didn't know that one. If I had thought we have a consistent
interface before...

So, yes, it changes that case also. Note that nothing in git-show[1]
hints at the fact that one can use rev-list arguments, especially that
one could walk the commits, so it is undocumented behavior which would
change.

I would even say that quite generally it is difficult to find cases
where prune and no_walk make sense together. One may construe a user who
feeds a list of commits to "rev-list --no-walk" and uses it as a filter,
returning only those commits which touch a given pathspec. But, I'm not
suggesting to change "rev-list --no-walk -- pathspec" or log.

But I do think that "show" would benefit from a better default. An
alternative would be to imply --sparse (i.e. dense=0).

BTW: If you look at cmd_log_reflog() you see that already for other
log-like commands we have the problem that we have to override the
log-centric defaults from cmd_log_init(), which means ignoring certain
user specified rev-list and diff-core options!

Michael
