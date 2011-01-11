From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Re[2]: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 17:49:07 +0300
Message-ID: <961742587.20110111174907@mail.ru>
References: <746745466.20110111134101@mail.ru> <m3lj2rbmq5.fsf@localhost.localdomain>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 15:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcfXA-0005KD-7o
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 15:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab1AKOtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 09:49:11 -0500
Received: from smtp13.mail.ru ([94.100.176.90]:58487 "EHLO smtp13.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775Ab1AKOtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 09:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=AiKtB6UZBw0IIGMpeiN4P/zfvXFhBR6vM8OJemnrowQ=;
	b=Ha4aWI3oA3iHDbEI7CrknYXi+ltOKO1piEoI2OoqFPAPTjEtBTCrwR08+mxVbog29hv57ToOWBrU89LXbxLSeIoeG4o6c7eAW+CZHZ3AJBUg20CVfuzfGEdW05BKb6bP;
Received: from [85.140.106.43] (port=43532 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp13.mail.ru with asmtp 
	id 1PcfX1-0005AS-00; Tue, 11 Jan 2011 17:49:08 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <m3lj2rbmq5.fsf@localhost.localdomain>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164950>

Hello, Jakub.

Thank you very much. Your method works great and it suits for me well

>> 1.5 years ago I had sources of a project in a SVN repository (actually it does not
>> matter what SCM was used before). And I had two branches: v2.4 and v2.5.
>> They differed enough at that moment and (as usual for SVN branches)
>> laid in two different folders.
>> Then I had known of Git and I decided to try to use this powerful DVCS.
>> But as I was a newbie I created two git-repositories: one per each
>> branch. So v2.4 has its own git-repo. v2.5 (and above) has another one.
>> 
>> Now I'd like to merge them as v2.5 was a continuos branch from v2.4,
>> but without a rebasing (i.e. without a global changing of v2.5
>> repository, which already has another branches)
>> It must look like LAST commit of v2.4 should be a PARENT of FIRST commit of v2.5
>> 
>> Now there's a question: Is it possible to do so (no rebasing!), and If
>> "yes" then how to?

JN> As Andreas Ericsson wrote, you can do this using grafts (and you can
JN> make history with grafts permanent using "git filter-branch").

JN> Better solution might be to use more modern replace mechanism, see
JN> e.g. "git replace" manpage.  Below there is untested step-by-step
JN> instruction.

JN> First, you have put history of v2.4 and of v2.5 in a single repository
JN> (e.g. using "git remote add").  Then you need to find FIRST commit of
JN> v2.5 among

JN>   $ git rev-list master --parents | grep -v ' '

JN> The above finds all parent-less commits in 'master' branch; replace it
JN> with branch holding v2.5 history.  Then you need to find LAST commit
JN> of v2.4 and its SHA-1, e.g. via

JN>   $ git rev-parse v2.4

JN> Save current state of FIRST commit of v2.5 to a file

JN>   $ git cat-file -p FIRST > tmp

JN> Edit this file, adding 'parent' line between 'tree' and 'author'
JN> headers, so the header of this file looks like the following:

JN>   tree 13d050266e05f7c66000240814199fcf3b559d43
JN>   parent ada9983c4256f5a7bac1f7f0e29d52011741d6aa
JN>   author Jakub Narebski <jnareb@gmail.com> 1294231771 +0100

JN> (trailing space added for better readibility).

JN> Then you need to add newly created object to repository:

JN>   $ git hash-object -t commit -w tmp

JN> and then use it as replacement

JN>   $ git replace <SHA-1 of FIRST> <SHA-1 returned by hash-object>

JN> Finally check that replacement works, e.g.:

JN>   $ git show FIRST
JN>   $ git log --graph --oneline -3 FIRST

JN> The anyone who would fetch refs/replace/ would get joined history, and
JN> who doesn't would see it not connected.


JN> P.S. This probably should made it into Documentation/howto
