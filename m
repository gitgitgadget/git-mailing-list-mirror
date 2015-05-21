From: Mike Hommey <mh@glandium.org>
Subject: Occasional wrong behavior of rev-walking (rev-list, log, etc.)
Date: Thu, 21 May 2015 15:15:53 +0900
Message-ID: <20150521061553.GA29269@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 08:16:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvJlz-0001Jo-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 08:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbbEUGP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 02:15:59 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:44642 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbbEUGP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 02:15:58 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1YvJlp-0007ni-Q3
	for git@vger.kernel.org; Thu, 21 May 2015 15:15:53 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269560>

Hi,

I noticed that in some weird cases, git rev-list and friends would
appear to not do their work as intended. As I wasn't entirely sure at
the time I saw previous occurrence (which involved lots of refs and
big history) , I kept that on the side to look back later, but today,
it happened again on a somewhat smaller testcase, albeit, on a big
repository.

I was able to reproduce it with the following:

$ git clone https://github.com/mozilla/gecko-dev
$ cd gecko-dev
$ git checkout -b a 4d3f25020072867e19ad6d840a73c8d77ea040bd
$ git commit --allow-empty -m a
$ git checkout -b b e90de3e5e045428e8f2b732882736dc93ce05f14
$ git commit --allow-empty -m b
$ git merge a -m merge

Now here's the problem:

$ git rev-list e90de3e5e045428e8f2b732882736dc93ce05f14..b | wc -l
86

But:
$ git rev-list e90de3e5e045428e8f2b732882736dc93ce05f14 | grep 4d3f25020072867e19ad6d840a73c8d77ea040bd
4d3f25020072867e19ad6d840a73c8d77ea040bd

So 4d3f25020072867e19ad6d840a73c8d77ea040bd is in
e90de3e5e045428e8f2b732882736dc93ce05f14's history, which means the only
thing that's on top of e90de3e5e045428e8f2b732882736dc93ce05f14 in b is
the 3 commits created above.

My guess is that rev-walking is tripping on the fact that this repository
has commit dates in random order.

Mike
