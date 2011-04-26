From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 23:26:57 +0200
Message-ID: <4DB738A1.8020706@lsrfire.ath.cx>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com> <7vaafdexsp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEpnW-000839-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab1DZV1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 17:27:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:37414 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743Ab1DZV1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 17:27:47 -0400
Received: from [192.168.2.106] (p4FFDA9E5.dip.t-dialin.net [79.253.169.229])
	by india601.server4you.de (Postfix) with ESMTPSA id 80C192F8050;
	Tue, 26 Apr 2011 23:27:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vaafdexsp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172128>

Am 26.04.2011 19:18, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com>  writes:
>=20
>> strbuf_grow(sb, 0) may allocate less than requested len and violate =
the
>> next assertion.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gma=
il.com>
>> ---
>>   strbuf.h |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/strbuf.h b/strbuf.h
>> index 07060ce..ab213da 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
>>
>>   static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>>   	if (!sb->alloc)
>> -		strbuf_grow(sb, 0);
>> +		strbuf_grow(sb, len);
>>   	assert(len<  sb->alloc);
>=20
> Wait.  Isn't _setlen() meant to be used only to truncate at the lengt=
h,
> and isn't that clearly documented?
>=20
> I don't think we need this patch at all.

How about something like this instead?  The call to strbuf_grow() was
introduced in a8f3e2219 when there was no strbuf_slopbuf buffer that
nowadays makes sure we always have a place to write an initial NUL.
We can take it out again now, simplifying the code and hopefully
avoiding future confusion.

 strbuf.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 07060ce..b157ede 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -33,9 +33,7 @@ static inline size_t strbuf_avail(const struct strbuf=
 *sb) {
 extern void strbuf_grow(struct strbuf *, size_t);
=20
 static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
-	if (!sb->alloc)
-		strbuf_grow(sb, 0);
-	assert(len < sb->alloc);
+	assert(len < (sb->alloc ? sb->alloc : 1));
 	sb->len =3D len;
 	sb->buf[len] =3D '\0';
 }
