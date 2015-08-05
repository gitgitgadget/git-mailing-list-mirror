From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: Re: [PATCH] git_open_noatime: return with errno=0 on success
Date: Wed, 5 Aug 2015 16:36:00 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150805143600.GA3111@musxeris015.imu.intel.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com> <CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com> <20150804082429.GA22271@musxeris015.imu.intel.com> <xmqqfv3y6a24.fsf@gitster.dls.corp.google.com> <CA+55aFx-WXxCbVTWdJHFf4WA2MNXS3UMerv4cD1wtsZGaQkJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Martin =?iso-8859-1?Q?Schr=F6der?= <martin.h.schroeder@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 16:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMzx3-0003Sw-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 16:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbbHEOps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 10:45:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:45548 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbbHEOps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 10:45:48 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 05 Aug 2015 07:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,617,1432623600"; 
   d="scan'208";a="777370714"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2015 07:36:01 -0700
Content-Disposition: inline
In-Reply-To: <CA+55aFx-WXxCbVTWdJHFf4WA2MNXS3UMerv4cD1wtsZGaQkJLw@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275370>

On Wed, Aug 05, 2015 at 10:59:09AM +0200, Linus Torvalds wrote:
> On Tue, Aug 4, 2015 at 11:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > I would agree it is a good idea to clear it after seeing the first
> > open fail due to lack of O_NOATIME before trying open for the second
> > time, iow, more like this?

Looks good to me.

> So I don't think this is _wrong_ per se, but I think the deeper issue
> is that somebody cares about 'errno' here in the first place.
> 
> A stale 'errno' generally shouldn't matter, because we either
> 
>  (a) return success (and nobody should look at errno)
> 
> or
> 
>  (b) return an error later, without setting errno for that _later_ error.
> 
> and I think either of those two situations are the real bug, and this
> "clear stale errno" is just a workaround.

I agree. But I do not see how to get there easily.

We are trying to read an object. We first try to read from a pack. We
may encounter broken pack files, missing index files, unreadable files,
but those errors are not necessarily fatal since we may still be able to
read the object from the next pack file or from a sha1 file.

If finally we do not find the object anywhere, in
read_sha1_file_extended we try our best to die with an appropriate error
message, for example by looking at errno, and otherwise we just return
NULL. Most callers seem to die explicitly or they dereference the null
pointer.

I think we should instead output error messages closer to the source,
like for example in map_sha1_file, but continue anyway. In particular we
should immediately report failures due to EPERM or unexpected ENOENT. In
the end we may return NULL without another message, but at least the
user should have some hints about what went wrong along the way.
