From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Is there a place for benchmarking scripts?
Date: Wed, 26 Oct 2011 11:50:27 +0200
Message-ID: <4EA7D7E3.2020009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 11:50:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ08D-0003VI-8b
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634Ab1JZJub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 05:50:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54036 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616Ab1JZJua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 05:50:30 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9Q9oRLn028746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 26 Oct 2011 11:50:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184253>

I've been doing a lot of benchmarking of git performance in the presence
of lots of references.  I've written a few scripts to automate the
benchmarking [1].  They are not beautiful and would require a couple of
local adjustments [2,3].  They are too time-consuming to be made part of
the usual test suite.  I wouldn't want to commit to maintaining them.
But they have certainly been useful to me, and they generate readable
output [4].

My question is: would such benchmarking scripts be welcome within the
git project?  If so, where should I put it?  Is any benchmarking
code/framework already in use?

Michael

[1] Branch "refperf" at git://github.com/mhagger/git.git

[2] For example, one script checks out specified git revisions, merges
in the "refperf" branch to get the benchmarking code, then runs tests.
This script has to be adjusted with the local name of the "refperf"
branch (e.g., "refperf" vs. "origin/refperf" vs. ...)

[3] I wanted the tests to include cases with a cold disk cache and with
a warm disk cache.  For the former, I have the script run "sync; sudo sh
-c 'echo 3 >/proc/sys/vm/drop_caches'" which obviously only works on
Linux and only when the user has password-less sudo permissions.

[4] Example (numbers are times in seconds):

===================================  ========  ========  ========
Test name                                 [0]       [1]       [2]
===================================  ========  ========  ========
branch-loose-cold                        3.32      3.25      0.55
branch-loose-warm                        0.60      0.22      0.00
for-each-ref-loose-cold                  3.71      3.46      3.45
for-each-ref-loose-warm                  0.83      0.46      0.47
checkout-loose-cold                      3.82      3.23      0.63
checkout-loose-warm                      0.58      0.21      0.01
checkout-orphan-loose                    0.58      0.20      0.00
checkout-from-detached-loose-cold        4.54      4.20      3.75
checkout-from-detached-loose-warm        1.41      1.07      0.63
branch-contains-loose-cold               4.04      3.71      3.67
branch-contains-loose-warm               0.93      0.57      0.56
pack-refs-loose                          2.31      1.92      1.91
branch-packed-cold                       0.53      0.50      0.49
branch-packed-warm                       0.02      0.02      0.03
for-each-ref-packed-cold                 1.01      0.92      0.94
for-each-ref-packed-warm                 0.26      0.27      0.28
checkout-packed-cold                    14.37      1.51      1.27
checkout-packed-warm                     0.04      0.03      0.03
checkout-orphan-packed                   0.02      0.02      0.03
checkout-from-detached-packed-cold      14.54      1.51      1.12
checkout-from-detached-packed-warm      13.85      0.82      0.46
branch-contains-packed-cold              1.03      1.04      1.01
branch-contains-packed-warm              0.37      0.38      0.39
clone-loose-cold                        13.17     11.97     12.45
clone-loose-warm                         6.86      5.40      5.83
fetch-nothing-loose                      1.24      1.11      1.52
pack-refs                                0.27      0.27      0.29
fetch-nothing-packed                     1.23      1.11      1.52
clone-packed-cold                        1.89      1.84      1.80
clone-packed-warm                        0.62      0.63      0.70
fetch-everything-cold                   12.85     13.07     13.40
fetch-everything-warm                    6.53      6.92      6.88
filter-branch-warm                   35383.91  15869.38    748.01
===================================  ========  ========  ========


[0] 703f05a (tag: v1.7.7) Git 1.7.7
    Test repository created using: t/make-refperf-repo --commits 20000
--refs 10000 --shard
[1] 2c5c66b Merge branch 'jp/get-ref-dir-unsorted'
    Test repository created using: t/make-refperf-repo --commits 20000
--refs 10000 --shard
[2] f579019 (ref-api-D) sort_ref_dir(): remove the recurse argument
    Test repository created using: t/make-refperf-repo --commits 20000
--refs 10000 --shard


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
