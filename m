From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: [PATCH] Include headers for getrlimit() in sha1_file.c
Date: Fri, 18 Mar 2011 20:22:24 -0400
Message-ID: <AANLkTi=tJL8A9RyuoitSSUAWEF7+PZxxWZPcQdk00yj9@mail.gmail.com>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
	<20110318202351.GA22696@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Sperling <stsp@stsp.name>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 01:22:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0jw9-0000oU-GX
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 01:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604Ab1CSAW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 20:22:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55384 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CSAWY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 20:22:24 -0400
Received: by iwn34 with SMTP id 34so4538573iwn.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8EZHCNKLaYFhlh24hBReAJsU2PgCJi0nHfZMpFFW7X8=;
        b=ZVoCiPbKCOAv/z5LrKZR8DEBBlymzUMgBBAGUX4fEEUtkldh1EH8USVA+mLvgyCiF4
         c6f21adIUyjKfz+WW8tNNkpARHugAWtJHqvWAk/UhchsQsEJZLySzWygoyXcsrYAi2Db
         UMP4NB+aR4BHMpmWjQx93YVIsFg/dd6ANtRlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ovh6+vxtp4edNC54x2Hj3BJ48NJT1MIJVkiKij5j7EDmnYDjaooWyXafJb7PvUW2YE
         qX55/ZqvS5e97bTOH5b7aYyuT5hUUmrp3NoLo/lluFqqVBWVFE2WLDtS+abMk+6uI5om
         znnkexapnyhMjRmBgIE5wO+SeRL1smRqd3FNs=
Received: by 10.43.47.194 with SMTP id ut2mr2554590icb.66.1300494144421; Fri,
 18 Mar 2011 17:22:24 -0700 (PDT)
Received: by 10.42.177.132 with HTTP; Fri, 18 Mar 2011 17:22:24 -0700 (PDT)
In-Reply-To: <20110318202351.GA22696@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169378>

Hi,

On Fri, Mar 18, 2011 at 4:23 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> (+cc: Shawn, Erik)
> Hi Stefan,
>
> Stefan Sperling wrote:
>
>> Fixes compilation error on OpenBSD:
>> sha1_file.c: In function 'open_packed_git_1':
>> sha1_file.c:718: error: storage size of 'lim' isn't known
>> sha1_file.c:721: warning: implicit declaration of function 'getrlimi=
t'
>> sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in thi=
s function)
>> sha1_file.c:718: warning: unused variable 'lim'
>
This also fix the build on FreeBSD 8 (did not test other version).

 - Arnaud

> Good catch.
>
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -18,6 +18,10 @@
>> =A0#include "pack-revindex.h"
>> =A0#include "sha1-lookup.h"
>>
>> +#include <sys/types.h>
>> +#include <sys/time.h>
>> +#include <sys/resource.h>
>
> System headers like this tend to go in git-compat-util.h, so
> portability fixes having to do with compatibility replacements or
> order of inclusion only need to happen in one place.
>
> In this case, afaict sys/resource.h is not available on mingw, meanin=
g
> the #include would probably go in the "#ifndef __MINGW32__" block.
> Maybe something like this (untested)?
>
> -- 8< --
> Subject: compat: add missing #include <sys/resource.h>
>
> Starting with commit c793430 (Limit file descriptors used by packs,
> 2011-02-28), git uses getrlimit to tell how many file descriptors it
> can use. =A0Unfortunately it does not include the header declaring th=
at
> function, resulting in compilation errors on OpenBSD:
>
> =A0sha1_file.c: In function 'open_packed_git_1':
> =A0sha1_file.c:718: error: storage size of 'lim' isn't known
> =A0sha1_file.c:721: warning: implicit declaration of function 'getrli=
mit'
> =A0sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in t=
his function)
> =A0sha1_file.c:718: warning: unused variable 'lim'
>
> The standard header to include for this is <sys/resource.h> (which on
> some systems itself requires declarations from <sys/types.h> or
> <sys/time.h>). =A0Probably the problem was missed until now because i=
n
> current glibc sys/resource.h happens to be included by sys/wait.h.
>
> MinGW does not provide sys/resource.h (and compat/mingw takes care of
> providing getrlimit some other way), so add the missing #include to
> the "#ifndef __MINGW32__" block in git-compat-util.h.
>
> Reported-by: Stefan Sperling <stsp@stsp.name>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =A0git-compat-util.h | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 49b50ee..40498b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -118,6 +118,7 @@
> =A0#endif
> =A0#ifndef __MINGW32__
> =A0#include <sys/wait.h>
> +#include <sys/resource.h>
> =A0#include <sys/socket.h>
> =A0#include <sys/ioctl.h>
> =A0#include <termios.h>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
