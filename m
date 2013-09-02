From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Mon, 2 Sep 2013 22:50:06 +0100
Organization: OPDS
Message-ID: <66A16BF0137D40568A34C316DDA6D32E@PhilipOakley>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley><20130901.134900.829124962244710553.chriscool@tuxfamily.org><29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley> <20130902.081157.986549849748779440.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <git@vger.kernel.org>, <trast@inf.ethz.ch>,
	<j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 02 23:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGc0X-00035I-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab3IBVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 17:49:58 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:39836 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758963Ab3IBVt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 17:49:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AucLAO4GJVJOl3GZ/2dsb2JhbABagwc1iTa4AgQEAYEqF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HDCUUAQQaBgcXBhMIAgECAwGHawq5Io92gySBAAOIfYYSihWLC4UsgTopgT47
X-IPAS-Result: AucLAO4GJVJOl3GZ/2dsb2JhbABagwc1iTa4AgQEAYEqF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAw4HDCUUAQQaBgcXBhMIAgECAwGHawq5Io92gySBAAOIfYYSihWLC4UsgTopgT47
X-IronPort-AV: E=Sophos;i="4.89,1009,1367967600"; 
   d="scan'208";a="440082789"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 02 Sep 2013 22:49:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233661>

From: "Christian Couder" <chriscool@tuxfamily.org>
> From: "Philip Oakley" <philipoakley@iee.org>
>>
>> From: "Christian Couder" <chriscool@tuxfamily.org>
>>
>>> Maybe we can show that in an example. But I think the patch is quite
>>> clear as it is and should be enough.
>>>
>>> If we really want to correct some false beliefs, the best would be 
>>> to
>>> state the truth where those false beliefs are stated.
>>>
>> I've added a sub-comment to the original SO post that started this
>> thread (my post $gmane/231598 - SO/a/18027030/717355), but given the
>> guy's blog has comments going back to 2009 I suspect its a bit of a
>> http://xkcd.com/386/ task, hence my desire that it's explicitly
>> mentioned in the 'replace' documentation. In addition, if the guy
>> doesn't correct his post I'll mark it down in a couple of days to 
>> make
>> it plain to other readers it's in error.
>>
>> The creation of a (merge?) commit that's equivalent to a graft line
>> isn't something that jumps out (to me) as an easy couple lines of 
>> bash
>> script.
>>
>> A 'graft2replace' script (or 'git-graft' command) which takes an
>> existing graft file (or command line list) and creates the 
>> replacement
>> objects and then does the replace, all while still in a dirty tree
>> would be the holy grail for properly deprecating grafts (which are
>> sooo easy to create)
>
> You mean something like the following:
>
> $ cat  ./graft2replace.sh
> #!/bin/bash
>
> while read orig parents
> do
>        printf "%s" "git cat-file commit $orig"
>        printf "%s" " | perl -n -e 'print unless /^parent /'"
>        insn=''
>        for commit in $parents; do insn="$insn print \"parent 
> $commit\\n\";"; done
>        printf "%s" " | perl -n -e 'print; if (/^tree /) { $insn }'"
>        printf "%s\n" " > new_commit.txt"
>        printf "%s\n" 'REPL=$(git hash-object -t commit -w 
> new_commit.txt)'

Does `hash-object` do the inverese of `cat-file commit`?

I didn't find the hash-object(1) man page very informative on that 
matter and a (very) quick look at its code made me think it was just 
hashing the raw contents which wouldn't be what what was wanted.

>        printf "%s\n" "git replace $orig \$REPL"
> done
>
> This generates shell instructions from a graft file. Then you only 
> need to execute the generated shell instructions.
> For example:
>
> $ cat graft_file.txt
> 5bf34fff3186254d7254583675d10ddf98df989b 
> 79fe155489351e8af829a3106e7150397c57d863 
> dcfbab6bea3df3166503f3084cec2679f10f9e80
> fb5657082148297b61fbca7e64d51c1e7870309a
>
> $ cat graft_file.txt | ./graft2replace.sh
> git cat-file commit 5bf34fff3186254d7254583675d10ddf98df989b | 
> perl -n -e 'print unless /^parent /' | perl -n -e 'print; if (/^tree 
> /) {  print "parent 79fe155489351e8af829a3106e7150397c57d863\n"; print 
> "parent dcfbab6bea3df3166503f3084cec2679f10f9e80\n"; }' > 
> new_commit.txt
> REPL=$(git hash-object -t commit -w new_commit.txt)
> git replace 5bf34fff3186254d7254583675d10ddf98df989b $REPL
> git cat-file commit fb5657082148297b61fbca7e64d51c1e7870309a | 
> perl -n -e 'print unless /^parent /' | perl -n -e 'print; if (/^tree 
> /) {  }' > new_commit.txt
> REPL=$(git hash-object -t commit -w new_commit.txt)
> git replace fb5657082148297b61fbca7e64d51c1e7870309a $REPL
>
> Note that I haven't really tested it.
>
> Best,
> Christian.
> --

I think we could call it 'git-graft', being the help function/script 
that converts raw grafts to proper object replacements ;-)

Philip 
