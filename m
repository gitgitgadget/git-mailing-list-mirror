From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: Problem cloning packed-and-pruned http repository
Date: Fri, 6 Oct 2006 23:26:16 +0200
Message-ID: <20061006212616.GA5175@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 06 23:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVxaA-000430-NE
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWJFVuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422987AbWJFVuI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 17:50:08 -0400
Received: from student.uhasselt.be ([193.190.2.1]:2060 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP
	id S1422989AbWJFVuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 17:50:05 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by student.uhasselt.be (Postfix) with ESMTP id EFDCB1332
	for <git@vger.kernel.org>; Fri,  6 Oct 2006 23:50:03 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from lumumba.uhasselt.be (lumumba.uhasselt.be [193.190.9.252])
	by student.uhasselt.be (Postfix) with ESMTP id 1253D3B84
	for <git@vger.kernel.org>; Fri,  6 Oct 2006 23:26:17 +0200 (CEST)
Received: by lumumba.uhasselt.be (Postfix, from userid 1000)
	id D4703EDB4A; Fri,  6 Oct 2006 23:26:16 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28446>

Hi

I've been having trouble setting up a public repository using GIT. After
I have pushed my repository to a directory within ~/public_html, I can
clone it. But the repository is _big_ (261M).

So, I use "git-repack" on it and a "git-prune-packed". This makes it
nicely fit in 14MiB. If I try to clone this pruned/packed repository
again both cg-clone hangs on it (as does git-clone).

Here's two outputs demonstrating this. One repository was a "cp -lr"
clone [1] of the other, and one was packed/pruned, the other wasn't:
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

So, I tried tracing it, to see what was going on:
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
select(0, [], [], [], {0, 50000})       = 0 (Timeout)
...

And this keeps going on... so I can't see any data getting in :-(

Any hints what I might be doing wrong?

Thanks in advance for any replies! :)

With friendly regards,
Takis

[1] I am aware of "git-clone -l -s" but wanted to make fully
independent copy and wasn't sure about any links between them if only
using "-l".
-- 
OpenPGP key: http://lumumba.uhasselt.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
