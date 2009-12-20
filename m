From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Sun, 20 Dec 2009 23:21:53 +0000
Message-ID: <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@virtutech.com>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 00:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMV6G-0004iQ-30
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 00:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbZLTXV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 18:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbZLTXV4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 18:21:56 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:49444 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbZLTXV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 18:21:56 -0500
Received: by fxm21 with SMTP id 21so4271195fxm.21
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5zeoFIVrycggKVV3yykh027HI1WnKrgirnYSHsq957Y=;
        b=bxGZPHMp1ugWDDD3yVD25TGiirrQ+CIjnGzpA/0WDSVT+G0MGp87+9QFMYCFsIdFpi
         2v0fdG9GrjATMSvSmBwKtgZI/Wsf532wJiaEqAscyWf8vcptG/qr00/FW64s6UxpH7iw
         NA+A4hrguS9bplqBx1WJyjVZJsC7imjSC7qtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rtlwx8BxJcX2cuHL8zQ8PScRAQpdaO2Nv91+WW+iCNwAAPacK76gRMCblhXKL/Hs2P
         wl/MgN+NUD2YMjSi4mhPwBjxKgIIT7GHiMjzzzzAUTUyEdRgMgTXcJDU+MoeeHeNowjc
         rurjRxFJQ5czNIRKEFZ+D5ID0qWE5a9U42J5E=
Received: by 10.223.6.9 with SMTP id 9mr8567871fax.84.1261351313902; Sun, 20 
	Dec 2009 15:21:53 -0800 (PST)
In-Reply-To: <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135539>

2009/12/19 Karl Wiberg <kha@treskal.com>:
> On Fri, Dec 18, 2009 at 4:49 PM, Catalin Marinas
> <catalin.marinas@gmail.com> wrote:
>
>> @@ -371,12 +369,10 @@ class StackTransaction(object):
>> =A0 =A0 =A0 =A0 =A0 =A0 # We've just caused conflicts, so we must al=
low them in
>> =A0 =A0 =A0 =A0 =A0 =A0 # the final checkout.
>> =A0 =A0 =A0 =A0 =A0 =A0 self.__allow_conflicts =3D lambda trans: Tru=
e
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0# Save this update so that we can run it a =
little later.
>> - =A0 =A0 =A0 =A0 =A0 =A0self.__conflicting_push =3D update
>> + =A0 =A0 =A0 =A0 =A0 =A0self.__patches =3D _TransPatchMap(self.__st=
ack)
>> + =A0 =A0 =A0 =A0 =A0 =A0update()
>> =A0 =A0 =A0 =A0 =A0 =A0 self.__halt("%d merge conflict(s)" % len(sel=
f.__conflicts))
>> =A0 =A0 =A0 =A0 else:
>> - =A0 =A0 =A0 =A0 =A0 =A0# Update immediately.
>> =A0 =A0 =A0 =A0 =A0 =A0 update()
>>
>> =A0 =A0 def push_tree(self, pn):
>
> Better. But couldn't you remove the update function completely and
> just inline the code in it, since it's called immediately?

Of course, I tried, but couldn't get it to work. I get HEAD and top
not equal unless I call update() between _TransPatchMap and
self.__halt(). For the non-conflicting case we need to call update
before or after this "if merge_conflict".

One solution is to split the "if merge_conflict" in two but maybe you
have a better idea.

Thanks,

--=20
Catalin
