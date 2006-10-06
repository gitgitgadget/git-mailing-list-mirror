From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Problem setting up public packed repository
Date: Fri, 6 Oct 2006 23:49:31 +0200
Message-ID: <20061006214931.GA18555@poseidon.issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 06 23:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVxZc-0003uj-0O
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 23:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJFVtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 17:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWJFVtf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 17:49:35 -0400
Received: from outmx026.isp.belgacom.be ([195.238.4.91]:47533 "EHLO
	outmx026.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1422985AbWJFVte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 17:49:34 -0400
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
        by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k96LnSuM032315
        for <git@vger.kernel.org>; Fri, 6 Oct 2006 23:49:28 +0200
        (envelope-from <takis.issaris@uhasselt.be>)
Received: from localhost ([87.67.20.207])
        by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k96LnKAP032255
        for <git@vger.kernel.org>; Fri, 6 Oct 2006 23:49:21 +0200
        (envelope-from <takis.issaris@uhasselt.be>)
Received: by localhost (Postfix, from userid 1000)
	id 62B938C40D; Fri,  6 Oct 2006 23:49:31 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28445>

Hi

I'm having trouble setting up a public GIT repository. After using git-push
everything works fine, but the repository is _big_ (261MB). But, I can clone it
without any problem. If I "git-pack -a -d" and "git-prune-packed" it, the
repository is nicely shrinked to 14MB _but_ I can't clone it anymore. It starts
alright and seems to look for the pack, but it just hangs at that point...

To illustrate this, I have made a "cp -lr" copy of that public tree [1], one as it
was after git-push (well in fact, it it a packed/prune-packed one, unpacked
again) and another which is packed/prune-packed (the 14MiB one).

Trying to clone it shows this (both with git-clone and cg-clone):

takis@poseidon:/tmp$ cg-clone http://lumumba.uhasselt.be/takis/git/ffmpeg-h264.git
defaulting to local storage area
Fetching head...
Fetching objects...
progress: 38 objects, 159434 bytes
cg-clone: interrupted

takis@poseidon:/tmp$ cg-clone http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git
defaulting to local storage area
Fetching head...
Fetching objects...
Getting alternates list for http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git/
Getting pack list for http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git/
progress: 0 objects, 0 bytes
cg-clone: interrupted


With the packed/prune-packed repository it just hangs with the "progress: 0
objects, 0 bytes" message. So, I decided to have look what might be going on, if
any data was actually getting in and that I was maybe just being to impatient:

takis@poseidon:/tmp/a$ ps x|grep git
18386 pts/9    S+     0:00 /bin/sh /home/takis/bin/git-clone http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git
18400 pts/9    S+     0:00 git-http-fetch -v -a -w heads/master heads/master http://lumumba.uhasselt.be/takis/git/ffmpeg-h264-test.git/
18416 pts/10   S+     0:00 grep git

takis@poseidon:/tmp/a$ strace -f -p 18400
Process 18400 attached - interrupt to quit
select(0, [], [], [], {0, 48000})       = 0 (Timeout)
poll([{fd=4, events=POLLIN}], 1, 0)     = 0
gettimeofday({1160169868, 454932}, NULL) = 0
gettimeofday({1160169868, 454989}, NULL) = 0
select(0, [], [], [], {0, 50000})       = 0 (Timeout)
poll([{fd=4, events=POLLIN}], 1, 0)     = 0
gettimeofday({1160169868, 506226}, NULL) = 0
gettimeofday({1160169868, 506277}, NULL) = 0
select(0, [], [], [], {0, 50000})       = 0 (Timeout)
poll([{fd=4, events=POLLIN}], 1, 0)     = 0
gettimeofday({1160169868, 558245}, NULL) = 0
gettimeofday({1160169868, 558296}, NULL) = 0
select(0, [], [], [], {0, 50000})       = 0 (Timeout)
poll([{fd=4, events=POLLIN}], 1, 0)     = 0
gettimeofday({1160169868, 610227}, NULL) = 0
gettimeofday({1160169868, 610277}, NULL) = 0
...

And this goes on and on and on... and there seems to be no data getting in.
(Ofcourse at first I had just done a "du -h" of the clone target dir, but that
didn't grow. To make sure git wasn't using a hidden dir somewhere or keeping all
the pulled-in-data in-memory or something, I decided to look with strace).

What am I doing wrong? Any hints?

I am using the current git-GIT.

Thanks in advance for any replies! :)

With friendly regards,
Takis

[1] I know about the "-l" and "-s" flags, but I wanted to be 100% sure that it
were just copies, and no references would be pointing from here to there...
