From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 09/10] pack-objects: Estimate pack size; abort early if pack size limit is exceeded
Date: Mon, 23 May 2011 19:07:27 +0200
Message-ID: <201105231907.27639.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net> <1306111923-16859-10-git-send-email-johan@herland.net> <BANLkTimQURetDxYeAJr5sVRB-ja9yuqT7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 23 19:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOYcM-00082D-3K
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 19:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab1EWRI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 13:08:29 -0400
Received: from smtp.opera.com ([213.236.208.81]:59037 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756621Ab1EWRI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 13:08:28 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p4NH7veu001609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 May 2011 17:07:57 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <BANLkTimQURetDxYeAJr5sVRB-ja9yuqT7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174254>

On Monday 23. May 2011, Shawn Pearce wrote:
> We can still get a tighter estimate if we wanted to. I wouldn't mix
> it into this patch, but make a new one on top of it. During delta
> compression we hold onto deltas, or at least compute and retain the
> size of the chosen delta. We could re-check the pack size after the
> Compressing phase by including the delta sizes in the estimate, and
> if we are over, abort before writing.

Ok. Not sure when I'll have the time/courage to dive into this, but I'll 
at least give it a try.

> For non-delta, non-reuse we may be able to guess by just using the
> loose object size. The loose object is most likely compressed at the
> same compression ratio as the outgoing pack stream will use, so a
> deflate(inflate(loose)) cycle is going to be very close in total
> bytes used. If we over shoot the limit by more than some fudge
> factor (say 8K in 1M limit or 0.7%), abort before writing.

I already have an unsubmitted patch on top of the series that includes 
the on-disk/compressed size of loose objects in the estimate. However, 
it's quite intrusive (need to extend sha1_object_info() to return 
compressed size of loose objects). Also, since I don't yet take the 
delta compression into account, these numbers are obviously unreliable.

That said, in the cases where loose objects are not deltified it seems 
the compressed/loose versions are about 3 to 7 bytes larger than the 
corresponding compressed/packed versions. I guess this is due to the 
loose files using a "<type> SP <size> NUL" text header (deflated), 
whereas the pack uses a more compact binary format (not deflated).

We could test a large corpus (e.g. linux-kernel) to find the average 
difference between compressed/loose size and compressed/packed size, and 
then multiply this with the number of non-delta, non-reuse object to 
determine the fudge factor you describe above.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
