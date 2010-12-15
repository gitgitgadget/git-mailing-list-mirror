From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 0/5] make open/unlink failures user friendly on windows
 using retry/abort
Date: Wed, 15 Dec 2010 16:52:17 +0100
Message-ID: <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
References: <20101214220604.GA4084@sandbox>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PStel-00045n-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab0LOPwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:52:40 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:43652 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0LOPwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 10:52:39 -0500
Received: by fxm18 with SMTP id 18so2194621fxm.2
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=O9oyh4Nh3PjAnEKX5qsaj80t3sHrcYlGqFR4fDbLLmw=;
        b=Wn0gZfIqtTNsll4EM7vPgxeh3czIDAv0RSj49K9Bk291oW/QBiR9Kq572TIp9HS9Mz
         /yCTA0kwhZKm7+VmoZ/HrMIJLJN59zriz3b90UwUX5KaGINUzCBBwRp1BgOOqzQorDu5
         weuP482gfOnSgm9j+LjMKM4jb4o3CNxFjGYb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=XzWTgoXpjzgDOJQPfmHoPsKosWXQvorL/HkUJGmmrYOU2eoa659dUSFV7qMK3AUkIB
         RX7c38SFTay71JvP1leEm//atdV2D553nWqmdHRyrzln3ouIM0OhjLTi/X7n03xKC8qo
         LW1PdVfWHRGiF4n01RzHxClMuB8s+d4rtln8k=
Received: by 10.223.83.11 with SMTP id d11mr901157fal.37.1292428358014; Wed,
 15 Dec 2010 07:52:38 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Wed, 15 Dec 2010 07:52:17 -0800 (PST)
In-Reply-To: <20101214220604.GA4084@sandbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163786>

On Tue, Dec 14, 2010 at 11:06 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
> Hi,
>
> On Wed, Nov 10, 2010 at 09:32:00PM +0100, Johannes Sixt wrote:
>> On Dienstag, 9. November 2010, Heiko Voigt wrote:
>> > So it seems that unlink also has the problem of getting an
>> > ERROR_ACCESS_DENIED (Code 5) sometimes. Johannes would you agree t=
hat
>> > including this code into the is_file_in_use_error() function and t=
hus
>> > having the potential risk of a 71ms delay for real access denials =
for
>> > these calls makes sense?
>>
>> Of course, it matches my own observations.
>
> Sorry for the delay. Here is finally a new iteration of the patch
> series. I hope I have addressed all raised issues. An extra pair of e=
yes
> is appreciated.
>
> This series has been ported to Junios tree.
>
> I also added one patch from Johannes which I think should be part of
> this series.
>
> Cheers Heiko
>
> Heiko Voigt (4):
> =A0mingw: move unlink wrapper to mingw.c
> =A0mingw: work around irregular failures of unlink on windows
> =A0mingw: make failures to unlink or move raise a question
> =A0mingw: add fallback for rmdir in case directory is in use
>
> Johannes Schindelin (1):
> =A0mingw_rmdir: set errno=3DENOTEMPTY when appropriate
>
> =A0compat/mingw.c | =A0172 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++-
> =A0compat/mingw.h | =A0 14 ++---
> =A02 files changed, 177 insertions(+), 9 deletions(-)
>

I like the goal of the series (and enjoy the end-result on mingw), but
the more I think of this the more I wonder if this is solving the
problem on the wrong abstraction level.

POSIX says that unlink et al can set errno to EBUSY if a file is in
use and the implementation considers that an error. I suspect they had
a reason for adding that, and I doubt that reason was Windows. POSIX
is already pretty incompatible with Windows. Some Googling have
suggested (but I haven't found definitive proof) that some flavors of
QNX (depending on the file system used, it seems) and Solaris might be
affected. Even Linux seems to be affected if the NTFS 3G driver is
used. Perhaps we've only seen this on Windows so far because
anti-virus is uncommon on these other systems? Perhaps something like
Dropbox-syncing on a mounted NTFS drive under Linux can cause this in
real life as well?

Perhaps instead we would be better of with something like an xunlink
(etc) in wrapper.c that deals with this on all platforms (and make
sure that unlink sets errno to EBUSY correctly if it doesn't already)?
