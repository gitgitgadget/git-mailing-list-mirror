From: Phil Hord <hordp@cisco.com>
Subject: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 16:31:00 -0400
Message-ID: <4FBD4904.9090000@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com,
	Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:40:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIMJ-0001NY-1X
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 22:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875Ab2EWUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 16:40:33 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:47409 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758666Ab2EWUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 16:40:32 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2012 16:40:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2508; q=dns/txt;
  s=iport; t=1337805632; x=1339015232;
  h=message-id:date:from:mime-version:to:subject:
   content-transfer-encoding;
  bh=ZPGvhoLeatMBb4MzO7kVExBYoULnO8T4G3bYHk/hX8Y=;
  b=SQNTNGA2znDBnkT2uvTh7+SgcKhuyjPE7tcGEisPwF0SXNDEzskHWB0m
   NYlW3NkQfAZoAYrJL4LH0ZdPZfGM20OH1fPGbL/Xyv4e2gcfChm+ufJu7
   nW8SAu7Zg0csUaLuLJZ2RD54zyzW4KmkFxGphJWrCc4JDYHZHpjeDQ/bg
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EALpHvU+tJV2d/2dsb2JhbABDtC2BB4IuAWUwDRYYAwIBAgFLAQwGAgEBHodrmyOfcop9hSADlRiFT4g9gWSDBg
X-IronPort-AV: E=Sophos;i="4.75,646,1330905600"; 
   d="scan'208";a="86064668"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-8.cisco.com with ESMTP; 23 May 2012 20:31:00 +0000
Received: from [64.100.104.83] (dhcp-64-100-104-83.cisco.com [64.100.104.83])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id q4NKUxPC006924;
	Wed, 23 May 2012 20:31:00 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198319>

In git.git 'master' when I cherry-pick a commit which is eventually
empty, git gives me a friendly description of my supposed error, leaves
my cherry-pick "pending" and exits with an error code.


$ git cherry-pick a0aff2d                          
# On branch master
nothing to commit (working directory clean)
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git reset'


In 'next' this is broken.  Now git does not tell me anything and it does
not exit with an error code.  It does still leave the cherry-pick
pending, though.


$ git cherry-pick a0aff2d
$ cat /tmp/repo/.git/CHERRY_PICK_HEAD
a0aff2da3d12a9a097c02e39570611f359433c23



It bisects to this commit:

commit b27cfb0d8d4cbb6d079c70ffeadac9c0dcfff250
Author: Neil Horman <nhorman@tuxdriver.com>
Date:   Fri Apr 20 10:36:15 2012 -0400

    git-cherry-pick: Add keep-redundant-commits option
   
    The git-cherry-pick --allow-empty command by default only preserves
empty
    commits that were originally empty, i.e only those commits for which
    <commit>^{tree} and <commit>^^{tree} are equal.  By default commits
which are
    non-empty, but were made empty by the inclusion of a prior commit on
the current
    history are filtered out.  This option allows us to override that
behavior and
    include redundant commits as empty commits in the change history.
   
    Note that this patch changes the default behavior of git cherry-pick
slightly.
    Prior to this patch all commits in a cherry-pick sequence were
applied and git
    commit was run.  The implication here was that, if a commit was
redundant, and
    the commit did not trigger the fast forward logic, the git commit
operation, and
    therefore the git cherry-pick operation would fail, displaying the
cherry pick
    advice (i.e. run git commit --allow-empty).  With this patch
however, such
    redundant commits are automatically skipped without stopping, unless
    --keep-redundant-commits is specified, in which case, they are
automatically
    applied as empty commits.
   
    Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


I don't have time to chase it any further today.  Hopefully someone can
see the flub and straighten it out before I get a chance to look again. 
If not, I'll probably forget anyway.

Phil
