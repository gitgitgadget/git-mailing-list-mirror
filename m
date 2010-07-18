From: Michel Lespinasse <walken@google.com>
Subject: git diff slow after initial checkout
Date: Sun, 18 Jul 2010 07:17:19 -0700
Message-ID: <20100718141719.GA32660@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 18 16:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaUgQ-0004WE-Fz
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 16:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab0GROR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 10:17:29 -0400
Received: from smtp-out.google.com ([216.239.44.51]:9845 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab0GROR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 10:17:28 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id o6IEHQN9001461
	for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:17:27 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1279462647; bh=DZILClK9V71qFMnIlRnbSEOy/g8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=J5sRVA/fZuLafz3v/Hu07BbY5WoxVdGmkXAeM+TubnzzNieVfwvQz8b9rNhHnNBhf
	 6oCKsfV1HviFqPcJOKwBg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:to:subject:message-id:mime-version:content-type:
	content-disposition:user-agent:x-system-of-record;
	b=KvTlpreRA/s7IOe13WN+sYByR/+RNDE3/xGjEhD76FqlNdCGjdZD+FZE7ETHd1ilN
	wFm88ILyxeqOsS5Cqug6A==
Received: from pzk36 (pzk36.prod.google.com [10.243.19.164])
	by hpaq12.eem.corp.google.com with ESMTP id o6IEHOb3021822
	for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:17:25 -0700
Received: by pzk36 with SMTP id 36so2295646pzk.35
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:17:24 -0700 (PDT)
Received: by 10.114.120.20 with SMTP id s20mr5183115wac.15.1279462644392;
        Sun, 18 Jul 2010 07:17:24 -0700 (PDT)
Received: from google.com (studio.mtv.corp.google.com [172.22.65.142])
        by mx.google.com with ESMTPS id d39sm59008513wam.16.2010.07.18.07.17.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 07:17:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151211>

Hi,

I am seeing a slow 'git diff' when doing the following with git 1.7.0.4:

% git clone /path/to/repo
% cd repo
% git checkout e0d960b
% time git diff | cat
git diff  0.15s user 0.30s system 96% cpu 0.468 total
cat  0.00s user 0.00s system 0% cpu 0.467 total
% strace -o ../strace.before git diff | cat
% touch .git/index
% time git diff | cat
git diff  0.00s user 0.00s system 0% cpu 0.006 total
cat  0.00s user 0.00s system 0% cpu 0.005 total
% strace -o ../strace.after git diff | cat

The first diff is ~100 times slower than what git has gotten me used to.
If I run the diff multiple times, it stays slow every time until I touch
the index.

The strace shows that before I touch the index, 'git diff' mmaps .git/index
and then does an lstat/open/read/close loop on every file in the repository.
After I touch the index, 'git diff' only does an lstat on every file.


It looks like 'git checkout' should touch the index file after it's done ?

Alternatively, maybe 'git diff' should do that after it notices there are
no modified files ?

Is this fixed with a more recent version of git ? (in RelNotes-1.7.1.1.txt
I see something about 'git status' stopped refreshing the index by mistake
in git 1.7.1, which sounds like the same problem but in a different place ?)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
