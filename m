From: David Barr <davidbarr@google.com>
Subject: Re: [RFC/PATCH 2/3] small-alloc: add allocator for small objects
Date: Fri, 24 Jun 2011 10:02:16 -0700
Message-ID: <BANLkTi=1NhVHMScynVFWxQo2H_mAGq0t1Q@mail.gmail.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
	<1308728011-14136-3-git-send-email-davidbarr@google.com>
	<7vk4cd617u.fsf@alter.siamese.dyndns.org>
	<BANLkTi=34cQvU9oE0gPe=5PFDYfhxoYF+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 19:02:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa9lx-0007gb-M2
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 19:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab1FXRCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jun 2011 13:02:20 -0400
Received: from smtp-out.google.com ([74.125.121.67]:32866 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab1FXRCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2011 13:02:19 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p5OH2IYj008433
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 10:02:18 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308934938; bh=sJkQ4anYcT+G8ySIDbae74KQ7GQ=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=CVdu9SF9HE8SbLALSwBq0uanQx323v/vsnHonYt3w8Do0fxRF6p+v0U3EjStEo+rL
	 9n9TJg4caXIm8P4wx9xpg==
Received: from gwj15 (gwj15.prod.google.com [10.200.10.15])
	by wpaz24.hot.corp.google.com with ESMTP id p5OH2GJq024530
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 10:02:16 -0700
Received: by gwj15 with SMTP id 15so1662154gwj.39
        for <git@vger.kernel.org>; Fri, 24 Jun 2011 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pKkcOZXDPBN0xvIn4kJ+7PJMbOq0xcnKTGilPv7h5q0=;
        b=guiW3y+obOT40VcUn22WeJryfW1LmXWoW7TUiCFXOkdPjiaUGuP9jXP49c/+QPbSCG
         HO/gjbvaQqGa+oR7Nnyw==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jEQj+U44nyZCdXVKcx9/jJ4yQhQVJTimF5tWISHoovWVau8FJokXbCbatXxmMsHc//
         hZgW+LxqDpz8CvIxSjxg==
Received: by 10.100.99.17 with SMTP id w17mr3751997anb.135.1308934936526; Fri,
 24 Jun 2011 10:02:16 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Fri, 24 Jun 2011 10:02:16 -0700 (PDT)
In-Reply-To: <BANLkTi=34cQvU9oE0gPe=5PFDYfhxoYF+A@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176311>

Junio wrote:
> Instead of having two independently depleted byte-buffer (space[] and
> len[]), I wonder if it would be more space efficient (without being l=
ess
> processing efficient) to use a single buffer space. =A0Your pool_ptr(=
) would
> start at the beginning of pool->space[n], decode a varint and take it=
 as a
> length, if that is not the object you are looking for, skip that many
> bytes (i.e. payload immediately follows the length) to the next objec=
t,
> and so on.

David Barr wrote:
> I have already investigated this arrangement, it has very poor
> locality of access.
> For objects <32 bytes long, its not too bad since typically 2 bytes o=
f a 64 byte
> cache line would be read consecutively. For larger objects this is pa=
thological
> cache behavior. On the other hand, the current design means that the =
entire
> sequence of lengths will fit on a single >=3D16 byte cache line.

Another approach is to keep the buffers separate but interleave
pointers and lengths.
I'll give this a go and see if it's an overall improvement.

--
David Barr
