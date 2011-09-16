From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Problem with submodule merge
Date: Fri, 16 Sep 2011 16:57:25 +0200
Message-ID: <20110916145724.GA2782@book.hvoigt.net>
References: <4E734582.6030704@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 16:57:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Zr9-000582-O1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 16:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab1IPO50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 10:57:26 -0400
Received: from darksea.de ([83.133.111.250]:45103 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755179Ab1IPO5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 10:57:25 -0400
Received: (qmail 16548 invoked from network); 16 Sep 2011 16:57:23 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 16 Sep 2011 16:57:23 +0200
Content-Disposition: inline
In-Reply-To: <4E734582.6030704@morey-chaisemartin.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181534>

Hi,

this looks like you have hit a codepath where the submodules object
database is not added to the object database. I am not sure why.

Could you try my patch that moves the merge search into a forked process:

3dcb369b allow multiple calls to submodule merge search for the same path

That should solve the issue as a side effect. Its currently in Junio's
pu branch.

Cheers Heiko

On Fri, Sep 16, 2011 at 02:48:02PM +0200, Nicolas Morey-Chaisemartin wrote:
> Hi,
> 
> We have meet an issue few times at work with submodule merge.
> I'm running git 1.7.7-rc1 build from master on FC15 x86_64 but I've seen the issue on other ditro with older (stable) versions
> 
> I still haven't figured out exactly when it happends but here are the symptoms:
> 
> 1) I commited some updates for a submodule in our integration repo.
> 2) I pulled a remote branch of the integration repo which had an update on the same submodule (but different SHAs)
> 3) When the merge driver try to find a following commit for the submodule, I get some (sometimes many) error messages about refs that point to invalid objects:
> 
> [nmorey@sat:SigmaCToolchain (user/nmorey/dev/0.3.0 *%>)]$ git merge origin/prerelease/0.3-0 
> error: refs/heads/user/nmorey/master does not point to a valid object!
> error: refs/remotes/origin/dev/cpp does not point to a valid object!
> error: refs/remotes/origin/dev/scuk does not point to a valid object!
> error: refs/remotes/origin/dev/sys_agents does not point to a valid object!
> error: refs/remotes/origin/user/bbodin/cea does not point to a valid object!
> error: refs/remotes/origin/user/borgogoz/master does not point to a valid object!
> warning: Failed to merge submodule db (merge following commits not found)
> Auto-merging db
> CONFLICT (submodule): Merge conflict in db
> Automatic merge failed; fix conflicts and then commit the result.
> 
> 
> I checked and the object really exists in the submodule but is in a pack.
> 
> >From checking the strace, git looks for a the object in db/.git/objects/... whch does not exists
> And from what I could figure it, the issue seems to be coming from  find_pack_entry which does not return 1 so git goes looking for loose object
> and cannot find any (as expected).
> This is not a big issue as it just outputs errors about refs and does not block the user but it gets quite scary when there are a few hundreds of them !
> 
> 
> I kept a tarball of the repo so I can provide more info/logs/trace if needed.
> 
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
