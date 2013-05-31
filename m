From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read non-{tag,commit}
Date: Fri, 31 May 2013 10:08:06 +0200
Message-ID: <87sj138tcp.fsf@linux-k42r.v.cablecom.net>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
	<5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
	<20130530212223.GA2135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	"John Keeping" <john@keeping.me.uk>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 31 10:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKNp-0007Et-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3EaIIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:08:17 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:22659 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183Ab3EaIIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:08:09 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 31 May
 2013 10:08:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 31 May 2013 10:08:06 +0200
In-Reply-To: <20130530212223.GA2135@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 30 May 2013 17:22:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226073>

Jeff King <peff@peff.net> writes:

> On Thu, May 30, 2013 at 10:00:23PM +0200, Thomas Rast wrote:
>
>> lookup_commit_reference_gently unconditionally parses the object given
>> to it.  This slows down git-describe a lot if you have a repository
>> with large tagged blobs in it: parse_object() will read the entire
>> blob and verify that its sha1 matches, only to then throw it away.
>> 
>> Speed it up by checking the type with sha1_object_info() prior to
>> unpacking.
>
> This would speed up the case where we do not end up looking at the
> object at all, but it will slow down the (presumably common) case where
> we will in fact find a commit and end up parsing the object anyway.
>
> Have you measured the impact of this on normal operations? During a
> traversal, we spend a measurable amount of time looking up commits in
> packfiles, and this would presumably double it.

I don't think so, but admittedly I didn't measure it.

The reason why it's unlikely is that this is specific to
lookup_commit_reference_gently, which according to some grepping is
usually done on refs or values that refs might have; e.g. on the old&new
sides of a fetch in remote.c, or in many places in the callback of some
variant of for_each_ref.

Of course if you have a ridiculously large number of refs (and I gather
_you_ do), this will hurt somewhat in the usual case, but speed up the
case where there is a ref (usually a lightweight tag) directly pointing
at a large blob.

I'm not sure this can be fixed without the change you outline here:

> This is not the first time I have seen this tradeoff in git.  It would
> be nice if our object access was structured to do incremental
> examination of the objects (i.e., store the packfile index lookup or
> partial unpack of a loose object header, and then use that to complete
> the next step of actually getting the contents).

But in any case I see the point, I should try and gather some
performance numbers.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
