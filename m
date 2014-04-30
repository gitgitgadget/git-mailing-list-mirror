From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 10:55:27 -0700
Message-ID: <xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfYjI-0004f3-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933685AbaD3Rzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 13:55:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbaD3Rzc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 13:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2197D25C;
	Wed, 30 Apr 2014 13:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iF5mdrcEsG9yN+oUjtXMkZKURgM=; b=QSaYHT
	npoDFZVcerIWvnyaHwVZLaNWTh1aYQje9sdmAhQiBiNOsBzCiGP8lkXcCulPQ6Mu
	mG74rletjiRrniXUuQtTLjtTaJbM8WboEURkzLTfP0ijMZWiR3dc0Cl7K4ysR94r
	mRKeV+231XWVeVp4+f+5Dn1iGzWz5WLLQ07Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=byHF4XahPeR8jHNPCpHw47i0Y+fk85hc
	N9/zFX3K95F6quMC147jQRGrbOV9Cdvqn9xCBl0oGLfbOtVw+Cox20MDO4YND4Cp
	URmqu8Zs3dIFSHiFRbN6qQgi3jQkzCTsPBt9c3X69lBoaQ5N6bZ5YzyRXrhVh6Gp
	9cm0jPfcaK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1767D25A;
	Wed, 30 Apr 2014 13:55:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBB4C7D253;
	Wed, 30 Apr 2014 13:55:28 -0400 (EDT)
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 29 Apr 2014 06:17:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D9ED96C-D090-11E3-BF3A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247749>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These are the steps needed to achieve this:

The overall progression (this comment is only about the design, not
the implementation) looks almost sensible, but I may have missed
some issues because the presentation was done in reverse.

In the following comment, I'll flip the presentation order to better
show natural progression of what the users will see.

> 1) Rename pull.rename to pull.mode and
>    branch.<name>.rebase to branch.<name>.pullmode
>
> This way the configurations and options remain consistent:
>
>   git pull --merge
>   pull.mode = merge
>   branch.<name>.pullmode = merge
>
>   git pull --rebase
>   pull.mode = rebase
>   branch.<name>.pullmode = rebase
>
>   git pull --rebase=preserve
>   pull.mode = rebase-preserve
>   branch.<name>.pullmode = rebase-preserve
>
>   git pull
>   pull.mode = merge-ff-only
>   branch.<name>.pullmode = merge-ff-only

Until the "--merge" option is added, "pull.mode = merge" cannot be
the same as "git pull --merge".  I think you either need to squash
these two steps into one, or flip the order of them.

> 2) Add --merge option
>
> Since we have a message that says "If unsure, run 'git pull --merge'", which is
> more friendly than 'git pull --no-rebase', we should add this option, and
> deprecate --no-rebase.

Obviously s/have a/will have a/, but the intention is good.

> However, the documentation would become confusing if --merge is configured in
> pull.rebase, instead, we want something like this:
>
>   See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
>   to make `git pull` always use `--merge`.

It gets unclear to me how the transition is planned around here.  Is
this a correct paraphrasing of these four steps?

    - Add pull.mode (and its branch-specific friend) and "pull
      --merge" so that people can set the former to "merge" or train
      their fingers to type the latter to keep doing the
      fetch-and-merge (your steps 1 and 2)

    - Add ff-only to pull.mode (your step 3)

    - With the endgame of "out of box Git without any configuration
      refuses 'git pull' (without --merge/--rebase) that does not
      fast forward" in mind, start warning "In the future you will
      have to either set pull.mode (and/or its friends) or type
      "pull --merge" (or "pull --rebase") when the endgame version
      of 'git pull' would fail with the error message, but still do
      as was asked to do as before.  At this step, existing users
      can set pull.mode to "merge" or "rebase" or whatever to
      squelch the warning.

    - Flip the default.  By the time this happens, thanks to the
      previous step to warn beforehand, nobody needs to see the
      warning. (your step 4)

If that is the rough outline, I think it is sensible.

> 3) Add merge-ff-only config
>
> This option would trigger a check inside `git pull` itself, and error out with
> the aforementioned message if it's not possible to do a fast-forward merge.
>
> However, this option conflicts with --rebase, and --no-rebase. Solution below.

Am I reading you correctly that setting "pull.mode = ff-only" will
require you to explicitly say "git pull --merge/--rebase"?  If that
is the case, I think the step makes sense.

> 4) Only allow fast-forward merges by default
>
> We could pass --ff-only to `git merge`, however, if we do that we'll get an error like this:
>
>   Not possible to fast-forward, aborting.
>
> This is not friendly; we want an error that is user-friendly:
>
>   The pull was not fast-forward, please either merge or rebase.
>   If unsure, run 'git pull --merge'.
>
> When we do this we want to give the users the option to go back to the previous
> behavior, so a new configuration is needed.
