From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3] Add git-grep threads param
Date: Tue, 27 Oct 2015 11:52:56 +0000
Message-ID: <20151027115256.GQ19802@serenity.lan>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
 <20151026193241.GO19802@serenity.lan>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FC@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 12:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr2oW-0002Ht-EI
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 12:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbbJ0LxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 07:53:12 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53495 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbbJ0LxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 07:53:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6168986601E;
	Tue, 27 Oct 2015 11:53:11 +0000 (GMT)
X-Quarantine-ID: <6+g6Td+XoWOQ>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6+g6Td+XoWOQ; Tue, 27 Oct 2015 11:53:10 +0000 (GMT)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 536C7CDA638;
	Tue, 27 Oct 2015 11:52:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FC@mail.accesssoftek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280261>

On Mon, Oct 26, 2015 at 10:25:41PM -0700, Victor Leschuk wrote:
> >> @@ -22,6 +22,7 @@ SYNOPSIS
> >>          [--color[=<when>] | --no-color]
> >>          [--break] [--heading] [-p | --show-function]
> >>          [-A <post-context>] [-B <pre-context>] [-C <context>]
> >> +        [--threads <num>]
> 
> > Is this the best place for this option?  I know the current list isn't
> > sorted in any particular way, but here you're splitting up the set of
> > context options (`-A`, `-B`, `-C` and `-W`).
> 
> Agree, I'll move the option both here and in documentation.
> 
> >> -static int wait_all(void)
> >> +static int wait_all(struct grep_opt *opt)
> 
> > I'm not sure passing a grep_opt in here is the cleanest way to do this.
> > Options are a UI concept and all we care about here is the number of
> > threads.
> 
> > Since `threads` is a global, shouldn't the number of threads be a global
> > as well?  Could we reuse `use_threads` here (possibly renaming it
> > `num_threads`)?
> 
> This thought also crossed my mind, however we already pass grep_opt to
> start_threads() function, so I think passing it to wait_all() is not
> that ugly, and kind of symmetric. And I do not like the idea of
> duplicating same information in different places. What do you think?

The grep_opt in start_threads() is being passed through to run(), so it
seems slightly different to me.  If the threads were being setup in
grep.c (as opposed to builtin/grep.c) then I'd agree that it belongs in
grep_opt, but since this is local to this particular user of the grep
infrastructure adding num_threads to the grep_opt structure at all feels
wrong to me.

Note that I wasn't suggesting passing num_threads as a parameter to
wait_all(), but rather having it as global state that is accessed by
wait_all() in the same way as the `threads` array.

If we rename use_threads to num_threads and just use that, then we only
have the information in one place don't we?
