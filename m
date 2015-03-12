From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Thu, 12 Mar 2015 18:16:49 +0700
Message-ID: <CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com> <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com> <55016A3A.6010100@alum.mit.edu>
 <20150312104651.GF46326@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:17:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW17b-0008Dx-MB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 12:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbCLLRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 07:17:43 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35431 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbbCLLRV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 07:17:21 -0400
Received: by ieclw3 with SMTP id lw3so33480187iec.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=U5PKSGCQ1E3HszGExsXa7400LvvhgmknsOM07cSSSAk=;
        b=NLEy7RTD6UmPGzU2LoGo4r5MzZV8+vfO9/GEfNxWOYO7uvwoCTW2T8fMvG0FM9YM7X
         Bo7mb+wE+oVUoRzkO65euBSc5AjlbgpsgV7ZslM3VgDV46eIIrNIZbyerr62mrMdFESq
         NLJE9vMgojmh7NBUI/ezm1gAvg8im7xFj0b1wDfUlsJ7qw61eRWppTCVB8oNw2CCHouf
         CqXkOd3O6YvgPQnqQkluBxXIVvkjtGBaHrIZFXps2+OsOiwRUvYmf1aSx87AbFdiFfOK
         ByDc3Jg3E/UFKk8a2LXiU8RRvRYABDb67ZsbTM7nL3e6/mSZDlIcpVMi/TTOBATdabM4
         pnTg==
X-Received: by 10.50.36.103 with SMTP id p7mr99938903igj.20.1426159041123;
 Thu, 12 Mar 2015 04:17:21 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 12 Mar 2015 04:16:49 -0700 (PDT)
In-Reply-To: <20150312104651.GF46326@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265360>

On Thu, Mar 12, 2015 at 5:46 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Mar 12, 2015 at 11:28:10AM +0100, Michael Haggerty wrote:
>>
>> On 03/12/2015 01:26 AM, Junio C Hamano wrote:
>>>
>>> And that would break the abstraction effort if you start calling the
>>> field with a name that is specific to the underlying hash function.
>>> The caller has to change o->sha1 to o->sha256 instead of keeping
>>> that as o->oid and letting the callee handle the implementation
>>> details when calling
>>>
>>>         if (!hashcmp(o1->oid, o2->oid))
>>>                 ; /* they are the same */
>>>         else
>>>                 ; /* they are different */
>>> [...]
>>
>>
>> Hmm, I guess you imagine that we might sometimes pack SHA-1s, sometimes
>> SHA-256s (or whatever) in the "oid" field, which would be dimensioned
>> large enough for either one (with, say, SHA-1s padded with zeros).
>>
>> I was imagining that this would evolve into a union (or maybe struct) of
>> different hash types, like
>>
>>    struct object_id {
>>        unsigned char hash_type;
>>        union {
>>            unsigned char sha1[GIT_SHA1_RAWSZ];
>>            unsigned char sha256[GIT_SHA256_RAWSZ];
>>        } hash;
>>    };
>>
>> BTW in either case, any hopes of mapping object_id objects directly on
>> top of buffer memory would disappear.
>
>
> What I think might be more beneficial is to make the hash function
> specific to a particular repository, and therefore you could maintain
> something like this:
>
>  struct object_id {
>      unsigned char hash[GIT_MAX_RAWSZ];
>  };
>
> and make hash_type (or hash_length) a global[0].  I don't think it's
> very worthwhile to try to mix two different hash functions in the same
> repository,

This may or may not fall into the "mix different hash functions"
category. In pack files version 4, trees are encoded to point to other
trees or blobs by a (pack, offset) tuple. It would be great if the new
object_id could support carrying this kind of object id around because
it could help reduce object lookup cost a lot. (pack, offset) can be
converted back to SHA-1 so no info is lost and hashcmp() can compare
(pack, tuple) against an SHA-1 just fine.

> so we could still map directly onto buffer memory if we
> decide that's portable enough.  I expect the cases where we need to do
> that will be relatively limited.
>
> Regardless, it seems that this solution has the most support (including
> Junio's) and it's more self-documenting than my current set of patches,
> so I'm going to go with it for now.  It should be easy to change if the
> consensus goes back the other way.
>
> [0] I personally think globals are a bit gross, but they don't seem to
> have the problems that they would if git were a shared library.
>
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187



-- 
Duy
