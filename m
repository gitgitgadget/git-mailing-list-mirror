From: Steve Folly <steve@spfweb.co.uk>
Subject: init --shared=0666 isn't
Date: Tue, 9 Mar 2010 22:31:56 +0000 (UTC)
Message-ID: <loom.20100309T224207-485@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 23:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np7yH-0006Pp-LU
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 23:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab0CIWcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 17:32:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:39117 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab0CIWcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 17:32:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Np7yA-0006Mh-4d
	for git@vger.kernel.org; Tue, 09 Mar 2010 23:32:06 +0100
Received: from cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com ([92.234.82.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 23:32:06 +0100
Received: from steve by cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 23:32:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.234.82.118 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141850>

Using git 1.7.0.2 on Mac OS X 10.6.2:

$ git init --bare --shared=0666 /tmp/shared.git
$ git --git-dir=/tmp/shared.git remote add --mirror \
        origin git://git.kernel.org/pub/scm/git/git.git
$ git --git-dir=/tmp/shared.git fetch origin

# login as someone else; different uid, different gid, then:

$ git --git-dir=/tmp/shared.git fetch origin

error: cannot open /tmp/shared.git/FETCH_HEAD: Permission denied


FETCH_HEAD is owned by the original user, with 0644 permissions,
 not 0666 as originally requested.

I've only had a quick glance at the source - my first guess
 is that in builtin-fetch.c, store_updated_refs and 
truncate_fetch_head should call adjust_shared_perm after
closing the file being written? Or, should an empty FETCH_HEAD
with appropriate shared perms be written during init?

In my case I'm using /tmp/shared.git as a mirror for other
 local repositories init'ed with --reference=/path/to/mirror.git
and all I'll be doing if fetching into it periodically, so I think fixing 
FETCH_HEAD will suffice for me. 

But, I wonder if there are other files written that will need fixing
also - ORIG_HEAD, MERGE_HEAD?

Is there a workaround for this or am I doing something wrong? 
Thanks for any help.

Regards,
Steve
