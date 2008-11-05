From: Roderik van der Veer |Smartlounge| 
	<roderik.van.der.veer@smartlounge.be>
Subject: Looking for the perfect git workflow
Date: Wed, 05 Nov 2008 21:10:07 +0100
Message-ID: <4911FD9F.9010103@smartlounge.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 21:12:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxojI-0003Ic-1i
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 21:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbYKEUKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 15:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbYKEUKk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 15:10:40 -0500
Received: from yorgi.telenet-ops.be ([195.130.133.69]:33097 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbYKEUKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 15:10:39 -0500
Received: from edna.telenet-ops.be (edna.telenet-ops.be [195.130.132.58])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id C1A17681E9D
	for <git@vger.kernel.org>; Wed,  5 Nov 2008 21:10:37 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 35DC5E4063
	for <git@vger.kernel.org>; Wed,  5 Nov 2008 21:10:05 +0100 (CET)
Received: from mercurius.leuven.smartlounge.be (d5152FE02.access.telenet.be [81.82.254.2])
	by edna.telenet-ops.be (Postfix) with ESMTP id 267C8E4037
	for <git@vger.kernel.org>; Wed,  5 Nov 2008 21:10:05 +0100 (CET)
Received: from [172.17.16.54] (unknown [172.17.16.54])
	by mercurius.leuven.smartlounge.be (Postfix) with ESMTP id 37E496800BE9
	for <git@vger.kernel.org>; Wed,  5 Nov 2008 21:10:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100179>

Hello,

I'm trying to work out the best way to use git in the workflow for our 
projects. We have
migrated from CVS in 2007 and are happy with it, but we have a need for 
a more structured
way of working with our different repositories.

Let me describe the project to begin with, we have developed a 
java+velocity based cms
system, and all out client sites are based upon this cms. The CMS is in 
constant
development, so there are no set releases, only new features when a 
customer has a need
for it, or bugfixes. Our project structure, that we cannot changed for 
backward
compatibility is something like this:

   * project x
         o src
               + cms
               + components
                     # forum
                     # blog
                     # etc
               + shop
               + project x
         o Webroot
               + images
               + html
               + velocity
                     # cms
                     # components
                           * forum
                           * blog
                           * etc
                     # shop
                     # project x


We have a git repository for the base cms system containing everything 
but the "project
x" folders and the html folder. This git repository contains the base 
files (database
transaction layer etc) but also global modules like the "blog" module. 
The projects
extend these base files to create the client's website, the project 
files are contained
in folders different from the base folders. An added difficulty is that 
every java source
folder, has a velocity template folder structure, so for the module 
"blog" there are two
folders "blog" in src and "blog" in webroot. The html folder in webroot 
contains the html
files and images created by a third party and are updated by a rsync 
script from their
server (they cannot use git). So to summarise:

   * project x
         o src
               + cms (BASE)
               + components
                     # forum (BASE - FORUM)
                     # blog (BASE - BLOG)
                     # etc (BASE - ETC)
               + shop (BASE - SHOP)
               + project x (PROJECT)
         o Webroot
               + images (BASE)
               + html (THIRD PARTY)
               + velocity
                     # cms (BASE)
                     # components
                           * forum (BASE - FORUM)
                           * blog (BASE - BLOG)
                           * etc (BASE - ETC)
                     # shop (BASE - SHOP)
                     # project x (PROJECT)


The cvs and basic git workflow was:

changes from BASE went into the project like this: BASE -> a custom 
rsync script ->
PROJECT
changes for BASE from PROJECT were merged back by hand, eighter in 
master, or in a
feature branch

Since moving to git we started using the feature branches for big new 
features, and just
used master for bugfixes. We developped the client sites using the 
master branch combined
with some feature branches. The moment the site was live, the feature 
branches were
considered stable and supported, and were merged into master.

So, what's the problem,

1. regressions, because to get a bugfix, you get stuffed with some new 
feature or
refactoring. Just keeping everything as branches means you have a lot of 
work to build a complete version for the project.
2. merging back by hand is a pain, since you can't forget any templates etc.
3. since BASE contains all the global, non site specific modules, every 
project has the
SHOP code, even if it isn't a webshop.

What have we looked at:

1. git submodules -> since every module has two folders, and we don't 
want two git
repositories for one module

2. A currently running experiment has an origin remote (the project repo 
on our central
server) for it's master and some feature branches. And a remote to the 
BASE repo, with a
checked out branch for that specific project.

   * PROJECT X
         o BASE - remote
               + project-x
         o ORIGIN - remote
               + master
               + feature x
               + feature y

When we start the project x project, we merge the BASE/project-x branch 
into
ORIGIN/master and start from there. This way we can cherry pick changes 
to BASE, and
control the flow from BASE/master to BASE/project-x and from 
BASE/project-x into
ORIGIN/master

This works fairly good except that plain "git push" wants to put the 
local version of master into
BASE/master (and that is really not the way we want it) and it's bound 
to happen that someone forgets to add extra params to the command. And 
we have no real way of dealing with problem number 3 (the modules)

So in short, i'm looking for some insight, to create a foolproof 
framework to deal with
this kind of setup.

Regards,
Roderik

-- 
==========================================
Roderik van der Veer
roderik.van.der.veer@smartlounge.be
==========================================
Smartlounge
JP Minckelersstraat 78
B-3000 Leuven
tel: +32 16 311 412
gsm: +32 486 36 66 39
==========================================
http://www.smartlounge.be
==========================================
internet application development & hosting
