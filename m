From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 04:22:05 +0530
Message-ID: <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr> <7vmwsqns4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPbP-000674-Le
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab3DVWwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:52:47 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:33178 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3DVWwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:52:46 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so5772311iay.29
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5UjTYSCnW7kYiAG7tzdsm98C1wIEpkUUuUCmI61z+bE=;
        b=YjPrv7RA09wB9wgHCQCDIhMFApiMs5omnkBcLsDZOVoK/vUNSQvDY+nO7n0QnxIQVs
         /uVQ+ULq+lhpcawFirCM5ZJSALE/hL8U9FixdEpNDVidU7iIM4ahB7E07Y8sEart78Ch
         7nEXnjk1E6JT+W7sTcfKApiz4WGHE39WWHFg+rUXkBG3vGbinAbsLKU4J2J1Y1mqcIrC
         xsZGfxOgoG1oOH8YdPXo6QogD2bJ1FNfL9PdahOmZI9r0O3/Uho4heKvotaeYLokbcFk
         4H/VyQcmfQOtwrLtFEvOMYi+g2juAlIu9+HS58Rqz6UeOJvSth3F3kDz+QBkJN62yjmB
         yTgA==
X-Received: by 10.50.17.166 with SMTP id p6mr9285936igd.12.1366671165702; Mon,
 22 Apr 2013 15:52:45 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 15:52:05 -0700 (PDT)
In-Reply-To: <7vmwsqns4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222126>

Junio C Hamano wrote:
> I have forgotten about this topic (and its numerous iterations in
> the past), but it appears me that people mostly lost interest after
> v7 review cycle where the series looked like a solution that is
> looking for a problem.

I agree.  Over-generalizing the problem is going nowhere.  I have some
ideas in my head, but I think I'm at the brink of insanity again:

We have a special type of merge commit that has 'bind' lines
corresponding to the trees of the commits we just merged in: each line
references a tree and a prefix.  Then, a diff between the merge's tree
and one of these trees can easily tell us what changes were introduced
by each side.  And here's the bomb: if we consider extending it to
include a blob-like buffer, we can use it to store submodule-like
information for each prefix.  Everything would just work out of the
box with a few minor adjustments:

1. We have to modify our packing algorithm to not reach out beyond ^1
of these special merge commits.  This means object-store isolation
(not $GITDIR isolation).  And it means that submodules can be cloned
and removed at will.

2. We have to maintain a symbolic ref for each prefix.  A commit
invoked from a special-commit referenced subdirectory will update this
symref.  Ofcourse, this means that we need to namespace our refs/ and
refs/remotes sensibly.

3. Git commands will take into account $CWD very strongly, and just
DTRT all the time.  Whether you're looking from the submodule
perspective or the superproject perspective.

Am I making any sense?
