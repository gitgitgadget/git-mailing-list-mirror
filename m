From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/3] patch-id: make it stable against hunk reordering
Date: Mon, 31 Mar 2014 22:04:44 +0300
Message-ID: <20140331190444.GA12208@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
 <xmqqk3ba6yg9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhVr-0004e4-9I
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbaCaTEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22507 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbaCaTEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:04:36 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2VJ4L2U003064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 31 Mar 2014 15:04:22 -0400
Received: from redhat.com (vpn1-7-154.ams2.redhat.com [10.36.7.154])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2VJ4J9d032255;
	Mon, 31 Mar 2014 15:04:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3ba6yg9.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245511>

On Mon, Mar 31, 2014 at 10:59:50AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Patch id changes if users
> > 1. reorder file diffs that make up a patch
> > or
> > 2. split a patch up to multiple diffs that touch the same path
> > (keeping hunks within a single diff ordered to make patch valid).
> >
> > As the result is functionally equivalent, a different patch id is
> > surprising to many users.
> > In particular, reordering files using diff -O is helpful to make patches
> > more readable (e.g. API header diff before implementation diff).
> >
> > Change patch-id behaviour making it stable against these two kinds
> > of patch change:
> > 1. calculate SHA1 hash for each hunk separately and sum all hashes
> > (using a symmetrical sum) to get patch id
> > 2. hash the file-level headers together with each hunk (not just the
> > first hunk)
> >
> > We use a 20byte sum and not xor - since xor would give 0 output
> > for patches that have two identical diffs, which isn't all that
> > unlikely (e.g. append the same line in two places).
> >
> > Add a new flag --unstable to get the historical behaviour.
> >
> > Add --stable which is a nop, for symmetry.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > changes from v2:
> > 	several bugfixes
> > changes from v1:
> > 	hanges from v1: documented motivation for supporting
> > 	diff splitting (and not just file reordering).
> > 	No code changes.
> >
> >  builtin/patch-id.c | 72 ++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 56 insertions(+), 16 deletions(-)
> 
> Does this have to interact or be consistent with patch-ids.c which
> is the real patch-id machinery used to filter like-changes out by
> "cherry-pick" and "log --cherry-pick"?

I don't know off-hand.

Specifically, this is diff_flush_patch_id and in diff.c, isn't it?

> This series opens a very interesting opportunity by making it
> possible to introduce the equivalence between two patches that touch
> the same file and a single patch that concatenates hunks from these
> two patches.
> 
> One example I am wondering about is perhaps this could be used to
> detect two branches, both sides with many patches cherry-picked from
> the same source, but some patches squashed together on one branch
> but not on the other.  It would be very nice if you can detect that
> two sets of patches are equivalent taken as a whole in such a
> situation while rebasing one on top of the other.
> 
> Another example is that another mode that gives a set of broken-up
> patch-ids for each hunk contained in the input.  Suppose there is a
> patch that is only meant to be used on the proprietary fork of an
> open source project, and the project releases the open source
> portion by cherry-picking topics from the development tree used for
> the proprietary "trunk".  The integration service of such a project
> used to prepare the open source branch may want to have a
> pre-receive hook that says "do not merge any commit to cause this
> this hunk appear in the result, no matter what other changes the
> patches in the commit may bring in", and broken-down patch-ids
> (e.g. "diff HEAD...$commit | patch-id --individual") may be an
> ingredient to implement such a hook.  There may be interesting
> applications other than such a "broken-down patch-ids" that can be
> based on the enhancement you are presenting here.

OK sure, I can tweak that to use the same algorithm if desired,
though it does look like an unrelated enhancement to me.
Agree?
