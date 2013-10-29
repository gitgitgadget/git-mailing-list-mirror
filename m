From: Simon Ruderich <simon@ruderich.org>
Subject: Git v1.8.4.2 test failure in ./t5570-git-daemon.sh
Date: Tue, 29 Oct 2013 01:54:31 +0100
Message-ID: <20131029005430.GA23920@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 01:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaxep-00071O-IT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 01:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab3J2A7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 20:59:39 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:42068 "EHLO
	zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab3J2A7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 20:59:39 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2013 20:59:38 EDT
Received: from localhost (pD9E96CE6.dip0.t-ipconnect.de [::ffff:217.233.108.230])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Tue, 29 Oct 2013 01:54:31 +0100
  id 000000000002001A.00000000526F0747.000065DF
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236878>

Hello,

I just compiled Git v1.8.4.2 on Debian Wheezy amd64 and test
t5570 fails (with GIT_TEST_GIT_DAEMON=1):

    --- expect      2013-10-28 23:27:26.792409631 +0000
    +++ output      2013-10-28 23:27:26.788409614 +0000
    @@ -1 +1,2 @@
    +Cloning into 'nowhere'...
     fatal: remote error: access denied or repository not exported: /nowhere.git
    [18908] [19625] Disconnected (with error)
    not ok 9 - clone non-existent

    --- expect      2013-10-28 23:27:26.944410377 +0000
    +++ output      2013-10-28 23:27:26.944410377 +0000
    @@ -1 +1,2 @@
    +Cloning into 'nowhere'...
    fatal: remote error: no such repository: /nowhere.git
    [19727] [19747] Disconnected (with error)
    not ok 13 - clone non-existent

Bisecting leads to this commit:

    commit 68b939b2f097b6675c4aaa178655559aa81b25cb
    Author: Jeff King <peff@peff.net>
    Date:   Wed Sep 18 16:05:13 2013 -0400

        clone: send diagnostic messages to stderr

        Putting messages like "Cloning into.." and "done" on stdout
        is un-Unix and uselessly clutters the stdout channel. Send
        them to stderr.

        We have to tweak two tests to accommodate this:

        1. t5601 checks for doubled output due to forking, and
            doesn't actually care where the output goes; adjust it
            to check stderr.

        2. t5702 is trying to test whether progress output was
            sent to stderr, but naively does so by checking
            whether stderr produced any output. Instead, have it
            look for "%", a token found in progress output but not
            elsewhere (and which lets us avoid hard-coding the
            progress text in the test).

        This should not regress any scripts that try to parse the
        current output, as the output is already internationalized
        and therefore unstable.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
