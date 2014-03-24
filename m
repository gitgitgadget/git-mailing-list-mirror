From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 23:09:36 +0100
Message-ID: <vpqa9cf9rkv.fsf@anie.imag.fr>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<vpq61n3bcve.fsf@anie.imag.fr>
	<CAAyEjTNPqPHswbrrV9pRyXUUqD8dYzJaXQpWr+g3kuBERNLMRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSD42-0005AD-RS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbaCXWJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:09:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47069 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaCXWJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:09:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2OM9YsJ004826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Mar 2014 23:09:34 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2OM9aiB017596;
	Mon, 24 Mar 2014 23:09:36 +0100
In-Reply-To: <CAAyEjTNPqPHswbrrV9pRyXUUqD8dYzJaXQpWr+g3kuBERNLMRw@mail.gmail.com>
	(Scott Sandler's message of "Mon, 24 Mar 2014 16:01:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Mar 2014 23:09:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2OM9YsJ004826
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396303777.085@S6w05d0FK9OdYT83jqEFMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244890>

Scott Sandler <scott.m.sandler@gmail.com> writes:

> It's a bare repo and I didn't realize server-side reflogs were a
> thing. Just ran "git config core.logallrefupdates true" in the repo on
> the server which seems to be what I should do to enable that.

That should be it, yes.

> The server does know about B, it shows up when you do "git show B".
> However "git branch --contains B" returns nothing.

That is "normal": git push sends objects to the object store in a
lockless manner, and then updates the reference corresponding to the
branch you're pushing to. So in case of concurrent access, the objects
may be sent, but the reference update will fail. Objects would be
garbage collected by a further "git gc [--prune]".

The "not normal" part is that the race condition on the ref update does
actually break for you.

> Gitlab's update hook maintains an event log when any push event
> happens, who pushed and which commits. The most recent time this
> happened, the first push which was lost occured at 2014-03-24 19:04:51
> and the one that overwrote it happened at 2014-03-24 19:05:04. That's
> when the update hook ran, not necessarily when the user hit "git
> push", but it is notable that it's 13 seconds apart which is a pretty
> long time. We do run several hooks for checking coding syntax and
> various other things so it's believable to me that the hooks would
> take more than 13 seconds on occasion, but based on the testing I did
> with the sleep hook it didn't seem like the hooks were actually the
> problem.

Are you really, really, really sure that there's no force-push involved?
(either "push --force" or "push remotename +branchname")

What you describe really looks like a force-push, or a hook doing a ref
update (e.g. a hook on a dev branch that updates master if the code
passes tests or so).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
