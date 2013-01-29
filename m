From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 08:25:39 -0700
Message-ID: <2c88f15d-405b-4dd1-8546-94f54f0ac565@email.android.com>
References: <20130126224011.GA20675@sigill.intra.peff.net> <7vlibfxhit.fsf@alter.siamese.dyndns.org> <20130129082939.GB6396@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0D4Z-00025A-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 16:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab3A2PZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 10:25:46 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:57647 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab3A2PZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 10:25:45 -0500
X-IronPort-AV: E=Sophos;i="4.84,561,1355126400"; 
   d="scan'208";a="22842254"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Jan 2013 07:25:44 -0800
Received: from [10.10.7.117] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E9ABF10004C7;
	Tue, 29 Jan 2013 07:25:43 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20130129082939.GB6396@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214940>



Jeff King <peff@peff.net> wrote:

>On Sat, Jan 26, 2013 at 10:32:42PM -0800, Junio C Hamano wrote:
>
>> Both makes sense to me.
>> 
>> I also wonder if we would be helped by another "repack" mode that
>> coalesces small packs into a single one with minimum overhead, and
>> run that often from "gc --auto", so that we do not end up having to
>> have 50 packfiles.
>> 
>> When we have 2 or more small and young packs, we could:
>> 
>>  - iterate over idx files for these packs to enumerate the objects
>>    to be packed, replacing read_object_list_from_stdin() step;
>> 
>>  - always choose to copy the data we have in these existing packs,
>>    instead of doing a full prepare_pack(); and
>> 
>>  - use the order the objects appear in the original packs, bypassing
>>    compute_write_order().
>
>I'm not sure. If I understand you correctly, it would basically just be
>concatenating packs without trying to do delta compression between the
>objects which are ending up in the same pack. So it would save us from
>having to do (up to) 50 binary searches to find an object in a pack,
>but
>would not actually save us much space.
>
>I would be interested to see the timing on how quick it is compared to
>a
>real repack, as the I/O that happens during a repack is non-trivial
>(although if you are leaving aside the big "main" pack, then it is
>probably not bad).
>
>But how do these somewhat mediocre concatenated packs get turned into
>real packs? Pack-objects does not consider deltas between objects in
>the
>same pack. And when would you decide to make a real pack? How do you
>know you have 50 young and small packs, and not 50 mediocre coalesced
>packs?


If we are reconsidering repacking strategies, I would like to propose an approach that might be a more general improvement to repacking which would help in more situations. 

You could roll together any packs which are close in size, say within 50% of each other.  With this strategy you will end up with files which are spread out by size exponentially.  I implementated this strategy on top of the current gc script using keep files, it works fairly well:

https://gerrit-review.googlesource.com/#/c/35215/3/contrib/git-exproll.sh

This saves some time, but mostly it saves I/O when repacking regularly.  I suspect that if this strategy were used in core git that further optimizations could be made to also reduce the repack time, but I don't know enough about repacking to know?  We run it nightly on our servers, both write and read only mirrors. We us are a ratio of 5 currently to drastically reduce large repack file rollovers,

-Martin
