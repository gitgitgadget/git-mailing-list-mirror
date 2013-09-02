From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option
 bypasses the type check
Date: Mon, 02 Sep 2013 08:11:57 +0200 (CEST)
Message-ID: <20130902.081157.986549849748779440.chriscool@tuxfamily.org>
References: <70F5C527E29F43A9BE85694F560E01A9@PhilipOakley>
	<20130901.134900.829124962244710553.chriscool@tuxfamily.org>
	<29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, trast@inf.ethz.ch,
	j6t@kdbg.org
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNNB-0005G9-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3IBGMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:12:21 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:59913 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753240Ab3IBGMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:12:21 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E4EF564;
	Mon,  2 Sep 2013 08:11:57 +0200 (CEST)
In-Reply-To: <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233602>

From: "Philip Oakley" <philipoakley@iee.org>
>
> From: "Christian Couder" <chriscool@tuxfamily.org>
>
>> Maybe we can show that in an example. But I think the patch is quite
>> clear as it is and should be enough.
>>
>> If we really want to correct some false beliefs, the best would be to
>> state the truth where those false beliefs are stated.
>>
> I've added a sub-comment to the original SO post that started this
> thread (my post $gmane/231598 - SO/a/18027030/717355), but given the
> guy's blog has comments going back to 2009 I suspect its a bit of a
> http://xkcd.com/386/ task, hence my desire that it's explicitly
> mentioned in the 'replace' documentation. In addition, if the guy
> doesn't correct his post I'll mark it down in a couple of days to make
> it plain to other readers it's in error.
> 
> The creation of a (merge?) commit that's equivalent to a graft line
> isn't something that jumps out (to me) as an easy couple lines of bash
> script.
>
> A 'graft2replace' script (or 'git-graft' command) which takes an
> existing graft file (or command line list) and creates the replacement
> objects and then does the replace, all while still in a dirty tree
> would be the holy grail for properly deprecating grafts (which are
> sooo easy to create)

You mean something like the following:

$ cat  ./graft2replace.sh 
#!/bin/bash

while read orig parents
do
        printf "%s" "git cat-file commit $orig"
        printf "%s" " | perl -n -e 'print unless /^parent /'"
        insn=''
        for commit in $parents; do insn="$insn print \"parent $commit\\n\";"; done
        printf "%s" " | perl -n -e 'print; if (/^tree /) { $insn }'"
        printf "%s\n" " > new_commit.txt"
        printf "%s\n" 'REPL=$(git hash-object -t commit -w new_commit.txt)'
        printf "%s\n" "git replace $orig \$REPL"
done

This generates shell instructions from a graft file. Then you only need to execute the generated shell instructions.
For example:

$ cat graft_file.txt 
5bf34fff3186254d7254583675d10ddf98df989b 79fe155489351e8af829a3106e7150397c57d863 dcfbab6bea3df3166503f3084cec2679f10f9e80
fb5657082148297b61fbca7e64d51c1e7870309a

$ cat graft_file.txt | ./graft2replace.sh 
git cat-file commit 5bf34fff3186254d7254583675d10ddf98df989b | perl -n -e 'print unless /^parent /' | perl -n -e 'print; if (/^tree /) {  print "parent 79fe155489351e8af829a3106e7150397c57d863\n"; print "parent dcfbab6bea3df3166503f3084cec2679f10f9e80\n"; }' > new_commit.txt
REPL=$(git hash-object -t commit -w new_commit.txt)
git replace 5bf34fff3186254d7254583675d10ddf98df989b $REPL
git cat-file commit fb5657082148297b61fbca7e64d51c1e7870309a | perl -n -e 'print unless /^parent /' | perl -n -e 'print; if (/^tree /) {  }' > new_commit.txt
REPL=$(git hash-object -t commit -w new_commit.txt)
git replace fb5657082148297b61fbca7e64d51c1e7870309a $REPL

Note that I haven't really tested it.

Best,
Christian.
