From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Mon, 28 Apr 2014 21:52:07 +0200
Message-ID: <535EB167.4030804@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com> <20140428193502.GD25993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerbG-0006VR-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbaD1TwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 15:52:20 -0400
Received: from mout.web.de ([212.227.17.11]:51901 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932951AbaD1TwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:52:17 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LgYdx-1XHS010tFt-00nw5F; Mon, 28 Apr 2014 21:52:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140428193502.GD25993@sigill.intra.peff.net>
X-Provags-ID: V03:K0:xcQs0rgGSTn3bHMdeOUiJ4P48xJps2nKxrIaqD+j2joLvfYdkqF
 sX6OqjFUmdoubZ1KN2K/LWdGZw3X7VfFm1tC9M8p/lpsYM5LW+u8ISL3MpDR58udAw8weIQ
 5wXXQzy8ahS9ekpITANb6gRGdOoKL0YG3cDyWfeiDE9j791mcFMGh/d2FHc9hTaFDJruqHX
 PrcFulJzONDJ0XaagbUUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247427>


On 28.04.14 21:35, Jeff King wrote:
> On Mon, Apr 28, 2014 at 12:17:28PM -0700, Junio C Hamano wrote:
>
>>>   3. Convert index filenames to their precomposed form when
>>>      we read the index from disk. This would be efficient,
>>>      but we would have to be careful not to write the
>>>      precomposed forms back out to disk.
>> I think this may be the right approach, especially if you are going
>> to do this only when core.precomposeunicode is set.
>>
>> the reasoning behind "we would have to be careful not to write"
>> part, is unclear to me, though.  Don't decomposing filesystems
>> perform the manglig from the precomposed form without even being
>> asked to do so, just like a case insensitive filesystem will
>> overwrite an existing "makefile" on a request to write to
>> "Makefile"?
> Sorry, I meant "do not write the precomposed forms back out to the
> on-disk index". And by extension, do not update cache-tree and write
> them out to git trees.
>
> IOW, it is not enough to just set cache_entry->name to the normalized
> form. You'd need to store both.
>
> Since such entries are in the minority, and because cache_entry is
> already a variable-length struct, I think you could get away with
> sticking it after the "name" field, and then comparing like:
>
>   const char *ce_normalized_name(struct cache_entry *ce, size_t *len)
>   {
> 	const char *ret;
>
> 	/* Normal, fast path */
> 	if (!(ce->ce_flags & CE_NORMALIZED_NAME)) {
> 		len =3D ce_namelen(ce);
> 		return ce->name;
> 	}
>
> 	/* Slow path for normalized names */
> 	ret =3D ce->name + ce->namelen + 1;
> 	*len =3D strlen(name);
> 	return ret;
>   }
>
> The strlen is probably OK since such paths are presumably in the
> minority (even for UTF-8 paths, we can avoid storing the extra copy i=
f
> they do not need any normalization). Or we could get fancy and encode
> the length in front, but I am not sure it is worth the complexity.
>
> Anyway, the tricky part is then making sure that all cache_entry name
> comparisons use ce_normalized_name instead of ce->name.
>
> -Peff
To my knowledge repos with decomposed unicode should be rare in practic=
e.
I only can speak for european (or latin based) or cyrillic languages my=
self:

- It is difficult (but not impossible) to enter decomposed unicode on t=
he keyboard.
- Some programs under Mac OS X do not handle decomposed code points wel=
l,
  an "=C3=A4" may be displayed as "=C2=A8a" for example.
- Pushing and pulling to Windows or Linux is possible, but the same pro=
blems here:
  the keyboard is not prepared to enter the decomposed form, and the di=
splay may be wrong.

The only possible use case for decomposed unicode I am aware of is when=
 you use git-bzr,
because bzr does not do the precomposition (and neither hg to my knowle=
dge).

So for me the test case could sense, even if I think that nobody (TM) u=
ses an old Git version
under Mac OS X which is not able to handle precomposed unicode.

Unless I have missed something.
