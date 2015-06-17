From: josh@joshtriplett.org
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 15:28:28 -0700
Message-ID: <20150617222828.GB24438@cloud>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617205931.GB24079@cloud>
 <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:28:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Lp1-000569-KK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbbFQW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:28:34 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47455 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933008AbbFQW2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:28:31 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 97CFEA80B1;
	Thu, 18 Jun 2015 00:28:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271924>

On Wed, Jun 17, 2015 at 02:51:18PM -0700, Junio C Hamano wrote:
> josh@joshtriplett.org writes:
> 
> > Having more than one author field in a commit would likely break things,
> > but having a coauthor field seems plausible these days.  Git added
> > support for signed commits, and the world didn't end, so it's possible
> > to extend the commit format.
> 
> Something being possible and something being sensible are two
> different things, though.
> 
> I agree "coauthor field that is not understood by anybody" would
> unlikely break existing implementations, but it is not a useful way
> to add this information to commit objects.  For one thing, until you
> teach "git log" or its equivalents in everybody's (re)implementation
> of Git, the field will not be shown, you cannot easily edit it while
> amending or rebasing, "git log --grep=" would not know about it, and
> you would need "git cat-file commit" to view it.
> 
> A footer Co-authored-by: does not have any such issue.

Sure it does; while it would display in raw form because it's a part of
the commit message, you'd still have to teach "git log --author" about
it (git grep is not a substitute), map it through mailmap, teach git
shortlog about it, teach send-email and format-patch to use it in mail
headers, teach repository statistics tools about it, and in general
teach every tool that reads the "author" field of a commit to handle
co-authors.  And if it's a pseudo-field in the commit, you'd also have
to have more complex parsing rules to find and parse it.

Git has almost no understanding of in-band magic "headers" in a commit
message.  It has a bit of support for generating (but not parsing)
Signed-off-by, and send-email has some support for adding *-by headers
to Cc, but a pseudo-header that git tools actually *parse* out of the
commit message would be a first.

> We left commit headers extensible long before we introduced commit
> signing, and we used it to add the "encoding" header.  In general,
> we invent new headers only when structurely necessary.  When you
> declare that the log message for this indiviaul commit is done in
> one encoding, that is not something you would want to _edit_ with
> your editor while you are editing your message.  Similarly you would
> not want to risk touching the GPG signature of a signed commit or a
> signed merge while editing your message.
> 
> The _only_ reason I would imagine why somebody may be tempted to
> think that "coauthor" as part of the object header makes sense is
> because "author" is already there.  You can argue that "author" did
> not have to be part of the object header, and that is right.  I
> would agree with you 100% that "author" did not have to be there.

Author and committer are used by many git tools; if they weren't part of
the object header, they'd need to be part of some pseudo-header with a
standardized format that git can parse.

- Josh Triplett
