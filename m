From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: t3032 incompatible with Cygwin/Windows
Date: Thu, 18 Jul 2013 20:11:13 +0100
Message-ID: <51E83DD1.8010109@ramsay1.demon.co.uk>
References: <51E591FF.7030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuoh-0004E6-ME
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934298Ab3GRU2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:28:40 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:50015 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933027Ab3GRU2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:28:38 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 86B3E1280B6;
	Thu, 18 Jul 2013 21:28:37 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9FEE71280A6;
	Thu, 18 Jul 2013 21:28:36 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:28:36 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E591FF.7030600@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230736>

Mark Levedahl wrote:
> Subtests 6,7, and 9 of t3032 fail on Cygwin, and I presume will fail on 
> msysgit for similar reasons. Looking at test 6, the expected result is a 
> line ending with \r\n in text.txt. This line is extracted with grep 
> (grep 'justice and holiness' text.txt > actual), with unavoidable result 
> that on Cygwin the line ending is \n. This happens because on Cygwin, 
> the text utils are compiled to open files in text mode meaning than \n 
> and \r\n are both recognized as EOL markers. Thus, even though text.txt 
> is an exact match for what is created on Linux, the test fails because 
> \r\n cannot be distinguished by the available tools.
> 
> I'm not sure the right way forward. I did confirm that by substituting 
> "q_to_tab" for "q_to_cr" in t3032, the test pass on Cygwin and on Linux. 
> Perhaps t3032 should be so amended to avoid use of a non-portable line 
> ending construct?

This passes for me, on both cygwin and MinGW.

After adding a test_pause to test #6:

$ ./t3032-merge-recursive-options.sh -v

...

expecting success:
        q_to_cr <<-\EOF >expected &&
            justice and holiness and is the nurse of his age and theQ
        EOF

        git read-tree --reset -u HEAD &&
        git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
        grep "justice and holiness" text.txt >actual &&
        test_cmp expected actual &&
        test_pause

Merging HEAD with remote
Merging:
0ab7224 Clarify
be82dcf Remove cruft
found 1 common ancestor:
c1e95d9 Initial revision
Auto-merging text.txt
$ xxd expected
0000000: 2020 2020 6a75 7374 6963 6520 616e 6420      justice and
0000010: 686f 6c69 6e65 7373 2061 6e64 2069 7320  holiness and is
0000020: 7468 6520 6e75 7273 6520 6f66 2068 6973  the nurse of his
0000030: 2061 6765 2061 6e64 2074 6865 0d0a        age and the..
$ xxd actual
0000000: 2020 2020 6a75 7374 6963 6520 616e 6420      justice and
0000010: 686f 6c69 6e65 7373 2061 6e64 2069 7320  holiness and is
0000020: 7468 6520 6e75 7273 6520 6f66 2068 6973  the nurse of his
0000030: 2061 6765 2061 6e64 2074 6865 0d0a        age and the..
$ grep "justice and holiness" text.txt | xxd
0000000: 2020 2020 6a75 7374 6963 6520 616e 6420      justice and
0000010: 686f 6c69 6e65 7373 2061 6e64 2069 7320  holiness and is
0000020: 7468 6520 6e75 7273 6520 6f66 2068 6973  the nurse of his
0000030: 2061 6765 2061 6e64 2074 6865 0d0a        age and the..
$ exit

...

# passed all 11 test(s)
1..11
$ 

ATB,
Ramsay Jones
