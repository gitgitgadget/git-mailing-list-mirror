From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v3] Add git-grep threads param
Date: Tue, 27 Oct 2015 02:14:25 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FE@mail.accesssoftek.com>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>,<CA+55aFwrU25x25XrRODgS1oRXqN60rmYPiXLgfs3mqRco4Oi9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0Ku-0007AW-87
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbJ0JO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:14:28 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:56270 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbbJ0JO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 05:14:27 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 27 Oct 2015 02:14:26 -0700
Thread-Topic: [PATCH v3] Add git-grep threads param
Thread-Index: AdEQiyDmh0fQJbXWS1qr96nKVElQmAACVtS+
In-Reply-To: <CA+55aFwrU25x25XrRODgS1oRXqN60rmYPiXLgfs3mqRco4Oi9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280248>

Hello Linus, 

>> According to several tests on systems with different number of CPU cores
>> the hard-coded number of 8 threads is not optimal for all systems:

> Did you also compare cold-cache filesystem performance?

>  One of the reasons for doing threaded grep is for CPU scaling. But another is for IO scaling. If your git tree is over NFS, doing grep eight threads at a time if likely going to make things much faster even if you are on a single CPU.

Yes, I have performed tests on cold-cache FS and it looks like number of threads affects performance. Here are the results for grepping linux kernel repo on a 4-core machine (similar test was conducted on 8-core machine):

Threads: 4 Time: 39.13
Threads: 8 Time: 34.39
Threads: 16 Time: 31.46
Threads: 32 Time: 27.40

Here is test scenario:

#!/bin/bash
TIMEFORMAT=%R
GIT=/home/del/git-dev/bin/git
TESTS=10
for n in 4 8 16 32; do
    echo -n "Threads: $n Time: "
    for i in $(seq 1 $TESTS); do
        echo 3 > /proc/sys/vm/drop_caches
        time $GIT grep --threads $n -e '#define' --and \( -e MAX_PATH -e PATH_MAX \)  >/dev/null
    done 2>&1 | awk -v ntests=${TESTS} '{sum+=$1} END{printf "%.2f\n", sum/ntests}'
done

Note: With hot-cache grepping with 4 threads gives fastest results on both 4-core and 8-core machines.

Thus I think it can be useful for users to be able to tune the threads number according to their needs.
