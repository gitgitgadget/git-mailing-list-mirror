From: Brian Ericson <bericson@ptc.com>
Subject: Cygwin sparse checkout degrades performance
Date: Wed, 24 Dec 2014 12:30:42 -0600
Message-ID: <549B0652.3020605@ptc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 19:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3qrK-0008R6-RM
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 19:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaLXSka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 13:40:30 -0500
Received: from mx1.ptc.com ([12.11.148.188]:56287 "EHLO mx1.ptc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaLXSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 13:40:29 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Dec 2014 13:40:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ptc.com; s=ptc; t=1419446429; x=1450982429;
  h=message-id:date:from:mime-version:to:subject:
   content-transfer-encoding;
  bh=9/yn+KMuZwxx/u+H9Tkbs3Vkz3xOF8le5vbTK7aOH+U=;
  b=FNWZhCczn1/Vr41wODoDz96FGELbr7yyfEu7rw4HOGA2qqU8+fUiZfRI
   bdbiWTAq4qk2D78S2bNGYo9r1RQPmmAW3ZUk0C2qpQ5bMqX0DYMgH29Qw
   1chzFT9E8XwYu9b+wkJM9tK+1MLFjnsULp6EywZOgJHP0ozPBgAgm3Grn
   E=;
X-IronPort-AV: E=Sophos;i="5.07,639,1413259200"; 
   d="scan'208";a="40808697"
Received: from hq-x10prdhub2.ptcnet.ptc.com ([132.253.198.28])
  by mx1-int.ptc.com with ESMTP; 24 Dec 2014 13:30:52 -0500
Received: from bericson.ptcnet.ptc.com (132.253.8.81) by
 HQ-X10PRDHUB2.ptcnet.ptc.com (132.253.201.252) with Microsoft SMTP Server id
 14.3.123.3; Wed, 24 Dec 2014 13:30:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Originating-IP: [132.253.8.81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261808>

Counter-intuitively, using sparse checkout in Cygwin degrades "status" 
times as status appears to "stat" non-existent files and directories.

To demonstrate, I created a repo with 100k random files in a 
dir/dir/dir/file structure (on a linux box -- to do this in Cygwin 
requires piping the result of "openssl rand" to "dos2unix" as the output 
contains "\r") and cloned in a Cygwin shell:

git init test
cd test
git commit --allow-empty -m 'Empty first commit'
for i in {1..10}; do for j in {1..10000}; do file=$( openssl rand -hex 
32 | sed 's,^\(.\)\(.\)\(.\),\1/\2/\3/,'); mkdir -p $( dirname $file ); 
echo $file > $file ; done & done; wait
git add .
git commit -m '100000 files'
git gc --prune=now --aggressive

I then timed and plotted "git status" as sparse checkout step-wisely 
reduced the number of files in the working tree using the folllowing 
command:

( ( git status >& /dev/null; time -p git status > /dev/null ) |& sed -n 
'/real/{s/real/100000/p}'; git config core.sparseCheckout true; for i in 
$( seq 90000 -10000 10000 ) 1; do git ls-files | head -n $i | sed 
's,^,/,' > .git/info/sparse-checkout; git read-tree -u -m HEAD; git 
status >& /dev/null; ( time -p git status > /dev/null ) |& sed -n 
"/real/{s/real/$i/p}"; done; echo '*' > .git/info/sparse-checkout; git 
read-tree -u -m HEAD; rm .git/info/sparse-checkout; git config --unset 
core.sparseCheckout ) | gnuplot -p -e "set terminal dumb; set xrange[] 
reverse; set style data dots; set nokey; plot '-' using 1:2"

Vertical bar is time in seconds, horizontal the number of files in the 
working tree after the sparse checkout.

Linux results (v2.1.0):
   0.45 
.+-----+------+-----+------+------+------+------+-----+------+-----++
        +      +      +     +      +      +      +      + +      +      +
| |
    0.4 ++ ++
| |
   0.35 ++ ++
| |
| |
    0.3 ++ .                                                           ++
| |
        | .                                                     |
   0.25 ++                  . .                                       ++
        |                                 . .                          |
| |
    0.2 ++                                              . .            ++
| |
   0.15 ++                                                           . +.
| |
        +      +      +     +      +      +      +      + +      +      +
    0.1 
++-----+------+-----+------+------+------+------+-----+------+-----++
      100000 90000  80000 70000  60000  50000  40000  30000 20000 10000    0

Cygwin results (v2.1.1):
   10 
++-----+------+------+------+------+------+------+------+------+-----++
      +      +      +      +      +      +      +      + +      +      +
| .
    9 ++ ++
| .      |
| |
    8 ++ .            ++
| |
| |
    7 ++ .                   ++
| |
| |
      |                                  . .                           |
    6 ++ ++
| |
| |
    5 ++ .                                                             ++
      .                    . .                                         |
      +      +      .      +      +      +      +      + +      +      +
    4 
++-----+------+------+------+------+------+------+------+------+-----++
    100000 90000  80000  70000  60000  50000  40000  30000  20000 10000    0

Linux times do what I expect/want (they get better as the number of 
working tree files decrease), but Cygwin does the opposite: the worst 
times are in a working tree with only 1 (sparse) file, and it's double 
where I started with no sparse checkout!  I'd hoped sparse checkout 
would improve the too-slow status times when all files are present...

Looking at strace with a working tree consisting of a single (sparse) 
file suggests Cygwin is attempting to access the non-existent files and 
directories whereas Linux does not appear to do so.  In fact, if I do 
nothing more than "mkdir -p $( git ls-files | cut -c1-5 | sort -u )" 
when looking at a single (sparse) file, I can drop status times below 
3s, a 3-fold improvement and something at least better than where I started!

Is there a way I can get improved status times using sparse checkout 
with Cygwin?
