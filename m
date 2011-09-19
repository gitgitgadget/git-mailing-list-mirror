From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: Problem with submodule merge
Date: Mon, 19 Sep 2011 09:55:14 +0200
Message-ID: <4E76F562.30306@morey-chaisemartin.com>
References: <4E734582.6030704@morey-chaisemartin.com> <20110916145724.GA2782@book.hvoigt.net>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 09:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5YhI-0002P5-H7
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 09:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1ISHzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 03:55:19 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:38844 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146Ab1ISHzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 03:55:18 -0400
Received: from mail96.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id E587EFFA3E5
	for <git@vger.kernel.org>; Mon, 19 Sep 2011 09:56:46 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 19 Sep 2011 09:55:16 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 19 Sep 2011 09:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
In-Reply-To: <20110916145724.GA2782@book.hvoigt.net>
X-Ovh-Tracer-Id: 17681976563277750168
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -180
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfedvkedrtdduucetggdotefuucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlvddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181667>

Hi,

You're right, this fixes the issue:
$ git merge origin/prerelease/0.3-0
warning: Failed to merge submodule db (merge following commits not found)
Auto-merging db
CONFLICT (submodule): Merge conflict in db
Automatic merge failed; fix conflicts and then commit the result.

Thanks for the help

Nicolas

On 09/16/2011 04:57 PM, Heiko Voigt wrote:
> Hi,
>
> this looks like you have hit a codepath where the submodules object
> database is not added to the object database. I am not sure why.
>
> Could you try my patch that moves the merge search into a forked process:
>
> 3dcb369b allow multiple calls to submodule merge search for the same path
>
> That should solve the issue as a side effect. Its currently in Junio's
> pu branch.
>
> Cheers Heiko
>
> On Fri, Sep 16, 2011 at 02:48:02PM +0200, Nicolas Morey-Chaisemartin wrote:
>> Hi,
>>
>> We have meet an issue few times at work with submodule merge.
>> I'm running git 1.7.7-rc1 build from master on FC15 x86_64 but I've seen the issue on other ditro with older (stable) versions
>>
>> I still haven't figured out exactly when it happends but here are the symptoms:
>>
>> 1) I commited some updates for a submodule in our integration repo.
>> 2) I pulled a remote branch of the integration repo which had an update on the same submodule (but different SHAs)
>> 3) When the merge driver try to find a following commit for the submodule, I get some (sometimes many) error messages about refs that point to invalid objects:
>>
>> [nmorey@sat:SigmaCToolchain (user/nmorey/dev/0.3.0 *%>)]$ git merge origin/prerelease/0.3-0 
>> error: refs/heads/user/nmorey/master does not point to a valid object!
>> error: refs/remotes/origin/dev/cpp does not point to a valid object!
>> error: refs/remotes/origin/dev/scuk does not point to a valid object!
>> error: refs/remotes/origin/dev/sys_agents does not point to a valid object!
>> error: refs/remotes/origin/user/bbodin/cea does not point to a valid object!
>> error: refs/remotes/origin/user/borgogoz/master does not point to a valid object!
>> warning: Failed to merge submodule db (merge following commits not found)
>> Auto-merging db
>> CONFLICT (submodule): Merge conflict in db
>> Automatic merge failed; fix conflicts and then commit the result.
>>
>>
>> I checked and the object really exists in the submodule but is in a pack.
>>
>> >From checking the strace, git looks for a the object in db/.git/objects/... whch does not exists
>> And from what I could figure it, the issue seems to be coming from  find_pack_entry which does not return 1 so git goes looking for loose object
>> and cannot find any (as expected).
>> This is not a big issue as it just outputs errors about refs and does not block the user but it gets quite scary when there are a few hundreds of them !
>>
>>
>> I kept a tarball of the repo so I can provide more info/logs/trace if needed.
>>
>> Nicolas
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
