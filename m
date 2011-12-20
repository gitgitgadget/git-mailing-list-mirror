From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: labels
Date: Mon, 19 Dec 2011 17:47:53 -0800
Message-ID: <20111220014753.GD20591@padd.com>
References: <4EEE3203.10605@diamand.org>
 <CAOpHH-W1hE6bw51NKXrdf1QtF3T+v4aLwxMn+_5xPP5j=uJr3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:48:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcooF-00033M-Q8
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab1LTBr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:47:59 -0500
Received: from honk.padd.com ([74.3.171.149]:38106 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1LTBr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:47:58 -0500
Received: from tic.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 2FE2831BF;
	Mon, 19 Dec 2011 17:47:57 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id 65F4A10006A; Mon, 19 Dec 2011 20:47:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-W1hE6bw51NKXrdf1QtF3T+v4aLwxMn+_5xPP5j=uJr3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187495>

vitor.hda@gmail.com wrote on Mon, 19 Dec 2011 10:28 +0000:
> On Sun, Dec 18, 2011 at 6:33 PM, Luke Diamand <luke@diamand.org> wrote:
> > I've been looking at fixing the --detect-labels flag in git-p4. I'm now
> > thinking that the current way it's done is just all wrong.
> >
> > The current code has a few annoying bugs which I mostly have fixes for:
> >
> > - it only works when there is no more than one label per changelist;
> >
> > - if the count of files in the p4 label doesn't match the count of files in
> > the p4 changelist then the label gets dropped (by design);
> >
> > - git-p4 rebase ignores --detect-labels
> >
> > - it imports all the label/file mappings each time (I haven't fixed this
> > yet)
> >
> > However, the thing that's more annoying is that it only imports labels when
> > importing the changelist they are pointing at.
> >
> > So, for example, if you do something like this:
> >
> > p4 edit; p4 submit
> > p4 tag TAG1
> > git-p4 rebase
> > p4 tag TAG2
> > git-p4 rebase
> >
> > then TAG1 will be detected, but TAG2 won't.
> >
> > This is a particular nuisance for me, as I just have git-p4 running all the
> > time eating commits, so there's no scope for a human to delay the git-p4 and
> > pickup the label.
> >
> > I think what's needed is to do something completely different.
> >
> > This is speculation at the moment, and I'd welcome comments before I start
> > hacking.
> >
> > There will be a new _command_, import-labels. This command will find all the
> > labels that git knows about, and the labels that p4 knows about, and then do
> > the obvious diff. It will then create tags as needed directly (i.e. not
> > using fast-import).
> >
> > It will unfortunately need to hunt through the revision history looking for
> > the git hash <h> that matches p4 changelist <c>. This could get quite slow,
> > although no worse than O(n).
> >
> > Something like:
> >
> > p4 edit; p4 submit
> > p4 tag TAG1
> > git-p4 rebase
> > git-p4 import-labels
> > p4 tag TAG2
> > git-p4 import-labels
> >
> > I'm going to try to work up a patch with some test cases but in the meantime
> > if anyone thinks I've missed something, please let me know.
> 
> Hi Luke,
> 
> Personally, I would prefer to keep the label import working together
> with git-p4 rebase/sync so that it doesn't need to go over P4 history
> twice. The sanity check currently implemented seems completely bogus. In
> my opinion that check should be completely rewritten (maybe move it into
> a specific class method?). On a first approach it should at least check
> if all files in the label exist in the repository/branch. Ideally, if
> not all repository/branch files are labelled, then a special branch
> should be created that would not contain those files and the label would
> be applied to that. I'm not sure what to do in the case where the label
> contains files that are not part of the repository/branch... maybe we
> can simply ignore them with a Warning?

Agree we can at least keep what's currently working, especially
with the bug fixes mentioned.  It's pretty blatantly broken in
those cases.  I imagine for some flows, like where labels are old
compared to git checkouts, it's okay.

But adding a new command to go back and look for _new_ labels
makes sense too.  Finding the new ones isn't so bad, given that
p4 can just print them directly, and we keep them as tags in git.

> If you are really sure that this is not the way to go and that the
> import-labels command needs to be created, then I would advise you to
> search P4 history backwards until you find a label that was already
> imported. This way the script only has to go over P4 history until the
> last time import-labels was run. Of course, it still needs to do this
> for all branches (hope you are not forgeting them ;).

Yeah.  That's probably a good bet.  Find the tag that points to
the most recent change number and stop there.

I'm not too worried about walking backwards looking for a given
change number either.  You could even bisect if you feel clever.  :)
Off and on, it has felt like a good idea to keep that mapping
permanent somewhere, matching up tags to change numbers.  This
has come up on the list outside of p4 discussions too.

But isn't there a step in label detection that looks an awful lot
like branch point detection?  You've got a label, which is a
bunch of files, not a p4 change number.  Now you have to figure
out the change number so you can go hunt that down in the git
history.  Vitor's take on this was to use git diff machinery to
find it, not trawling through the p4 change/filelog/describe
history, mainly because it's likely much faster to do it locally
in git.

		-- Pete
