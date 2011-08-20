From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v4] fast-import: do not write bad delta for replaced subtrees
Date: Sun, 21 Aug 2011 00:28:34 +0600
Message-ID: <CA+gfSn_G0Q8=NsLr_Qku+oHwgkzBXajHpebLVT2SG4YDUUZD-g@mail.gmail.com>
References: <20110820154356.GB15864@elie.gateway.2wire.net>
	<1313860946-1596-1-git-send-email-divanorama@gmail.com>
	<20110820174812.GD15864@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 20:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuqHg-00062v-14
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab1HTS2f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 14:28:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36550 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1HTS2f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 14:28:35 -0400
Received: by qwk3 with SMTP id 3so2455881qwk.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cOeFrwaK8Wit+afd2JjZUjDjY7iPVMeUEAc7U7+W0HE=;
        b=d57JJSr5Ya76megVxyvcsz1PD5tU5Cpuzh1SzFtEZi7wsNpIbkEUjRJV9hNc6axwOC
         mB4wzavitsIBjvtAiJUNEf9wt7LOeZbQRKwhbl1fBVJtJ3jlA3WYN3SvgYUkQQ5oo1VL
         zvMQXWj8D1n6A0RPG/5YdSx9huB5ah0eFBp5s=
Received: by 10.229.67.11 with SMTP id p11mr337693qci.49.1313864914179; Sat,
 20 Aug 2011 11:28:34 -0700 (PDT)
Received: by 10.229.138.71 with HTTP; Sat, 20 Aug 2011 11:28:34 -0700 (PDT)
In-Reply-To: <20110820174812.GD15864@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179769>

On Sat, Aug 20, 2011 at 11:48 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Dmitry Ivankov wrote:
>
>> How about adding a new bit field "no_delta" instead?
>
> Currently the layout of "struct tree_entry_ms" is:
>
> =A0 =A0 =A0 =A0uint16_t mode; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0two =
bytes
> =A0 =A0 =A0 =A0unsigned char sha1[20] =A0 =A0 =A0 =A0 =A020 bytes
>
> which adds up to 22 bytes. =A0Here is "struct tree_entry":
>
> =A0 =A0 =A0 =A0struct tree_entry *tree; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
one machine word
> =A0 =A0 =A0 =A0struct atom_str *name; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0one machine word
> =A0 =A0 =A0 =A0struct tree_entry_ms versions[2]; =A0 =A0 =A0 44 bytes
>
> Although it only looks like it adds one byte per tree entry, in
> practice I suspect your patch adds four. =A0Is that worth it? =A0(The
> answer might be yes. =A0I'm not sure.)
Hm, we can make mode 1 byte in fast-import (only 8 values are used).
But not in this patch of course.

>
>> The patch is
>> smaller this way. Also could 04000 theoretically be S_IFDIR on some
>> platform?
>
> No, these modes are part of the format of objects as written on disk
> and over the wire, so when we meet a platform with S_IFDIR !=3D 04000=
0,
> there will have to be bigger changes (to distinguish between the
> platform's idea of file status and git's idea of modes).
>
>> - switch to a separate no_delta bit in tree_entry
>
> If it doesn't cost too much, this is a good idea.
>
>> - when setting no_delta =3D 1 don't check for S_ISDIR(versions[0].mo=
de),
>> =A0 this is a redundant check and logic duplication. Who knows, mayb=
e some
>> =A0 day we'll want to delta a tree against blob. :)
>
> Why? =A0When versions[0] is not a tree, the hack is not needed, since
> versions[0].mode and versions[0].sha1 accurately describe the delta
> base and are not inconsistent with anything.
Oh, right you are. The new check and one in store_tree look the same
but the purpose differs.

>
> Thanks, that was helpful.
>
