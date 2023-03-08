Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB32C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCHUeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCHUeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:34:13 -0500
Received: from mta01.prd.rdg.aluminati.org (mta01.prd.rdg.aluminati.org [94.76.243.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BD61537
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:33:57 -0800 (PST)
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta.aluminati.local (Postfix) with ESMTP id 97E6FC0048;
        Wed,  8 Mar 2023 20:33:55 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 8CF632035B;
        Wed,  8 Mar 2023 20:33:55 +0000 (GMT)
X-Quarantine-ID: <sZkARWeu4DUS>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sZkARWeu4DUS; Wed,  8 Mar 2023 20:33:54 +0000 (GMT)
Received: from keeping.me.uk (unknown [81.174.171.191])
        by svc01-1.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 7B53E1C0002;
        Wed,  8 Mar 2023 20:33:53 +0000 (GMT)
Date:   Wed, 8 Mar 2023 20:33:51 +0000
From:   John Keeping <john@keeping.me.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: output header for empty commits
Message-ID: <ZAjxL2MIXCNZgYj/@keeping.me.uk>
References: <20230303160301.3659328-1-john@keeping.me.uk>
 <xmqqwn3xg3m0.fsf@gitster.g>
 <ZAMhOehmuIov/KM8@keeping.me.uk>
 <xmqqlek9byeb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlek9byeb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 09:08:44AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Fri, Mar 03, 2023 at 09:13:27AM -0800, Junio C Hamano wrote:
> >> John Keeping <john@keeping.me.uk> writes:
> >> 
> >> > When formatting an empty commit, it is surprising that a totally empty
> >> > file is generated.  Set the flag to always print the header, matching
> >> > the behaviour of git-log.
> >> 
> >> Don't these empty files help send-email as safety against sending
> >> them out?  Unless existing tools depend on the current behaviour in
> >> such a way, I think this is quite a sensible change.
> >
> > Yes, send-email fails trying to send an empty file, but to me this feels
> > more like an accident than an intentional safeguard.  If there were
> > something intentional I'd expect format-patch to fail with --allow-empty
> > as an option to bypass that safety check.
> >
> > Since there are checks in place to avoid unintentionally creating empty
> > commits,...
> 
> Speaking as the original implementer of format-patch, the original
> intention was to forbid such a message to be sent out.  But it was
> designed back in the days when an empty commit were not used as "a
> marker in the history" as widely as these days.  IOW, the original
> intention does not matter all that much when we have to determine if
> the code with the proposed change would negatively affect _today's_
> users.  What the users would see is that they have been protected
> from sending out such a message by mistake (an empty commit may not
> be something you created but you pulled from your colleages), but
> with this change the protection is no longer there.
> 
> Another worry is if the receiving end is prepared to see such a
> "patch".
> 
> Overall, if we were designing format-patch/send-email/am today with
> today's use cases in mind without any existing users of these three
> commands, I think these three would be designed to pass an empty
> commit through the chain unconditionally.  But we do not live in
> such a world, so perhaps some sort of opting in may be appropriate.

Does that mean you want to see format-patch die on empty commits unless
--allow-empty is specified?

I think it's in a slightly strange place because it's both a "creation"
command and an "inspection" command.  Elsewhere the creation commands
(like commit or cherry-pick) require --allow-empty but inspection
commands (like log or show) always show all commits.

My mental model groups format-patch in the inspection commands and I
wouldn't send anything out without inspecting the patch files first (but
then I get caught out by this empty commit behaviour when I use
format-patch for non-email use and grep doesn't find something I'm sure
should be there in an empty commit's message!).
