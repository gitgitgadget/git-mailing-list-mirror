From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Index format v5
Date: Tue, 8 May 2012 21:34:30 +0700
Message-ID: <CACsJy8DmhcFHOOToEWLoHNRJtXHe8EOnKfOn4+kOMBaW=tyWBw@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <CACsJy8CUC8AXYvDEH75NGC_r3HwLoaiq0qxn2EAC0Aq4VXVMag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRlVO-0008Kg-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab2EHOfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 10:35:04 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53082 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415Ab2EHOfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 10:35:03 -0400
Received: by wibhj6 with SMTP id hj6so756038wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YayV8Owz6E9tAG+aTOJLp9JgVoq4s1Shmh9dHEfIajc=;
        b=BGY1KghwtCGGBxC9wYt5/uQywnJleUCU1amVzaN55PH29yOH3McFefUYZVWrWutDhZ
         YBxT2iFci5+msf8bnCKkg0++BvQqychJJt1nhfi56cPH0urJ7G+PUpz7eMQoQpZwgqik
         K5nsMJ1m6gxsUtyxv4hATjzIm7Jez62wirlORU9A4+SrTgXWNGFP5V254RggARnK+kKs
         cv7lJlFzl2k6UzqgCtdhAB5QfJ6JMijM+ErvMtL3byQ+o3wFnR2o7Oph6zZIrBjav+w1
         yk+9IGRkdj+LqYIk+zpWnXuRFPVTiyCdglhseteWvxBABoG/x3gZvDhfTYX/ktgAd9Br
         Rmtw==
Received: by 10.216.145.153 with SMTP id p25mr12432419wej.112.1336487700261;
 Tue, 08 May 2012 07:35:00 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Tue, 8 May 2012 07:34:30 -0700 (PDT)
In-Reply-To: <CACsJy8CUC8AXYvDEH75NGC_r3HwLoaiq0qxn2EAC0Aq4VXVMag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197370>

Sorry I replied too fast.

On Tue, May 8, 2012 at 9:25 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Tue, May 8, 2012 at 9:11 PM, Thomas Gummerer <t.gummerer@gmail.com=
> wrote:
>>> * "160-bit object name for the object that would result from writin=
g
>>> =C2=A0 this span of index as a tree." =C2=A0Is this always valid?
>>
>> No, this is only valid if the entry count is not -1. It's clarified
>> now.
>
> ..and..
>
>> The entry_count in the index is only valid, if the cache-tree is val=
id,
>> which is not always the case.
>
> I think your trees are the cache-trees already. For invalid
> cache-trees, you can just use all-zero sha-1 as the indicator. Then
> entry_count can go away.

=46urthermore, in directory entry format:

  The last 24 bytes (4-byte number of entries + 160-bit object name) ar=
e
    for the cache tree. An entry can be in an invalidated state which i=
s
    represented by having -1 in the entry_count field. If an entry is i=
n
    invalidated state, the next entry will begin after the number of
    subtrees, and the 160-bit object name is dropped.

Dropping objname out of invalid (cache-)trees is a bad idea. When you
generate tree objects (aka cache_tree_update), you'll need objname
field again, which means structure change and directory entry rewrite.
If objname is always there, you can just overwrite objname with new
value. Though this may bring race condition issue back to directory
entries. The same approach on file entries might be reused.
--=20
Duy
