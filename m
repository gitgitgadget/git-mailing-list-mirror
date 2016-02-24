From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 24 Feb 2016 06:05:48 -0500
Message-ID: <20160224110548.GA21620@sigill.intra.peff.net>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
 <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 12:06:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYXGc-0003v7-8v
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 12:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbcBXLF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 06:05:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:48239 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751447AbcBXLFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 06:05:51 -0500
Received: (qmail 29889 invoked by uid 102); 24 Feb 2016 11:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 06:05:51 -0500
Received: (qmail 7331 invoked by uid 107); 24 Feb 2016 11:05:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 06:05:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 06:05:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287199>

On Thu, Jan 07, 2016 at 02:54:50PM -0800, Junio C Hamano wrote:

> We do not check if the offset of individual objects are within the
> corresponding .pack file, either, and nth_packed_object_offset()
> does return the data read from .idx file that is not checked for
> sanity.  use_pack(), which is the helper used by the callers of
> nth_packed_object_offset() that finds the offset in the packfile for
> each object, avoids allowing a read access to mapped pack data
> beyond the end of it, so it is OK to return bogus value that was
> read from the .idx file from this function, but there is one
> computation the function itself does using a possibly bogus value
> read from the disk: to find out where in the secondary offset table
> in the .idx file the offset in the packfile is stored.

Looks like this topic got dropped. I was reminded of it when somebody
pointed me to a similar case[1] today which segfaults in a similar way (but
this time was caused by actual filesystem corruption).

Did you ever push the patch below further along?

I confirmed that your patch detects and complains on this newer case.
Though I think there is another similar problem in
read_v2_anomalous_offsets (I haven't dug, but it triggers for me in
"index-pack --verify").

-Peff

[1] https://github.com/libgit2/libgit2/issues/3556
