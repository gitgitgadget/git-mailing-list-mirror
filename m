From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Sun, 7 Jul 2013 16:52:23 -0700
Message-ID: <CAJo=hJugvqBEQwPYcttNH+R8xUKxy1uDm5EjiWaye-wEuTxk-w@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707101438.GD19143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 01:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvyl7-0004ek-8y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 01:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab3GGXwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 19:52:45 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58423 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab3GGXwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 19:52:44 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so8930984iej.29
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hAQ90viieYFg4sYmFvzJCF3vKPNpzDI4cS+BT8dmj88=;
        b=D3AUx9mr5RTaTFJ9MufRxo7RBqf8ujnQBYWLkArLWvf4FtSD6OiWBSdk4zsnh0fxgV
         1ZcAwaYXe3RnSbY1WhZF2KjW9PRXWBM9Kh1Ur9If/UL8Lsc4aiC1+iK9H7HD5aKZGfGL
         v+JxDmCeebcfyOtUx1/26KvOeGCmKSDgtXzKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=hAQ90viieYFg4sYmFvzJCF3vKPNpzDI4cS+BT8dmj88=;
        b=WCxKVv9cePua7DI2OMEA233IE5oNqKjZBL+11PlKmHNKqee5Pnosu31tLWfWzeMVq2
         2zzlRUWprVBRF/3RNFt5MnFDuqM7WVDP6YUKR0nHiSJuQtjeIiSz3L0oM22XkhF2BktS
         yuf4GNor60MeEcvheRLYgiLnkmVbE3bGLQPh3horfH1MRr7xSNKhplFPQrSI5QVKZL1F
         z6NwUWt+GuYxKssyyBDKI1D4eY5lST1RSJd5Pn5Olgr9KXukTEWm2nWoc2c5GUgX3a9T
         Z/KD5Z/JKpsdisG6TblS87xsL4cHPOyQPk6DNbWCSR2k2wZcCc2boM8hDtnNzOypDpVC
         SX3Q==
X-Received: by 10.43.84.131 with SMTP id ak3mr6318185icc.84.1373241163740;
 Sun, 07 Jul 2013 16:52:43 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Sun, 7 Jul 2013 16:52:23 -0700 (PDT)
In-Reply-To: <20130707101438.GD19143@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnu+x+/WurVa9xIx1uGFNNAn3BuvYFvpDefiyFgi5cjyd3ln52wXn21sFUuZ+NBAYp/R9jV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229818>

On Sun, Jul 7, 2013 at 3:14 AM, Jeff King <peff@peff.net> wrote:
> The pack revindex stores the offsets of the objects in the
> pack in sorted order, allowing us to easily find the on-disk
> size of each object. To compute it, we populate an array
> with the offsets from the sha1-sorted idx file, and then use
> qsort to order it by offsets.
>
> That does O(n log n) offset comparisons, and profiling shows
> that we spend most of our time in cmp_offset. However, since
> we are sorting on a simple off_t, we can use numeric sorts
> that perform better. A radix sort can run in O(k*n), where k
> is the number of "digits" in our number. For a 64-bit off_t,
> using 16-bit "digits" gives us k=4.

Did you try the simple bucket sort Colby now uses in JGit?

The sort is pretty simple:

  bucket_size = pack_length / object_count;
  buckets[] = malloc(object_count * sizeof(int));

  foreach obj in idx:
    push_chain(buckets[obj.offset / bucket_size], obj.idx_nth);

  foreach bucket:
    insertion sort by offset

https://eclipse.googlesource.com/jgit/jgit/+/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/PackReverseIndex.java

We observed on linux.git that most buckets have an average number of
objects. IIRC the bucket_size was ~201 bytes and most buckets had very
few objects each. For lookups we keep the bucket_size parameter and a
bucket index table. This arrangement uses 8 bytes per object in the
reverse index, making it very memory efficient. Searches are typically
below O(log N) time because each bucket has <log N entries.
