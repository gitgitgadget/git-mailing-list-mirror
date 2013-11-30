From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 12/24] read-cache: read index-v5
Date: Sat, 30 Nov 2013 21:27:01 +0100
Message-ID: <87li05y6sq.fsf@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-13-git-send-email-t.gummerer@gmail.com> <CALWbr2xUMHSU0MV-6nVbN4_eSMoj3Eyc_Ta_CxTwZ_Y8tLfbdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	robin.rosenberg@dewire.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 21:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmr87-00048D-2E
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 21:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3K3U1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 15:27:03 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:45241 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3K3U1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 15:27:01 -0500
Received: by mail-lb0-f176.google.com with SMTP id x18so7724411lbi.35
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=Oyl7ZWIOqCmVH+vjW/2+/4ItUFclGGuTWFoC6vbeVbs=;
        b=qSF6sAwUaCq5xKZ8koELQRt3Dq0sTaK4ebUF3KcQ3nbFOpiPY2lRcXhFQ/ceiGssB2
         cbepN1tmE1J19kGTYeeBSksSFjZkHpdVpmZy55F2ChgKZrwnfRjg3a5+4ttnPKuJBul2
         G+k17BVeg31d97FeMZ2az8rYZ1V9uXNA/hywZlIY0lgL2IF9+BR0JskTjp4WbzClJ36G
         irq2ZiXlSjaSnlmQVI+/SvF2MOiW0636wpss+zahcvqPKRyq4TWCW+HHB0//3HzRhrG7
         SHysMnrG/fWCnWx3a5phjQgNl4OpQjLtErTz2Bb2dcOhNDqX5bCS7nFTfb8aspO2khaS
         0tTw==
X-Received: by 10.152.4.230 with SMTP id n6mr39962486lan.1.1385843219922;
        Sat, 30 Nov 2013 12:26:59 -0800 (PST)
Received: from goose.tgummerer.com (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id l10sm57823040lbh.13.2013.11.30.12.26.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2013 12:26:59 -0800 (PST)
In-Reply-To: <CALWbr2xUMHSU0MV-6nVbN4_eSMoj3Eyc_Ta_CxTwZ_Y8tLfbdQ@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238571>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static int verify_hdr(void *mmap, unsigned long size)
>> +{
>> +       uint32_t *filecrc;
>> +       unsigned int header_size;
>> +       struct cache_header *hdr;
>> +       struct cache_header_v5 *hdr_v5;
>> +
>> +       if (size < sizeof(struct cache_header)
>> +           + sizeof (struct cache_header_v5) + 4)
>> +               die("index file smaller than expected");
>> +
>> +       hdr = mmap;
>> +       hdr_v5 = ptr_add(mmap, sizeof(*hdr));
>> +       /* Size of the header + the size of the extensionoffsets */
>> +       header_size = sizeof(*hdr) + sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
>> +       /* Initialize crc */
>> +       filecrc = ptr_add(mmap, header_size);
>> +       if (!check_crc32(0, hdr, header_size, ntohl(*filecrc)))
>> +               return error("bad index file header crc signature");
>> +       return 0;
>> +}
>
> I find it curious that we actually need a value from the header (and
> use it for pointer arithmetic) to check that the header is valid. The
> application will crash before the crc is checked if
> hdr_v5->hdr_nextensions is corrupted. Or am I missing something ?

Good catch, I'm the one that was missing something here.  We still need
to use the value from the header before calculating the crc, but should
check if header_size - 4 is less than the total size of the index file.
Then even if the header is corrupted we won't read anything that is not
mmap'ed and thus won't crash.

This guard should also be included for everything else that checks the
crc checksum, as that has the same problems and the calculated place in
the file for the crc might be after the end of the file.

Thanks, will fix in the re-roll.
