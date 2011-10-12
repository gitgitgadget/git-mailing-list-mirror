From: Simon Klinkert <klinkert@webgods.de>
Subject: Re: [PATCH] Improving performance with pthreads in refresh_index().
Date: Wed, 12 Oct 2011 09:21:20 +0200
Message-ID: <470EDA14-707D-42C7-A57A-CFE7208E1D03@webgods.de>
References: <1318325521-23262-1-git-send-email-klinkert@webgods.de> <4E942D76.7030908@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 09:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDtS9-0006rv-MD
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 09:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1JLHmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 03:42:05 -0400
Received: from fredda.webgods.de ([192.166.196.83]:56608 "EHLO
	fredda.webgods.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1JLHmF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 03:42:05 -0400
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Oct 2011 03:42:04 EDT
In-Reply-To: <4E942D76.7030908@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183357>


Okay. It seems like my idea was already implemented by Linus. I wasn't aware of that fact.

Anyway, I've learned a bit more about git's bowels. Thanks a lot.

Simon

On 11.10.2011, at 13:50, Michael J Gruber wrote:

> klinkert@webgods.de venit, vidit, dixit 11.10.2011 11:32:
>> Git performs for every file in a repository at least one (with a cold cache)
>> lstat(). In larger repositories operations like git status take a
>> long time. In case your local repository is located on a remote server
>> (e. g. mounted via nfs) it ends up in an *incredible* slow git.
>> 
>> With this patch you're able to determine a number of threads (maxthreads)
>> in your config file to run these tons of lstats in threads. There
>> won't be created any pthreads if you haven't set maxthreads. In my
>> test cases a git status with this patch performs enormously faster (over
>> two minutes before and approximately 25 seconds now). Of course, it
>> has a positive impact on other git commands, too.
> 
> Can you specify under which circumstances one should get a speedup? Our
> NFS isn't slow enough... but on a dead slow sshfs work tree I get the
> following for "git status -s":
> 
> maxthreads: 0, preloadindex: false, time: 14.73
> maxthreads: 1, preloadindex: false, time: 14.25
> maxthreads: 2, preloadindex: false, time: 13.32
> maxthreads: 3, preloadindex: false, time: 12.40
> maxthreads: 4, preloadindex: false, time: 12.65
> maxthreads: 5, preloadindex: false, time: 12.16
> maxthreads: 8, preloadindex: false, time: 12.32
> maxthreads: 10, preloadindex: false, time: 11.98
> maxthreads: 15, preloadindex: false, time: 12.31
> maxthreads: 20, preloadindex: false, time: 12.00
> maxthreads: 0, preloadindex: true, time: 12.17
> maxthreads: 1, preloadindex: true, time: 11.98
> maxthreads: 2, preloadindex: true, time: 12.21
> maxthreads: 3, preloadindex: true, time: 11.99
> maxthreads: 4, preloadindex: true, time: 12.14
> maxthreads: 5, preloadindex: true, time: 12.21
> maxthreads: 8, preloadindex: true, time: 12.14
> maxthreads: 10, preloadindex: true, time: 12.08
> maxthreads: 15, preloadindex: true, time: 12.16
> maxthreads: 20, preloadindex: true, time: 11.96
> 
> So it seams it gives me what preloadindex does, which is not much.
> 
> Note: I'm not saying the patch is bad. I'm just wondering whether that
> is expected.
> 
> Michael
> P.S.: It's actually sshfs with ssh to an NFSv3 client (server restricts
> exports) :(
