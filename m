From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/2] rev-parse: add --filename-prefix option
Date: Tue, 9 Apr 2013 22:28:27 +0100
Message-ID: <20130409212827.GG2222@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
 <7vtxnfpglq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPg5r-0004yQ-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935976Ab3DIV2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:28:39 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:46023 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934470Ab3DIV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:28:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 15127161E7BC;
	Tue,  9 Apr 2013 22:28:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H541Y67qyQlg; Tue,  9 Apr 2013 22:28:37 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4348E161E7C2;
	Tue,  9 Apr 2013 22:28:29 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vtxnfpglq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220636>

On Tue, Apr 09, 2013 at 01:57:21PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > This adds a prefix string to any filename arguments encountered after it
> > has been specified.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> 
> Stale subject?

Yep.  Sorry.

> > +--prefix <arg>::
> > +	Behave as if 'git rev-parse' was invoked from the `<arg>`
> > +	subdirectory of the working tree.  Any relative filenames are
> > +	resolved as if they are prefixed by `<arg>` and will be printed
> > +	in that form.
> > ++
> > +This can be used to convert arguments to a command run in a subdirectory
> > +so that they can still be used after moving to the top-level of the
> > +repository.  For example:
> > ++
> > +----
> > +prefix=$(git rev-parse --show-prefix)
> > +cd "$(git rev-parse --show-toplevel)"
> > +eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
> 
> I think you should tighten rev-parse parameter to reject options and
> revisions, especially as an example to teach how to use it.  When
> the user said
> 
> 	git mylog -U20 master..next -- README
> 
> inside Documentation/ directory,  "git-mylog" script would want to
> see README prefixed with Documentation/ but want to see -U20 or
> master..next untouched.

And it will if it runs:

	git rev-parse --prefix Documentation/ -U20 master..next -- README

Which gives:

	-U20
	f131fb6eb2a1e09f7ce53d148e21ce6960f42422
	^fa7285dc3dce8bd01fd8c665b032603ed55348e5
	--
	Documentation/README

>                          Historically, rev-parse was a way to sift
> options and args meant for rev-list from those mant for diff-tree
> so that a variant of
> 
> 	git rev-list $(git rev-parse --revs) "$@" |
>         git diff-tree --stdin $(git rev-parse --no-revs)
> 
> can be used to implement such "git mylog" script.
> 
> I think "--no-revs --no-flags" is how you ask it to give you only
> the paths, but I am writing from memory so please double check.
> 
> Having said all that.
> 
> Existing scripts (e.g. "git am") do this kind of things without such
> an option added to rev-parse.  They first do:
> 
>     prefix=$(git rev-parse --show-prefix)
> 
> and refer to "$prefix/$1", "$prefix/$2", etc., I think.
> 
> Is this option really necessary to update "git submodule"?  Don't we
> have a much better idea which parameter holds user-supplied path in the
> script than having rev-parse make a guess on the entire "$@"?

It's not guessing on all of "$@" in git-submodule - we know that
everything left is a path.

I've looked at git-am and hadn't thought of doing that, just thought
this was a reasonably elegant way of processing the arguments.  I'm
happy to try another approach if that's going to be more acceptable.
