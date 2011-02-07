From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY
 when appropriate
Date: Mon, 7 Feb 2011 22:23:24 +0100
Message-ID: <AANLkTi=ntgYOW58pPnt-azMw6rFZfJjDW3OaCgLsvJp6@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
 <20110207205400.GF63976@book.hvoigt.net> <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
 <20110207211844.GH63976@book.hvoigt.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:23:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYYp-0004r4-8m
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1BGVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:23:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab1BGVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:23:45 -0500
Received: by fxm20 with SMTP id 20so5363258fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=i9vuSspZ65r1sOnTxpkPWEb11eNXNB/920TVTLnUbzU=;
        b=vfM9yNT9lrLZI8uXu8f/c2NrZt8yUHgETEjEYVc5/OZrnbSYMX45sI4s71tBaApWUZ
         9vkh541e5WUqvafP++V3Bx+lBUdNL0G8gOgd4YqIIMf+N2WDosIKNXvW+lvCzpnd0J9/
         S/k2PzRIXt8YHBGoRVnJXHLJa1L9+E/Gy/7Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=piZ5rH+N7QN8TgzLJ3D5DQvmZMZExyNrsCpvkZ83807V/YeKjaDDuWFLj7zRSqRSSO
         NnxOihqC5oVRkzuJ/uClzyoXsVa1eZbD+A362ztMojjkP1ZBucrvrFcX6U6iWCIIqrNt
         zxdv95an0xbJ0Zb2E69TTPUMo4L5IeHwb5VoM=
Received: by 10.223.86.193 with SMTP id t1mr10523070fal.147.1297113824596;
 Mon, 07 Feb 2011 13:23:44 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 13:23:24 -0800 (PST)
In-Reply-To: <20110207211844.GH63976@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166298>

On Mon, Feb 7, 2011 at 10:18 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, Feb 07, 2011 at 10:07:10PM +0100, Erik Faye-Lund wrote:
>> On Mon, Feb 7, 2011 at 9:54 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
>> > directory is busy, we only want to retry deleting the directory if it
>> > is empty, so test specifically for that case and set ENOTEMPTY rather
>> > than EACCES.
>> >
>>
>> I'm sorry, I don't quite understand. rmdir on Windows/MinGW fails with
>> errno=ENOTEMPTY if a directory isn't empty:
>
> I think Johannes was referring to the case when a directory is busy.
> E.g. a process is running that has its working directory inside that
> directory. In that case ENOTEMPTY was not returned even though the
> directory is not empty. Thats what I read from the patch.
>

I don't think that's the case either:
$ echo "int main() { while (1); }" | gcc -x c - -o foo/bin.exe
[kusma@HUE-PC:/git@work/xgetenv]
$ foo/bin.exe &
[2] 3188
[kusma@HUE-PC:/git@work/xgetenv]
$ ./a.exe
rmdir: Directory not empty
errno: 41 (expected 41)
