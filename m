From: Thomas Lucas <toml@zuken.co.uk>
Subject: Git Garbage Collect Error.
Date: Wed, 13 Jun 2012 11:27:04 +0100
Organization: Zuken
Message-ID: <4FD86AF8.1050100@zuken.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 12:27:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeknD-0007h8-9w
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 12:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2FMK1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 06:27:10 -0400
Received: from mail.zuken.co.uk ([94.72.213.32]:59858 "EHLO mail.zuken.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2FMK1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 06:27:09 -0400
Received: from zpo.ztc.zuken.co.uk (zpo [89.33.36.3])
	by mail.zuken.co.uk (Postfix) with ESMTP id 96FD278EB3
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 11:27:04 +0100 (BST)
Received: from [89.33.56.90] (ood.ztc.zuken.co.uk [89.33.56.90])
	by zpo.ztc.zuken.co.uk (Postfix) with ESMTP id 5AD932014A
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 11:27:02 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.2; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Stationery: 0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199887>


Hi,

Hopefully this is the right place to send bug reports... The community page 
"http://git-scm.com/community" suggests that it is.


      Introduction

I am creating a large GIT repository fetching from a large SVN repository, as an 
experiment initially. I usually use GIT repositories interfacing to parts of the 
SVN repository.


      Defect

During garbage collection (git gc) it encountered the following error:

git gc | git gc --prune :

    Counting objects: 856758, done.
    Delta compression using up to 2 threads.
    fatal: Out of memory, malloc failed (tried to allocate 303237121 bytes)
    error: failed to run repack

git gc --aggressive:

    Counting objects: 856758, done.
    Delta compression using up to 2 threads.
    fatal: Out of memory, malloc failed (tried to allocate 291942401 bytes)
    error: failed to run repack

At the moment the bare repository is about 4Gb in size and about 2/3rds the way 
through fetching.

The compression gets over 90% of the way through before this error occurs, but I 
don't think any compression results are kept, because when you repeat it has the 
same amount of work to do.

Initially this happen during an automatic gc during the fetch process. This 
aborted the fetch.

My system is XP64 2 core with 4Gb of memory and plenty of virtual memory.


      Comments

If this a genuine limitation due to the size of an object and memory handling 
limitations, then perhaps the error could be caught and the successful results 
kept. Ie. do a partial compression. That way the process could continue.


      Background

My requirement is to have GIT repositories of a source directory with all SVN 
branches included so that I can more easily merge and compare branches using 
GIT. However for even small source directories it takes weeks to fetch from the 
SVN respository (including all tags and branches), whereas fetching just the 
trunk takes a few hours. The SVN repository has over 90000 revisions. I am aware 
that I can fetch a sub-set of revisions (I don't want to at the moment), but 
I've found no way to fetch a sub-set of branches.

My config is as follows:

[svn-remote "svn"]
         url = svn://svn
         fetch = trunk:refs/remotes/svn/trunk
         branches = branches/*:refs/remotes/svn/*
         tags = tags/*:refs/remotes/svn/tags/*

I set this up using:

git svn init --prefix=svn/ --stdlayout --no-minimize-url svn://svn

To do this for individual directories I have to do the following:

git svn init --prefix=svn/ --stdlayout --no-minimize-url 
svn://svn/trunk/source/<dir>

and then edit the config manually so that:

[svn-remote "svn"]
         url = svn://svn
         fetch = trunk/source/<dir>:refs/remotes/svn/trunk
         branches = branches/*/source/<dir>:refs/remotes/svn/*
         tags = tags/*/source/<dir>:refs/remotes/svn/tags/*

This works ok but I couldn't get this result by using "git svn init" directly. 
Maybe I've missed something.

Regards,
Tom.
