From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [RFC/PATCH 2/2] gitweb: check given hash before trying to create snapshot
Date: Fri, 11 Sep 2009 11:44:04 -0400
Message-ID: <9513F576-4154-4281-8545-81841D59B766@mailservices.uwaterloo.ca>
References: <4AA96DAF.4070200@mailservices.uwaterloo.ca> <200909110952.50536.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm8JS-0006sA-3I
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 17:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZIKPpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbZIKPpN
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 11:45:13 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:58006 "EHLO
	minos.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751557AbZIKPpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 11:45:12 -0400
Received: from [10.5.26.28] (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by minos.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8BFj4oP028824
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Sep 2009 11:45:07 -0400
In-Reply-To: <200909110952.50536.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1076)
X-UUID: 7389de1b-5111-40e9-8526-7d61bf696ea1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128200>


On 2009-09-11, at 3:52 AM, Jakub Narebski wrote:

> Second, I'd rather have better names for snapshots than using full  
> SHA-1.
> For snapshot of 'v1.5.0' of repository 'repo.git' I'd prefer for  
> snapshot
> to be named 'repo-v1.5.0', and for snapshot of 'next' branch of the  
> same
> project to be named for example 'repo-next-20090909', or perhaps
> 'repo-next-2009-09-10T09:16:18' or 'repo-next-20090909-g5f6b0ff',
> or 'repo-v1.6.5-rc0-164-g5f6b0ff'.

Ah, yeah, well, I let $hash still hold the originally passed value,  
which
would be used to create the outputted file name (unless overwritten by  
the
client by using curl -o or something). Then $snapshot holds the full  
hash.
This way, if you were to type something like

http://git.kernel.org/?p=git/git.git;a=snapshot;h=next;sf=tgz

into your browser window, you would get git.git-next.tar.gz back, but  
the
backend could look up something like

git-5f6b0ffff13f5cd762d0a5a4e1c4dede58e8a537.tar.gz

using the $snapshot variable in some hypothetical cache (or even  
without the
cache it won't mangle the nicer name $hash might have).

Also, right now gitweb will not accept tags for hashes. This seems to be
because it passes the --verify option to rev-parse, but the output  
from using
and not using the verify option seems to be the same (other than also  
accepting
all tree-ishes). Could you let me know if there is a good reason not  
to take
off the --verify option? Otherwise, I would like to take it off in the  
next
version of this patch.

Your point about adding the short hash to snapshots of branch heads is  
cool,
I'll try that for the next version of the patch.


>> 	}
>>
>> 	my $name = $project;
>> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501- 
>> gitweb-standalone-http-status.sh
>> index d0ff21d..4f8f147 100644
>> --- a/t/t9501-gitweb-standalone-http-status.sh
>> +++ b/t/t9501-gitweb-standalone-http-status.sh
>> @@ -75,4 +75,30 @@ test_expect_success \
>> test_debug 'cat gitweb.output'
>>
>>
>> +test_expect_success \
>> +	'snapshots: bad treeish id' \
>> +	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
>> +	grep "400 - Not a valid hash id:" gitweb.output'
>> +test_debug 'cat gitweb.output'
>> +
>> +test_expect_success \
>> +	'snapshots: good treeish id' \
>> +	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
>> +	grep "Status: 200 OK" gitweb.output'
>> +test_debug 'cat gitweb.output'
>
> Why you don't check for "Status: 400" too?

I'm not sure which test you are referring to (I think the second). The
second test is valid and should return a nice .git-master.tar.gz
tarball.


>> Second, any given treeish will always be translated to the full  
>> length,
>> unambiguous, hash id; this will be useful for things like creating
>> unique names for snapshot caches.
>
> But this is not a good idea, IMHO.
>
> First, it introduces feature that nobody uses (at least yet); we can
> introduce this feature when it is needed instead.

Sorry for promoting vapourware, I did originally rip this patch out from
something else. I removed the comment from the v2 commit message.



--
Mark Rada (ferrous26)
marada@uwaterloo.ca
