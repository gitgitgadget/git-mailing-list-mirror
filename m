From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 3 Apr 2012 19:28:41 +0700
Message-ID: <CACsJy8AbRsVq0b=K+=vqfpQOMuduNBDwignfAiiV+cvpFeS3jQ@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <italyhockeyfeed@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 03 14:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF2rQ-0004PA-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 14:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab2DCM3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 08:29:13 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61733 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2DCM3M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 08:29:12 -0400
Received: by wgbdr13 with SMTP id dr13so3688523wgb.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QAl8IYo9t28yznbx5O+/GTAR03ay9jRKbmitMOvZz1k=;
        b=pjqaFH7N5xDtC3376IlxYYyXxACBOaM2OKiFtONjkDgobVMMbAn3yANvHB3VvfX1Be
         Uah0TrsLlr45kcE6mQeT0tSvOLjBCwQA6QIun54soFTcD5TdJ0EgvEMd+AMDht7aEeeV
         zdncx4iQG2hBdN+5O7RceptBY7A8FicwcjLH51lv3BNI83rcMZKRCc3Z9NEs/oCHEET2
         3wt3BROAwIMNoltEkXpmxd0ULku4t2MTHdWDOJnXXkhO7ZyWHecfV8Ti0pn0ODgueZp8
         IYreYsAABGJS06xPflVgdCp7H/0LOhNkm8Arg+WTbT/oknj4wH7bPMrX0wY93wodnpCT
         vk0w==
Received: by 10.180.85.35 with SMTP id e3mr5953819wiz.6.1333456151676; Tue, 03
 Apr 2012 05:29:11 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 3 Apr 2012 05:28:41 -0700 (PDT)
In-Reply-To: <4F7ABA19.7040408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194617>

On Tue, Apr 3, 2012 at 3:51 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
>> -- Proposed solution --
>> The proposed solution is to redesign the index to a B-tree based for=
mat. This
>> allows changes to the index in O(log(n)) time, with n being the numb=
er of
>> entries in the index.
>
> I thought that the index lock currently only blocks writers, not read=
ers
> (am I wrong?).

I think you are right.

> So given that you want to be able to mutate the index
> file without rewriting the whole file, it seems to me that you have t=
o
> pick from one of these alternatives:
>
> 1. Change the locking semantics so that readers also block when the f=
ile
> is locked. =C2=A0This choice would have some important consequences: =
(a)
> readers will also have to obtain a lock before starting to read. =C2=A0=
(b) to
> avoid deadlock, it will become crucial that the lock is never held
> across the execution of any other git (sub-)commands that might want =
to
> read the index.
>
> 2. Implement a file format that can be read even while it is being
> mutated. =C2=A0If so, please explain the data file format in more det=
ail; in
> particular, how do you plan to mutate the file in a way that does not
> disturb readers? =C2=A0How do you plan to read the whole index effici=
ently (I
> imagine that reading the whole index will remain a frequent operation=
)?

Copy-on-write B-trees, aka btrfs. Does anybody like to go that route ;)

> I encourage you to include an analysis of the number of disk seeks wh=
en
> you are analyzing the cost of read/write operations on the index. =C2=
=A0This
> will have a strong effect on the time for working with the index when
> the disk cache is cold. =C2=A0The current index requires O(1) seeks f=
or
> reading and writing, which I believe is a big part of the reason that
> the current read-the-whole-index/write-the-whole-index design perform=
s
> excellently despite the amount of data that it is touching.
--=20
Duy
