From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 2 Nov 2010 16:24:10 +0100
Message-ID: <201011021624.10803.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com> <201011020948.22677.johan@herland.net> <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kenny Root <kroot@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 02 16:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIir-0006Ou-4J
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab0KBPYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:24:25 -0400
Received: from smtp.opera.com ([213.236.208.81]:48872 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab0KBPYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:24:23 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oA2FOAou010421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Nov 2010 15:24:11 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160526>

On Tuesday 02 November 2010, Shawn Pearce wrote:
> On Tue, Nov 2, 2010 at 1:48 AM, Johan Herland wrote:
> > On Tuesday 02 November 2010, Jonathan Nieder wrote:
> >> (+cc: Johan, Thomas)
> >>
> >> Kenny Root wrote:
> >> > Git notes were restricted to refs/notes/* in the command line
> >> > utilities, but setting things like GIT_NOTES_REF to something
> >> > outside of that structure would work.
> >> >
> >> > This removes the restrictions on the git notes command line
> >> > interface.
> >
> > Why do you need to set GIT_NOTES_REF to something outside
> > refs/notes/ at all?
>
> I wanted Kenny to create a notes branch called refs/meta/bad-commits,
> and put that inside of one of our Gerrit Code Review server
> repositories.  We want to extend Gerrit Code Review to check to see
> if any commit in the incoming pack appears in the bad-commits with a
> note.  If it does, it will reject the push.  This allows a repository
> owner to ban certain commits from re-entering a repository once they
> have done a filter-branch or rebase to rewrite a particular item out
> of history.

Ah. Nice feature. Yet another use case for 'git notes' to add to my 
list... :)

> I didn't want to use refs/notes/bad-commits because its not really an
> annotation you would be looking at with git log. But we do want to
> have a log of who banned particular SHA-1s from entering the
> repository, and being able to push that branch from a workstation to
> the server is a convenient way to edit that list of banned SHA-1s.
> During prototyping Kenny discovered you can't use `git note --ref
> refs/meta/bad-commits`.  Which means a server administrator wouldn't
> be able to edit the list directly in the repository.  Hence this
> patch.

Ok, so you're using notes to annotate commits that should NOT exist in 
your repo. In other words (from the code's POV) you are annotating SHA1 
sums that (hopefully) don't exist as objects in your repo.

The notes code will happily do this (and I don't plan on changing this 
behaviour), but you should still know that this is more a side-effect 
of the current implementation than part of the design specification. 
Other notes implementations (jgit?) will need to keep this extra 
requirement in mind.

Also, if you run 'git notes prune' on your notes ref, it will (as 
specified) happily purge all notes to non-existing objects.

> >> Cc-ing some people more knowledgeable about notes than I am; maybe
> >> they can give more information about what this notes.rewriteref
> >> protection and other check are about.
> >
> > Well, I guess we originally decided to limit notes refs to within
> > refs/notes/ in order to clearly separate notes from non-notes, and
> > to prevent notes code from accidentally messing up non-notes refs.
>
> I guess I can see some logic in this.  But the documentation says
> --ref accepts a qualified ref name, and then proceeds to assume that
> a string that starts with "refs/" (like "refs/meta/bad-commits")
> should actually be "refs/notes/refs/meta/bad-commits".  That's a bug
> in the UI and/or documentation.  If we are given a string starting
> with "refs/" and its documented as taking a qualified name, that's
> qualified and should either be rejected, or should be taken as-is.
>
> I think the docs are correct, and the code is buggy.  If the user
> asked us to edit refs/meta/bad-commits, we should.  If the user asked
> us to edit refs/heads/my-branch... well, they asked us to edit it.
>
> :-)

Ok, we've probably been too conservative by trying to restrict where 
users put notes. As I said in the earlier email, we need to loosen this 
up in any case, in order to share notes with remote repos.

> A better safety measure might be to sniff the ref's contents and see
> what it is.  If the top level directory has a number of non-note like
> entries, we should abort editing the branch.  Its not common for
> users to name their directories "02" and "fe".

Good idea. We should probably add something like this to the bottom of 
notes.c:init_notes() (UNTESTED - not even compiled):

  unsigned int i, empty_tree = 1;

  for (i = 0; i < 16; i++) {
  	if (t->root[i]) {
  		empty_tree = 0;
  		break;
  	}
  }

  /* If no notes and >0 non-notes, this is probably not a notes tree */
  if (empty_tree && t->first_non_note)
  	die("'%s' doesn't look like a valid notes tree", t->ref);


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
