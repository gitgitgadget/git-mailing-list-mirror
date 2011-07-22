From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [REGRESSION, BISECTED] `git checkout <branch>` started to be
	memory hog
Date: Fri, 22 Jul 2011 17:05:18 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 15:23:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkFhK-0007QW-C0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 15:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1GVNXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 09:23:17 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:43450 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158Ab1GVNXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 09:23:16 -0400
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jul 2011 09:23:16 EDT
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1QkFQr-00068x-3F; Fri, 22 Jul 2011 17:06:21 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1QkFPq-0002fB-8e; Fri, 22 Jul 2011 17:05:18 +0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177643>

Hello up there,

Today I've tried to upgrade to linux-3.0 on my netbook with 1GB of RAM,
with today's Git master (v1.7.6-233-gd79bcd6) and Git was killed by an OOM:

    $ git new-workdir linux linux-3.0 linux-3.0.y
    Checking out files: ~80% (XXXXX/36783)
    Aborted
    (with OOM messages in dmesg).

git new-workdir boils down to (uninteresting to the issue) symlinks
setup + final `git checkout -f <branch>` and that final git checkout is
failing.


It turned out that with Git v1.7.6 memory usage for git-checkout
linux-3.0.y as seen in top is

    VIRTmax     RESmax

    ~338M       ~247M

and for master

    VIRTmax     RESmax
    (both till not killed)
   ~2200M       ~1000M


i.e. it looks like when residential memory usage approaches the amount of
physical RAM, the OOM killer comes into play.


And I've bisected this to b6691092 ("Add streaming filter API"; Junio C
Hamano, May 20 2011; merged to next on Jun 30 2011):

    commit b6691092d707860019bbab80eaaf9173ada10586
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Fri May 20 14:33:31 2011 -0700

        Add streaming filter API

        This introduces an API to plug custom filters to an input stream.

        The caller gets get_stream_filter("path") to obtain an appropriate
        filter for the path, and then uses it when opening an input stream
        via open_istream().  After that, the caller can read from the stream
        with read_istream(), and close it with close_istream(), just like an
        unfiltered stream.

        This only adds a "null" filter that is a pass-thru filter, but later
        changes can add LF-to-CRLF and other filters, and the callers of the
        streaming API do not have to change.

        Signed-off-by: Junio C Hamano <gitster@pobox.com>



Hope Git stays usable for us, with not enormous amount of RAM onboard,
and thanks beforehand for fixing,

Kirill
