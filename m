From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read
 non-{tag,commit}
Date: Fri, 31 May 2013 12:00:20 -0400
Message-ID: <20130531160020.GA1365@sigill.intra.peff.net>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
 <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
 <20130530212223.GA2135@sigill.intra.peff.net>
 <87sj138tcp.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 31 18:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiRki-0006gr-DU
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 18:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab3EaQAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 12:00:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:59417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab3EaQAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 12:00:23 -0400
Received: (qmail 16176 invoked by uid 102); 31 May 2013 16:01:05 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 31 May 2013 11:01:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 May 2013 12:00:20 -0400
Content-Disposition: inline
In-Reply-To: <87sj138tcp.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226094>

On Fri, May 31, 2013 at 10:08:06AM +0200, Thomas Rast wrote:

> > Have you measured the impact of this on normal operations? During a
> > traversal, we spend a measurable amount of time looking up commits in
> > packfiles, and this would presumably double it.
> 
> I don't think so, but admittedly I didn't measure it.
> 
> The reason why it's unlikely is that this is specific to
> lookup_commit_reference_gently, which according to some grepping is
> usually done on refs or values that refs might have; e.g. on the old&new
> sides of a fetch in remote.c, or in many places in the callback of some
> variant of for_each_ref.

Yeah, I saw that the "_gently" form backs some of the other forms
(non-gently, lookup_commit_or_die) and was worried that we would use it
as part of the revision traversal to find parents. But we don't, of
course; we use lookup_commit, because we would not accept a parent that
is a tag pointing to a commit.

So I think it probably won't matter in any sane case.

> Of course if you have a ridiculously large number of refs (and I gather
> _you_ do), this will hurt somewhat in the usual case, but speed up the
> case where there is a ref (usually a lightweight tag) directly pointing
> at a large blob.

In my large-ref cases, there are often a lot of duplicate refs anyway
(e.g., many forks of a project having the same tags). So usually the
right thing there is to use lookup_object to see if we have the object
already anyway. parse_object has this optimization, but we can add it
into sha1_object_info, too, if it turns out to be a problem.

-Peff
