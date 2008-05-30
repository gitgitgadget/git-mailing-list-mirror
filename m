From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Fri, 30 May 2008 09:58:19 +0200 (MEST)
Message-ID: <483FB39A.4070104@gmail.com>
References: <20080529210018.GA5508@damson.getinternet.no>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Sverre Rabbelier <alturin@gmail.com>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 10:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ziO-00013J-Fz
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 10:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbYE3ILE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 04:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYE3ILE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 04:11:04 -0400
Received: from as4.cineca.com ([130.186.84.251]:47434 "EHLO as4.cineca.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYE3IK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 04:10:59 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 May 2008 04:10:59 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by as4.cineca.com (Postfix) with ESMTP id DFE1A42F;
	Fri, 30 May 2008 10:02:13 +0200 (CEST)
Received: from cineca.mm.cineca.it (cineca.mm.cineca.it [130.186.10.200])
	by as4.cineca.com (Postfix) with ESMTP id 35065442;
	Fri, 30 May 2008 10:02:04 +0200 (CEST)
Received: from [192.168.64.177] (pdl-19-81.nat.cineca.it [130.186.19.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	as user a.righi@cineca.it by cineca.mm.cineca.it (Postfix) with ESMTP
	id 14D00B80D1A; Fri, 30 May 2008 09:58:19 +0200 (MEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20080529210018.GA5508@damson.getinternet.no>
X-Virus-Scanned: Cineca AppOs 0.99 at as4.cineca.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83275>

Vegard Nossum wrote:
> Hi,
> 
> I've written this perl script that takes a patch as input and prints the
> authors/committers of the affected lines, using git-blame as the back end.
> 
> (The purpose of this is of course to find out whom to send patches to.)
> 
> There are some caveats:
> 
> - If I've understood correctly, git-blame incremental output doesn't split
>   commits when a newer one is found, so we currently possibly take into
>   account more than just the last patch to touch a line. This might not be
>   a disadvantage, however...
> 
> - The patch must apply to the current working tree. I suppose there is
>   some way to use the index information in the patch to determine what to
>   run git-blame against, but this is currently beyond my git knowledge.
> 
> - It's a bit slow, particularly for large files. But doing the same thing
>   by hand would be slower, so I suppose it's an overall improvement.
> 
> Running this on a random -mm patch, for example
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.26-rc2/2.6.26-rc2-mm1/broken-out/acpi-fix-fadt-parsing.patch
> gives the following output:
> 
>   $ perl whomto2.pl acpi-fix-fadt-parsing.patch
>   Running git-blame on drivers/acpi/tables/tbfadt.c...
> 
>   To: (Committers)
>       48 Len Brown <len.brown@intel.com>
>   Cc: (Authors)
>       44 Bob Moore <robert.moore@intel.com>
>        2 Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
>        2 Len Brown <len.brown@intel.com>
> 
> Maybe this tool can be useful? :-)
> 
> (Improvements are of course also welcome.)

Minor fix: do not git-blame /dev/null in patches that add new files.

-Andrea

diff -urpN linux/whomto.orig.pl linux/whomto.pl
--- linux/whomto.orig.pl	2008-05-30 09:43:08.000000000 +0200
+++ linux/whomto.pl	2008-05-30 09:49:26.000000000 +0200
@@ -101,6 +101,7 @@ sub parse_patch {
 
 	for (@p) {
 		if (m/^--- .*?\/([^\s~]*)/) {
+			next if ($1 eq 'dev/null');
 			$file = $files{$1} = {
 				chunks => [],
 			};
