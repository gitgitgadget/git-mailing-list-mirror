From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Tue, 13 Oct 2009 19:13:17 +0100
Message-ID: <hb2fvu$8qi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 20:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm3A-0006Ju-4W
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760848AbZJMSOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760610AbZJMSOt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:14:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:40486 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbZJMSOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:14:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxlsY-0000iA-GK
	for git@vger.kernel.org; Tue, 13 Oct 2009 20:13:46 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 20:13:46 +0200
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 20:13:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130176>

Hello,

I'm trying to clone an existing subversion repository (Restlet: 
http://restlet.tigris.org/source/browse/). I'm using Git 1.6.5. The 
layout of the project is like this:
   trunk/
   branches/1.0
   branches/1.1
   tags/1.0/1.0b1
   tags/1.0/1.0b2
   ...
   tags/1.0/1.0.1
   ...
   tags/1.1/1.1.0
   tags/1.1/1.1.1
   ...

Therefore, I've tried to use this (with and without '-T trunk', but 
that's a separate problem):

   git init
   git svn init --prefix=svn/ -t tags/1.0 -t tags/1.1 -t tags/1.2 -t 
tags/2.0 -b branches/1.0 -b branches/1.1 
http://restlet.tigris.org/svn/restlet
   git svn fetch


This takes a while (I've had to interrupt this) and this creates a 
number of branches such as:
   remotes/svn/tags/1.0b1
   remotes/svn/tags/1.0b2
   remotes/svn/tags/1.0b3
   remotes/svn/tags/1.0b3@1883
   remotes/svn/tags/1.0b3@323


What surprises me is that it looks like it's looping over and over, 
since sometimes it starts back from SVN revision 1 when it's trying to 
import a new tag.

Tt starts like this:
> 
> Checked through r101
> Checked through r201
> Checked through r301
>       A       www/index.html
> r1 = 2ec77afc2e491e2b7c825cb685101e3bcbe7a8f7 (refs/remotes/svn/tags/1.0b1@312)
>         A       source/impl/License.txt
>         A       source/impl/Copyright.txt
>         A       source/impl/org/restlet/UniformInterface.java
>         A       source/impl/org/restlet/RestletException.java
> ...

Then, when it reaches r312, it starts again at r1:

> r312 = 5b40558b5bb2b4b04f9520f89b699ff6b0f50cdb (refs/remotes/svn/tags/1.0b1@312)
> r313 = 7ebcbd9da535cfdc23aacb612271e625445a7516 (refs/remotes/svn/tags/1.0b1@1881)
> r1882 = aed1582d4868a1be8ae8fcc0f15546822099f339 (refs/remotes/svn/tags/1.0b1)
> Checked through r101
> Checked through r201
> Checked through r301
>       A       www/index.html
> r1 = 2ec77afc2e491e2b7c825cb685101e3bcbe7a8f7 (refs/remotes/svn/tags/1.0b2@321)
>         A       source/impl/License.txt
>         A       source/impl/Copyright.txt
>         A       source/impl/org/restlet/UniformInterface.java
>         A       source/impl/org/restlet/RestletException.java
>         A       source/impl/org/restlet/AbstractRestlet.java
>         A       source/impl/org/restlet/connector/Resolver.java

(And so on for each tag).

This seems particularly inefficient and unfriendly for the resource 
provider (I stopped as soon as I noticed). Is there a better way to do this?


Best wishes,

Bruno.
