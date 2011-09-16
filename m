From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Problem with submodule merge
Date: Fri, 16 Sep 2011 14:48:02 +0200
Message-ID: <4E734582.6030704@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 16:44:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Ze4-0006L6-AL
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 16:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab1IPOny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 10:43:54 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:58867 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752325Ab1IPOny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 10:43:54 -0400
X-Greylist: delayed 6947 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2011 10:43:54 EDT
Received: from mail96.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id EC9C7101109F
	for <git@vger.kernel.org>; Fri, 16 Sep 2011 14:49:30 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 Sep 2011 14:48:05 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 16 Sep 2011 14:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Ovh-Tracer-Id: 5009128686507581406
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfedvkedrtdduucetggdotefuucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181533>

Hi,

We have meet an issue few times at work with submodule merge.
I'm running git 1.7.7-rc1 build from master on FC15 x86_64 but I've seen the issue on other ditro with older (stable) versions

I still haven't figured out exactly when it happends but here are the symptoms:

1) I commited some updates for a submodule in our integration repo.
2) I pulled a remote branch of the integration repo which had an update on the same submodule (but different SHAs)
3) When the merge driver try to find a following commit for the submodule, I get some (sometimes many) error messages about refs that point to invalid objects:

[nmorey@sat:SigmaCToolchain (user/nmorey/dev/0.3.0 *%>)]$ git merge origin/prerelease/0.3-0 
error: refs/heads/user/nmorey/master does not point to a valid object!
error: refs/remotes/origin/dev/cpp does not point to a valid object!
error: refs/remotes/origin/dev/scuk does not point to a valid object!
error: refs/remotes/origin/dev/sys_agents does not point to a valid object!
error: refs/remotes/origin/user/bbodin/cea does not point to a valid object!
error: refs/remotes/origin/user/borgogoz/master does not point to a valid object!
warning: Failed to merge submodule db (merge following commits not found)
Auto-merging db
CONFLICT (submodule): Merge conflict in db
Automatic merge failed; fix conflicts and then commit the result.


I checked and the object really exists in the submodule but is in a pack.

>From checking the strace, git looks for a the object in db/.git/objects/... whch does not exists
And from what I could figure it, the issue seems to be coming from  find_pack_entry which does not return 1 so git goes looking for loose object
and cannot find any (as expected).
This is not a big issue as it just outputs errors about refs and does not block the user but it gets quite scary when there are a few hundreds of them !


I kept a tarball of the repo so I can provide more info/logs/trace if needed.

Nicolas
