From: Johan Herland <johan@herland.net>
Subject: Re: Q. about usage of notes
Date: Tue, 31 Aug 2010 11:07:31 +0200
Message-ID: <201008311107.32278.johan@herland.net>
References: <4C7CB8AF.5080008@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 11:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqMp7-0004YL-6R
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 11:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab0HaJHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 05:07:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56623 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756649Ab0HaJHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 05:07:35 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L8000D8IEOL7G50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 31 Aug 2010 11:07:33 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2F3191EA5971_C7CC655B	for <git@vger.kernel.org>; Tue,
 31 Aug 2010 09:07:33 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E05561EA2914_C7CC654F	for <git@vger.kernel.org>; Tue,
 31 Aug 2010 09:07:32 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L80009EOEOK8W00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 31 Aug 2010 11:07:32 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.0; x86_64; ; )
In-reply-to: <4C7CB8AF.5080008@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154889>

On Tuesday 31 August 2010, Stefan Naewe wrote:
> Hi,
> 
> I was playing around with 'git notes' these days (after reading S.Chacons
> post to this list and hist blog post at progit.org).
> 
> Some things came to my mind when doing some 'git notes add' and
> 'git notes remove':
> 
> How do I really get rid of git notes ? 'git notes remove' doesn't really
> remove the notes but creates a new commit (like 'git rm file ; git
> commit..' does).

Well, how do you "really" get rid of a file on a "regular" Git branch? The 
answer is that Git doesn't let you do this without rewriting history (e.g. 
using 'git filter-branch' to create a new history where that file never 
existed). The same argument goes for notes: If you want to remove all traces 
of notes for a given object, you must rewrite the notes history so that 
those notes never existed.

At least that's how the 'git notes' porcelain behaves. At the plumbing 
level, it's possible to create notes commits that don't point to the 
preceding notes history (every notes commit is a root commit), and thus end 
up with "history-less" notes. An example of this is the notes-cache code.

> And why does 'git remove' do that repetetively (is that even a word...?),
> i.e. 'git add -m"Note" ; git remove; git remove; git remove; git remove'
> creates 5 commit objects under 'refs/notes/commits' Is that the intended
> behaviour ?

(I assume your meant to put "notes" in all those commands: git notes add, 
git notes remove, etc.)

Yes, this is the intended behaviour. Otherwise you would need a separate 
notes index where you could stage notes changes (with git notes add/remove), 
and then later commit those notes changes with (the imaginary) git notes 
commit. This was deemed too cumbersome/complicated, and we settled for the 
current approach instead.

If you want to make several adds/removes per notes commit, you could:

1. Use git-fast-import and its 'N' command (search the manual page for 
"notemodify").

2. Check out the notes ref into your working tree ("git checkout 
refs/notes/commits"). You can now edit notes directly, like you would edit 
your "regular" files. (Ideally, you should have some knowledge about the 
format of notes trees before you add/rename files). When you're done, you 
stage and commit as you would do in your regular checkout.

> I'm a little bit puzzled....

Hope this helps, :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
