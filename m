From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: struct hashmap_entry packing
Date: Mon, 04 Aug 2014 21:20:02 +0200
Message-ID: <53DFDCE2.9060406@gmail.com>
References: <20140728171743.GA1927@peff.net> <53D806AC.3070806@gmail.com> <20140801223739.GA15649@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:20:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XENnv-0002AS-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 21:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaHDTUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 15:20:08 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:33243 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaHDTUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 15:20:07 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so8082317wev.26
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wkzvRWtgT1C8XDEsKo0J2sC9KblBf0IGeUvvsf2oiSk=;
        b=COOGOo1pPfYlj6oWWlPAQGuzYSVjDLOUgkG5l5GLbTJ6Dt5jzWGLV7mSq59xvGiYzj
         Fs57H1mtiDPKtehR8icavSEh2amvJbXZfQAH8AumwamGfS2PVJhmrWw3T9L+9kyDfCHs
         PlH9yOQ285sej8eHZWXIJaxD5Ma6s43ukzCQAv8shTMCemGC5g55eSi7wqTVUuUFuRSs
         umRufSdb2nFzGcqLYeXgIz3RfYp2h2LO/1Jc/XHUw8/VcLzGCs2kfW97BVymMkYE9DH5
         vM5Zid74mbAqEGsWIx6v9RqzBDVejoKByu/Ups+0dKssltzkOknv1PJ0RpzB/hSU1m3o
         7v2g==
X-Received: by 10.194.123.129 with SMTP id ma1mr35353064wjb.80.1407180002450;
        Mon, 04 Aug 2014 12:20:02 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id dj2sm43596485wib.11.2014.08.04.12.20.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 12:20:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140801223739.GA15649@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254770>

Am 02.08.2014 00:37, schrieb Jeff King:
> On Tue, Jul 29, 2014 at 10:40:12PM +0200, Karsten Blees wrote:
> 
>>> The sizeof() has to be the same regardless of whether the hashmap_entry
>>> is standalone or in another struct, and therefore must be padded up to
>>> 16 bytes. If we stored "x" in that padding in the combined struct, it
>>> would be overwritten by our memset.
>>>
>>
>> The struct-packing patch was ultimately dropped because there was no way
>> to reliably make it work on all platforms. See [1] for discussion, [2] for
>> the final, 'most compatible' version.
> 
> Thanks for the pointers; I should have guessed there was more to it and
> searched the archive myself.
> 
>> Hmmm. Now that we have "__attribute__((packed))" in pack-bitmap.h, perhaps
>> we should do the same for stuct hashmap_entry? (Which was the original
>> proposal anyway...). Only works for GCC, but that should cover most builds
>> / platforms.
> 
> I don't see any reason to avoid the packed attribute, if it helps us. As
> you noted, anything using __attribute__ probably supports it, and if
> not, we can conditionally #define PACKED_STRUCT or something, like we do
> for NORETURN. Since it's purely an optimization, if another compiler
> doesn't use it, no big deal.
> 
> That being said, I don't know if those padding bytes are actually
> causing a measurable slowdown. It may not even be worth the trouble.
> 

Its not about performance (or correctness, in case of platforms that don't
support unaligned read), just about saving memory (e.g. mapping int to int
requires 24 bytes per entry, vs. 16 with packed structs).

The padding at the end of a structure is only needed for proper alignment in
arrays. Struct hashmap_entry is always used as prefix of some other structure,
never as an array, so there are no alignment issues here.

Typical memory layouts on 64-bit platforms are as follows (note that even in
the 'followed by int64' case, all members are properly aligned):


Unpacked struct followed by int32 - wastes 1/3 of memory:

      struct {
        struct hashmap_entry {
00-07     struct hashmap_entry *next;
08-11     int hash;
12-15     // padding
        } ent;
16-19   int32_t value;
20-23   // padding
      }


Packed struct followed by int32:

      struct {
        struct hashmap_entry {
00-07     struct hashmap_entry *next;
08-11     int hash;
        } ent;
12-15   int32_t value;
      }


Packed struct followed by int64:

      struct {
        struct hashmap_entry {
00-07     struct hashmap_entry *next;
08-11     int hash;
        } ent;
12-15   // padding
16-23   int64_t value;
      }


Array of packed struct (not used):

      struct hashmap_entry {
00-07   struct hashmap_entry *next;
08-11   int hash;
      }; // [0]
      struct hashmap_entry {
12-19   struct hashmap_entry *next; // !!!unaligned!!!
20-23   int hash;
      }; // [1]
