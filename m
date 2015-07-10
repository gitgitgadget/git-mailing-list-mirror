From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Fri, 10 Jul 2015 13:59:07 -0400
Organization: Twitter
Message-ID: <1436551147.4542.72.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
		<1436316963-25520-2-git-send-email-dturner@twopensource.com>
		<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
		<559D92CF.7000408@kdbg.org>	<xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
		<1436399058.4542.26.camel@twopensource.com>
		<xmqqmvz5x4cc.fsf@gitster.dls.corp.google.com>
		<1436478800.4542.61.camel@twopensource.com>
	 <xmqqbnflugsw.fsf@gitster.dls.corp.google.com>
	 <559F4A55.1070309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDcZy-0002Tk-RK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 19:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbbGJR7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 13:59:14 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35660 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbbGJR7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 13:59:11 -0400
Received: by qget71 with SMTP id t71so132705974qge.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 10:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Cg61iMDtBQsibqIADOUsok8Bp93W879cHFZdxpXlHLQ=;
        b=VojUi9+CjszO74NKyOe0f0lVBnkuEJyOw2fEestBYjRNVNXwxD0Fed3U8rUYk223wA
         4N9DajH9enTMXwiHaUImTFaQaCd9vi4Ws0WrYVw8OuIKQ8DoJ8lD1BsMano1VHCEMkI9
         msyjuySHQkbDU+qpB29zPIgjVfvDt8LKeqHwa2FRShiv7ryU4rdtQGC/aY/Og38UFWFj
         Z7VnTfu6YWgDRjaZNH5LALTl+d6rI+0nryVd8W6p7SfxALpjjluAALiNdhn+1V87RVVK
         mTyq5KYexxvCb6hKYanaZ0iyJU75WYamsWiwUGKQPQE+zufQLlXerKgKyRgVbkGpUfuv
         hjIA==
X-Gm-Message-State: ALoCoQlj1FicW3ay+9aap88PZWfY5GibvukIVn8ennqjsQoxcbEbEI4ER6X+XxqDHGi+QDNmGtc/
X-Received: by 10.140.217.149 with SMTP id n143mr37293620qhb.9.1436551150278;
        Fri, 10 Jul 2015 10:59:10 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id q22sm5816177qkh.35.2015.07.10.10.59.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 10:59:09 -0700 (PDT)
In-Reply-To: <559F4A55.1070309@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273830>

On Fri, 2015-07-10 at 06:30 +0200, Michael Haggerty wrote:
> On 07/10/2015 12:06 AM, Junio C Hamano wrote:
> > David Turner <dturner@twopensource.com> writes:
> > 
> >> OK, here's my current best idea:
> >>
> >> 1. A "pseudoref" is an all-caps file in $GIT_DIR/ that always contains
> >> at least a SHA1.  CHERRY_PICK_HEAD and REVERT_HEAD are examples. Because
> >> HEAD might be a symbolic ref, it is not a pseudoref. 
> >>
> >> Refs backends do not manage pseudorefs.  Instead, when a pseudoref (an
> >> all-caps ref containing no slashes) is requested (e.g. git rev-parse
> >> FETCH_HEAD) the generic refs code checks for the existence of that
> >> file and if it exists, returns immediately without hitting the backend.
> >> The generic code will refuse to allow updates to pseudorefs.
> >>
> >> 2. The pluggable refs backend manages all refs other than HEAD.
> >>
> >> 3. The "files" backend always manages HEAD.  This allows for a reflog
> >> and for HEAD to be a symbolic ref.
> >>
> >> The major complication here is ref transactions -- what if there's a
> >> transaction that wants to update e.g. both HEAD and refs/heads/master?
> > 
> > An update to the current branch (e.g. "git commit") does involve at
> > least update to the reflog of HEAD, the current branch somewhere in
> > refs/heads/ and its log, so it is not "what if" but is a norm [*1*].
> 
> The updating of symlink reflogs in general, and particularly that of
> HEAD, is not done very cleanly. You can see the code in
> `commit_ref_update()` (some of it helpfully commented to be a "Special
> hack"):
> 
> * If a reference is modified through a symlink, the symlink is locked
> rather than the reference itself.
> * If a reference is modified directly, and HEAD points at it, then the
> HEAD reflog is amended without locking HEAD.
> 
> Aside from the lack of proper locking, which could result in races with
> other processes, we also have the problem that the same reference that
> is being changed via one of these implicit updates could *also* be being
> changed directly in the same transaction. Such an update would evade the
> `ref_update_reject_duplicates()` check.
> 
> Previously my thinking was that the locking should be done differently:
> when the transaction is being processed, extra ref_update records could
> be created for the extra reference(s) that have to be modified, then
> these could be handled more straightforwardly. So supposing that HEAD
> points at refs/heads/master,
> 
> * An update of HEAD would be turned into a reflog update and also add a
> synthetic update to refs/heads/master.
> * An update of refs/heads/master would add a synthetic update to the
> HEAD reflog
> 
> The first point would obviously apply to any updates via symbolic refs.
> The second one should too, thought this is a case that we currently punt
> on to avoid the need to do reverse symbolic ref lookups.

All of this is worth fixing, but I don't know that it needs to be fixed
before ref backends hit.  What do you think?

> >> It may be the case that this never happens; I have not actually audited
> >> the code to figure it out.  If someone knows for sure that it does not
> >> happen, please say so. But assuming it does happen, here's my idea:
> >>
> >> If the refs backend is the files backend, we can simply treat HEAD like
> >> any other ref.
> >>
> >> If the refs backend is different, then the refs code needs to hold a
> >> files-backend transaction for HEAD, which it will commit immediately
> >> after the other transaction succeeds.  We can stick a pointer to the
> >> extra transaction in the generic struct ref_transaction, which (as
> >> Michael Haggerty suggests) specific backends will extend.
> >>
> >> A failure to commit either transaction will be reported as a failure,
> >> and we'll give an additional inconsistent state warning if the main
> >> transaction succeeds but the HEAD transaction fails.
> > 
> > Yeah, I was thinking along those lines, too.  Thanks for clearly
> > writing it down.
> > 
> >> What do other folks think?
> > 
> > Me too ;-)
> 
> I don't have an answer right now, and I have to get on an airplane in a
> few hours so I can't think hard about it at the moment. But let me also
> braindump another vague plan that I have had for a long time:
> overlayable reference storage schemes. Think of the way that loose refs
> are currently overlaid on top of packed refs. I think it might be useful
> to support overlaying more generally.
> 
> In this particular case there could be a workspace-local reference
> storage that only handles HEAD and perhaps some of the other
> pseudoreferences. That could be overlaid onto loose reference storage
> (which would then only concern itself with references under "refs/"),
> which would in turn be overlaid onto packed refs. The workspace-local
> reference storage layer would have evil special-cased code for dealing
> with the references that live outside of "refs/".
> 
> A `ref_transaction_commit()` would be broken into phases: first each of
> the stacked backends would be asked to verify that the transaction is
> possible and acquire any necessary locks, then each backend would get
> the final "commit" command.
> 
> This construct would make it easy for different backends to share the
> same implementation for HEAD (and potentially other workspace-local)
> references, by simply layering that one storage mechanism on top of
> their own.
> 
> That would probably be overengineering if it were only used to deal with
> HEAD, but I think it is a nice general mechanism that could have other
> applications.

Interesting concept.  I think the semantics could get rather
complicated, but maybe it's worth thinking about.

But for now, I think it would be better to special-case pseudorefs, with
the option to expand that to full layering later if we see a need.
