From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Mon, 28 Oct 2013 17:16:02 +0100
Message-ID: <CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com> <CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
 <xmqq61shgzvn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 17:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VapUW-0003NR-9M
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 17:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab3J1QQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 12:16:25 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:36643 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347Ab3J1QQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 12:16:23 -0400
Received: by mail-ve0-f182.google.com with SMTP id c14so3700299vea.13
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yT58ZU2S/M66IU4E2qorClFKyCrhLF20fRhsBO8L84I=;
        b=lt+IqVPR5mRCBz/Ze9x2AIOBIiJg101WuIRDoKiQNlCrvzLwQDyf5jzDlmcNd+NS3J
         i6NFDo75HW650Rw8zEqIVxq1Y1PeESW0nJb5P9XT++MGC9LCi4PY6cAB3AKAvojzcDHu
         dUU/BF3qTwjZo/o+pWGjtrI3ZU35GaTcL2vOVp+VvnsPgmyIXRHkjRbsnAqsgfB0+XWY
         K+EhHctp0UmLvYFhQbSELfBXD0EEq8HjKjG6B4cDlh4eDi/66x1StIxhkLqVCq8cA6+H
         p2qAsarmfQ8iJT79hd/Ny0goGdpw+oHvoLGa62oC1eA/2HaZf7+v7inA1AQ/HJ6qHM9V
         jYkA==
X-Received: by 10.52.157.232 with SMTP id wp8mr11812523vdb.4.1382976982925;
 Mon, 28 Oct 2013 09:16:22 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Mon, 28 Oct 2013 09:16:02 -0700 (PDT)
In-Reply-To: <xmqq61shgzvn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236837>

On Mon, Oct 28, 2013 at 4:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> jk/pack-bitmap adds khash.h, which from a first glance looks like yet
>> another hash table implementation. I was just wondering if kb's new
>> hash tables can cover the need of pack-bitmap.c too so we can remove
>> khash.h later..
>
> Good thinking ;-).

We use the khash tables to map:

    - sha1 (const char *) to (void *)
    - sha1 (const char *) to int

The new `hashmap.c` covers the first case quite well (albeit slightly
more verbosely than I'd like), but in the second case it doesn't quite
work. Since the new hash needs to embed the "struct hashmap_entry" on
all its values (to allow for separate chaining), having it map to
`int` keys requires a struct like this:

    struct sha1_position {
        struct hashmap_entry {
            struct hashmap_entry *next;
            unsigned int hash;
        };
        int position;
    }

khash on the other hand is capable of storing the position values as
part of the hash table itself (i.e. `int **buckets`), and saves us
from thousands of bytes of allocations + indirection.

I am not sure whether the consistency of having a single hash map
warrants the performance and memory hits when operating on the
extended index.

Please advice.

luv,
vmg
