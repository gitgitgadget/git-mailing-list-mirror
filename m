From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: SP in committer line in fast-import stream
Date: Mon, 18 Jul 2011 15:38:19 +0000 (UTC)
Message-ID: <loom.20110718T172927-173@post.gmane.org>
References: <CAE3X6mwJquoHj06FVGTsg0qtzyTwbd6gNqy7J4yWiVF-+p-23Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 17:50:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiq5J-0006dM-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 17:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab1GRPuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 11:50:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:53066 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1GRPuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 11:50:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qiq5A-0006ZK-Th
	for git@vger.kernel.org; Mon, 18 Jul 2011 17:50:09 +0200
Received: from dhcp249-230.yandex.net ([87.250.249.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 17:50:08 +0200
Received: from divanorama by dhcp249-230.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 17:50:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.249.230 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.9.168 Version/11.50)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177377>

Hi,

SASAKI Suguru <sss.sonik <at> gmail.com> writes:

> 
> Hi,
> 
> I'm working with data from `bzr fast-export` and `git fast-import`.
> (bzr is 2.4b5, git is 1.7.5.4, on Debian GNU/Linux (sid))
> 
> Export and import themselves are OK,
> but `git fsck --strict` exits with error, saying:
> 
>   error in commit 2e7a16fbe57b555c1c5954470ef66f3a2a089288: invalid
> author/committer line - missing space before email
> 
> and pushing to remote like GitHub fails.
> 
> I found minimal OK-data unlike `bzr fast-export` outputs and NG-data
> like `bzr fast-export`.
> (Attached: test_NG.data.txt and test_OK.data.txt)
> 
> Only one difference between these is a space in committer line.
>   * OK: 'committer' SP SP LT GT ...
>   * NG: 'committer' SP    LT GT ...
> 
> `man git-fast-import` says:
> 
>   commit
>     Create or update a branch with a new commit, recording one logical
> change to the project.
> 
>       'commit' SP <ref> LF
>       mark?
>       ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>       'committer' (SP <name>)? SP LT <email> GT SP <when> LF
>       data
>       ('from' SP <committish> LF)?
>       ('merge' SP <committish> LF)?
>       (filemodify | filedelete | filecopy | filerename | filedeleteall
> | notemodify)*
>       LF?
> 
> I think, from this notations, both data is OK.
> What's the problem?
The problem is with git-fast-import that it doesn't verify the format strictly 
here.
For example following (no LT) will pass:
<name> SP <email> GT 
The second problem is that it generates "bad" committer, in fact name-email is 
used as-is, so at least it should convert absent name to a empty name. Or maybe 
just fix the format to make string obligatory.
There even is a third minor problem, fsck will report confusing "missing space" 
for the no-LT example.

Third one is a clear.
Your one is the second one, while internally it pulls the first one too.

The shortest fix is to read documentation as
'committer' SP <name> SP LT <email> GT SP <when> LF


> 
> Regards,
> 
