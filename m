From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to
 control pack size
Date: Wed, 04 Apr 2007 18:04:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZDbB-0007eM-CM
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXDDWE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXDDWE6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:04:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20061 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXDDWE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:04:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFZ00AVPUO73830@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Apr 2007 18:04:55 -0400 (EDT)
In-reply-to: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43781>

On Wed, 4 Apr 2007, Dana How wrote:

> The motivations are to better support portable media,
> older filesystems,  and larger repositories without
> awkward enormous packfiles.

I wouldn't qualify "enormous" pack files as "awkward".

It will always be more efficient to have only one pack to deal with 
(when possible of course).

> When --pack-limit[=N] is specified and --stdout is not,
> all bytes in the resulting packfile(s) appear at offsets
> less than N (which defaults to 1<<31).  The default
> guarantees mmap(2) on 32b systems never sees signed off_t's.
> The object stream may be broken into multiple packfiles
> as a result,  each properly and conventionally built.
> 

This sounds fine.  *However* how do you ensure that the second pack (or 
subsequent packs) is self contained with regards to delta base objects 
when it is _not_ meant to be a thin pack?

> When --stdout is also specified,  all objects in the
> resulting packfile(s) _start_ at offsets less than N.
> All the packfiles appear concatenated on stdout,
> and each has its object count set to 0.  The behavior
> without --stdout cannot be duplicated here since
> lseek(2) is not generally possible on stdout.

Please scrap that.  There is simply no point making --pack-limit and 
--stdout work together.  If the amount of data to send over the GIT 
protocol exceeds 4G (or whatever) it is the receiving end's business to 
split it up _if_ it wants/has to.  The alternative is just too ugly.

> When --blob-limit=N is specified,  blobs whose uncompressed
> size is greater than or equal to N are omitted from the pack(s).
> If --pack-limit is specified, --blob-limit is not, and
> --stdout is not,  then --blob-limit defaults to 1/4
> of the --pack-limit.

Is this really useful?

If you have a pack size limit and a blob cannot make it even in a pack 
of its 
own then you're screwed anyway.  It is much better to simply fail the 
operation than leaving some blobs behind.  IOW I don't see the 
usefulness of this feature.


Nicolas
