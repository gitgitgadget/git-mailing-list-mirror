From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: struct hashmap_entry packing
Date: Tue, 29 Jul 2014 22:40:12 +0200
Message-ID: <53D806AC.3070806@gmail.com>
References: <20140728171743.GA1927@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:40:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCECD-0004jT-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 22:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbaG2UkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 16:40:17 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44470 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaG2UkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 16:40:15 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so6085986wiw.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6g7twPTK0uN5vlpYgdMdQKQgqhzKeJFelWX8okvSOBI=;
        b=skdKq7flC86mamjPReJtc+JDDdBHLEoIg0irsszCjVeOoYyZ05mhL86mfjPpJWvx7T
         siEY/uzzN7bwri82yh1vrHGyuHRA2TVjK2OeEhh8Lyi9X/RlUY26PC2/RrB5PO3SLu5Q
         0KPOiYo0/NQfR6hkU4Em7qG/hNhD6Nci8N6gwpC+3bNNKrBgs9PcBaRVpShH7Whl2uwJ
         WD647amsWN8J5YvKSKuyZGaE5b2vxGEQo27039DYatZ+53b+nQePCEZkrvFY1O0hUYGF
         L9jbG7uJ8QfYzbNQvhgw6jb8eIwqDi86J5H4hGYdOOGCYyquE5IM5AIlxGftMO2h+lYL
         ygpQ==
X-Received: by 10.180.39.73 with SMTP id n9mr462113wik.70.1406666414255;
        Tue, 29 Jul 2014 13:40:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pj6sm171313wjb.21.2014.07.29.13.40.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 13:40:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140728171743.GA1927@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254468>

Am 28.07.2014 19:17, schrieb Jeff King:
> Hi Karsten,
> 
> The hashmap_entry documentation claims:
> 
>   `struct hashmap_entry`::
> 
> 	An opaque structure representing an entry in the hash table,
> 	which must be used as first member of user data structures.
> 	Ideally it should be followed by an int-sized member to prevent
> 	unused memory on 64-bit systems due to alignment.
> 
> I'm not sure if the statement about alignment is true. If I have a
> struct like:
> 
>     struct magic {
> 	    struct hashmap_entry map;
> 	    int x;
>     };
> 
> the statement above implies that I should be able to fit this into only
> 16 bytes on an LP64 system. But I can't convince gcc to do it. And I
> think that makes sense, if you consider code like:
> 
>    memset(&magic.map, 0, sizeof(struct hashmap_entry));
> 
> The sizeof() has to be the same regardless of whether the hashmap_entry
> is standalone or in another struct, and therefore must be padded up to
> 16 bytes. If we stored "x" in that padding in the combined struct, it
> would be overwritten by our memset.
> 

The struct-packing patch was ultimately dropped because there was no way
to reliably make it work on all platforms. See [1] for discussion, [2] for
the final, 'most compatible' version.

> Am I missing anything? If this is the case, we should probably drop that
> bit from the documentation.

Hmmm. Now that we have "__attribute__((packed))" in pack-bitmap.h, perhaps
we should do the same for stuct hashmap_entry? (Which was the original
proposal anyway...). Only works for GCC, but that should cover most builds
/ platforms.

Btw.: Using struct-packing on 'struct bitmap_disk_entry' means that the
binary format of .bitmap files is incompatible between GCC and other
builds, correct?

> It's possible that we could get around it by
> embedding the hashmap_entry elements directly into the parent struct,

Already tried that, see [3].

[1] http://article.gmane.org/gmane.comp.version-control.git/239069
[2] http://article.gmane.org/gmane.comp.version-control.git/241865
[3] http://article.gmane.org/gmane.comp.version-control.git/239435
