From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] fix problems with recursive submodule fetching
Date: Sun, 19 Sep 2010 00:32:05 +0200
Message-ID: <4C953DE5.6020900@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 00:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox5yq-0001YM-NK
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 00:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0IRWdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 18:33:51 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42177 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0IRWdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 18:33:50 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2B4A2160B4B0E;
	Sun, 19 Sep 2010 00:32:11 +0200 (CEST)
Received: from [93.240.106.153] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Ox5x5-0002by-00; Sun, 19 Sep 2010 00:32:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/+3LK6Mrs/YWo/3VNrbXcerMt8C/MIe7SK4z8F
	gpZoXLKKgwt3OjP7gFHyv1X0wzegw77B/kZ0DQPYwKNSYCeOZa
	8LAm1FCBeg14bT0JVvTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156477>

Am 18.09.2010 02:29, schrieb Kevin Ballard:
> Yep, this patch fixes the output issue. Now all submodules are reported.

Thanks again for testing this, the first patch of this series fixes
that and adds the necessary tests to not let that happen again.

The second patch lets "git fetch" use the index instead of .gitmodules
to get the list of submodules to fetch. I think this makes sense, even
if fetch didn't need to read the index until now, but the gitlink
entries are not susceptible to configuration errors like those from
.gitmodules (And "git submodule update" uses the index via "git
ls-files" too, so we'll also avoid regressions that way).

Any objections to the second patch?


> However, they're still not prefixed with the previous layers, so it appears like all submodules are rooted in the current directory, which is obviously not true.

Yes, as promised I will address this in a patch soon to come. And I
will also post a patch to add a configuration option to control the
recursive fetching.

Junio: IMO these future patches are needed before this feature can be
merged into master.


> And of course the performance issue is still relevant.

Hmm, I think it still the right thing to do to a full fetch of all
submodule changes, as you can't possibly know at fetch time what you'll
need later. But I have to admit that "git submodule update" does some
kind of optimization, as it only fetches submodules where the commit
recorded in the superproject has changed. But IMO this aims a bit too
short, as it still can lead to commits missing in submodules (which are
on branches you didn't check out and ran "git submodule update" on).

The aim of these changes is to make you able to do a fetch before you go
onto a plane and then check out every branch of the superproject without
having a commit missing from a submodule. And even more, you should be
able to use all new submodule commits not yet committed inside the
superproject without being able to forget to fetch them before you leave.

But maybe we can reduce this performance impact by running the submodule
fetches in threads. Dunno yet, I'll look into that as soon as I have the
other two patches ready.


These patches apply to current next or jl/fetch-submodule-recursive.


Jens Lehmann (2):
  fetch: Fix a bug swallowing the output of recursive submodule
    fetching
  fetch: Get submodule paths from index and not from .gitmodules

 submodule.c                 |   26 +++++++++++++++++++-------
 t/t5526-fetch-submodules.sh |   30 +++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 12 deletions(-)

-- 
1.7.3.rc2.234.g00c0
