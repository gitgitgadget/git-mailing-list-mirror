From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: problem with BOINC repository and CR/LF
Date: Sat, 22 Dec 2012 21:54:37 +0300
Message-ID: <CAHkcotjv2EKdzJ3d-2YfFrHe0kv0keq1LVuzGAA5VwYTUTOcvw@mail.gmail.com>
References: <50CEF289.4040503@gmx.de>
	<CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
	<50CF41EB.1060402@gmx.de>
	<CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
	<50D03D80.3090005@gmx.de>
	<50D05E62.7090605@web.de>
	<20121218164132.GC20122@sigill.intra.peff.net>
	<50D5A81B.1000306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmUDp-0005CG-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 19:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab2LVSyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 13:54:39 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45770 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2LVSyh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 13:54:37 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so7761564iea.30
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=K65S8iKrwob/Y+orxmtH8AAoYkYKcpktK2aOA2DkjSY=;
        b=nKFlj/bZbIN7blZJhZNfY2zC87b/9Lo3HUnzCZ4QQhXUNgTEFnEqGEEdKgnSEh2QQc
         pMnz/0tCCEsQWxuibyIcj21pPOLah93I+uRz9ambZ4ilutNstPErXhYNWSpphj6nj4Bm
         v+Hp+wfyFrxvLTrelPU+0gQVf4Irb+5fHeiDB6KJ6y8bRGEkx9FBjCsvQvqg7rcgtDLr
         s0pEwFXVIRu4XPAOXda3FchBWfa5VLF9s4zqsE9JiOmTVI86ttSMBls0aZvMkG4fe3x3
         FL70/SUC0x8Qe/O3bK/JzPPMUQCbrKB6e1/+VKH/SRGXKPyXDaQoxoWuBLXzjRK9w7bY
         7MWA==
Received: by 10.50.11.226 with SMTP id t2mr11682320igb.99.1356202477319; Sat,
 22 Dec 2012 10:54:37 -0800 (PST)
Received: by 10.43.92.194 with HTTP; Sat, 22 Dec 2012 10:54:37 -0800 (PST)
In-Reply-To: <50D5A81B.1000306@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212066>

On Sat, Dec 22, 2012 at 4:31 PM, Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
>
> /me still wonders whether this race condition is a feature or an issu=
e
> in GIT - b/c it means that 2 different people cloning the same
> repository get different results.

The problem is that Git assumes that conversion from git to the worktre=
e
and back produces the same result. Unfortunately, this assumption is no=
t
enforced anywhere and when it is broken by editing .gitattributes, it m=
ay
be difficult to notice that immediately unless you do that trick with
removing the index and "git reset". Perhaps, it would be better if
git considered that timestamps on all files changed if .gitattributes
is changed, so it would check all files for consistence, then anyone
who edits .gitattributes will be forced to fix the file ending to be
consistent.

Anyway, when this underlying assumption is broken, it is easy to get
that race, because git checks only those files for modification that
have its timestamp equal or newer than the index. (The equal timestamp
are inspected for modification, because the timestamp resolution can
be 1 second on some systems.) When you check out some version, some
of files are going to have an older timestamp than the index (and thus
they are not inspected for modification) but those that have the same
timestamp as the index are inspected for modification.


Dmitry
