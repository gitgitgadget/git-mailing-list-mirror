From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Toy PATCH] Avoid spilling collided entries in object hash table
 to the next slots
Date: Sat, 30 Mar 2013 07:38:07 +0700
Message-ID: <CACsJy8Atw3wBCboXsS2MTj80T91A5zDXdXBjgJnmZx8G67O4xQ@mail.gmail.com>
References: <1364568469-2250-1-git-send-email-pclouds@gmail.com> <7vd2uip1p4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 01:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULjp4-0005ma-9j
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 01:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab3C3Aii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 20:38:38 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:63369 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab3C3Aih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 20:38:37 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so752574oag.30
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=yl0X7GDr/tAp6DzzOu57QWp0oorOdl6+wOFoj9VbD6o=;
        b=YzJu0549JahAvYkrwRAzdVbQEtIpHUxlWDFMxOYtbTHJQvs5cK3tkBicHqwvZ8cAlV
         m9E3YbzO4QLVso2GZZ/aUpet9xZdqZ3UXvS5N7rQ2ig9fV1waMd3D+YBv4zuVuAKURee
         LoLbWw3y8B3/AplDrA2ZHNCbOpr2pvKq935cROXCeA8LcpwkRFo9f+s1lLVnKzrPiJ4Q
         qRaC9pd+eGeSSbreZyd5J5zDvrIgtlMSqwehKg487xl6LTcYhuQQ5XyqvrCXwJpFUxWm
         2gZY92xViH2zMjF2FPlw3WwkD8TLjyhfWFOq7ex4pV2YhEd+l/xZ5WagUKWfS6AvngOi
         3JoQ==
X-Received: by 10.182.8.70 with SMTP id p6mr1400288oba.90.1364603917119; Fri,
 29 Mar 2013 17:38:37 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 29 Mar 2013 17:38:07 -0700 (PDT)
In-Reply-To: <7vd2uip1p4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219547>

On Sat, Mar 30, 2013 at 12:15 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> If a position in object hash table is taken, we currently check out
>> the next one. This could potentially create long object chains. We
>> could create linked lists instead and leave the next slot alone.
>
> In the current code, not just the logic in lookup_object(), but the
> logic to enforce load factor when create_object() decides to call
> grow_object_hash() and object enumeration implemented by
> get_max_object_index() and get_indexed_object() are closely tied to
> the open addressing scheme.  If you want to switch to any other
> method (e.g. separate chaining) these need to be updated quite a
> bit.
>
> I do not see get_max_object_index() and get_indexed_object() updated
> at all.  Do fsck, index-pack, name-rev and upload-pack still work?

No, apparently not. I should have been hit hard by not updating
grow_object_hash(). But I think it was ok because I was on top of my
preallocation patch and there probably were not many chains before
that patch kicked in.

> This particular implementation that uses a fake "union" is a bit
> ugly, but in general, it may be worth rethinking the object hash
> implementation.  I vaguely recall trying cuckoo in the vicinity of
> this code.

Yeah I saw that. Need to read and maybe try again some time. Still
playing with the linked list idea. If every time we find something in
a chain, we swap it to top (with hope it'll be accessed more often),
then the number of traversing in chains goes down from 33m times to
21.5m times. If we just push it up one node in the linked list, it's
21.3m times. Interesting.
--
Duy
