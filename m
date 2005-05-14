From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Sat, 14 May 2005 09:24:42 +0100
Message-ID: <4285B5CA.8060106@dgreaves.com>
References: <E1DWihi-0007DQ-SD@ash.dgreaves.com> <20050513225516.GG32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 10:25:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWrxm-0006y1-2q
	for gcvg-git@gmane.org; Sat, 14 May 2005 10:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVENIZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 04:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVENIZP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 04:25:15 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:10915 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262705AbVENIZA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 04:25:00 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C3D13E6D9A; Sat, 14 May 2005 09:23:25 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03092-01; Sat, 14 May 2005 09:23:25 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.155.138])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 81EB6E6D69; Sat, 14 May 2005 09:23:24 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWrwz-0007dp-2W; Sat, 14 May 2005 09:24:45 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513225516.GG32232@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sat, May 14, 2005 at 12:32:22AM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>Updated
>>    cg-add
>>    cg-commit
>>    
>>
>
>I consider this Bad Thing (tm). Or could you please point a situation
>where this would be actually useful? If you explicitly cg-add, you
>likely know what are you doing, and same thing with cg-commit - if it's
>already added, it should be watches, no matter what ignore patterns, I
>think.
>  
>
OK, lets say I'm clever and know what an ignore pattern is.
I can
find * | xargs cg-add
my laziness something my hubris acknowledges :)

And in fact this has come up a few times on the list already - it was
that code snippet in cg-init that caused me to create cg-Xignore because
as someone pointed out, even finding files/links would still cause probs
with files beginning with '.'
does that sway you?

>>--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-commit  (mode:100755)
>>+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-commit  (mode:100755)
>>@@ -65,6 +65,15 @@
>> 	[ -s $_git/merging ] && merging=$(cat $_git/merging | sed 's/^/-p /')
>> fi
>> 
>>+# strip ignored files - *1 at a time* - any attempt to stream from 1
>>+# while loop to another uses a subprocess and can't pass the variable
>>+# back
>>+# Also I don't know if this can be put in a shell function
>>+for file in ${commitfiles[@]}
>>+  do
>>+  commitfiles[$i]=`echo $file | cg-Xignore`
>>+  ((i++))
>>+done
>> 
>> LOGMSG=$(mktemp -t gitci.XXXXXX)
>> LOGMSG2=$(mktemp -t gitci.XXXXXX)
>>    
>>
>
>The variable? What variable?
>  
>
well basically we want to edit the commitfiles variable - perl map()
a more efficient method in shell appears to be:
foreach file in commitfiles; echo file | filter | read into commitfiles
I spent ages trying not to exec a cg-Ignore process per file comparison

>>Index: cg-status
>>===================================================================
>>--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-status  (mode:100755)
>>+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-status  (mode:100755)
>>@@ -15,21 +15,11 @@
>> 
>> {
>> 	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
>>-} | sort -z -k 2 | xargs -0 sh -c '
>>-while [ "$1" ]; do
>>-	tag=${1% *};
>>-	filename=${1#* };
>>-	case "$filename" in
>>-	*.[ao] | tags | ,,merge*) ;;
>>-	*)   echo "$tag $filename";;
>>-	esac
>>-	shift
>>-done
>>-' padding
>>+} | sort -z -k 2 | cg-Xignore -0 -t | tr "\000" "\n"
>>    
>>
>
>So you have two ignores now - exclude and Xignore.
>  
>
No, cogito has an ignore.
git has a less powerful exclude.
cogito users won't need exclude but power-users aren't barred from it.


David

-- 

