From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sun, 05 Apr 2015 01:23:37 +0530
Message-ID: <55204141.9070100@gmail.com>
References: <551F7984.5070902@gmail.com> <1428126162-18987-1-git-send-email-karthik.188@gmail.com> <xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeU8Z-0001t6-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 21:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbbDDTxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 15:53:43 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36708 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbbDDTxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 15:53:42 -0400
Received: by pdea3 with SMTP id a3so1393182pde.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/TN/ILNwLaMR9zXOlkuay04TR8lxGBhSWb/DeKXGTGg=;
        b=D4ug+ACfFK9S6HBaCM4Ztvoq7TfwcPgpCH5Q20QraPtom0L9c0qXQsQOSSJ0PUJFyM
         lB5WSFSlmJO681CZYEb/wSCmrNmhNXCby+6h/Q/9yay3bhOkXbYUXCr1dCAMeVv/c8Ie
         FhxLTIKTGkgWlP2s9o4YPU6t/r0S9D33iZlO1aWEAq1f0svh8D9oWG0XiYcW1DbV6t3B
         zAMCAZ1te7Gaj9/y3SrkhLF2s/SfibzvVE7hH3nPZJ8i7HOUwIMla/yJU5iCrkvL6ksa
         AfxcnG2B0D8P0KYB+rm5m5FfWYbqugxZUUMwBKQwUX6HUxJ5JtE4WoRYYhXnn1QrQAb+
         GQWA==
X-Received: by 10.66.186.142 with SMTP id fk14mr14567070pac.74.1428177221944;
        Sat, 04 Apr 2015 12:53:41 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id pb2sm51431pdb.33.2015.04.04.12.53.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 12:53:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266781>


On 04/05/2015 01:04 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > @@ -2586,13 +2649,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
> >               *(oi->disk_sizep) = 0;
> >           if (oi->delta_base_sha1)
> >               hashclr(oi->delta_base_sha1);
> > +        if (oi->typename)
> > +            strbuf_addstr(oi->typename, typename(co->type));
> >           oi->whence = OI_CACHED;
> >           return 0;
> >       }
>
> Just before the pre-context of this hunk, there is this bit:
>
>     if (oi->typep)
>         *(oi->typep) = co->type;
>
> which tells me that the callers of this function is allowed to pass
> a NULL in oi->typep when they are not interested in the type of the
> object.
>
> >       if (!find_pack_entry(real, &e)) {
> >           /* Most likely it's a loose object. */
> > -        if (!sha1_loose_object_info(real, oi)) {
> > +        if (!sha1_loose_object_info(real, oi, flags)) {
> >               oi->whence = OI_LOOSE;
> >               return 0;
> >           }
> > @@ -2616,6 +2681,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
> >           oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
> >                        rtype == OBJ_OFS_DELTA);
> >       }
> > +    if (oi->typename)
> > +        strbuf_addstr(oi->typename, typename(*oi->typep));
>
> So, it makes me wonder what guarantee we have that this does not
> dereference a NULL here.
>
As per my code, oi->typename is only pointing to something when oi->typep
is ( As oi->typename is currently only used in cat-file.c).
But what you're saying also is true, there is no other guarantee, as a user may
set oi->typename to point to a struct strbuf and leave out oi->typep.

  if (oi->typename && oi->typep)
          strbuf_addstr(oi->typename, typename(*oi->typep));

This should suffice. Do you want me to re-roll this?
