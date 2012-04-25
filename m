From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Possible segfault introduced in commit.c
Date: Wed, 25 Apr 2012 22:22:34 +0200
Message-ID: <4F985D0A.9020100@lsrfire.ath.cx>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com> <20120425111435.GA21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Mueller <mmueller@vigilantsw.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN8jx-0007ow-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 22:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756Ab2DYUW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 16:22:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:57244 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab2DYUW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 16:22:59 -0400
Received: from [192.168.2.105] (p4FFDBB95.dip.t-dialin.net [79.253.187.149])
	by india601.server4you.de (Postfix) with ESMTPSA id CA7F82F8047;
	Wed, 25 Apr 2012 22:22:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <20120425111435.GA21579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196334>

Am 25.04.2012 13:14, schrieb Jeff King:
> On Wed, Apr 25, 2012 at 12:59:28AM -0700, Michael Mueller wrote:
>
>> As you might already know, we analyze git regularly with Sentry (our
>> static analysis tool).  Today it picked up a new NULL pointer
>> dereference in commit.c:366:
>>
>>      void commit_list_reverse(struct commit_list **list_p)
>>      {
>>          struct commit_list *prev =3D NULL, *curr =3D *list_p, *next=
;
>>
>>          if (!list_p)
>>              return;
>>          /* function continues... */
>>      }
>>
>> list_p is dereferenced on the first line, then tested for NULL on
>> the very next statement.  If it's possible that list_p is NULL, this
>> will be a segfault.  If it can't be NULL, then the check is
>> unnecessary (and probably misleading).
>
> Yes, you're right. There is only one caller currently, and it can nev=
er
> be NULL (it passes the address-of a pointer variable). I think droppi=
ng
> the NULL-check is the right thing; even an empty list will still have=
 a
> pointer to its NULL head.

More often then not, a mistake like that is surrounded by other issues.=
=20
  No, I didn't put it there intentionally to prove this point. ;-)

Having to reverse the list at all is unfortunate and I only did that=20
because I thought appending would be more complicated and because we ar=
e=20
going to replace the linked list with a different data structure soon=20
anyway.  Turns out appending is easy.  Patches to follow.

Ren=C3=A9
