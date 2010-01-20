From: Andre Loker <loker@gmx.de>
Subject: Error when cloning gc'ed repository
Date: Wed, 20 Jan 2010 11:45:21 +0100
Message-ID: <hj6ms0$vcg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXY8j-0006Y0-MS
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab0ATKuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856Ab0ATKuL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:50:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:42087 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab0ATKuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:50:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXY8S-0006Q5-Q3
	for git@vger.kernel.org; Wed, 20 Jan 2010 11:50:04 +0100
Received: from p5dca2397.dip0.t-ipconnect.de ([93.202.35.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:50:04 +0100
Received: from loker by p5dca2397.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5dca2397.dip0.t-ipconnect.de
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137542>

Hi,

First of all, my setup:

Server:
Win 2008
cygwin git 1.6.6, built from source
gitosis

Client:
Win 7
cygwin git 1.6.6, built from source

The server is hosting several repositories, they all work fine, except 
for one (at least I've experienced the following error with only one of 
the repos). For this repository, cloning fails if the repository has 
been repacked (or gc'ed) on the client side:

$ git clone git@theserver:the/repository.git
Initialized empty Git repository in /e/Temp/dr/.git/
remote: Counting objects: 1396, done.
remote: Compressing objects: 100% (654/654), done.
fatal: The remote end hung up unexpectedly
fatal: early EOFs:  47% (657/1396)
fatal: index-pack failed

However, if I unpack the objects completely and delete the pack file, I 
can clone the repository without any problem:

$ git clone git@theserver:the/repository.git
Initialized empty Git repository in /e/Temp/dr/.git/
remote: Counting objects: 1396, done.
remote: Compressing objects: 100% (1293/1293), done.
remote: Total 1396 (delta 639), reused 0 (delta 0)
Receiving objects: 100% (1396/1396), 4.99 MiB | 1.70 MiB/s, done.
Resolving deltas: 100% (639/639), done.

fsck shows no error

Does this problem sound familiar to anyone? May it's a network issue, 
but other repositories (also larger ones) work flawlessly even when in a 
packed state. Any help is appreciated!

Kind regards,
Andre Loker

P.S.:

Here's a trace:
$ GIT_TRACE=1 git clone git@theserver:the/repository.git
trace: built-in: git 'clone' 'git@theserver:the/repository.git'
Initialized empty Git repository in /e/Temp/dr/.git/
trace: run_command: 'ssh' 'git@theserver' 'git-upload-pack 
'\''the/repository.git'\'''
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 5208 on Phobos'
trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 5208 on Phobos'
remote: Counting objects: 1396, done.
remote: Compressing objects:  19% (125/654)   race: exec: 
'git-index-pack' '--stdin' '-v' '--fix-thin' '--keep=fetch-pack 5208 on 
Phobos'
remote: Compressing objects:  21% (138/654)
remote: Compressing objects: 100% (654/654), done.
fatal: The remote end hung up unexpectedly
fatal: early EOFs:  88% (1229/1396), 4.76 MiB | 9.23 MiB/s
fatal: index-pack failed

And here's a trace of a successful run:

$ GIT_TRACE=1 git clone git@theserver:the/repository.git
trace: built-in: git 'clone' 'git@theserver:the/repository.git'
Initialized empty Git repository in /e/Temp/dr/.git/
trace: run_command: 'ssh' 'git@theserver' 'git-upload-pack 
'\''the/repository.git'\'''
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 4624 on Phobos'
trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 4624 on Phobos'
trace: exec: 'git-index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 4624 on Phobos'
trace: run_command: 'git-index-pack' '--stdin' '-v' '--fix-thin' 
'--keep=fetch-pack 4624 on Phobos'
remote: Counting objects: 1396, done.
remote: Compressing objects: 100% (1293/1293), done.
remote: Total 1396 (delta 639), reused 0 (delta 0)
Receiving objects: 100% (1396/1396), 4.99 MiB | 1.68 MiB/s, done.
Resolving deltas: 100% (639/639), done.
