From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 22:25:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609262203510.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 22:26:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJUe-0008S9-0V
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWIZUZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWIZUZX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:25:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:9153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964784AbWIZUZW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 16:25:22 -0400
Received: (qmail invoked by alias); 26 Sep 2006 20:25:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 26 Sep 2006 22:25:20 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <45196628.9010107@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27817>

Hi,

On Tue, 26 Sep 2006, A Large Angry SCM wrote:

> 							20060926.1715

You forgot the time zone ;-)

> Notes on Using Git with Subprojects
> ===================================
> Copyright (C) 2006 by Raymond S Brand
> 
> 
> Git does not have native support for subprojects and this is a good
> thing because managing subprojects is better handled by the project
> build machinery. Managing subprojects with the project build machinery
> is more flexible than the native support from an SCM and allows the use
> of different SCMs by different subprojects. However, there is a lot of
> interest in using Git for the SCM of a project with subprojects.
> 
> Git, unfortunately, does not make it easy.

After skimming your text, I imagine that it should be possible (read: 
easy) to write a really simple script which does what you describe, 
storing the relevant information about root or sub projects in the config.

However, you left out one of the most important aspects of subprojects: 
the ability to manage the state of the root project: you can add, update 
and remove subprojects.

A while ago, Junio started playing with a new object type for subprojects 
so that you could have tree objects containing subprojects in addition 
to tree objects and blobs.

Of course, the difficult thing about this is to teach all tools to behave 
sensibly with the new object type.

Now, your approach of having multiple clones (sharing the object pool) is 
more simple than Junio's approach: no need to introduce a new object type, 
or adapt existing tools.

Taking this a step further, how about managing the root project in this 
manner:

A root project is a branch containing just one special file, 
"root-project". This file consists of lines like these:

-- snip --
f80a17bf3da1e24ac904f9078f68c3bf935ff250 next
03adf42c988195b50e1a1935ba5fcbc39b2b029b todo
-- snap --

The meaning: subdirectory "next" contains subproject "next" which is also 
tracked in the branch "next" of the root project. Likewise for "todo". The 
root project could even contain some administrative files like a Makefile, 
a license, README, etc.

You could even handle the update of root-project with each commit in a 
subproject by a hook in that subproject's .git/hooks/post-commit, so that 
you'd only need a script "git-checkout-root-project.sh" to initialize them 
all, and probably a script "git-update-root-project.sh".

Thoughts?

Ciao,
Dscho

P.S.: Is it just me, or do other people also find it confusing that 
--shared means different things for git-init-db and git-clone? (I know I 
am the sinner...)
