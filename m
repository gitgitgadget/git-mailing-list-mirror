From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using
 git ls-files
Date: Mon, 04 Oct 2010 08:58:42 -0600
Message-ID: <4CA9EBA2.9020401@workspacewhiz.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com> <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com> <201010032019.09244.j6t@kdbg.org> <20101004074916.GK24884@burratino> <AANLkTikgLzczp1Gkmcg2v35oE2bKxBtxY389Z76FJDRz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Thomas Adam <thomas@xteddy.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 04 16:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2mVB-0002SX-NQ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab0JDO6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 10:58:48 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:35952 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0JDO6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 10:58:48 -0400
Received: (qmail 23629 invoked by uid 399); 4 Oct 2010 08:58:46 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.144.122)
  by hsmail.qwknetllc.com with ESMTPAM; 4 Oct 2010 08:58:46 -0600
X-Originating-IP: 75.220.144.122
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTikgLzczp1Gkmcg2v35oE2bKxBtxY389Z76FJDRz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158058>

  ----- Original Message -----
From: Erik Faye-Lund
Date: 10/4/2010 8:03 AM
> On Mon, Oct 4, 2010 at 9:49 AM, Jonathan Nieder<jrnieder@gmail.com>  wrote:
>> Johannes Sixt wrote:
>>> On Sonntag, 3. Oktober 2010, Thomas Adam wrote:
>>>> It's a real shame about the code duplication here.  Can we not avoid
>>>> it just by doing:
>>>>
>>>> unsigned char c1 = (ignore_case) ? tolower(*match) : *match;
>>>> unisgned char c2 = (ignore_case) ? tolower(*name) : *name;
>>>>
>>>> I appreciate that to some it might look like perl golf, but...
>>> It has been discussed, and IIRC, the concensus was to keep the code
>>> duplication because this is an inner loop.
>> Did anyone time it?  If it really is not dwarfed by other computation,
>> then how about (warning: ugly!)
>>
> I believe it was timed. I was the one who reacted on this the first
> time around, and I seem to remember that the performance impact was
> indeed significant. This function is used all the time when updating
> the index etc IIRC.
In a good sized repository I have in front of me now, running 'git 
ls-files' through this code path results in 705,374 characters being 
processed by this body of code.  Given the code listed above, that means 
we add 1,410,748 additional comparisons that everyone has to suffer 
through, even those on a case sensitive file system.  Sure, the code 
could be optimized to not perform the double comparison, and the 
compiler may actually perform that optimization.  Still, it is hundreds 
of thousands of additional comparisons and branches that were not there 
before.

I'm running on a really, really fast machine, a Xeon X5560.  The 
difference in time for the above code versus what is in the patch seems 
to average about 0.07 seconds.  Remember, this is an incredibly fast 
machine, and I imagine it will be worse on machines with slower 
processors and less cache.

As discussed in the original thread (which, I believe, was on the 
msysGit mailing list), one of Git's features is its speed.  Maintaining 
that speed in the core.ignorecase=false case is top priority for me, but 
others with more know how can tell me I'm wrong.

Josh
