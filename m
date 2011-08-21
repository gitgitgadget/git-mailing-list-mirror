From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 2/2] fast-import: treat cat-blob as a delta base hint for
 next blob
Date: Sun, 21 Aug 2011 21:01:09 +1000
Message-ID: <CAFfmPPNOdCAZxtVHx3Px+ACad4fCdL2Op+3sezf14EMSBqwiJg@mail.gmail.com>
References: <1313867052-11993-1-git-send-email-divanorama@gmail.com>
	<1313867052-11993-3-git-send-email-divanorama@gmail.com>
	<20110820191754.GA22833@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 13:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv5mJ-00069p-5b
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 13:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1HULBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 07:01:14 -0400
Received: from smtp-out.google.com ([74.125.121.67]:33645 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1HULBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 07:01:13 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p7LB1Bwq001770
	for <git@vger.kernel.org>; Sun, 21 Aug 2011 04:01:11 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1313924471; bh=7SAlEPW55ncsy8k7xVRmeMb8n28=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=LBGL5K5w1kjwTDhAxF6f7vDPC1KxKsnMhH4dDI5v4mW6M8Gb9uoqzyslSbI2zMed9
	 b3D5z28Htn9Os6mQAw5pQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=SMsPlUnVTqM7Bjjcp/FtG+kDFWrVXqVMflhUWwt9wA1e0fS3tOygf+l9CXbSuCcqV
	dIYwwYMt9jtWU+bOkWauQ==
Received: from gxk3 (gxk3.prod.google.com [10.202.11.3])
	by wpaz21.hot.corp.google.com with ESMTP id p7LB198r015667
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 21 Aug 2011 04:01:10 -0700
Received: by gxk3 with SMTP id 3so35206gxk.34
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wssFY2Trtr+eTG4cnuakQixW0c8yywo2Mxp3BISdEP0=;
        b=vcjx53Nsx4wmDYc7O9cnUwMKXOs6Wp5+mSWAXYx5LdDYliHDID9NCr3CkYPXQ4ayVc
         7Cjm3C07K1Yi3yx9INkg==
Received: by 10.101.167.27 with SMTP id u27mr1153761ano.95.1313924469842;
        Sun, 21 Aug 2011 04:01:09 -0700 (PDT)
Received: by 10.101.167.27 with SMTP id u27mr1153748ano.95.1313924469597; Sun,
 21 Aug 2011 04:01:09 -0700 (PDT)
Received: by 10.100.106.5 with HTTP; Sun, 21 Aug 2011 04:01:09 -0700 (PDT)
In-Reply-To: <20110820191754.GA22833@elie.gateway.2wire.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179800>

On Sun, Aug 21, 2011 at 5:17 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -2802,7 +2802,12 @@ static void cat_blob(struct object_entry *oe,=
 unsigned char sha1[20])
>> =A0 =A0 =A0 strbuf_release(&line);
>> =A0 =A0 =A0 cat_blob_write(buf, size);
>> =A0 =A0 =A0 cat_blob_write("\n", 1);
>> - =A0 =A0 free(buf);
>> + =A0 =A0 if (oe && oe->pack_id =3D=3D pack_id) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_attach(&last_blob.data, buf, size, =
size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 last_blob.offset =3D oe->idx.offset;
>> + =A0 =A0 =A0 =A0 =A0 =A0 last_blob.depth =3D oe->depth;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(buf);
>> =A0}
>
> Neat. =A0For what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>

Brilliant!

Acked-by: David Barr <davidbarr@google.com>
