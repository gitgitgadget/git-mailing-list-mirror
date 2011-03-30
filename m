From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 20:50:38 +0200
Message-ID: <4D937B7E.10808@morey-chaisemartin.com>
References: <4D92E225.3040602@morey-chaisemartin.com> <4D93773C.2010807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50Tg-00018R-D7
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab1C3Sun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 14:50:43 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:44234 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754815Ab1C3Sum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 14:50:42 -0400
Received: (qmail 9556 invoked by uid 503); 30 Mar 2011 18:40:10 -0000
Received: from b9.ovh.net (HELO mail417.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 30 Mar 2011 18:40:10 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Mar 2011 20:50:40 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 30 Mar 2011 20:50:39 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4D93773C.2010807@web.de>
X-Ovh-Tracer-Id: 8898831390200487863
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170402>

On 03/30/2011 08:32 PM, Jens Lehmann wrote:
> Am 30.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:

> All looking good up to here. But I wonder if the rest of git-submodule.sh
> could be changed a bit less invasive ... maybe as simple as this?
> 
> @@ -458,7 +461,6 @@ cmd_update()
> 
>  		if test "$subsha1" != "$sha1"
>  		then
> -			force=
>  			if test -z "$subsha1"
>  			then
>  				force="-f"
> 
> Now force will not be cleared and thus contain "-f" if the user provided
> it on the command line. All tests (including your new ones) are running
> fine with this simplification ... am I missing something?

Actually, I don't think this work.
By doing that, if you run git submodule update without -f, it will set -f when you reached the first submodule not yet checked out ( -z $subsha1 ),
and the following submodules will be checkout using --force which may throw away changes the user wanted to keep.

I know it is very intrusive. The main reason for that is I wanted the -f option to always behave the same (meaning throw away changes),
whether the submodule is already on the right commit or not.

If we accept to drop this and only drop the changes when subsha1 != sha1, the patch can be much sorter by simply keeping the force flags I used and without modifying all the case/while thing.


>>  
>> +test_expect_success 'submodule update should fail due to local changes' '
>> +	(cd super/submodule &&
>> +	 git reset --hard HEAD~1 &&
>> +	 echo "local change" > file
>> +	) &&
>> +	(cd super &&
>> +	 (cd submodule &&
>> +	  compare_head
>> +	 ) &&
>> +	 test_must_fail git submodule update submodule
>> +	)
>> +'
> 
> This test is shorter and might be easier to understand rewritten as:
> 
> +test_expect_success 'submodule update should fail due to local changes' '
> +	(cd super &&
> +	 (cd submodule &&
> +	  git reset --hard HEAD~1 &&
> +	  echo "local change" > file
> +	  compare_head
> +	 ) &&
> +	 test_must_fail git submodule update submodule
> +	)
> +'
> 

Agreed.
