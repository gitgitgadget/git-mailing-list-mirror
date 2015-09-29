From: "George Spelvin" <linux@horizon.com>
Subject: Re: Why not git reset --hard <path>?
Date: 29 Sep 2015 12:15:43 -0400
Message-ID: <20150929161543.23444.qmail@ns.horizon.com>
References: <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 29 18:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgxZG-0001OZ-17
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 18:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933391AbbI2QPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 12:15:46 -0400
Received: from ns.horizon.com ([71.41.210.147]:47222 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932887AbbI2QPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 12:15:45 -0400
Received: (qmail 23445 invoked by uid 1000); 29 Sep 2015 12:15:43 -0400
In-Reply-To: <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278828>

> I agree with you if we limit the scope to "reset --hard" that does
> not mention any commit on the command line (or says "HEAD").
> 
> However, for things like:
>
>     $ git reset --hard HEAD^ Makefile
>     $ git reset --hard HEAD@{4.hours.ago} Makefile
>
> I do not think "reset --hard" is a good match.  Conceptually, you
> are grabbing what was stored in a given commit and checking that out
> to your current workspace (that is, the index and the working tree).

I actually disagree, BUT that was based on an inaccurate mental model,
so I'm not sure if my judgement can be trusted.  Still, I'll blather on
just to give a different perspective.

To me, "git reset --hard" is "git reset" plus checking out from the index
to the working directory.  That's the difference and the only difference.

So any difference in behaviour between
	git reset --hard <revision> -- <paths>
and
	git reset --mixed <revision> -- <paths>
	git checkout -- <paths>
needs to be justified.  (There might be some if a file does not exist in
the revision.)

> All modes of "git reset" are primarily about updating where in the
> history DAG your HEAD points at, and then adjusting your current
> workspace to that update, taking into account the reason why you are
> repointing your HEAD in the history DAG (e.g. when doing --hard
> reset, you want the workspace to match what the commit your HEAD now
> points at; when doing --soft reset, you don't want any changes
> done).

Er... no.  Re-pointing HEAD can *only* be done as a global operation.
That's the single most fundamental difference between git and CVS.

Any time you specify a path, *obviously* that part can't be done, so
git-reset just skips that part and goes on to the index-updating part..


Git reset also skips that part in the single most common invocation
scenario: un-doing git-add.  That's for a different reason (pointing
HEAD to HEAD is a no-op), but it contributes to the mental model that
git-reset is fundamentally used for copying from history to the index.


That's my mental model, for what little it's worth (given the caveat above):
- git checkout is fundamentally about copying from the index to the
  working directory.  If can also move HEAD first (and create branches!)
  as a convenience feature.
- git reset is fundamentally about copying from HEAD to the index.
  Like git-checkout, it can also move HEAD first (and copy to the working
  directory) as a convenience feature.

To me, "git reset" is "throw the changes away and get me back to
some previous state".  That's why it's the tool I reached for in the
merge-conflict situation that started this thread.

I didn't think to try "git checkout" because I needed to overwrite the
merge conflict in the index, and I don't think of "git checkout" as
doing that.  (Globally, it fails if there are unresolved conflits.)
