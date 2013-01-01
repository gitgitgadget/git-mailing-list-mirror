From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Tue, 1 Jan 2013 11:15:58 +0700
Message-ID: <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net> <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 05:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TptHe-0004ve-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 05:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3AAEQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 23:16:29 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:42790 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab3AAEQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 23:16:28 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so11911939oag.39
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 20:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1+SG0MaA/PJARw6/TFafx9o2Kynvy5IUxwKvbLU6nQQ=;
        b=kcQcbh9WhEWYG6Xw5aVsced69MNqWvZ3mzwMwp88ckG5HUqsvkbmV/ftzaSov2hD6t
         nAV4q3vD/I1VjGDU1FOuMCLPnkJ71bCbbKMIQs7Sas9X9561plT2TpLEw93NolJRBjlM
         utm4sNH26xS73254TS2fyMKZiXvKbxY98qTWdqpJStp8ROBExeMGxE1resb3VmHtRUy5
         mt9NB7DYL6k/9YkAKeGMtoufStqOR9WLFcRqmuheDWEOqii53ecGB5Mpb0QlyIz1owbn
         TjgU23EanNVwnl2VloCk95rl4w1aMoDU0F3yupSPZnn2nozhU55ICi7xMYAD/nG3XzWz
         10/Q==
Received: by 10.60.30.70 with SMTP id q6mr23608115oeh.107.1357013788209; Mon,
 31 Dec 2012 20:16:28 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 31 Dec 2012 20:15:58 -0800 (PST)
In-Reply-To: <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212413>

On Tue, Jan 1, 2013 at 1:06 AM, Shawn Pearce <spearce@spearce.org> wrote:
>>   3. Dropping the "commits" file and just using the pack-*.idx as the
>>      index. The problem is that it is sparse in the commit space. So
>>      just naively storing 40 bytes per entry is going to waste a lot of
>>      space. If we had a separate index as in (1) above, that could be
>>      dropped to (say) 4 bytes of offset per object. But still, right now
>>      the commits file for linux-2.6 is about 7.2M (20 bytes times ~376K
>>      commits). There are almost 3 million total objects, so even storing
>>      4 bytes per object is going to be worse.
>
> Fix pack-objects to behave the way JGit does, cluster commits first in
> the pack stream. Now you have a dense space of commits. If I remember
> right this has a tiny positive improvement for most rev-list
> operations with very little downside.

I was going to suggest a similar thing. The current state of C Git's
pack writing is not bad. We mix commits and tags together, but tags
are few usually. Once we get the upper and lower bound, in terms of
object position in the pack, of the commit+tag region, we could reduce
the waste significantly. That is if you sort the cache by the object
order in the pack.
-- 
Duy
