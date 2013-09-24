From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 08:54:19 +0300
Message-ID: <20130924055419.GA11208@redhat.com>
References: <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLXh-0005eJ-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab3IXFwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:52:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3IXFwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:52:08 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8O5q2fI028173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 01:52:03 -0400
Received: from redhat.com (vpn1-6-85.ams2.redhat.com [10.36.6.85])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8O5q0qE013400;
	Tue, 24 Sep 2013 01:52:01 -0400
Content-Disposition: inline
In-Reply-To: <20130923213729.GE9464@google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235270>

On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Michael S. Tsirkin wrote:
> >> On Tue, Sep 17, 2013 at 04:56:16PM -0400, Jeff King wrote:
> 
> >>>>> A problem with both schemes, though, is that they are not
> >>>>> backwards-compatible with existing git-patch-id implementations.
> [...]
> >>> It may be esoteric enough not to worry about, though.
> 
> Yeah, I think it would be okay.  Details of the diff generation
> algorithm have changed from time to time anyway (and broken things,
> as you mentioned) and we make no guarantee about this.
> 
> [...]
> >> patch-id: make it more stable
> >>
> >> Add a new patch-id algorithm making it stable against
> >> hunk reodering:
> >> 	- prepend header to each hunk (if not there)
> >> 	- calculate SHA1 hash for each hunk separately
> >> 	- sum all hashes to get patch id
> >>
> >> Add --order-sensitive to get historical unstable behaviour.
> 
> The --order-sensitive option seems confusing.  How do I use it to
> replicate a historical patch-id?

You supply a historical diff to it :)

> If I record all options that might
> have influenced ordering (which are those?) then am I guaranteed to
> get a reproducible result?  

Maybe not. But if you have a patch on disk, you will get
old hash from it with --order-sensitive.

> So I would prefer either of the following over the above:
> 
>  a) When asked to compute the patch-id of a seekable file, use the
>     current streaming implementation until you notice a filename that
>     is out of order.  Then start over with sorted hunks (for example
>     building a table of offsets within the patch for each hunk to
>     support this).
> 
>     When asked to compute the patch-id of an unseekable file, stream
>     to a temporary file under $GIT_DIR to get a seekable file.

This can be computed in one pass: just keep two checksums around.

But the result won't be stable: if you get same patch from two
people one is ordered, the other isn't, you get two different checksums.

What are we trying to achieve here?


>  b) Unconditionally use the new patch-id definition that is stable
>     under permutation of hunks.  If and when someone complains that
>     this invalidates their old patch-ids, they can work on adding a
>     nice interface for getting the old-style patch-ids.  I suspect it
>     just wouldn't come up.

That's certainly easy to implement.

> Of course I can easily be wrong.  Thanks for a clear patch that makes
> the choices easy to reasonable about.
> 
> Thoughts?
> Jonathan
