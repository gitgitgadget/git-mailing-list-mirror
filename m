From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 4 Apr 2013 19:35:16 -0700
Message-ID: <20130405023516.GA32290@leaf>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
 <7v6202jjhx.fsf@alter.siamese.dyndns.org>
 <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNwVN-0008KH-UU
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819Ab3DECfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 22:35:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42615 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964816Ab3DECfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 22:35:24 -0400
Received: from mfilter3-d.gandi.net (mfilter3-d.gandi.net [217.70.178.133])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 78080A80BF;
	Fri,  5 Apr 2013 04:35:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter3-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter3-d.gandi.net (mfilter3-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id rJno5B9wCN4m; Fri,  5 Apr 2013 04:35:21 +0200 (CEST)
X-Originating-IP: 50.43.39.152
Received: from leaf (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 13C7EA80B8;
	Fri,  5 Apr 2013 04:35:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220133>

On Thu, Apr 04, 2013 at 06:22:08PM -0700, John Koleszar wrote:
> On Thu, Apr 4, 2013 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > John Koleszar <jkoleszar@google.com> writes:
> >
> >> @@ -402,7 +404,8 @@ static void get_info_refs(char *arg)
> >>
> >>       } else {
> >>               select_getanyfile();
> >> -             for_each_ref(show_text_ref, &buf);
> >> +             head_ref_namespaced(show_text_ref, &buf);
> >> +             for_each_namespaced_ref(show_text_ref, &buf);
> >>               send_strbuf("text/plain", &buf);
> >>       }
> >
> > Whether we are namespaced or not, we used to do for_each_ref() here,
> > not advertising the HEAD (outside refs/ hierarchy), but we now do,
> > and as the first element in the output.
> >
> > Am I reading the patch correctly?
> >
> > Is that an unrelated but useful bugfix even for people who do not
> > use server namespaces?
> >
> 
> Actually, I think this line may be buggy. Hold off submitting if you
> haven't already.
> 
> Including the HEAD ref in the advertisement from /info/refs ends up
> duplicating it, since the dumb client unconditionally fetches the file
> /HEAD to use as the that ref. I think the right thing to do is
> generate the correct /HEAD using head_ref_namespaced(), rather than
> returning the bare file $GIT_DIR/HEAD, but I'm not 100% sure how HEAD
> and namespaces interact, since I haven't been able to produce a repo
> with a different HEAD in a namespace. Can you verify this approach?

Semantically, every namespace should act like a completely independent
repository, which includes having its own independent HEAD.  A namespace
should *not* see the HEAD of the entire repository, only its own
namespaced HEAD.

Namespaces exist so that you can make a pile of repos share the same
object store while acting as independent repositories.  As long as you
never expose the un-namespaced repository, a client should not be able
to tell whether you use namespaces.

- Josh Triplett
