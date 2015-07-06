From: Mike Hommey <mh@glandium.org>
Subject: suboptimal behavior of fast-import in some cases with "from"
Date: Tue, 7 Jul 2015 07:07:46 +0900
Message-ID: <20150706220746.GA29367@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 00:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCEYR-00027L-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 00:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbbGFWHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 18:07:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45334 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbbGFWHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 18:07:51 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZCEYE-0007yY-M2
	for git@vger.kernel.org; Tue, 07 Jul 2015 07:07:46 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273465>

Hi,

I did something "stupid" with a script using fast-import, and that made
the whole process ~20% slower on Linux and 400~500% slower on Mac. The
reason this happened is that the script was essentially adding a "from"
to every "commit" command, even when the "from" commit is the current
head of the branch.

One of the first things parse_from does is unconditionally throw away
the tree for the given branch, and then the "from" tree is loaded. So
when the "from" commit is the current head of the branch, that make
fast-import do more work than necessary.

Even more so when the pack flush code in gfi_unpack_entry is triggered,
which, on mac, is extra slow (and explains the huge slow down there).

Now, I do understand that my script is doing something stupid. So the
question is whether it's worth fixing in fast-import or not. I already
fixed my script anyways.

Mike
