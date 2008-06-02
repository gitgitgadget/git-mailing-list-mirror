From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Mon, 2 Jun 2008 08:49:02 -0700
Message-ID: <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
	 <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
	 <20080602064218.GA15144@sigill.intra.peff.net>
	 <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
	 <alpine.DEB.1.00.0806021635220.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:50:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CIf-0007iF-Rm
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbYFBPtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756829AbYFBPtG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:49:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:63136 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbYFBPtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:49:03 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1095009rvb.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=VTfeq3CtjNILp+ikKmYEOTNmGPZy0fhaST8+d9d7t00=;
        b=npCuG1WCwjxTY+2x4TPorkFisNxxdQ4EbPbU8LPvQsZKfxhn1pR/seQH07FIz6AFEi1+qG1TeM0M5qxv2LihUBhX4hCtAy5v2dYSjPI6M7o8Wa+/C+bv9OHc+kyo6qq5mMqniLRSFoknsKp03dtNqACYH7pMP/4eNWyo0GUDd2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IWqOxWlYur4lLXGmrrrIzeE8DDt0xbrnePG9ms1JmRtKKiK46eVlXWqCimDJg3GEJWbBud0cwbMaLFrI/Wa90MehHexYVQcS6BOmTxv9HRTyLB10ESMYkBI1vXPeaLY78APrHJIAYMgAbBbU5MpuwstD0akHHQofo+DiGpGYiaM=
Received: by 10.140.133.9 with SMTP id g9mr5053580rvd.235.1212421742745;
        Mon, 02 Jun 2008 08:49:02 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Mon, 2 Jun 2008 08:49:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806021635220.13507@racer.site.net>
Content-Disposition: inline
X-Google-Sender-Auth: 2dbe9b9a65dd4c3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83535>

On Mon, Jun 2, 2008 at 8:37 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 2 Jun 2008, Geoffrey Irving wrote:
>
>> On Sun, Jun 1, 2008 at 11:42 PM, Jeff King <peff@peff.net> wrote:
>> > On Mon, Jun 02, 2008 at 07:13:14AM +0100, Johannes Schindelin wrote:
>> >
>> >> I do not think that this "read-the-entire-table-into-memory" paradigm
>> >> is a wise choice. mmap()ing, I would have understood, but reading a
>> >> potentially pretty large table into memory?
>> >
>> > When I was just a git-youth, I wrote a fast mmap-based cache for
>> > storing SHA1 pairs. It might give some direction. You should be able
>> > to find it here:
>> >
>> >  http://mid.gmane.org/20060629035849.GA30749@coredump.intra.peff.net
>> >
>> > It mmaps and binary searches a sorted list. New entries are added to
>> > an in-memory list, and then at the end of a run, the two sorted lists
>> > are merged to create the new on-disk version.
>>
>> I don't need sorting (and neither did you), so I think a hash table is
>> better (O(1) instead of O(log n), and we don't even need to compute hash
>> keys.  I'll leave it up to you and Dscho (or anyone else who cares to
>> chime in) which one you think I should do.
>
> My tests suggested that the lookup time advantage of hashes makes them a
> more appropriate choice than sorted lists, if you look up often, but add
> rarely.
>
> Another issue that just hit me: this cache is append-only, so if it grows
> too large, you have no other option than to scratch and recreate it.
> Maybe this needs porcelain support, too?  (git gc?)

If so, the correct operation is to go through the hash and remove
entries that refer to commits that no longer exist.  I can add this if
you want.  Hopefully somewhere along the way git-gc constructs an easy
to traverse list of extant commits, and this will be straightforward.

Geoffrey
