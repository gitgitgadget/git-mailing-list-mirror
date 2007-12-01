From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: Some git performance measurements..
Date: Sat, 01 Dec 2007 12:36:04 +0100
Message-ID: <85abou8x5n.fsf@lupus.ig3.net>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 12:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyQeN-0003g9-Fm
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 12:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXLALgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 06:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbXLALgU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 06:36:20 -0500
Received: from main.gmane.org ([80.91.229.2]:43481 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbXLALgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 06:36:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IyQdq-0002ln-3p
	for git@vger.kernel.org; Sat, 01 Dec 2007 11:36:14 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 11:36:14 +0000
Received: from cjhaga by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 11:36:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:WLC6jvsdGHaqOUPl/hPG4/sbuHA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66711>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The pack-files (both index and data) are accessed somewhat randomly, but 
> there is still enough locality that doing read-ahead and clustering really 
> does help.

They are dense enough that slurping them in whole is 20% faster, at 
least here. And much less noisy! These are both cache-cold tests.

$ time git read-tree -m -u HEAD HEAD

real    0m9.255s
user    0m0.832s
sys     0m0.196s

$ time (cat .git/objects/pack/* .git/index >/dev/null; git read-tree -m -u HEAD HEAD)

real    0m7.141s
user    0m0.936s
sys     0m1.912s


Now, I don't know how useful this is since git doesn't know if the
data are cached. Is it perhaps possible to give a hint to the
readahead logic that it should try to read as far as possible?


-j.
