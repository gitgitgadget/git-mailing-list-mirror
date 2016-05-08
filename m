From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFD/PATCH] submodule doc: describe where we can configure
 them
Date: Mon, 9 May 2016 00:01:28 +0200
Message-ID: <20160508220127.GB59077@book.hvoigt.net>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
 <20160503235652.GA395@google.com>
 <xmqqd1p1frw4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 00:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azWqL-0001eX-GB
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 00:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbcEHWG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 18:06:26 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:59477 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcEHWGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 18:06:25 -0400
Received: from [95.90.185.119] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1azWlV-0002hw-D7; Mon, 09 May 2016 00:01:29 +0200
Content-Disposition: inline
In-Reply-To: <xmqqd1p1frw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293980>

Hi,

On Wed, May 04, 2016 at 02:13:47PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > This design is somewhat problematic for a few reasons:
> >
> > - When I want to stop paying attention to a particular submodule and
> >   start paying attention to it again later, all my local settings are
> >   gone.
> 
> True; "[submodule "foo"] enabled = no" may also be a way to fix it
> without throwing the whole with bathwater, though.

IMO we already have this. With

	git config submodule.<name>.update none
	rm -rf <path>
	mkdir <path>

We remove a submodule from the working copy and disable any updates with
'git submodule update ...'. Maybe we should add this 'light' operation
as an option to 'git submodule deinit' in the long run?

> > - When upstream adds a new submodule, I have to do the same manual
> >   work to change the options for that new submodule.
> 
> Because a new module is not automatically "init"ed by default?
> 
> Isn't "config only" vs "config with gitmodules fallback" orthogonal
> to that issue?

What do you mean with "orthogonal to that issue"? AFAICS a gitmodule
fallback does not have that issue. Actually I would see it more like:
.gitmodule is the default and .git/config a possibility to override.
When viewing it like this and using .gitmodule directly is the default
a user does not have any issues when upstream changes submodule
configurations.

Or are we talking about subsequent forks from upstreams? Like C forked
from B and B from A... Then forget what I said.

> > - When upstream changes submodule options (perhaps to fix a URL
> >   typo), I don't get those updates.
> 
> True.

I would say it depends on what is your default view. See above.

> > A fix is to use settings from .git/config when present and fall back
> > to .gitmodules when not.  
> 
> How would that fix the "upstream updated"?

When .gitmodules is the default source "upstream updated" is
automatically read.

> I think an alternative suggested in an ancient time had a more
> elaborate scheme:
> 
>  * Use .git/config as the authoritative source, but record
>    sufficient information to detect the case and cope with it when
>    entry in .gitmodules changes (details below).
> 
>  * When seeing a new .gitmodules entry, either by "git pull" or even
>    "git checkout other-branch", copy that to .git/config (just like
>    what "git submodule init" does).  It would be a policy decision
>    to automatically enabling it or not.  If the policy is "no
>    autoinit", then "module.<name>.inited = no" may also have to be
>    added to .git/config at this point.
> 
>    Record contents of the entry in .gitmodules to the corresponding
>    .git/config entry as "seen".
> 
>  * When the entry in .gitmodules for a submodule known to
>    .git/config is different from what has been "seen", offer the
>    user a chance to update corresponding .git/config entry, and
>    append to the "seen" set of variants in .gitmodules so that the
>    user will not be bugged with "we see .gitmodules entry for module
>    <foo> is different from anything you have ever seen; do you want
>    to make corresponding changes to the module entry in your
>    .git/config" again.
> 
> which would handle all of the above, and without using anything from
> .gitmodules before the user has a chance to vet it.

I can see that for some users it might be important not to pull every
submodule that upstream decides they should have. On the other hand: Is
it really a decision a user can/should make during a pull or a checkout.
I would be annoyed by it, since it interrupts me from the thing I really
want to do and would mostly just choose some default (like always yes or
always no) depending on what is important to me (e.g. faster checkout or
complete repository). So IMO it is more sensible if we just give the
user some default to configure and then use that instead of asking
questions in a situation where the user is not ready to answer them.

And when the user has his defaults we can actually try to deduct such
decisions directly from .gitmodules and do not need to store anything in
.git/config as long as the user goes with the defaults.

Cheers Heiko
