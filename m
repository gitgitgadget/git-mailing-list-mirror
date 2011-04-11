From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Mon, 11 Apr 2011 14:20:38 -0400
Message-ID: <20110411182038.GA17928@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
 <20110406055200.GA12547@kytes>
 <m31v1a4keq.fsf@localhost.localdomain>
 <7v1v18y8oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LjE-0006oY-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab1DKSUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:20:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34881
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab1DKSUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 14:20:42 -0400
Received: (qmail 2994 invoked by uid 107); 11 Apr 2011 18:21:31 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Apr 2011 14:21:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2011 14:20:38 -0400
Content-Disposition: inline
In-Reply-To: <7v1v18y8oc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171344>

On Mon, Apr 11, 2011 at 10:55:31AM -0700, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Currently I have TODO file in gitweb/ subdirectory, which is stored in
> > gitweb/.git repository.  Still it doesn't prevent me from "git add"-ing
> > e.g. 'gitweb/gitweb.perl' to git repository itself.
> 
> I would have to say that it is somewhat a sensible thing to want to do
> from an individual contributor's point of view to keep track of personal
> notes on a subpart of a project in a separate repository.
> 
> It however directly contradicts with the approach I suggested earlier,
> which resulted in Peff's patch
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/170937/focus=171040 
> 
> and will be broken, I think.

Interestingly, I came across a similar situation yesterday. I have a
project with asciidoc documentation, and I was looking at making the
built forms available on a separate ref (similar to how you do the
html/man docs in git). One way I came up was to make a repo in
"Documentation/.git" which ignored all of the "*.txt" sources (which
tracked by the main repo) but track all of the built "*.html" files
(which are ignored by the main repo).

Which is exactly the kind of setup my patch tries to declare invalid.
But then I decided that what I was considering was too gross and
error-prone, and maybe it _should_ be banned. :)

In particular, some flaws I considered are:

  1. it is easy to get meta-files like ".gitignore" mixed up
     between the two repositories. And in fact, you have no way in the
     sub-repository to ignore the files from the parent repository
     except by using the non-tracked $GIT_DIR/info/exclude file. And
     without that, you can never use "git clean" in the sub-repository.

  2. When you want to add/commit files in the sub-directory to the main
     repository, you must do so from _outside_ that directory. Otherwise
     git will find the sub-repository's .git dir and you accidentally
     add them to the sub-repository.

> If there is an equally easy way of keeping track of personal notes in a
> subpart of a larger project like you do, without having an unrelated .git/
> directory in a worktree that is controlled by a project and mixing files
> in a single directory in such a way that some belong to the main project
> while others belong to the unrelated "personal notes" project, I would
> rather see us recommend such an approach, and declare that your use case
> is forbidden, as it would give us a far easier to explain rule: "files in
> one directory can be controlled only by one .git/ directory".

It works fine if you just put the notes in their own directory, i.e.:

  git init gitweb/local &&
  $EDITOR gitweb/local/notes

And if you have just the single-file case, you can always do:

  ln -s local/notes gitweb/notes &&
  echo gitweb/notes >.git/info/exclude

to overlay it in the parent tree. You do have to chdir into the sub-repo
to actually commit, but that is a _good_ thing, because it means you're
not accidentally commiting changes to "gitweb.perl" to the sub-repo.

I do something similar with my config.mak, which I track in my own Meta
sub-repo but symlink into place in the main git repository.

-Peff
