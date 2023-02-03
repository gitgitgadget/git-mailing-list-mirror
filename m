Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA5C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 15:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBCPsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCPsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 10:48:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001214E8C
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 07:48:10 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 313Flj4Q002866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 10:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675439269; bh=eTo9rPwm7F0YB4uFlpTcyhIj7TbHhtZyeIr2XHP7GXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VYZ1MrtFaa8zMdKlPrE4t2Y1SVtmU5WOkQTLZk2WU9xMSmHCeNeKqZhdqEOF5d47G
         S/6dhiwxUDuEP4q5r0xJKKuvT5Fcwx40jNr1f83NWhAk+y36yTiuhAjTfKvcEk74cw
         VNKl/R7nrzuC5tlGxwpXNxM0rX/nFDMXa0IDnqzhX3FqoJeIsp50tjKzwK0rGOrm2f
         pnYwAP4QuW02NkRrkZzVJcnZMnK7KQMZG1p0nP3h8iB0OTIOr3PlAUqdSu59i1S4+M
         uuiQ5UglqRNimEg4FlCgfK+6WU/46546bcKQf33c9QFWz72PJZMnWbJjBPyChN0JqP
         tpqMiMP9Jca2g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E0CD315C340F; Fri,  3 Feb 2023 10:47:44 -0500 (EST)
Date:   Fri, 3 Feb 2023 10:47:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     phillip.wood@dunelm.org.uk
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
Message-ID: <Y90soPW6KRB7PQCY@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 04:17:09PM +0000, Phillip Wood wrote:
> Playing devil's advocate for a moment as we're not going to promise that the
> compressed output of "git archive" will be stable in the future perhaps we
> should use this breakage as an opportunity to highlight that to users and to
> advertize the config setting that allows them to use gzip for compressing
> archives. Reverting the change gives the misleading impression that we're
> making a commitment to keeping the output stable. The focus of this thread
> seems to be the problems relating to github which they have already
> addressed.
> 
> I think there is general agreement that it is not practical to promise that
> the compressed output of "git archive" is stable so maybe it is better to
> make that clear now while users can work around it in the short term with a
> config setting rather than waiting until we're faced with some security or
> other issue that forces a change to the output which users cannot work
> around so easily.

I would be in favor of adding a config option that allows using the
internal gzip option, although leave the default to be keep things
compatible.

The reason for that it should be easy for a forge provider such as
GitHub to break things, deliberately.  Sound insane?  Hear me out.

At $WORK, we have a highly reliable system, Paxos.  It is a highly
fault-tolerant system, so it rarely fails.  But "rarely fails" is not
the same as "never fails".  And hopefully, things should degrade
gracefully if there is a Paxos outage.  But as the Google SRE's are
fond of saying, "Hope is not a strategy".

So periodically, the people who run the Paxos service will
deliberately force downtime for a short amount of time.  The fact that
they will do this is well advertised, and scheduled ahead of time ---
and teams responsible for user-facing services are supposed to make
sure that end-users don't notice when this happens.  Maybe they won't
be able to update configurations as easily while Paxos is down, but it
shouldn't cause a user-visible outage.

So what I would recommend to the GitHub product manager, is that once
a quarter, on a well-advertised date, that they flip the switch and
break the git archive checksums for say, an hour.  Then next quarter,
they advertise that the switch will be thrown for 2 hours, doubling
each time, until it is ramped up to 16 hours.

This will provide the necessary nudge so that all of these badly
designed systems that depend on downloaded archives of arbitrary git
hubs to be stable will rethink their position, while minimizing the
end-user customer impact.  Otherwise, I predict that Bazel, homebrew,
etc will consider to rely on this ill-considered assumption, and at
some point in the future, when we *do* have a much better reason to
want to make a change to the tar or compression algorithm, all of
these end users will once again scream bloody murder.

Of course, this is going to be up to each forge provider to decide
whether they want to do this.  But we can make it easy for them to do
this thing, and I'd argue it is in our interest to make it easy for
them to do this.  Otherwise we'll get constrained in the future by the
fear of massive user blowback, no metter what we say in our
documentation regarding "no promises --- and next time, we really
mean it!"

	      	       	       	    	  - Ted
