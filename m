From: Josef Wolf <jw@raven.inka.de>
Subject: Trying to split repository
Date: Thu, 1 Oct 2009 18:03:35 +0200
Message-ID: <20091001160335.GA26068@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 18:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtOYs-00063z-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 18:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbZJAQbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 12:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbZJAQbN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 12:31:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:58034 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238AbZJAQbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 12:31:12 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2009 12:31:12 EDT
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1MtOCy-0002Go-Q0; Thu, 01 Oct 2009 18:08:44 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id C99EB2CBF0; Thu,  1 Oct 2009 18:03:35 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129399>

Hello,

One of my repositories has grown a subdirectory that I'd like to split off,
so other can use it as a subproject. With the help of google, I found this
solution:

    # first extract the library from the original repository
    #
    git clone --no-hardlinks repository library.tmp
    (
        cd library.tmp
        git filter-branch --subdirectory-filter CF -- --all
        git reset --hard
        git gc --aggressive
        git prune
        git gc
        git clone --bare . ../library
    )
    rm -rf library.tmp


    # Now remove the library from the original repository, so it can be
    # included as a subproject
    #
    git clone --no-hardlinks repository repository.new.tmp
    (
        cd repository.new.tmp
        git filter-branch \
            --index-filter "git rm -r -f --cached --ignore-unmatch CF" \
            -- --all
        git reset --hard
        git gc --aggressive
        git prune
        git gc
        git clone --bare . ../repository.new
    )
    rm -rf repository.new.tmp

This works fine. But there's one problem, though. "gitk --all" in the new
repository still shows all the history of the removed library. The patch
show no modifications, but the log entry is still there.

Any hints how to get rid of those log entries?
