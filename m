From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Tue, 17 Mar 2015 01:48:00 -0400
Message-ID: <20150317054759.GA16860@peff.net>
References: <20150316142026.GJ7847@inner.h.apk.li>
 <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
 <20150316184040.GA8902@inner.h.apk.li>
 <20150317024005.GA26313@peff.net>
 <xmqqd248p4o9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 06:48:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXkMK-0004ST-92
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 06:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbbCQFsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 01:48:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:33883 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751451AbbCQFsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 01:48:03 -0400
Received: (qmail 21164 invoked by uid 102); 17 Mar 2015 05:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 00:48:03 -0500
Received: (qmail 22331 invoked by uid 107); 17 Mar 2015 05:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 01:48:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 01:48:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd248p4o9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265609>

On Mon, Mar 16, 2015 at 10:35:18PM -0700, Junio C Hamano wrote:

> > It looks like we don't even really care about the value of HEAD. We just
> > want to know "is it a git directory?". I think in other places (like
> > "git add"), we just do an existence check for "$dir/.git". That would
> > not catch a bare repository, but I do not think the current check does
> > either (it is looking for submodules, which always have a .git).
> 
> If we wanted to be consistent, perhaps we should be reusing the "is
> this a git repository?" check used by the auto-discovery codepath
> (setup.c:is_git_directory(), perhaps?), but the idea looks simple
> enough and sounds sensible.

Yeah, I almost suggested that, but I'm concerned that would make us
inconsistent with how we report untracked files. I thought that dir.c
used ".git" as a magic token there.

But it seems I'm wrong. We do ignore ".git" directly in treat_path(),
but treat_directory actually checks resolve_gitlink_ref. I think this
will suffer the same problem as Andreas's original issue (e.g., if you
run "git ls-files -o").

Likewise, I think dir.c:remove_dir_recurse is in a similar boat.
Grepping for resolve_gitlink_ref, it looks like there may be others,
too.

All of these should be using the same test, I think. Doing that with
is_git_directory() is probably OK. It is a little more expensive than we
might want for mass-use (it actually opens and parses the HEAD file in
each directory), but it quits early when we _don't_ see a git directory,
which would be the common case here.

-Peff
