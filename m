From: Michael Heerdegen <michael_heerdegen@web.de>
Subject: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Tue, 17 May 2016 01:33:33 +0200
Message-ID: <87vb2d37ea.fsf@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yuri Khan <yuri.v.khan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:40:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2S7T-0005dB-A7
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbcEPXkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:40:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:58577 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbcEPXkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:40:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b2S7I-0005Zz-2n
	for git@vger.kernel.org; Tue, 17 May 2016 01:40:04 +0200
Received: from dslb-094-217-122-112.094.217.pools.vodafone-ip.de ([94.217.122.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2016 01:40:04 +0200
Received: from michael_heerdegen by dslb-094-217-122-112.094.217.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2016 01:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-094-217-122-112.094.217.pools.vodafone-ip.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
Cancel-Lock: sha1:cG5Lnx6S5VfbeDhm6bEkEyeM2/8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294819>

Hello,

the command

   git log --pretty=format:%ad --date=format:%s

displays wrong unixtime values; apparently how much the printed value
differs from the expected value depends on the system's time zone and
whether daylight savings time is enabled or not.

Here is a reproducible recipe compiled by Yuri Khan who helped me
localizing the problem and whom I CC'd:

0. Versions

    $ git --version
    git version 2.8.2

    $ dpkg -l tzdata | tail -1
    ii  tzdata  2016d-0ubuntu0.16.04 all  time zone and
daylight-saving time data

1. Initialize an empty Git repository:

    $ git init test
    $ cd test

2. Make a commit, using the Europe/Berlin time zone:

    $ TZ=Europe/Berlin git commit -m 'test' --allow-empty

3. Examine the timestamp recorded in the commit object:

    $ git cat-file -p HEAD | grep author
    author Yuri Khan <yurivkhan@gmail.com> 1463260938 +0200

4. Check that it corresponds to the current time:

    $ date +%s
    1463260977

5. Try to get the commit date in the unixtime format:

    $ TZ=Europe/Berlin git log --pretty=format:%ad --date=format:%s -1

Expected result: 1463260938 (same as recorded in the commit object).
Observed result: 1463264538 (3600s = one hour ahead).

For lulz, use another time zone:

    $ TZ=Asia/Novosibirsk git log --pretty=format:%ad --date=format:%s -1

Expected result: 1463260938 (unixtime is always UTC and should not
depend on TZ).
Observed result: 1463246538 (-14400s = 4 hours behind).

Not even specifying the UTC time zone helps:

    $ TZ=UTC git log --pretty=format:%ad --date=format:%s -1

Expected result: still 1463260938.
Observed result: 1463268138 (7200s = 2 hours ahead).


FWIW, personally I have not bound the TZ environment variable, my time
zone is constantly that of Berlin, currently CEST.

Many thanks in advance,


Michael.
