From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 13/21] refs: resolve symbolic refs first
Date: Wed, 17 Feb 2016 19:29:27 -0500
Organization: Twitter
Message-ID: <1455755367.7528.57.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-14-git-send-email-dturner@twopensource.com>
	 <56BDE780.2030407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 01:29:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWCTQ-0002dW-AU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 01:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162000AbcBRA3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 19:29:32 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33866 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161199AbcBRA3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 19:29:31 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so25750518qgb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 16:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=gIqSENzEkDAGenGt8dH1O473CVMTbEalKLw77yTpWcA=;
        b=sk6k7384/RuGRPZeGv+YA8gp5Wk6BrxlWZO1LoLPv4eO14CSYrpnfL0ozuDfu8s6an
         Yme41vg8mTBvCRDb3L9Qz1VcFGavf016Fvu7EVGGDlCsRXU44hb18j+uBx9gkTixBDPQ
         Uz4/2UfpguRjrfCfbVQqaGv+APPUEP26PbBRVWlJ8FI9yKWT+fltPyocQbHGa1UUr3Sp
         dUsBw1tKuHzH2d2MVgJLrO0i8F+XBscVPkMLY1NCKQzf1Z0jM9/yn6QfOJl2FKuVJ8rv
         CfGOjZvWnjBRthTIPcg4Ibkl55SkO+yuyb4QfI/JR2SRCA659LhCK356yVtdQZw7dr6W
         UL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=gIqSENzEkDAGenGt8dH1O473CVMTbEalKLw77yTpWcA=;
        b=RSjLvCPV4qlfY6jhm6Uvo9SpUW8V/MDJ+hmcqoES4xH3KP8IAUqEMIY5tSHP2NuwZe
         8rER4NOt7nv7meHJUUts1AraQkJ4bs0/PzXTfP2belKQjnTcpOGzeUOwf/3Tv0eL0LCi
         Eg0eD/ynJ+cR3jA3EWkaLoUM5ECEQh3Gf3lB/Y0+suOKvCKwqcDTJW95LES3PM1C4BHg
         AbduMKzrc3uN445XpEpiG3ZKm6B1dL4JgnjoOXriRaawlfkUt40k0H8kAX0RCnt4Rhyw
         V6jVlFT8JOmNS1jcnvmOtNUrhJKkGwJS8aMrp4BzH3tAI0DNizSiGSMKoxobV+Kf/AEZ
         CCvQ==
X-Gm-Message-State: AG10YORmNJRW/Yke3+rsFYzqSS4+GeyraTnsvBmspZEzkSH6cSZwyopTH55lUfvr17RiYw==
X-Received: by 10.140.82.146 with SMTP id h18mr5731274qgd.26.1455755369828;
        Wed, 17 Feb 2016 16:29:29 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id z62sm1585335qka.26.2016.02.17.16.29.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 16:29:28 -0800 (PST)
In-Reply-To: <56BDE780.2030407@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286569>

On Fri, 201-02-12 at 15:09 +0100, Michael Haggerty wrote:]
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Before committing ref updates, split symbolic ref updates into two
> > parts: an update to the underlying ref, and a log-only update to
> > the
> > symbolic ref.  This ensures that both references are locked
> > correctly
> > while their reflogs are updated.
> > 
> > It is still possible to confuse git by concurrent updates, since
> > the
> > splitting of symbolic refs does not happen under lock. So a
> > symbolic ref
> > could be replaced by a plain ref in the middle of this operation,
> > which
> > would lead to reflog discontinuities and missed old-ref checks.
> 
> This patch is doing too much at once for my little brain to follow.
> 
> My first hangup is the change to setting RESOLVE_REF_NO_RECURSE
> unconditionally in lock_ref_sha1_basic(). I count five callers of
> that
> function and see no justification for why the change is OK in the
> context of each caller. Here are some thoughts:
> 
> * The call from files_create_symref() sets REF_NODEREF, so it is
> unaffected by this change.

Yes.

> * The call from files_transaction_commit() is preceded by a call to
> dereference_symrefs(), which I assume effectively replaces the need
> for
> RESOLVE_REF_NO_RECURSE.

Yes.

> * There are two calls from files_rename_ref(). Why is it OK to do
> without RESOLVE_REF_NO_RECURSE there?
> 
>   * For the oldrefname call, I suppose the justification is the
> "(flag &
> REF_ISSYMREF)" check earlier in the function. (But does this
> introduce a
> significant TOCTOU race?)

The refs code as a whole seems likely to have TOCTOU issues. In
general, anywhere we check/set flag & REF_ISSYMREF without holding a
lock, we have a potential problem.  I haven't generally tried to handle
these cases, since they're not presently handled.  

The central problem with this area of the code is that commit interacts
so intimately with the locking machinery.  I understand some of why
it's done that way.  In particular, your change to ref locking to not
hold lots of open files was a big win for us at Twitter.  But this
means that it's hard to deal with cross-backend ref updates: you want
to hold multiple locks, and backends don't have the machinery for it.

We could add backend hooks to specifically lock and unlock refs. Then
the backend commit code would just be handled a bundle of locked refs
and would commit them.  This might be hairy, but it could fix the
TOCTOU problems.  So, first lock the outer refs, then split out updates
for any which are symbolic refs, and lock those. Finally, commit all
updates (split by backend).

One downside of this is that right now, the backend API is relatively
close to the front-end, and this would leak what should be an
implementation detail.  But maybe this is necessary to knit multiple
backends together.  

But I'm not sure that this is necessary right now, because I'm not sure
that I'm actually making TOCTOU issues much worse. 

>   * For the newrefname call, I suppose it's because the code a little
> higher up tries to delete any existing reference with that name. It
> looks to me like the old code was slightly broken: if newrefname was
> an
> unborn symbolic reference, then: read_ref_full() would fail;
> delete_ref() would be skipped; lock_ref_sha1_basic() would lock the
> *referred-to* reference; the referred-to reference would be
> overwritten
> instead of newrefname. So it could be that here REF_NODEREF
> indirectly
> fixes a bug?

Yes, that's correct.  These two appears to be separable, so I'll make
it an independent patch (and add a test for that case).

> * The last call, from files_reflog_expire(), is also questionable 
> before your patch. If refname is a symref, then the function is 
> expiring the reflog of the symref. But (before this patch) it locks 
> not the symref but its referent. 

I can also separate this one.

> This was discussed in some length before on the mailing list [1], and
> the conclusion was that the current behavior is wrong, but for
> backwards compatibility reasons it would be safest to change it to
> locking *both* the symref and its referent.

Yes, that would be the right thing to do.  But for the reasons I
discuss above, that requires a serious change in the way that backends
work.  

> If possible, it would be better to split this patch up into several:
> the
> first few would each add the REF_NODEREF flag at one callsite, with a
> careful justification of why that is OK. Once all the callsites
> (except
> the one in files_transaction_commit()) have been changed, then the
> last
> patch could add the dereference_symrefs() machinery and change the
> last
> callsite.
> 
> (I'm not certain that those steps are actually doable independently,
> given that REF_NODEREF has other effects besides setting
> RESOLVE_REF_NO_RECURSE.)
> 
> I'm not just being pedantic here. The patch as written is really too
> big
> to review effectively.

That's a legit complaint.  The problem, as you note, is that doing some
of these steps completely independently doesn't work.  But I'll try
splitting out what I can.
