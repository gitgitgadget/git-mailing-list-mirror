From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 4/9] patch-id: make it stable against hunk reordering
Date: Fri, 25 Apr 2014 00:32:38 +0300
Message-ID: <20140424213238.GB9129@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-4-git-send-email-mst@redhat.com>
 <20140424173043.GJ15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 23:32:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRFe-0004HQ-3o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 23:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbaDXVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 17:32:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61760 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbaDXVcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 17:32:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OLVt5q031597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2014 17:31:55 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3OLVqG1024893;
	Thu, 24 Apr 2014 17:31:53 -0400
Content-Disposition: inline
In-Reply-To: <20140424173043.GJ15516@google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247009>

On Thu, Apr 24, 2014 at 10:30:44AM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Michael S. Tsirkin wrote:
> 
> > Patch id changes if users
> > 1. reorder file diffs that make up a patch
> > or
> > 2. split a patch up to multiple diffs that touch the same path
> > (keeping hunks within a single diff ordered to make patch valid).
> >
> > As the result is functionally equivalent, a different patch id is
> > surprising to many users.
> 
> Hm.
> 
> If the goal is that functionally equivalent patches are guaranteed to
> produce the same patch-id, I wonder if we should be doing something
> like the following:
> 
>  1. apply the patch in memory
>  2. generate a new diff
>  3. use that new diff to produce a patch-id
> 
> Otherwise issues like --diff-algorithm=patience versus =myers will
> create trouble too.  I don't think that avoiding false negatives for
> patch comparison without doing something like that is really possible.
> 
> On the other hand if someone reorders file diffs within a patch, that
> is a potentially very common thing to do and something worth fixing.
> In other words, while your (1) makes perfect sense to me, case (2)
> seems less convincing.

I agree it's less convincing: one would have to edit patch
by hand (which I used to sometimes do to make important parts more prominent,
but stopped doing in favor of splitting a patch).
I'm not 100% sure whether it's worth supporting or not.


> The downside of allowing reordering hunks is that it can potentially
> make different patches to be treated the same (for example if they
> were making similar changes to different functions) when the ordering
> previously caused them to be distinguished.  But that wasn't something
> people could count on anyway, so I don't mind.

I think this example convinces me. I'll drop this support in the next version.

> Should the internal patch-id computation used by commands like 'git
> cherry' (see diff.c::diff_get_patch_id) get the same change?  (Not a
> rhetorical question --- I don't know what the right choice would be
> there.)
> 
> [...]
> > The new behaviour is enabled
> > - when patchid.stable is true
> > - when --stable flag is present
> >
> > Using a new flag --unstable or setting patchid.stable to false force
> > the historical behaviour.
> 
> Which is the default?
> 
> [...]
> >  builtin/patch-id.c | 89 ++++++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 73 insertions(+), 16 deletions(-)
> 
> Documentation?  Tests?
> 
> Thanks,
> Jonathan
