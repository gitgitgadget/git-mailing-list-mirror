From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: Reset by checkout?
Date: Mon, 09 Jun 2014 23:12:31 +0300
Message-ID: <5396152F.4020704@bracey.fi>
References: <20140601132624.821C.B013761@chejz.com> <538AE814.2010407@bracey.fi> <20140607135439.7893.B013761@chejz.com> <241E3E5EB7AE44E6821EA5DFAA24C28F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8p8-0008Mr-C2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbaFIXRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:17:51 -0400
Received: from mo6.mail-out.ovh.net ([178.32.228.6]:46504 "EHLO
	mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaFIXRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:17:49 -0400
Received: from mail172.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id BF1C4FFA6CE
	for <git@vger.kernel.org>; Mon,  9 Jun 2014 22:12:34 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 9 Jun 2014 22:12:34 +0200
Received: from 81-175-152-164.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@81.175.152.164)
  by ns0.ovh.net with SMTP; 9 Jun 2014 22:12:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <241E3E5EB7AE44E6821EA5DFAA24C28F@PhilipOakley>
X-Ovh-Tracer-Id: 1526720275633967157
X-Ovh-Remote: 81.175.152.164 (81-175-152-164.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -51
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrjeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -51
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrjeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251131>

On 07/06/2014 17:52, Philip Oakley wrote:
>
>
> Just to say there has been a similar confusion about 'git reset' 
> reported on the Git Users group for the case of reset with added 
> (staged), but uncommitted changes being wiped out, which simlarly 
> reports on the difficulty of explaining some of the conditions 
> especially when some are wrong ;-)
>
> https://groups.google.com/forum/#!topic/git-users/27_FxIV_100

I'm coming around to the view that "git reset <mode>" should be (almost) 
demoted to plumbing, leaving only the "reset <file>" that reverses "add 
<file>" as everyday Porcelain.

I think "reset --keep" and "--merge" were a step in the wrong direction, 
at least for the Porcelain - trying to make reset <mode> "more useful", 
rather than less necessary. Normal users shouldn't be needing to touch 
these hard-to-explain-and-slightly-dangerous commands.

The addition of "--abort" to merge and other commands was much more 
solid. They helped a lot, and I think we should follow that model by 
adding "--undo" to various commands. That would mop up all the common 
"reset"s, in conjunction with Atsushi's proposed "checkout -u" 
alternative to -B, which I quite like.

Main few:

commit --undo = reset --soft HEAD^
merge --undo  = reset --keep HEAD^
rebase --undo = reset --keep ORIG_HEAD   [bug report: rebase -p doesn't 
set ORIG_HEAD reliably]
pull --undo = merge/rebase --undo depending on rebase settings [could we 
go nuts and undo the fetch too?]

Bonus:

commit --amend --undo: reset --soft HEAD@{1}

The undos can also have a bit of extra veneer that checks the log/reflog 
for whether it matches the proposed undo, and also checks the upstream 
to see if the thing being undone is already public.

Given those, I honestly don't think I'd ever need to explain git reset 
<mode> to anyone again. Which would be nice...

(Note I propose no "--mixed" equivalent for the commit undos, but it's 
easy enough to follow the "commit --undo" with a normal "git reset". I'd 
rather re-document the normal git reset under "commit --undo" than add 
and document yet another option).

Kevin
