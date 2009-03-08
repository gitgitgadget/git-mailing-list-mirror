From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: git-grep Bus Error
Date: Sun, 8 Mar 2009 19:27:01 -0400
Message-ID: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 00:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgSYt-0005HP-Q1
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 00:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbZCHXgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZCHXgM
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 19:36:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57453 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZCHXgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 19:36:12 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2009 19:36:12 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A901F1FFC3FB; Sun,  8 Mar 2009 23:26:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 7EC391FFC043
	for <git@vger.kernel.org>; Sun,  8 Mar 2009 23:26:54 +0000 (UTC)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112652>

The --color display code in git-grep is giving me a bus error in  
show_line at line 492:

>                         printf("%.*s%s%.*s%s",
>                                match.rm_so, bol,
>                                opt->color_match,
>                                match.rm_eo - match.rm_so, bol +  
> match.rm_so,
>                                GIT_COLOR_RESET);

The first problem is that %.*s does not appear to do on OS X what the  
author thinks it does.  A precision of 0 for %s is listed in "man  
printf" as printing the entire string.

To fix that, I changed it to the following:

> 			if( match.rm_so > 0 )
> 				printf( "%.*s", match.rm_so, bol );
> 			if( match.rm_eo > match.rm_so )
> 				printf("%s%.*s%s",
> 					   opt->color_match,
> 					   match.rm_eo - match.rm_so, bol + match.rm_so,
> 					   GIT_COLOR_RESET);

This code does not fail, but instead gives lines like the following  
(showing the raw color codes):

.gitignore:\033[31m\033[1m(nugit

GIT_COLOR_RESET is apparently being ignored, and I don't know why.

Adding a line to check the values of rm_so, rm_eo, and the difference  
between the two gives:

> 			printf( "%d %d %d",
> 				  match.rm_so, match.rm_eo,
> 				  match.rm_eo - match.rm_so );

.gitignore:0 0 3\033[31m\033[1m(nugit
.mailmap:23 0 26(null)\033[31m\033[1m(nugit-shortlog to fix a few  
botched name translations-shortlog to fix a few botched name  
translations

And now I'm baffled.  Apparently my computer thinks 0 - 0 == 3 and 0 -  
23 == 26.

Can I get some help?

~~ Brian
