From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's new in git.git
Date: Mon, 06 Feb 2006 08:58:43 -0800
Message-ID: <7vbqxk8lvg.fsf@assigned-by-dhcp.cox.net>
References: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602060754470.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:06:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F69hZ-0006Ug-R7
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 17:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWBFQ6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBFQ6r
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 11:58:47 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33184 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932228AbWBFQ6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 11:58:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206165849.OAWY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 11:58:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602060754470.3854@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 6 Feb 2006 08:03:28 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15654>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 5 Feb 2006, Junio C Hamano wrote:
>> 
>>  * Add -c and --cc to diff-tree and diff-files.  They give the
>>    "combined diff" output that shows merges more human readably.
>
> Btw, the only concern I have left about "-c" and "--cc" is that I don't 
> think the old merge-diff behaviour makes any sense at all, and that we 
> should drop it entirely in favour of "-c" and "--cc".
> ...
> Has anybody on the git list ever used "-m" with git-diff-tree? Speak up..

One thing that makes me a bit reluctant is that I am not as
confident as you are about -c doing the right thing.  I have not
examined differences between -m -p and -c, especially under
various combinations of other flags like -B, -C and -M. I did
compare output from -c and --cc to check if the logic to drop
"uninteresting" hunks are doing the right thing and I am
reasonably sure that part is good, though.

The code to do -c punts at showing type changes, and there is no
filemode information in the output either.  So far nobody has
complained about it, and a type change would be a rare thing
anyway and might not matter in practice.  We should however not
just silently ignore rare cases that we do not handle.  Instead
we should raise a big red flag; otherwise the rare cases in
which -c cheats can go unnoticed, which feels wrong.

Having said that, the above concern is primarily about debugging
the -c implementation and for that we could always fall back on
running "diff-tree -p H H^2" by hand, so maybe dropping "-m -p"
is an OK thing to do from that point of view.

People who are doing SCM migration part might be using it as a
replacement for "for i; do diff-tree -p H H^$i; done" to extract
diffs from each parent with a single command, though...
