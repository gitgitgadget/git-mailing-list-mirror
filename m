From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make git-mv work in subdirectories, too
Date: Tue, 29 Nov 2005 23:10:24 +0100
Message-ID: <20051129221024.GB3033@steel.home>
References: <Pine.LNX.4.63.0511251236060.30796@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzjsdt3z.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDgt-0007d6-Kq
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVK2WKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVK2WKl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:10:41 -0500
Received: from devrace.com ([198.63.210.113]:50957 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964781AbVK2WKk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:10:40 -0500
Received: from tigra.home (p54A0CEB2.dip.t-dialin.net [84.160.206.178])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jATMAPQd022113;
	Tue, 29 Nov 2005 16:10:26 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EhDg8-0002jq-00; Tue, 29 Nov 2005 23:10:24 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EhDg8-000375-6A; Tue, 29 Nov 2005 23:10:24 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzjsdt3z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12966>

Junio C Hamano, Sat, Nov 26, 2005 03:45:52 +0100:
> > Turns out, all git programs git-mv uses are capable of operating in
> > a subdirectory just fine. So don't complain about it.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >
> > ---
> >
> > 	I am no Perl guru, so this might not be the best way to go
> > 	about it. Also, if people agree, I would like to remove the
> > 	extra check for GIT_DIR validity, since git-rev-parse --git-dir
> > 	does that already.
> 
> I think that sounds sane.  You need to grab the exit status from
> `git-rev-parse --git-dir`, so the patch would become something
> like the attached.  I haven't seriously used git-mv myself, so
> somebody needs to test it, and if it actually works and Ack on
> it, please.

It actually works in subdirs.

--- t/t4007-mv.sh

#!/bin/sh

test_description='git-mv in subdirs'
. ./test-lib.sh

test_expect_success \
    'prepare reference tree' \
    'mkdir path0 path1 &&
     cp ../../COPYING path0/COPYING &&
     git-add path0/COPYING &&
     git-commit -m add -a'

test_expect_success \
    'moving the file' \
    'cd path0 && git-mv COPYING ../path1/COPYING'

# in path0 currently
test_expect_success \
    'commiting the change' \
    'cd .. && git-commit -m move -a'

test_expect_success \
    'checking the commit' \
    'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
    grep -E "^R100.+path0/COPYING.+path1/COPYING"'

test_done
