From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/32] move do_compress() from pack-objects.c to pack-write.c
Date: Wed, 25 Aug 2010 13:19:26 +1000
Message-ID: <AANLkTi=-90e8c5Wi2TYWnAxsWvRMx_PjJZHhhRuSuRwb@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-5-git-send-email-pclouds@gmail.com>
	<20100824232554.GF2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo6WU-0002Gq-3R
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab0HYDT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 23:19:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39630 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0HYDT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 23:19:28 -0400
Received: by wwb34 with SMTP id 34so247711wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6vqk8fUJsISAQBOO3wvWzdxABAu8StUKmsAXmEFnElo=;
        b=Mc07OPuN6dhyMgzGa08UJdqTTHuIh5tnrJLPTpqxE4X9rG6kDKOi3PjD1cLruz2lP+
         y29LiAVX8ImY1+oycKT727zyiFb3eD4++MQ9dUctIZLTRByN28mN+3X4IWnLt75gic/z
         T+aJyDSbh6VQ2T2znW83aR+Ofk2AnEFDQoq/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N16D/2SVzZcalBmev4z8bIQ/i35iG9scAj/jtcxPU3d5t+/3Z/GQX6q+Qqq9e6fvWI
         sZUie9eyvKtM1xAxfak3mHCcOvah/h4nszzPHBnFopDsd1IKPa5HiWqFnZOMn33cs/Wa
         Q6bMFIxwUwz9j2FhXOeGP91g/DZeyFKMtGTbs=
Received: by 10.216.234.93 with SMTP id r71mr251849weq.104.1282706367005; Tue,
 24 Aug 2010 20:19:27 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 20:19:26 -0700 (PDT)
In-Reply-To: <20100824232554.GF2376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154404>

On Wed, Aug 25, 2010 at 9:25 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> +unsigned long compress_object(void **pptr, unsigned long size)
>> +{
>> + =C2=A0 =C2=A0 z_stream stream;
>> + =C2=A0 =C2=A0 void *in, *out;
>> + =C2=A0 =C2=A0 unsigned long maxsize;
>> +
>> + =C2=A0 =C2=A0 memset(&stream, 0, sizeof(stream));
>> + =C2=A0 =C2=A0 deflateInit(&stream, Z_DEFAULT_COMPRESSION);
>> + =C2=A0 =C2=A0 maxsize =3D deflateBound(&stream, size);
>> +
>> + =C2=A0 =C2=A0 in =3D *pptr;
>> + =C2=A0 =C2=A0 out =3D xmalloc(maxsize);
>> + =C2=A0 =C2=A0 *pptr =3D out;
>> +
>> + =C2=A0 =C2=A0 stream.next_in =3D in;
>> + =C2=A0 =C2=A0 stream.avail_in =3D size;
>> + =C2=A0 =C2=A0 stream.next_out =3D out;
>> + =C2=A0 =C2=A0 stream.avail_out =3D maxsize;
>> + =C2=A0 =C2=A0 while (deflate(&stream, Z_FINISH) =3D=3D Z_OK)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; /* nothing */
>> + =C2=A0 =C2=A0 deflateEnd(&stream);
>> +
>> + =C2=A0 =C2=A0 return stream.total_out;
>> +}
>
> However, there is nothing particularly specialized to git objects
> about this. =C2=A0e.g. deflate_it() from diff.c could use this.

Also archive-zip.c, fast-import.c, http-push.c and remote-curl.c have
very similar code. I'll see if I can reduce some code duplication.
--=20
Duy
