From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 15:01:05 -0700
Message-ID: <4519A321.4010507@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.63.0609262203510.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 00:01:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKzM-0003em-T2
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWIZWBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWIZWBM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:01:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41341 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932430AbWIZWBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 18:01:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so314715nfa
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 15:01:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NGCDF9z2c14nlEnUFcW6oNu+70ItVGtSRLZ3RZiYKIxDwmg1+VZi6g4U8JV+mxNFvgntOpzCYsT2Z6c2e7L9fiaMz2OXg8PJfIpl55u3WboykEHb80GBiklTlxkLBER4B+pGN4eZlT2G/WnMuzUOuB7alsSCPQwAetOa/ZXNJ5M=
Received: by 10.78.151.15 with SMTP id y15mr707496hud;
        Tue, 26 Sep 2006 15:01:09 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id c18sm3072757hub.2006.09.26.15.01.07;
        Tue, 26 Sep 2006 15:01:09 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609262203510.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27828>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 26 Sep 2006, A Large Angry SCM wrote:
> 
>> 							20060926.1715
> 
> You forgot the time zone ;-)

UTC of course. ;-)

[...]
> 
> After skimming your text, I imagine that it should be possible (read: 
> easy) to write a really simple script which does what you describe, 
> storing the relevant information about root or sub projects in the config.
> 
> However, you left out one of the most important aspects of subprojects: 
> the ability to manage the state of the root project: you can add, update 
> and remove subprojects.

Since each project can have subprojects, the root project is special 
_only_ in that the initial checkout is _not_ handled by the build 
machinery (make in my example). This means that adding and removing 
subprojects should be no different for the root project. A subproject 
should be able to stand on its own (with its subprojects); otherwise, 
it's not a project but instead a directory tree versioned separately.

> A while ago, Junio started playing with a new object type for subprojects 
> so that you could have tree objects containing subprojects in addition 
> to tree objects and blobs.

Which I though was awful. Subprojects are really much better managed by 
the build machinery; it's more flexible and doesn't require all the 
separate projects to use the same VCS.

> Of course, the difficult thing about this is to teach all tools to behave 
> sensibly with the new object type.

And teach all the tools to gracefully handle subprojects using a 
different VCS ...

> Now, your approach of having multiple clones (sharing the object pool) is 
> more simple than Junio's approach: no need to introduce a new object type, 
> or adapt existing tools.
> 
> Taking this a step further, how about managing the root project in this 
> manner:
> 
> A root project is a branch containing just one special file, 
> "root-project". This file consists of lines like these:
> 
> -- snip --
> f80a17bf3da1e24ac904f9078f68c3bf935ff250 next
> 03adf42c988195b50e1a1935ba5fcbc39b2b029b todo
> -- snap --
> 
> The meaning: subdirectory "next" contains subproject "next" which is also 
> tracked in the branch "next" of the root project. Likewise for "todo". The 
> root project could even contain some administrative files like a Makefile, 
> a license, README, etc.

How the state (subproject list, branch names, etc.) is recorded in a 
parent project is only important to the parent project. The parent 
project must also know how to interact with with each of its subprojects.

For instance, if you were building some kind of internet appliance, it 
could have a very large number of subprojects (kernel, various servers 
and daemons, etc) with no common build tool or target set used by all of 
them. What each parent project does in this situation is to "interface" 
to the build machinery of each subproject so that when you command "make 
appliance image" at the top level project, all the subprojects _and_ the 
top level project do what is need to create the appliance image. The 
appliance can depend on projects using many VCS'; Git for the kernel, 
SVN for the web server, CVS for the SMTP daemon, Monotone for some other 
part, etc.

> You could even handle the update of root-project with each commit in a 
> subproject by a hook in that subproject's .git/hooks/post-commit, so that 
> you'd only need a script "git-checkout-root-project.sh" to initialize them 
> all, and probably a script "git-update-root-project.sh".

For _full_ subproject support, handling a tree of projects is required. 
So treating the root project differently that any other parent project 
(except of the initial checkout of the root project), means that you 
can't work a subproject independent of its parent projects.
