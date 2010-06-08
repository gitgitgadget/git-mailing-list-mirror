From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 09:24:45 -0300
Message-ID: <AANLkTinxcrIV2TM966EkOC_crR0bHdNllEIdibz4gGjd@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<20100608052929.GA15156@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@uchicago.edu, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 14:24:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLxrR-0002ZF-QC
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 14:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab0FHMYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 08:24:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47815 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0FHMYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 08:24:47 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1409546fgb.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F2RtCl7h4pHCNDvnBI6oN0pjiOHPZUdtOrz/1qHC6ZE=;
        b=PQMi6mTDuPZWnihF+PIc9rf8SVXdANgdeb4moe6MTDGS6ZZrWxPW6Jz7mEkcBpSU7v
         L485RRGDx6QxM/SWNEXjz6Rk9mA4Ck3OfoLV45TbAAyQszxyiKOtQwBwroILimzBIWia
         F5ji/K1D5du84E9+oMuq7eqPDTVSGVWzpKaX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZN0s38vIF2a9VTrYK+C0hIJka+3FolQI34v5LH6MiLwq9NJ1CX0/EugHrML7JsYlaF
         /GHN7E+VR69owBNo2vQ+hz1iQbCL19Rb+x67CLEkdBYjeSI2+/flgYppr8UIlmYDqD+c
         zi2I7OljhkF3/naGt8CyvwP6IkVcYZB+lKYU4=
Received: by 10.204.81.98 with SMTP id w34mr292015bkk.29.1275999885859; Tue, 
	08 Jun 2010 05:24:45 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Tue, 8 Jun 2010 05:24:45 -0700 (PDT)
In-Reply-To: <20100608052929.GA15156@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148665>

On Tue, Jun 8, 2010 at 2:29 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 07, 2010 at 08:58:08PM -0300, Dario Rodriguez wrote:
>
>> Default pager was 'less' even when some systems such AIX and other b=
asic
>> or old systems do NOT have 'less' installed. In such case, git just
>> does not display anything in pager-enabled functionalities such as '=
git log'
>> or 'git show', exiting with status 0.
>>
>> With this patch, git will not use DEFAULT_PAGER macro anymore, inste=
ad,
>> git will look for 'less' and 'more' in the most common paths.
>> If there is no pager, returns NULL as if it's 'cat'.
>
> Run-time pager detection seems like a reasonable goal, I guess, but..=
=2E
>
>> -const char *git_pager(int stdout_is_tty)
>> +static int is_executable(const char *name)
>> +{
>> + =A0 =A0 struct stat st;
>> +
>> + =A0 =A0 if (stat(name, &st) ||
>> + =A0 =A0 =A0 =A0 !S_ISREG(st.st_mode))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> +#ifdef WIN32
>> +{ =A0 =A0/* cannot trust the executable bit, peek into the file ins=
tead */
>> + =A0 =A0 char buf[3] =3D { 0 };
>> + =A0 =A0 int n;
>> + =A0 =A0 int fd =3D open(name, O_RDONLY);
>> + =A0 =A0 st.st_mode &=3D ~S_IXUSR;
>> + =A0 =A0 if (fd >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 n =3D read(fd, buf, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (n =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DOS executables start w=
ith "MZ" */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(buf, "#!") || =
!strcmp(buf, "MZ"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st.st_mode=
 |=3D S_IXUSR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 close(fd);
>> + =A0 =A0 }
>> +}
>> +#endif
>> + =A0 =A0 return st.st_mode & S_IXUSR;
>> +}
>> +
>> +const char *git_pager(int stdout_is_tty)
>> =A0{
>> + =A0 =A0 static const char *pager_bins[] =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "less", "more", NULL };
>> + =A0 =A0 static const char *common_binary_paths[] =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "/bin/","/usr/bin/","/usr/local/bin/",NU=
LL };
>
> ...must we really add code with such ugliness as magic PATHs and DOS
> magic numbers?
>

I copied the function 'is_executable' from 'help.c' so we already have
such code... :p

> Right now we fall back to just exec-ing "less". Could we instead just
> try to exec "less", if that fails then "more", and then finally "cat"=
?
>

is such a good idea but right now, 'git_pager' is not exec-ing, it's
just setting up a pager. If you set-up the pager based on wich one
fails in it's execution, you must avoid usage of this function, since
it will always return 'less' (or 'more...). What I posted is
transparent to any other function; 'git_pager' will be called
returning an existent, working pager, so the flow is the same, however
I like your proposal too, and should be considered.

> That would have almost the same effect and would be much simpler,
> wouldn't it? The exceptions I can think of are:
>
> =A0- we would actually run "cat" in the final case, instead of optimi=
zing
> =A0 =A0it out.
>

Actually pager is being set to NULL if it's 'cat'... what's git doing
with a NULL pager?

> =A0- "git var GIT_PAGER" wouldn't handle this automatically
>
> -Peff
>

Blessing,
Dario
