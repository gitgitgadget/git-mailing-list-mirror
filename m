From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Wed, 23 May 2012 00:11:30 +0200
Message-ID: <4FBC0F12.2000001@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu> <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 00:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWxJ0-0004BL-1B
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 00:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758402Ab2EVWLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 18:11:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:33113 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab2EVWLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 18:11:37 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 51FEB2F8058;
	Wed, 23 May 2012 00:11:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vlikj3nzc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198258>

Am 22.05.2012 23:27, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>> Why allocate a NUL-terminated copy at all when we can teach the code=
 to
>> stop after a given number of characters just as easily?  Alas, this
>> will still trigger an allocation in search_ref_dir() (see first patc=
h).
>
> Yeah, but it is only because search_ref_dir() tries to use ref_entry_=
cmp(),
> whose signature is geared more towards being used as a qsort(3) callb=
ack,
> as the comparison function for bsearch(3).
>
> A bsearch() callback takes two pointers, one is for the key and the o=
ther
> for an array element, and there is no reason to require the two types=
 be
> the same.
>
> In other words, something like this patch and we won't need an alloca=
tion
> of the ref_entry that did not have to be a full ref_entry in the firs=
t
> place (it only had to be something that supplies the "key" into a sor=
ted
> array).

Right, and this order (key-first) is documented for Linux, *BSD and by=20
Microsoft, so we can probably rely on it.  The proposed asymmetry=20
between sorting and lookup is a bit ... untidy, nevertheless.  But it's=
=20
certainly worth it to avoid that ugly allocation.

Here's a random observation that led me to write the three patches: Whe=
n=20
running the following command under valgrind, it reports a few=20
interesting numbers for total heap usage:

	$ git grep guess xdiff/xutils.c

   v1.7.8       591 allocs,    96 frees,   383,565 bytes allocated
   v1.7.9     2,940 allocs,   121 frees,   361,001 bytes allocated
   v1.7.10    3,002 allocs,   129 frees,   366,487 bytes allocated
   master     4,555 allocs, 1,586 frees, 2,380,265 bytes allocated
   3 patches  4,079 allocs, 1,110 frees,   430,093 bytes allocated
   4 patches  3,093 allocs,   124 frees,   377,749 bytes allocated

With your last patch, I think we're doing fine again, as the total
allocated size is within a few KB of the smallest one in this
arbitrary list of versions.

What has git grep to do with refs?  It checks if the path in the comman=
d
above is a ref, which makes it iterate over all of them..

Ren=C3=A9
