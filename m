From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Fix potential local deadlock during fetch-pack
Date: Tue, 29 Mar 2011 10:30:20 -0700
Message-ID: <AANLkTi=UDPFkox9Gsgv5Bbfsb-VTRweY9D2SNAAhptAc@mail.gmail.com>
References: <7vtyelsvp0.fsf@alter.siamese.dyndns.org> <AANLkTikZ=POeQi5nnt8D9v4Z-_OaXNrXDjP2awWUtKzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:30:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ckh-00043O-QI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab1C2Ram convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 13:30:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52386 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1C2Ram convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 13:30:42 -0400
Received: by vws1 with SMTP id 1so339512vws.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:30:41 -0700 (PDT)
Received: by 10.52.88.12 with SMTP id bc12mr37535vdb.243.1301419841380; Tue,
 29 Mar 2011 10:30:41 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Tue, 29 Mar 2011 10:30:20 -0700 (PDT)
In-Reply-To: <AANLkTikZ=POeQi5nnt8D9v4Z-_OaXNrXDjP2awWUtKzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170286>

On Tue, Mar 29, 2011 at 10:22, Shawn Pearce <spearce@spearce.org> wrote=
:
> On Tue, Mar 29, 2011 at 10:06, Junio C Hamano <gitster@pobox.com> wro=
te:
>> The fetch-pack/upload-pack protocol relies on the underlying transpo=
rt
>> (local pipe or TCP socket) to have enough slack to allow one window =
worth
>> of data in flight without blocking the writer. =A0Traditionally we a=
lways
>> relied on being able to have a batch of 32 "have"s in flight (roughl=
y 1.5k
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D flush_limit;
>
> Nak. You still deadlock because when count reaches PIPESAFE_FLUSH you
> still double it to 2*PIPESAFE_FLUSH here. Instead I think you mean:

I take this comment back. Re-reading fetch-pack.c the next_flush()
method is accepting as input a running counter of how many have lines
have already been sent to the remote peer, and is never reset to 0.
Therefore it is necessary to add the next round size to count and
return it.

--=20
Shawn.
