From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 21:05:45 +0200
Message-ID: <4D937F09.10000@web.de>
References: <4D92E225.3040602@morey-chaisemartin.com> <4D93773C.2010807@web.de> <4D937B7E.10808@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50jC-0001Ho-RF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab1C3TGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:06:46 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40355 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab1C3TGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:06:45 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id DB99D19B6ADA2;
	Wed, 30 Mar 2011 21:05:45 +0200 (CEST)
Received: from [93.240.98.1] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q50i9-0007T9-00; Wed, 30 Mar 2011 21:05:45 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D937B7E.10808@morey-chaisemartin.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18gPCyUovBZpaf624dD+pHpKdLc3qGvalKXY686
	h8QJ14g+nqlWi1ED6rlii4S17q1eZoCr6kzwwHXoE7dbxrLLtg
	LZF1s14n45JTcCFeixCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170408>

Am 30.03.2011 20:50, schrieb Nicolas Morey-Chaisemartin:
> On 03/30/2011 08:32 PM, Jens Lehmann wrote:
>> Am 30.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
> 
>> All looking good up to here. But I wonder if the rest of git-submodule.sh
>> could be changed a bit less invasive ... maybe as simple as this?
>>
>> @@ -458,7 +461,6 @@ cmd_update()
>>
>>  		if test "$subsha1" != "$sha1"
>>  		then
>> -			force=
>>  			if test -z "$subsha1"
>>  			then
>>  				force="-f"
>>
>> Now force will not be cleared and thus contain "-f" if the user provided
>> it on the command line. All tests (including your new ones) are running
>> fine with this simplification ... am I missing something?
> 
> Actually, I don't think this work.
> By doing that, if you run git submodule update without -f, it will set -f when you reached the first submodule not yet checked out ( -z $subsha1 ),
> and the following submodules will be checkout using --force which may throw away changes the user wanted to keep.

You are right, I just came to that conclusion myself ... but with a loop
local variable initialized from force on every iteration it should work.

> I know it is very intrusive. The main reason for that is I wanted the -f option to always behave the same (meaning throw away changes),
> whether the submodule is already on the right commit or not.

Hmm, I don't know if that is a good thing to do. People are used to
"git submodule update" to only touch those submodule where the HEAD
differs from the commit recorded in the superproject (And I often
find myself using "-f" if the command didn't succeed without it).
But when using "-f" touches other submodules than not using it the
user might experience a rather unpleasant surprise, I'm not sure we
want to go that way.

> If we accept to drop this and only drop the changes when subsha1 != sha1, the patch can be much sorter by simply keeping the force flags I used and without modifying all the case/while thing.

Yes.
