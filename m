From: Johan Herland <johan@herland.net>
Subject: checkout/branch needs some extra safety around the --track option
Date: Tue, 15 Feb 2011 18:52:03 +0100
Message-ID: <201102151852.03881.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 18:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpP4P-00073n-Je
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 18:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab1BORwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 12:52:07 -0500
Received: from smtp.opera.com ([213.236.208.81]:48491 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab1BORwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 12:52:06 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1FHq42g013873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 15 Feb 2011 17:52:04 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166860>

Hi,

I just got a problem report from a Git user a $dayjob, who was confused 
about the following output from 'git push' (without arguments, in a 
repo with push.default == 'tracking'):

> ----------------------------------------------------------------
> $ git push
> Total 0 (delta 0), reused 0 (delta 0)
> To .
>     c9e7b5a..1bf9fed  mybranch -> v0.99
> ----------------------------------------------------------------

After some investigations, I could reproduce his problem with the 
following commands:

$ git checkout -b mybranch --track v0.99
# Do work on mybranch
$ git push

In other words. The branch was erroneously created with the --track 
option, setting up a bogus branch.mybranch config section. When 
pushing, this caused the v0.99 tag to be (unexpectedly, to him) updated 
in the local repo.

Obviously, this is rooted in user error, but it occurs to me that Git 
should be more helpful in this situation. I propose:

1. When given "--track", branch/checkout should verify that the tracked 
branch is indeed a branch (preferably a remote branch, although I guess 
tracking a local branch can make sense in some situations). At least, 
it should deny tracking a _tag_. Tracking a tag simply does not make 
sense at all (unless you expect the tag to move, in which case it 
should be a branch and not a tag).

2. 'git push' should not move tags by default (not even in your local 
repo). Moving tags might be ok if given the -f option (still a remote 
repo should be able to object). With the current version of Git, the 
following commands will transform an annotated tag into a lightweight 
tag with no warning:

$ git config push.default tracking
$ git checkout -b foo --track $annotated_tag
$ git push


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
