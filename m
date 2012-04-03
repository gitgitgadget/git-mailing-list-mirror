From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Tue, 3 Apr 2012 09:45:05 -0500
Message-ID: <20120403144505.GE15589@burratino>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.w-lists@sohovfx.com>,
	Andrew Wong <andrew.w@sohovfx.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 16:45:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF4zA-0003h3-2y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 16:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab2DCOpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 10:45:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48495 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2DCOpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 10:45:17 -0400
Received: by iagz16 with SMTP id z16so5683523iag.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fHv7CLpsLU6Z0MLZkm+ShMasWd+BAtFcXgJSG9F5Eig=;
        b=X8l20vRHvTqPl6NRq9fgU/E/UjCl7g8OiaVGzZtHxeDKYeWYzKlckA5+Tds695jkud
         J5FdpmV40ZeqVSrPmoPUL2GPwSEUSYbyJL0HGagh9BS9wU+UXfiSrlnqdxRB6q5ipzyH
         vZceVUJLlr3lKl6jRsgWByffVt/m4pwBYHHkpeL2s4iOr6B8vDNY9qvX11A+fTFWylsj
         tmSqK+esl+HmYNo7WtB5uvAi2yoktKG7q9aHisehCXgsdcUZh56hPIg3UeMxlXuy5exn
         J02XeYZhB+yxIR3BhmwmCuaIH/gMfFGac0IDBhWX1/8WgofyIraRnPNHFJj1fgeZri7n
         3xhg==
Received: by 10.42.155.9 with SMTP id s9mr7456506icw.51.1333464316504;
        Tue, 03 Apr 2012 07:45:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b11sm15619012igq.7.2012.04.03.07.45.15
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 07:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194627>

(cc-ing Jay, expert on the CHERRY_PICK_HEAD facility)
Hi all,

Ramkumar Ramachandra wrote:
> Andrew Wong wrote:

>> Instead of having the sequencer catch errors and remove CHERRY_PICK_HEAD
>> for its caller's sake, let its caller do the work. This way, the
>> sequencer doesn't have to check all points of failures where its caller
>> doesn't want CHERRY_PICK_HEAD.
>
> This part makes sense.

Sorry, I think I've missed the point.  Can you explain to me what
problem this is solving, aside from somehow dividing responsibility
for the CHERRY_PICK_HEAD file among different tools?

>From the surrounding thread, it looks like the following sequence of
commands is at stake:

	git checkout -b tmp v1.7.9
	git cherry-pick 6e1c9bb^2^
	git rebase -i --onto 6e1c9bb HEAD^
	git rebase --continue

The pick works fine and is just part of the setup.  The rebase produces

	The previous cherry-pick is now empty, possibly due to conflict resolution.
	If you wish to commit it anyway, use:

	    git commit --allow-empty

	Otherwise, please use 'git reset'

CHERRY_PICK_HEAD points to "run-command: optionally kill children on
exit" to help the user understand how to resolve the conflict.
Normally print_advice() would remove it because the caller has set
GIT_CHERRY_PICK_HELP to indicate that it wants to use some other
mechanism than "git commit" to deal with resolved conflicts.
Unfortunately the GIT_CHERRY_PICK_HELP facility does not give the
caller a way to specify an alternative message for this case, like:

	The previous cherry-pick is now empty, possibly due to conflict resolution.

	When you have resolved this problem run "git rebase --continue".
	If you would prefer to skip this patch, instead run "git rebase --skip".
	To check out the original branch and stop rebasing run "git rebase --abort".

In fact, "git cherry-pick" does not handle this case at all.  It lets
"git commit" notice the lack of change.  "git commit" emits a message
and follows the usual rules for a failed commit, including preserving
CHERRY_PICK_HEAD to help the operator clean up.

Ok.  Now the user (sensibly) ignores the message from cherry-pick and
just runs "git rebase --continue".  The rebase finishes but nobody
feels it's his responsibility to remove the .git/CHERRY_PICK_HEAD file
and it gets left behind.

For symptom relief, your patch makes sense, though I haven't checked
it in detail yet.  The description distracted me --- it would be
better to say "this sequence of commands has this bad consequence;
this patch papers over the problem to make people happier until the
underlying problem can be addressed" instead of pretending the design
was almost sane and we are just fixing the last detail. ;-)

I suspect a more appropriate long-term fix would involve "git
cherry-pick" noticing when a patch has resolved to nothing instead of
leaving it to "git commit" to detect that.

Sensible?
Jonathan
