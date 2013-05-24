From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 17:01:43 +0100
Message-ID: <20130524160143.GF27005@serenity.lan>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <7v4ndtcmh0.fsf@alter.siamese.dyndns.org>
 <CABURp0rBzH9=VdW0Y4Bv1tfbSzZ3dwismwgZ7zCwrXC6nDRSJQ@mail.gmail.com>
 <loom.20130524T173321-264@post.gmane.org>
 <20130524153853.GE27005@serenity.lan>
 <loom.20130524T174015-773@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Greenleaf <james.a.greenleaf@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfuRT-0003hO-UK
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab3EXQCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:02:03 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:51054 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab3EXQCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:02:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3412ECDA636;
	Fri, 24 May 2013 17:01:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYbuF6AspZ0G; Fri, 24 May 2013 17:01:49 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 64166CDA63E;
	Fri, 24 May 2013 17:01:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <loom.20130524T174015-773@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225369>

On Fri, May 24, 2013 at 03:42:37PM +0000, Jim Greenleaf wrote:
> John Keeping <john <at> keeping.me.uk> writes:
> 
> > I wonder if this would be better as a file rather than another option to
> > git-update-index.  We already have .git/info/exclude so we could add
> > .git/info/freeze or .git/info/local with the same syntax as the normal
> > .gitignore file.
> 
> .git/info/freeze would be a good solution.
> It would avoid the need to add a new class of files for git-status,
> while keeping a simple, familiar record of all frozen files in a single location.

Now I've thought about it a bit more, I'm not sure this does work.

If an entry in the freeze list means "ignore local changes in this
file", we really want to be talking about local changes relative to some
base.  Otherwise, what happens if the upstream file is radically
altered?  A user probably doesn't want to keep their file unchanged when
this happens.

So we don't just want to store the filename, we want to store the
version of the file that the user chose to ignore.  One way to do this
might be to mark the file as a conflict whenever a change to it comes in
and ignore the freeze file when there is a conflict in the index.  But
then we either need to introduce a new command to manage this state or
some way for the user to perform Git operations ignoring the freeze
file, otherwise how can the user pull down updates?

Perhaps a more user-friendly way to handle this would be to introduce
auto-stash around any operation that will modify a frozen file.  So we
stash the user's (frozen) changes and then apply them after changing the
file.  If there are conflicts then these are marked in the index and
must be resolved, then the unstaged changes in the file are ignored
again.
