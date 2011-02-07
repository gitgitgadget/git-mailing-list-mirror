From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY when appropriate
Date: Mon, 7 Feb 2011 22:07:10 +0100
Message-ID: <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
 <20110207205400.GF63976@book.hvoigt.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYJ8-0003mA-7z
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab1BGVHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:07:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44232 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab1BGVHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:07:32 -0500
Received: by fxm20 with SMTP id 20so5348891fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=8bpZVSmHtuRKdSrKF3fdAnma25fTc54g2fiWweV/4UE=;
        b=aDE6uNJ67usIzuB/rIoQ1PAq6vMeQoPAE15xWi2mnUPp/6bO+pG6J5IgnhKn287dFK
         tnzc+zK5kJ2CpKtY1KnryO/eUbanTzNsM1a551xq3nsTb6VrioWpT/2cYa/A/1JTrXa9
         4bVBYWnI5MsI3XmrZsPUIC7dwqMPJr05fEYSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=wAy5r6hV6Inpbn+JMoc37AkRXmnr5JBQ42sdXZlIW3I3nxXO/rSVdo92HoQdI3S7Z1
         IWuJeWQ/Egd17muycnE68NpIfsjncpsvSlwYesz31XlI7qWXdrMr+0/zAqJJFgyZOw+9
         F4K5BZouhsZviE04iipgs0xMVa+INABVAQSWg=
Received: by 10.223.87.80 with SMTP id v16mr15590058fal.128.1297112850652;
 Mon, 07 Feb 2011 13:07:30 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 13:07:10 -0800 (PST)
In-Reply-To: <20110207205400.GF63976@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166294>

On Mon, Feb 7, 2011 at 9:54 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
> directory is busy, we only want to retry deleting the directory if it
> is empty, so test specifically for that case and set ENOTEMPTY rather
> than EACCES.
>

I'm sorry, I don't quite understand. rmdir on Windows/MinGW fails with
errno=ENOTEMPTY if a directory isn't empty:
---8<---
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
	if (mkdir("foo") < 0 && errno != EEXIST) {
		perror("mkdir");
		exit(-1);
	}

	if (!fopen("foo/bar", "w")) {
		perror("fopen");
		exit(-1);
	}

	if (rmdir("foo") < 0)
		perror("rmdir");
	printf("errno: %d (expected %d)\n", errno, ENOTEMPTY);
}
---8<---
$ ./a.exe
rmdir: Directory not empty
errno: 41 (expected 41)
