From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: How to set up a shared repository
Date: Wed, 21 Dec 2005 19:27:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512211919040.16640@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Dec 21 19:29:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8gc-0005A8-Ow
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVLUS1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVLUS1V
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:27:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56204 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932492AbVLUS1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:27:21 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2BF9813FBA6
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 19:27:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 10B2E9E26B
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 19:27:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id F0C8B9E230
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 19:27:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E21F113FBA6
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 19:27:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13889>

Hi,

I installed a shared git repository in the last few days and this is the 
result. May it be useful!

Ciao,
Dscho

---

[Note: this text assumes you have applied the core.umask patch]

So, there you are. You know CVS (or at least its concepts), and you want 
to set up a shared repository.

A. Setting up the umask

1. Separate repository box

If you are lucky enough that you can afford a separate machine for the 
shared repository: Good. Just make sure that the umask is set group 
friendly, either by ensuring that (assuming the login shell is bash) 
$HOME/.bash_profile contains the line

	umask 0002

or by using git-shell, which you have modified by inserting

	umask(0002);

at the start of main().

2. Some server accessible by ssh

If there are valid reasons not to set umask (maybe you want to allow other 
uses of that machine), or if you just do not want to go through the hassle 
to find out which scripts your login shell executes at startup, you just 
have to

	git-repo-config core.umask 0002


B. Making sure the index is not corrupted by a push

1. No checkout!

You can use the shared repository just like you use CVS: no working 
directory. To disallow a checkout, just do

	touch .git/index
	chmod a-rwx .git/index

Every attempt to modify the index (which is invalid), will now result in 
an error.

2. Ensure index and working directory consistency (no locking)

If you want to be able to work on the project in the shared repository, 
create hooks, as follows:

	test -d .git/hooks || mkdir .git/hooks

	cat > .git/hooks/update << EOF
	#!/bin/sh
	
	# if the working directory contains modifications, do not allow push
	HEAD=$(git-symbolic-ref HEAD)
	case "$1" in
	$HEAD)
	        unset GIT_DIR
	        cd .. && test -z "$(git-diff-index --name-only HEAD)";;
	esac
	EOF

	chmod a+x .git/hooks/update

	cat > .git/hooks/post-update << EOF
	#!/bin/sh
	
	# checkout HEAD, and build
	HEAD=$(git-symbolic-ref HEAD)
	case "$1" in
	$HEAD)
	        unset GIT_DIR
		umask 0002
		cd .. && git checkout -f HEAD && make;;
	esac
	EOF

	chmod a+x .git/hooks/post-update

This assumes that your project contains a Makefile, and that the tools
necessary to build are installed on the repository server.

Note that I did not check if a push locks another push.
