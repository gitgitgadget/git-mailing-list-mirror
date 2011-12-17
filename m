From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] use struct sha1_array in diff_tree_combined()
Date: Sat, 17 Dec 2011 12:16:32 +0100
Message-ID: <4EEC7A10.3080705@lsrfire.ath.cx>
References: <4EEC6BD4.4040302@lsrfire.ath.cx> <20111217105315.GA23935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 12:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbsFv-0002r3-M9
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 12:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab1LQLQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 06:16:40 -0500
Received: from india601.server4you.de ([85.25.151.105]:40087 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab1LQLQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 06:16:38 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id 3AC582F8038;
	Sat, 17 Dec 2011 12:16:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111217105315.GA23935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187378>

Am 17.12.2011 11:53, schrieb Jeff King:
>> -	parent =3D xmalloc(ents * sizeof(*parent));
>> -	for (i =3D 0; i<  ents; i++)
>> -		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
>> -	diff_tree_combined(parent[0], parent + 1, ents - 1,
>> +	for (i =3D 1; i<  ents; i++)
>> +		sha1_array_append(&parents, ent[i].item->sha1);
>> +	diff_tree_combined(ent[0].item->sha1,&parents,
>>   			   revs->dense_combined_merges, revs);
>> -	free((void *)parent);
>> +	sha1_array_clear(&parents);
>
> The original code is slightly more efficient, as it is able to use a
> single malloc (because it knows the number of entries ahead of time).
> It probably doesn't make a difference, but we could also add a
> sha1_array_grow() for this case.
>
> I think it could be used in all three spots you converted in this pat=
ch.

We coulddo that, yes.  In the case above we have the number already, in=
=20
the other cases we'd have to count.

But I don't think it's worth it here.  ALLOC_GROW gives us 24 entries=20
initially, which should be enough in most cases -- I'm not sure I want=20
to see combined diff of that many tree.  And 24 times 20 bytes is small=
=20
enough to not cause any memory allocation issues.

Taking out the counting and not having to worry about the number of=20
items is a feature in my book.  Simple timings before and after the=20
patch didn't show any significant difference.

Ren=C3=A9
