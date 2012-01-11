From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Wed, 11 Jan 2012 03:52:36 -0600
Message-ID: <20120111095236.GB31670@burratino>
References: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino>
 <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
 <20120111054954.GB13507@burratino>
 <CALkWK0=o+KkV08G9JuTaG8Vtb-AzHQVMQPzMy8td_iBVnGX4Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 10:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkumY-0001dX-SG
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 10:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab2AKJrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 04:47:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41473 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2AKJrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 04:47:40 -0500
Received: by iabz25 with SMTP id z25so870675iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=em8ic3JQ+oDoGZf8IzzM0z9k5zw8Cge9AWD1gGCzAFw=;
        b=uzBYFBSapeuzB6eJFrK3ePJbOw8gK52osO4hNT470b8HFbMKioM8222T2MfaUdKPSv
         LGqRomko4JJk0gdHaUnoDyp9ylZKLLO/ycXgtbnpvqxtQSi9Uf9s2BkDCZHsetJ3nhm+
         a42HLU2e0zpUTrjvo8fUKadJ+TwUmX4Nw2toI=
Received: by 10.42.151.195 with SMTP id f3mr25334994icw.19.1326275259779;
        Wed, 11 Jan 2012 01:47:39 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x18sm3506449ibi.2.2012.01.11.01.47.38
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 01:47:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=o+KkV08G9JuTaG8Vtb-AzHQVMQPzMy8td_iBVnGX4Dg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188349>

Ramkumar Ramachandra wrote:

>                                                              how does
> the sequencer know what to do with this hypothetical command string
> (say "cherry-pick") on a fresh invocation?  It needs to translate this
> into a replay_action at some point, right?  There are atleast three
> places where this happens: prepare_revs(), walk_revs_populate_todo(),
> and single_pick().

I see.

Perhaps cherry-pick and revert should be different values for
replay_subcommand, to avoid conflating the mechanics and the command
name?  Resulting in something like this:

	enum replay_subcommand {
		REPLAY_PICK_REVISIONS,
		REPLAY_REVERT_REVISIONS,
		REPLAY_EDIT_SEQUENCE,
		REPLAY_REMOVE_STATE,
		REPLAY_CONTINUE,
		REPLAY_SKIP,
		REPLAY_ROLLBACK
	};

Though this dispatcher on an enum to perform many different actions
already felt a bit awkward, so an alternative could be

	extern int pick_revisions(struct replay_opts *opts);
	extern int revert_revisions(struct replay_opts *opts);

	extern int launch_sequence_editor(struct replay_opts *opts);
	extern void remove_sequencer_state(void);
	extern int sequencer_continue(struct replay_opts *opts);
	extern int sequencer_skip(struct replay_opts *opts);
	extern int sequencer_rollback(struct replay_opts *opts);

which would make it easier to add arguments specific to any one of the
routines as appropriate.
