X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [BUG] git --git-dir dies with bus error
Date: Wed, 20 Dec 2006 09:47:37 -0500
Message-ID: <CF24F5E4-AE2F-48FD-A0C5-474D8BFA757F@silverinsanity.com>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com> <A76C0FA3-1649-409B-B0D4-C22865622C1F@silverinsanity.com> <emb8h2$io4$1@sea.gmane.org> <45892E16.2040301@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:47:53 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45892E16.2040301@op5.se>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34936>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2jS-0006Wb-5Q for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965113AbWLTOrl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWLTOrl
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:47:41 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:35334 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S965113AbWLTOrl (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 09:47:41 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 04CC11FFD321; Wed, 20 Dec 2006 14:47:39 +0000 (UTC)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org


On Dec 20, 2006, at 7:35 AM, Andreas Ericsson wrote:

> AFAIR, the discussions long ago went along the lines of "if no  
> argument is passed to any of the --*-dir options, print out the  
> current value". If "git --git-dir" doesn't print the directory name  
> of the .git directory inside the repo you're currently in, I'd  
> consider it a bug.

Consider this a bug then:

$ git --git-dir
Bus error
$ git --version
git version 1.4.4.1.GIT
$ git rev-parse origin/master
8336afa563fbeff35e531396273065161181f04c
$ gdb git
(gdb) set args --git-dir
(gdb) run
Starting program: /usr/local/stow/git/src/git/git --git-dir
Reading symbols for shared libraries ..+ done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_PROTECTION_FAILURE at address: 0x00000000
0x900332e6 in setenv ()
(gdb) bt
#0  0x900332e6 in setenv ()
#1  0x00001f9e in handle_options (argv=0xbffff4a4, argc=0xbffff4a0)  
at git.c:76
#2  0x000022da in main (argc=1, argv=0xbffff504, envp=0xbffff50c) at  
git.c:346

My current HEAD (and installed version) just includes my "remove  
COLLISION_CHECK" patch on top of git master.  This is on OS 10.4.8  
with fink 0.26.  It appears to be trying to set GIT_DIR to some non- 
set section of memory.  Bad git, bad.  I'd try to patch this myself  
(to at least display an error instead of dying), but I'm deep in my  
actual project code right now.

