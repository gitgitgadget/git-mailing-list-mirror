From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] receive-pack: optionally deny case-clone refs
Date: Tue, 03 Jun 2014 18:02:39 -0400
Organization: Twitter
Message-ID: <1401832959.18134.120.camel@stross>
References: <1401822896-816-1-git-send-email-dturner@twitter.com>
	 <xmqqioohwud5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:03:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwnN-0004bk-E8
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbaFCWCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:02:44 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53426 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbaFCWCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:02:43 -0400
Received: by mail-qa0-f43.google.com with SMTP id m5so5919636qaj.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 15:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=KFYidV4gTVFh21Nhxs9NkL5jwM/k1Mc9fm1+AEG6N9I=;
        b=KcIYedBUyb/edCHRmN2m8oR7PvdYz5Sa4822QCjE6kXn+BTkXKl8tWTeruIRuh7NFD
         9gwOGDk4tZcCLkkAb9+TtkVXxtjk94e/evDHgab9eWN8Ti9j4sDpOyOHWHq13gcnDOmV
         mo5xrk7qH4OGLftU5OVGGco4ygjxsvDjZE8YMSclPpb5kHz0Wrsqf1BKRX+My4NBZqo/
         xu45DvWklaOtrImyK7qLoBWrqzN+5IzB95DOMXB+u1f5ltmhBCfFmEiWN8ygGHT/j/Da
         SAZ+CHSbN/sviNBWCilOUu+W9IFKc6nQEvra+GBRfRNEhOOeI0OmaOIrpPhFhtvsZ7SB
         mB9w==
X-Gm-Message-State: ALoCoQnlqfdgothV6k/O8r7DhrmT8bnvrBBRDjZew3/CHBe1HUrwg0NrmDZWIs4hn2Y67QEtShFE
X-Received: by 10.140.23.166 with SMTP id 35mr60154677qgp.89.1401832962088;
        Tue, 03 Jun 2014 15:02:42 -0700 (PDT)
Received: from [172.17.3.196] ([38.104.173.198])
        by mx.google.com with ESMTPSA id s2sm848190qaj.36.2014.06.03.15.02.40
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 15:02:41 -0700 (PDT)
In-Reply-To: <xmqqioohwud5.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250691>

On Tue, 2014-06-03 at 14:33 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > It is possible to have two branches which are the same but for case.
> > This works great on the case-sensitive filesystems, but not so well on
> > case-insensitive filesystems.  It is fairly typical to have
> > case-insensitive clients (Macs, say) with a case-sensitive server
> > (GNU/Linux).
> >
> > Should a user attempt to pull on a Mac when there are case-clone
> > branches with differing contents, they'll get an error message
> > containing something like "Ref refs/remotes/origin/lower is at
> > [sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
> > (unable to update local ref)"
> >
> > With a case-insensitive git server, if a branch called capital-M
> > Master (that differs from lowercase-m-master) is pushed, nobody else
> > can push to (lowercase-m) master until the branch is removed.
> >
> > Create the option receive.denycaseclonebranches, which checks pushed
> > branches to ensure that they are not case-clones of an existing
> > branch.  This setting is turned on by default if core.ignorecase is
> > set, but not otherwise.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> 
> I do not object to this new feature in principle, but I do not know
> if we want to introduce a new word "case-clone refs" without adding
> it to the glossary documentation.

I would be happy to add "case-clone" to the glossary -- would that be OK
with you?  I do not immediately think of the better term.

> It feels a bit funny to tie this to core.ignorecase, which is an
> attribute of the filesystem used for the working tree, though.

It seems like it's an attribute of the filesystem used for the GIT_DIR
(at least, that's what's actually tested in order to set it).  So I
think this is OK.

> Updates to Documentation/config.txt and Documentation/git-push.txt
> are also needed.
> ...
> Would it make sense to reuse the enum deny_action for this new
> settings, with an eye to later convert the older boolean ones also
> to use enum deny_action to make them consistent and more flexible?
>...
> We write C not C++ around here; the pointer-asterisk sticks to the
> variable name, not typename.
>...[moved]
> The trailing blank line inside a function at the end is somewhat
> unusual.

Will fix these, thank you.  Do you happen to know if there's a style
checker available that I could run before committing?

> > +	return !strcasecmp(refname, incoming_refname) &&
> > +		strcmp(refname, incoming_refname);
> 
> (Mental note to the reviewer himself) This returns true iff there is
> an existing ref whose name is only different in case, and cause
> for-each-ref to return early with true.  In a sane case of not
> receiving problematic refs, this will have to iterate over all the
> existing refnames.  Wonder if there are better ways to optimize this
> in a repository with hundreds or thousands of refs, which is not all
> that uncommon.

My expectation is that on average a push will involve a small number of
refs -- usually exactly one.  We could put the refs into a
case-insensitive hashmap if we expect many refs.  This ties into the
general question of whether ref handling can be made O(1) or O(log N),
which I think the list has not come to a satisfactory solution to.

> > diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> > index 0736bcb..099c0e3 100755
> > --- a/t/t5400-send-pack.sh
> > +++ b/t/t5400-send-pack.sh
> > @@ -129,6 +129,26 @@ test_expect_success 'denyNonFastforwards trumps --force' '
> >  	test "$victim_orig" = "$victim_head"
> >  '
> >  
> > +if ! test_have_prereq CASE_INSENSITIVE_FS
> > +then
> 
> Hmm, don't we want the feature to kick in for both case sensitive
> and case insensitive filesystems?

Yes, but it's harder to test on case-insensitive filesystems because we
cannot have coexisting local case-clone branches.  We could test by
making sure to first locally deleting the case-clone branches, I guess.
I'll do that.

> > +test_expect_success 'denyCaseCloneBranches works' '
> > +	(
> > +	    cd victim &&
> > +	    git config receive.denyCaseCloneBranches true
> > +	    git config receive.denyDeletes false
> > +	) &&
> > +	git checkout -b caseclone &&
> > +	git send-pack ./victim caseclone &&
> > +	git checkout -b CaseClone &&
> > +	test_must_fail git send-pack ./victim CaseClone &&
> 
> At this point, we would want to see not just that send-pack fails
> but also that "victim" does not have CaseClone branch and does have
> caseclone branch pointing at the original value (i.e. we do not want
> to see "caseclone" updated to a value that would have gone to
> CaseClone with this push).
> 
> Each push in the sequence should be preceded by a "git commit" or
> something so that we can verify the object at the tip of the ref in
> the "victim" repository, I would think.  Otherwise it is hard to
> tell an expected no-op that has failed and a no-op because it
> mistakenly pushed the same value to a wrong ref.

Will fix!
