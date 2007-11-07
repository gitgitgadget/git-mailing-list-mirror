From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Thu, 08 Nov 2007 00:19:44 +0100
Message-ID: <47324810.2010507@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site> <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org> <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org> <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx> <Pine.LNX.4.64.0711062343050.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuCH-000632-BM
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbXKGXUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 18:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbXKGXUR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:20:17 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34041
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754554AbXKGXUQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 18:20:16 -0500
Received: from [10.0.1.201] (p57B7C524.dip.t-dialin.net [87.183.197.36])
	by neapel230.server4you.de (Postfix) with ESMTP id 62AB4873BA;
	Thu,  8 Nov 2007 00:20:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711062343050.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63894>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Wed, 7 Nov 2007, Ren=C3=A9 Scharfe wrote:
>=20
>> By the way, the more intrusive surgery required when using strbuf_ex=
pand()
>> leads to even faster operation.  Here my measurements of most of Pau=
l's
>> test cases (best of three runs):
>>
>> [...]
>=20
> impressive timings.  Although I wonder where the time comes from, as =
the=20
> other substitutions should not be _that_ expensive.

I haven't run a profiler, but my two suspects are the malloc()s and
free()s done by interp_set_entry(), and the fact that
format_commit_message() calls interpolate() twice.

> In any case, your approach seems much more sensible, now that we have=
=20
> strbuf.
>=20
>> diff --git a/strbuf.h b/strbuf.h
>> index cd7f295..95071d5 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -102,6 +102,9 @@ static inline void strbuf_addbuf(struct strbuf *=
sb, struct strbuf *sb2) {
>>  	strbuf_add(sb, sb2->buf, sb2->len);
>>  }
>> =20
>> +typedef void (*expand_fn_t) (struct strbuf *sb, const char *placeho=
lder, void *context);
>> +extern void strbuf_expand(struct strbuf *sb, const char *fmt, const=
 char **placeholders, expand_fn_t fn, void *context);
>=20
> I wonder if it would even faster (but maybe not half as readable) if=20
> expand_fd_t got the placeholder_index instead of the placeholder.

I doubt it.  All this would save is one pointer dereference per
placeholder.  I haven't tried and measured this, though.

Ren=C3=A9
