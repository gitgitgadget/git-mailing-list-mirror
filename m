From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 19:40:32 +0100
Message-ID: <437788A0.6030103@op5.se>
References: <4376C797.3050600@matysik.co.nz> <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 13 19:41:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbMme-00008c-AU
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 19:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKMSke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 13:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKMSke
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 13:40:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58812 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750712AbVKMSkd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 13:40:33 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id A81A86BCBE
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 19:40:32 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11745>

Linus Torvalds wrote:
> 
> Quite frankly, I'd really prefer to see the git-core-http as a separate 
> package.
> 

This would get rid of expat and curl dependencies. ssh, rsync and git 
protocols use external programs so they aren't exactly required (from 
the rpm point of view anyways, they'll just fail if rsync or ssh isn't 
installed). I.e. Good idea, but see below.

> I think it's ludicrous that people want to split out gitk (because it 
> wants tcl/tk), but that we then add all of these really obscure 
> dependencies for the http part. 
> 

Couldn't agree more. Moving out the {cvs,arch,svn}-import scripts made 
sense because they were only faintly related to git day-to-day 
operations and forced some really ridiculous dependencies down users 
throats (git requiring subversion was a funny one...).

It *might* make sense to build a very minimalistic package for 
server-side use only, but for client-side use it's really only confusing 
to have a dozen packages to install to get the full functionality.

While we're on the subject of confusing; How about not naming non-core 
packages git-core? It feels wrong to have git-core-http, git-core-cvs 
and git-core-svn since they, strictly speaking, aren't required for core 
operations.

So, to be nicely constructive then I suggest we create the following 
packages;

git-core; Low-level stuff with as few dependencies as possible (ssh and 
openssl should suffice, really). This should be everything needed for 
running a server and should be required by all other git-* packages. It 
will most likely be enough to run most client-side things as well.

git; holds all client side stuff useful for humans interfacing with git 
that introduces "normal" dependencies not necessarily found everywhere 
(gitk and suchlike).

git-email; This one only uses Email::Valid->address(), so I'll import 
that function from the perl module so this dependency can be dropped and 
git-send-email can be in the 'git' package.


Programs introducing obscene or plain weird dependencies (cvsimport, 
svnimport) can be put into their own package, but we should really try 
to keep those extra packages to a minimum and simply force users who 
want all the fluffy niceties of the 'git' package to install whatever's 
required (or install with --nodeps, or from source, or...).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
