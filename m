From: Jason Woofenden <jason@jasonwoof.com>
Subject: bug: git mv dir with submodule in dir/sub
Date: Tue, 3 Mar 2015 10:52:07 -0500
Message-ID: <20150303155207.GM30045@compy.jasonwoof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 17:12:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSpQn-0007Ic-4u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 17:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbbCCQMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 11:12:19 -0500
Received: from jasonwoof.com ([50.116.60.104]:52767 "EHLO jasonwoof.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157AbbCCQLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 11:11:43 -0500
X-Greylist: delayed 1173 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2015 11:11:43 EST
Received: from localhost (jasonwoof.com [127.0.0.1])
	by jasonwoof.com (Postfix) with ESMTP id B03188E6B3
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 10:52:09 -0500 (EST)
X-Spam-Flag: NO
X-Spam-Score: 0.798
X-Spam-Level: 
X-Spam-Status: No, score=0.798 tagged_above=-9999 required=6.31
	tests=[BAYES_00=-1.9, DNS_FROM_AHBL_RHSBL=2.699, NO_RECEIVED=-0.001,
	NO_RELAYS=-0.001, URIBL_BLOCKED=0.001] autolearn=no
Received: from jasonwoof.com ([127.0.0.1])
	by localhost (jasonwoof.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsZ1eV_XPAb3 for <git@vger.kernel.org>;
	Tue,  3 Mar 2015 10:52:09 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264668>

Hi all,

First, many thanks for all your work on git. It has been an
invaluable tool.

I believe I've found a bug. Submodules break when I use ``git mv``
to rename a directory, which contains a submodule as one of its
_sub_directories.

Here's the script I've been using to reproduce:

	#!/bin/bash

	# Settings
	REPO_TO_CLONE="$HOME/www/wfpl.git"

	# run in new directory
	export REPODIR="git-bug-$(date '+%s')"
	mkdir "$REPODIR" || exit $?
	cd "$REPODIR" || exit $?

	git --version

	# make a git repo with a submodule
	git init || exit $?
	mkdir old || exit $?
	git submodule add ~/www/wfpl.git old/wfpl || exit $?

	# run the command that borks the submodule
	git mv old new || exit $?

	# demonstrate that it's borked:
	git status || exit $?
	# for me this command produces:
	#     fatal: Could not chdir to '../../../../old/wfpl': No such file or directory
	#     fatal: 'git status --porcelain' failed in submodule new/wfpl

I run that and get this:

	git version 2.3.1.431.g836cf63
	Initialized empty Git repository in
	/home/jasonwoof/git-bug/git-bug-1425397321/.git/
	Cloning into 'old/wfpl'...
	done.
	fatal: Could not chdir to '../../../../old/wfpl': No such file or
	directory
	fatal: 'git status --porcelain' failed in submodule new/wfpl
	zsh: exit 128   ./script.sh

I got this same error (every time) with git-2.1.4-2.1 from debian
unstable, and from github's master (7f4ba4b6e3ba7), and from
github's pu branch (836cf6345)

All of the above running on debian unstable.

You'll need to change REPO_TO_CLONE of course.

It's probably worth noting that if I use ``git mv`` on the
submodule directly, it works fine. eg if I replace the ``git mv``
line in the above script with:

	mkdir new
	git mv old/wfpl new/wfpl

then it works fine (no error messages).


I am not subscribed to this list, so please remember to reply-all
if I can be of further assistance.

Thanks you!

-- 
Jason
