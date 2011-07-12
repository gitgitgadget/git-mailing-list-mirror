From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 23:15:37 +0200
Message-ID: <20110712211537.GA3220@toss.lan>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
 <20110712194540.GA21180@sigill.intra.peff.net>
 <20110712210716.GB17322@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgkJ0-0006Zc-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 23:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab1GLVPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 17:15:41 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:45976 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754037Ab1GLVPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 17:15:40 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 3AB22CDF85;
	Tue, 12 Jul 2011 23:15:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110712210716.GB17322@toss.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176981>

On Tue, Jul 12, 2011 at 11:07:16PM +0200, Clemens Buchacher wrote:
> 
> Exactly. The case I am talking about is where the patch-id's are
> different but there are no conflicts. I have worked out an example
> for git and darcs. Below are two scripts to demonstrate.

Oops, that was the same script twice. Here are the darcs and git
versions, respectively:

#!/bin/sh
#
# Darcs recognizes matching upstream changes
#

testdir=test-darcs

mkdir "$testdir" || exit 1

(
	cd "$testdir"
	mkdir master
	cd master
	darcs init

	for line in $(seq 20)
	do
		echo $line >>file
	done

	darcs add file
	darcs record -a -m initial

	cd ..
	darcs get master side
	cd side
	sed -i '5 s/^.*$/original change/' file
	darcs record -a -m 'original change'

	cd ../master
	sed -i '5 s/.*/original change/' file
	sed -i '15 s/^.*$/with an extra hunk/' file
	darcs record -a -m 'original change'

	sed -i '5 s/.*/modified change/' file
	darcs record -a -m 'modified change'

	darcs pull -a ../side
)


#!/bin/sh
#
# Git does not recognize matching upstream changes
#

testdir=test-git

mkdir "$testdir" || exit 1

(
	cd "$testdir"
	git init -q

	for line in $(seq 20)
	do
		echo $line >>file
	done

	git add file
	git commit -q -m initial

	git checkout -q -b side
	sed -i '5 s/^.*$/original change/' file
	git add file
	git commit -q -m 'original change'

	git checkout -q master
	sed -i '5 s/.*/original change/' file
	sed -i '15 s/^.*$/with an extra hunk/' file
	git add file
	git commit -q -m 'original change'

	sed -i '5 s/.*/modified change/' file
	git add file
	git commit -q -m 'modified change'

	git rebase master side
	git diff
)
