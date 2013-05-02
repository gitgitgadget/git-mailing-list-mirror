From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict
 for connectivity check
Date: Thu, 2 May 2013 16:53:16 +0700
Message-ID: <CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com> <1367405974-22190-5-git-send-email-pclouds@gmail.com>
 <7vvc722s0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 11:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqD1-0003GP-M4
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 11:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab3EBJxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 05:53:47 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:44302 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3EBJxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 05:53:46 -0400
Received: by mail-ob0-f172.google.com with SMTP id xk17so304978obc.17
        for <git@vger.kernel.org>; Thu, 02 May 2013 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=C/s1FKHdDL81rkI1Pb81jFGqpj6EzxrHfGdXUPhad74=;
        b=ofC3BDM5mJ2lo6sqDD8XJ4Newq+6LyePLNO6E9TI08bHuns/1BRpB1AounxtSCquzU
         51tBEjFfG1apL21iuovF37iaKiLj7vddfpjxAbNO7IxCxqvRKwkvCBHoln4mxLx/Eh8x
         50WII0jtFR4BuUIqNAaXa/qo1ctadSBevpnCkXw6R9iEjcml90S63DQN/Rt9ERyGBiFF
         PjZTuOK6d9ogjItSc5Ht8NM3gnzCIBGidSQRmTeCcIXmlHOLSdq/OYN5GIx4KNM/ooCU
         AnJQnEZ2c80RLudntlgTKxowOGdQnuASckKtywS5WUEpKsJdRISLfhHBIEqdFSdVyHdQ
         6uYw==
X-Received: by 10.60.124.81 with SMTP id mg17mr1576791oeb.117.1367488426232;
 Thu, 02 May 2013 02:53:46 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 02:53:16 -0700 (PDT)
In-Reply-To: <7vvc722s0h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223186>

On Thu, May 2, 2013 at 6:35 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> --not-so-strict only checks if all links from objects in the pack
>> point to real objects (either in current repo, or from the pack
>> itself). It's like check_everything_connected() except that:
>>
>>  - it does not follow DAG in order
>>  - it can detect incomplete object islands
>
> Could you clarify what this second point means?
>
> "rev-list --objects --all --not $this $that" does not detect
> "islands" but checking with the updated index-pack does?

Object islands (in the new pack) by definition are not connected to
the main DAG and so invisible to/unreachable from rev-list. index-pack
examines all objects in the pack and checks links of each object. With
this approach, islands are no different than reachable objects.

>>  - it seems to be faster than "rev-list --objects --all"
>
> More important is that it makes sure that it is safe to update our
> refs to the new value, just like the check this attempts to replace.
> If that is not the case, the speed does not matter.
>
> I am guessing that the code assumes that we are updating our refs to
> objects that are in the pack that we are looking at, and I can see
> how the new check in sha1_object() may detect an object that points
> at another object that is missing.  But that assumption (which I
> think is correct) is probably the most important thing to say in the
> log message.

Yes, we need to make sure the new value of our refs are existing
objects. But it does not need to be in the new pack. After index-pack
is run, we're guaranteed that all objects in repo are connected and
any of them could be new ref. This is also why I add has_sha1_file()
in clone.c. I forget if I have checked for similar call in fetch.c and
receive-pack.c. Will look again (and update log message)

>> +--not-so-strict::
>
> Perhaps "--check-connectivity" is a better name than this?

Definitely.
--
Duy
