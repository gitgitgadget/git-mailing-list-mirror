From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 0/5] Speed up string search routines
Date: Sun, 14 Feb 2010 17:47:05 +0100
Message-ID: <4c8ef71002140847i19b64b21ocfa71658a49d97b5@mail.gmail.com>
References: <20100213142014.GA9543@fredrik-laptop>
	 <7vk4uhklxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nghcq-0002U9-7b
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0BNQrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 11:47:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:45792 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab0BNQrI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 11:47:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so217110fgg.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CsnwYVf6kE5BiwnDvb36eSQ4o8WrTlPPM/dYB9mLPcw=;
        b=Cw+IFfShpsju6dmYSfpchiGkNY4OeRahglaz9vfjLXPHhRfjKOLoxkfjSUqIdkN8LI
         JTTmi2Zw5XbJkgTF5HV4RTgmOG5ePs7D9ujEA81g/HP9bQE/VvUQvTIf6PDO4P2/1V3u
         CGCw0fORtT5l1zjNN+ZwmhAA3K+djGYkPTUWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LS8WQHZLKEc4Ec/yqTaBY3ST1qved8RMmmpCHLi2dwrNDukI+8W9Az9LvkTrPYZNMf
         7cE2oKd2NHdQZhfIXtk22z2oOzc4LpRyJ8WM45TdVsr0G5BUjULdA8f7pWFCTrFnhc5c
         uBadyPje9oLJCUs4S2DiDZNO6T11fKefLtytI=
Received: by 10.239.161.76 with SMTP id g12mr414706hbd.182.1266166025117; Sun, 
	14 Feb 2010 08:47:05 -0800 (PST)
In-Reply-To: <7vk4uhklxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139925>

On Sat, Feb 13, 2010 at 19:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> Fredrik Kuivinen <frekui@gmail.com> writes:
>
> It needs to be a bit more friendly to readers of "git log" and
> ReleaseNotes by hinting why use of kwset is beneficial (e.g. "use kws=
et
> instead of memmem to find fixed string more efficiently") in the comm=
it
> titles.

Will fix in the next iteration.

> Shouldn't obstack.[ch] be in compat/ so that people on platforms wher=
e
> they are natively available do not have to compile our own copies?

There is code in obstack.c to check if we are using gnu libc or not.
If gnu libc is used, then ELIDE_CODE is defined and no code from
obstack.c is compiled.

> It is somewhat curious that you gave numbers for only negative case i=
n
> pickaxe test and numbers for only positive case in grep test. =A0Does=
 this
> conversion have some interesting performance charasteristics such as
> penalizing positive-match case to speed up negative-match case or vic=
e
> versa (the earlier "grep lookahead" work had that effect, even though=
 the
> downside was really small)?

I did some more benchmarking. In the extreme case when we are looking
for ' ' (i.e., a single space) with pickaxe the new code is actually
slightly slower than the old one.

before:

$ time git log -S' ' > /dev/null

real	0m32.908s
user	0m32.258s
sys	0m0.652s

after:

$ time ./git-log -S' ' > /dev/null

real	0m34.072s
user	0m33.418s
sys	0m0.656s

However, with longer strings the new code wins (the new code wins when
we are searching for two spaces).

grep gets a significant performance increase for all strings I have
tried, it doesn't matter if there are no matches or a lot of matches.

Thanks for the comments.

- Fredrik
