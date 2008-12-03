From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH 3/5] optimize parse_sha1_header() a little by detecting
 object type
Date: Wed, 03 Dec 2008 12:06:19 +0800
Message-ID: <493605BB.8020705@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <49349579.2030506@gmail.com> <20081202155300.GL23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 05:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7j1b-0006TK-RD
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 05:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYLCEG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 23:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYLCEG1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 23:06:27 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:9348 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYLCEG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 23:06:26 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2115010tic.23
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 20:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Vn7j+T3rpXZq00rIMidU2Kv4pVwwpw+wWnsO1YN3nTM=;
        b=QRy/aGqbvKSXcbU8QwJkK7+7furjpdNtVOaCK6t3SAXgUlulMGAhNG0aTjI8wxdHLI
         Z5xAGda9kGJzn52nv7/QtqDD0yz8bdJbxrLYa0VJZ97RLeYl7U6DZWWnGBmFX1iRkXlu
         y9P2EkULw1JhX8+RfkG8xw18A0HN4zFs314DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lT8SqSVAj36kxkJUq+CuapHKeQAPZ+h7AvBeikYDipOK09iEUbgUhuQ4uPH4W+Xcjn
         Zv7EW5nA1eTr1Kv/6I9u6Q9tB695f1HZIjkiC7Acxv8d4qUxsLvDn2AREwCSc1T16bKL
         kH7ihEY0VJlpXnUoR/gHUjTN6yn5mccaqdy3Q=
Received: by 10.110.103.5 with SMTP id a5mr19118634tic.26.1228277184094;
        Tue, 02 Dec 2008 20:06:24 -0800 (PST)
Received: from ?10.64.1.78? ([211.157.41.194])
        by mx.google.com with ESMTPS id w5sm5833435tib.14.2008.12.02.20.06.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 20:06:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081202155300.GL23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102210>

Shawn O. Pearce wrote:
> Liu Yubao <yubao.liu@gmail.com> wrote:
>> diff --git a/sha1_file.c b/sha1_file.c
>> index dccc455..79062f0 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1099,7 +1099,8 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
>>  
>>  		if (!fstat(fd, &st)) {
>>  			*size = xsize_t(st.st_size);
>> -			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
>> +			if (*size > 0)
>> +				map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
>>  		}
>>  		close(fd);
>>  	}
> 
> This has nothing to do with this change description.  Why are we
> returning NULL from map_sha1_file when the file length is 0 bytes?
> No loose object should ever be an empty file, there must always be
> some sort of type header present.  So it probably is an error to
> have a 0 length file here.  But that bug is a different change.
> 

Also a defensive programming for uncompressed loose object because the mapped memory
will be passed to parse_sha1_header() directly without being checked by inflateInit().

In fact unpack_sha1_header() in current code calls legacy_loose_object() without checking
mapsize first. If it encounters (very very unlikely) a corrupted empty loose object, it
will crash.

>> @@ -1257,6 +1258,8 @@ static int parse_sha1_header(const char *hdr, unsigned long length, unsigned lon
>>  	 * terminating '\0' that we add), and is followed by
>>  	 * a space, at least one byte for size, and a '\0'.
>>  	 */
>> +	if ('b' != *hdr && 'c' != *hdr && 't' != *hdr)	/* blob/commit/tag/tree */
>> +		return -1;
>>  	i = 0;
>>  	while (hdr < hdr_end - 2) {
>>  		char c = *hdr++;
> 
> Oh.  I wouldn't do that.  Its a cute trick and it works to quickly
> determine if the header is an uncompressed header vs. a zlib header
> vs. a new-style loose object header (which git cannot write anymore,
> but it still can read).  But its just asking for trouble when/if a
> new object type was ever added to the type table.
> 
I can't agree any more, it's just a trick. I considered adding
a function seems_likely_uncompressed_loose_object(), but I didn't
because this patch series are just my first try, I don't know whether
the idea to support uncompressed loose object is attractive enough.

> Given that we know that no type name can be more than 10 bytes and
> if you use my patch from earlier today you can be certain hdr has a
> '\0' terminator, so you could write a function to test for the type
> against the hdr, stopping on either ' ' or '\0'.  Or find the first
> ' ' in the first 10 bytes (which is what this loop does anyway) and
> then test that against the type name table.
> 
