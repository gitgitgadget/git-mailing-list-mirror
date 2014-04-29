From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] Sleep 1 millisecond in poll() to avoid busy wait
Date: Tue, 29 Apr 2014 05:47:27 +0200
Organization: <)><
Message-ID: <20140429034727.GB15181@camelia.ucw.cz>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com> <535E6E4B.6070308@viscovery.net> <20140428153527.GB12357@camelia.ucw.cz> <CABPQNSbpyFzg8A8gLp2nJZeTRSLSb0Qs8ytZDsJLmi6VyER71Q@mail.gmail.com> <xmqqfvkxqo0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wez14-00050j-L6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbaD2Dra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:47:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37898 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaD2Dra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:47:30 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 284A51C00AE;
	Tue, 29 Apr 2014 05:47:29 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3T3lSMU015305;
	Tue, 29 Apr 2014 05:47:28 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3T3lRG4015304;
	Tue, 29 Apr 2014 05:47:27 +0200
Content-Disposition: inline
In-Reply-To: <xmqqfvkxqo0l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247518>

Hello Junio,

thank you for pointing out the problems.

Let me explain the background:

After some discussion a one line fix to win32/poll.c was accepted to msysgit/git
at 2012-05-16 https://github.com/msysgit/git/pull/7

The description of the commit looked like this:
> I played around with this [...]
> [...]
> I also tested the very fast local case, and didn't see any measurable
> difference. On a big repo with 4500 files, the upload-pack took about 2
> seconds with and without the fix.
... but there was no sign-off by Theodore.

Because poll.c comes from Gnulib, it was reported there as well.
Paolo Bonzini accepted the fix for poll.c and added a fix for select.
The combined commit got this changelog entry:

> 2012-05-21  Paolo Bonzini  <bonzini@gnu.org>
> 
>         poll/select: prevent busy-waiting.  SwitchToThread() only gives away
>         the rest of the current time slice to another thread in the current
>         process. So if the thread that feeds the file decscriptor we're
>         polling is not in the current process, we get busy-waiting.
>         * lib/poll.c: Use SleepEx(1, TRUE) instead of SwitchToThread().
>         Patch from Theodore Leblond.
>         * lib/select.c: Split polling out of the loop that sets the output
>         fd_sets.  Check for zero result and loop if the wait timeout is
>         infinite.

The patch that I (Stepan) submitted as "v2" combines things like this:
- subject by Theodore
- first paragraph by Paolo, concise problem description
- rest from Theodore's original commit ("I" = Theodore, I suppose)
- diff exctly as in gnulib commit

On Mon, Apr 28, 2014 at 11:58:50AM -0700, Junio C Hamano wrote:
>     Subject: compat/poll: sleep 1 millisecond to avoid busy wait

Thanks for improving it.

>     Signed-off-by: Theodore Leblond <theodore.leblond@gmail.com>
>     Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>     Acked-by: Johannes Sixt <j6t@kdbg.org>
>     Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

Sorry that I forgot to add my sign-off (Stepan).
But I'm afraid I cannot add Theodore's, it was not in the original
commit.  But it is one line change; the real work was the analysis.

Stepan
