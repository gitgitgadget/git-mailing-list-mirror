From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add more checkout tests
Date: Sun, 9 Dec 2007 23:03:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712092244570.5349@iabervon.org>
References: <Pine.LNX.4.64.0712092204200.5349@iabervon.org>
 <7vprxfmczi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 05:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Zs8-0001zv-QG
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 05:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbXLJEDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 23:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXLJEDc
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 23:03:32 -0500
Received: from iabervon.org ([66.92.72.58]:53795 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808AbXLJEDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 23:03:30 -0500
Received: (qmail 15056 invoked by uid 1000); 10 Dec 2007 04:03:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2007 04:03:28 -0000
In-Reply-To: <7vprxfmczi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67676>

On Sun, 9 Dec 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +test_expect_success "checkout with unrelated dirty tree without -m" '
> > +
> > +	git checkout -f master &&
> > +	fill 0 1 2 3 4 5 6 7 8 >same &&
> > +	cp same kept
> > +	git checkout side >messages && 
> > +	git diff same kept
> > +	(cat > messages.expect <<EOF
> > +M	same
> > +EOF
> > +) &&
> > +	touch messages.expect &&
> > +	git diff messages.expect messages
> > +'
> 
> What is this "touch" about?

Left over from before I'd added the here document, so there'd be a file to 
diff against, and it would be wrong, and I could find the actual contents. 
I just forgot to take it out when I was creating the real thing.

> I do not recall the details, but we had problem reports that some shells
> do not handle here-documents (i.e. cmd <<EOF) inside test_expect_success
> well, and generally tried to keep them outside.  I however see some of
> the newer tests do have here-doc inside expect-success, and do not
> recall hearing breakage reports on them.  Maybe it was a false alarm and
> we were being overly cautious, or maybe not enough people (especially on
> more exotic systems) are running tests these days.  Let's keep the
> here-doc as-is in your tests and see what happens.

Sure. Possibly we should instead just be testing for the presence of the 
correct line, and absence of incorrect lines, in any case?

> >  test_expect_success "checkout -m with dirty tree" '
> >  
> >  	git checkout -f master &&
> >  	git clean -f &&
> >  
> >  	fill 0 1 2 3 4 5 6 7 8 >one &&
> > -	git checkout -m side &&
> > +	git checkout -m side > messages &&
> >  
> >  	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
> >  
> > +	(cat >expect.messages <<EOF
> > +Merging side with local
> > +Merging:
> > +ab76817 Side M one, D two, A three
> > +virtual local
> > +found 1 common ancestor(s):
> > +7329388 Initial A one, A two
> > +Auto-merged one
> > +M	one
> > +EOF
> > +) &&
> > +	git diff expect.messages messages &&
> 
> I do not like the idea of testing the exact wording of messages this
> way.
> 
> I do not think we care about the exact wording of these messages, and I
> think our tests should check what we do care about without casting the
> UI in stone.  Otherwise, it will make it harder to clean-up the user
> experience later.  Perhaps it would be sufficient to make sure that (1)
> this checkout succeeds with exit 0 status, and that (2) the contents of
> the merged 'one' is a reasonable merge result, i.e. "git diff HEAD one"
> gets the same patch-id as "git diff HEAD one" taken before switching the
> branches.

What I'm actually testing for is the "M<tab>one" line, and that the 
previous line isn't name-status stuff; that is, that the name-status stuff 
is right.

Of course, a patch to clean up the user experience could have a hunk that 
makes the test expect that the UI is cleaned up. It's not like we can't 
change our tests to accompany improvements in behavior, and I'd argue that 
those hunks give a useful example of the improvement.

> > @@ -145,7 +176,16 @@ test_expect_success 'checkout -m with merge conflict' '
> >  test_expect_success 'checkout to detach HEAD' '
> >  
> >  	git checkout -f renamer && git clean -f &&
> > -	git checkout renamer^ &&
> > +	git checkout renamer^ 2>messages &&
> > +	(cat >messages.expect <<EOF
> > +Note: moving to "renamer^" which isn'"'"'t a local branch
> > +If you want to create a new branch from this checkout, you may do so
> > +(now or later) by using -b with the checkout command again. Example:
> > +  git checkout -b <new_branch_name>
> > +HEAD is now at 7329388... Initial A one, A two
> > +EOF
> > +) &&
> > +	git diff messages.expect messages &&
> 
> Same here.  If we want to make sure the head is detached at the intended
> commit, make sure "rev-parse HEAD" gives the expected result, and make
> sure "symbolic-ref HEAD" says it is not symbolic.

I think we're already testing for that. I really want the "HEAD is now..." 
line, which ought to give the right info.

The point of adding these tests (and parts of tests) is that I'd forgotten 
to maintain some of the important information while writing 
builtin-checkout, and there wasn't a test that it was provided. While some 
of the output is arbitrary informative text, there's a certain amount of 
generated information there that shouldn't get lost or be incorrect.

	-Daniel
*This .sig left intentionally blank*
