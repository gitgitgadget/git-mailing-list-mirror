From: Phil Hord <hordp@cisco.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Thu, 21 Jul 2011 17:40:42 -0400
Message-ID: <4E289CDA.20209@cisco.com>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com> <7vhb6f1ipp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 23:40:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk0zC-0004jo-Ds
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 23:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab1GUVkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 17:40:45 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:44265 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1GUVko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 17:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3279; q=dns/txt;
  s=iport; t=1311284444; x=1312494044;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=alpBUQGSJg48hyoY2lXvwD7eegWaGR/fAltdyZRK2Ss=;
  b=bNWzG0x8GJ4Jd64XtIzsxIIHlOsHQJoifb5quZepkHZRwCP0FE0Fiwv1
   XQdQgDdgzPaIeOrV2fCulqOLR8d/X7YEs1AscYIoYBSH0th+VAhcKw4br
   maGTBG/nMqXEIBImQoYHfj1+ZTO3jXVzdXRUIRpR83XwpEXue3uGCHCal
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAB2cKE6tJV2c/2dsb2JhbABFDqdCd6YBnh+DI4McBJJuhQeLcw
X-IronPort-AV: E=Sophos;i="4.67,243,1309737600"; 
   d="scan'208";a="5270997"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-1.cisco.com with ESMTP; 21 Jul 2011 21:40:43 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p6LLeg5o007649;
	Thu, 21 Jul 2011 21:40:43 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <7vhb6f1ipp.fsf@alter.siamese.dyndns.org>
X-TagToolbar-Keys: D20110721174042802
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177625>

On 07/21/2011 04:28 PM, Junio C Hamano wrote:
> Fredrik Gustafsson<iveqy@iveqy.com>  writes:
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 87c9452..3ad3012 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -122,14 +122,56 @@ module_clone()
>>   	path=$1
>>   	url=$2
>>   	reference="$3"
>> +	gitdir=
>> +	gitdir_base=
>> +	base_path=`echo $path | sed -e 's|[^/]*$||'`
> We prefer $() over `` these days, no?  Without dq around $path, you would
> not be able to preserve $IFS inside $PATH. You are stripping a run of non
> slash at the trailing end --- is 'dirname "$path"' insufficient?
>
> I think you are using the path the submodule happens to be at in the
> current checkout to decide where in the .git/modules in the superproject
> to keep the submodule metadata directory. Shouldn't you be using
> module_name to convert the $path to the name of the submodule (this is
> important, as the same submodule that used to be at path P1 can be moved
> to a different path P2 in the history).

Now that you mention it, what happens if the submodule name changes in 
the history?
What happens if the submodule URL (and possibly the entire submodule 
contents) changes in the history?

Is there any unique thing simpler than "<submodule-name>+<url>" that can 
be used to uniquely identify "that" submodule repo?

Say I have linux as a submodule in my project.  But over time (or on 
different branches) I have different ideas about what should go there 
(and where it should go):

Commit      .gitmodules
   E           linux.path=linux ; 
linux.url=git://sources.blackfin.uclinux.org/git/linux-kernel
   D           linux.path=linux ; 
linux.url=https://github.com/mirrors/linux-2.6.git
   C           linux.path=linux ; 
linux.url=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
B           linux.path=linus ; 
linux.url=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
A           linus.path=linus ; 
linus.url=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

How many repos are in .git/modules/?  I can imagine anything from 1-5 in 
the implementation.  Logically there should be only 2, ideally (but not 
practically) named something like this:

   .git/modules/linux@blackfin
   .git/modules/linux@torvalds

and where the last one also includes "github/mirrors" as a remote.

But a more practical implementation would end up with three as it 
wouldn't know it could combine the last two:

   .git/modules/linux@blackfin
   .git/modules/linux@torvalds
   .git/modules/linux@github

But maybe a nearly practical implementation could actually wind up with 
one repo and three remotes:

   .git/modules/linux; remotes=blackfin, torvalds, github

But this is likely to confuse the poor user who did not expect all these 
remotes.  Also, a realistic practical implementation probably would wind 
up like this:

   .git/modules/linux; remotes=blackfin, torvalds, github
   .git/modules/linus; remotes=torvalds

In reality I suppose switching repositories like this is simply not 
supported by the code or the patch.  But it's something to think about 
when choosing a name for the .git/modules path.

Phil
