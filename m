From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 15:24:30 -0400
Organization: Twitter
Message-ID: <1438111470.18134.24.camel@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	 <1438107144-24293-3-git-send-email-dturner@twopensource.com>
	 <xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAUP-0004fe-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbbG1TYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:24:33 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35179 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbG1TYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:24:32 -0400
Received: by qgii95 with SMTP id i95so81057718qgi.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=EicAEBOVGaZu3Ma/lOcox4RvQCWh6dzw7o5+vHVecXU=;
        b=ZFXMEai1UjSMtSwaBoJJECMR4ZUxjKXJkpifGnfVwWHvE8+rAIkeQZBWt/gwpYLz3A
         Y7+KluIa4GNpiJsvDWAa+PFpT3x+TJCMtrV01MG4+uwe9ViRpM0fKsfrDqJ2aSOuy8Wd
         03XqbhNJ2pDV4toROsj3D7g4GLDwO6DzoyqLsEs75mFtEp+KD1wXZ9ie2PUx0JfH26ke
         px9uhusPWmLZd0a3VupmvPP9IoNoC8OixXF9EQKUHEme1SDKHZzMBPbt9zzQXenBpWvc
         m9tFIbYUGNewugL7y7/Vd1Kb5iNM5M1L3mWvbjFWjhX1c/ZWtAyVtZkeKKu3FdjCK+oO
         qMlA==
X-Gm-Message-State: ALoCoQmxSdVNYKUW2PbxN/U800JGXo1U7JGTubkBlWMdsxG8/B1hriinl/Jx2Ab2wt5tcRHKH34b
X-Received: by 10.140.23.102 with SMTP id 93mr51461333qgo.61.1438111472255;
        Tue, 28 Jul 2015 12:24:32 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id v64sm11797002qgv.28.2015.07.28.12.24.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 12:24:31 -0700 (PDT)
In-Reply-To: <xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274818>

On Tue, 2015-07-28 at 12:00 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > All-caps files like NOTES_MERGE_REF are pseudorefs, and thus are
> > per-worktree.  We don't want multiple notes merges happening at once
> > (in different worktrees), so we want to make these refs true refs.
> >
> > So, we lowercase NOTES_MERGE_REF and friends.  That way, backends
> > that distinguish between pseudorefs and real refs can correctly
> > handle notes merges.
> >
> > This will also enable us to prevent pseudorefs from being updated by
> > the ref update machinery e.g. git update-ref.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> This seems to do a bit more than what it claims to do.  As this kind
> of changes are very error-prone to review, I did a bulk replace of
> the three all-caps NOTES_*THING* and compared the result with what
> this patch gives to spot this:
> 
> >  	# Fail to finalize merge
> >  	test_must_fail git notes merge --commit >output 2>&1 &&
> > -	# .git/NOTES_MERGE_* must remain
> > -	test -f .git/NOTES_MERGE_PARTIAL &&
> > -	test -f .git/NOTES_MERGE_REF &&
> > -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
> > -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
> > -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
> > -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
> > +	# .git/notes_merge_* must remain
> > +	git rev-parse --verify notes_merge_partial &&
> > +	git rev-parse --verify notes_merge_ref &&
> > +	test -f .git/notes_merge_worktree/$commit_sha1 &&
> > +	test -f .git/notes_merge_worktree/$commit_sha2 &&
> > +	test -f .git/notes_merge_worktree/$commit_sha3 &&
> > +	test -f .git/notes_merge_worktree/$commit_sha4 &&
> 
> The two "rev-parse --verify" looks semi-sensible [*1*];
> notes_merge_partial is all lowercase and it refers to
> $GIT_DIR/notes_merge_partial, because they are shared across working
> tree. 
> 
> But then why are $GIT_DIR/notes_merge_worktree/* still checked with
> "test -f"?  If they are not refs or ref-like things, why should they
> be downcased?  If they are, why not "rev-parse --verify"?

They are downcased for consistency with the other notes_merge_* stuff.

> [Footnote]
> 
> *1* I say "semi-" sensible, because it looks ugly.  All ref-like
>     things immediately below $GIT_DIR/ are all-caps by convention.
>     Perhaps it is a better idea to move it under refs/; "everything
>     under refs/ is shared across working trees" is probably a much
>     better rule than "all caps but HEAD is special".

Do you mean move all current pseudorefs?  Or just the notes stuff? 

Moving MERGE_HEAD means that if someone upgrades in the middle of a
merge, they'll end up confused.  The same is true of the notes stuff,
but I imagine that many fewer people use notes than use git merge, so I
wasn't going to worry about that.  What do you think?
