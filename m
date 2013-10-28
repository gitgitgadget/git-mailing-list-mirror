From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Mon, 28 Oct 2013 02:08:50 -0700
Message-ID: <xmqq1u35iwyl.fsf@gitster.dls.corp.google.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 10:09:02 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vaion-00010z-Gy
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 10:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711Ab3J1JIz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 05:08:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223Ab3J1JIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 05:08:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2624B84B;
	Mon, 28 Oct 2013 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NUOw3KQaA3XWOebu+8b00ZY1Mzc=; b=a0Wio9
	uCwZXm8HdVoJ69KpSuy3l1/4yTdEaWiTXyEbBUmp+Grvw3IugICNfFWVRG/JOLP7
	veqTF+8x+CcTH+0Cwx2cVyg1mepr+NIOaVRnVkwQoJINYcShebERCCaLJk5sZGVC
	J7HGwSWEQA+2J6AoimWvOYt88AMrHE9MxCSFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXTGffyG0glKP57YXv74Vrb7zUMzJDEa
	sKCnMNreO1X3eENvI/gGnOVrpkRgr8DUcC0tXus3c6pfr7R5ifH71VmZeLliHirV
	asrpK7xL2XoY4kDv31o5TJ7lOnKkGA1AMAVvgH0F8tSQpsywHaGbzp442TlDDsrj
	Uvj7JDjU768=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8FC4B846;
	Mon, 28 Oct 2013 09:08:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4761A4B828;
	Mon, 28 Oct 2013 09:08:52 +0000 (UTC)
In-Reply-To: <xmqqa9hui2lp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 27 Oct 2013 18:52:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 909539D0-3FB0-11E3-B2BF-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236823>

Junio C Hamano <gitster@pobox.com> writes:

> There are unbound number of kinds of trailers people would want to
> add, depending on their projects' needs.  We should not have to add
> a specific support for a tailer like this one, before thinking
> through to see if we can add generic support for adding arbitrary
> trailers to avoid code and interface bloat.
>
> Think of the existing --signoff as a historical mistake.  Such a
> generic "adding arbitrary trailers" support, when done properly,
> should be able to express what "--signoff" does, and we should be
> able to redo "--signoff" as a special case of that generic "adding
> arbitrary trailers" support, and at that point, "Fixes:" trailer the
> kernel project wants to use should fall out as a natural consequence.

Thinking aloud further, what I had in mind was along the lines of
the following.

 * The most generic external interface would be spelled as

    --trailer <token>[=<param>]

   where <token> can be things like "signoff", "closes", "acked-by",
   "change-id", "fixes", etc.; they can be taken from an unbounded
   set.  The historical "--signoff" can become a short-hand for
   "--trailer signoff".  More than one "--trailer" option can be
   given on a single command line.

 * The token is used to look into the configuration, e.g.,

   [commitTrailer "signoff"]
	style = append-norepeat
	trailer = Signed-off-by
        command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

   [commitTrailer "change-id"]
	style = append-only-if-missing
	trailer = Change-Id
        command = 'git hash-object -t commit --stdin <$GIT_PROTO_COMMIT'

   [commitTrailer "fixes"]
	style = overwrite
        trailer = Fixes
        command = 'git log -1 --oneline --format="%h (%s)" --abbrev-commit=14 $ARG'

   where

   - "commitTrailer.<token>.style" defines the interaction with
     existing trailer of the same kind (e.g. S-o-b: accumulates by
     appending, but we try not to repeat the same sign-off twice
     which would show you forwarding your own message you are the
     last person in the Sign-off chain; Fixes: if there is already
     one will remove the old one and replaces; etc.);

   - "commitTrailer.<token>.trailer" defines the trailer label at
     the beginning of the trailer line;

   - "commitTrailer.<token>.command" gives the command to run to
     obtain the payload after the "trailer" label.  A handful
     obvious and useful variables are exported for the command to
     use, and <param> is exported as $ARG, if present.

With the most generic syntax, with the above commitTrailer.fixes.*
configuration, I would imagine that you can say something like:

    git commit --trailer fixes="v2.6.12^{/^i386: tweak frobnitz}"

to say that the first commit you find traversing the history of
v2.6.12 whose title is "i386: tweak frobnitz" was faulty, and you
are creating a commit that corrects its mistake.

Giving some default configuration to often used trailer types
(e.g. configuration for "--trailer signoff") and promoting some
commonly used ones into a separate built-in option (e.g. an option
"--signoff" that does not have to say "--trailer signoff") are
entirely separate issues, and only time can nudge us into evaluating
individual types of trailers.
