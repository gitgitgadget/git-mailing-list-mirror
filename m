From: Maxin john <maxin@maxinbjohn.info>
Subject: Re: [PATCH ] "git bisect visualize" results in an invalid error if
 "gitk" is not installed
Date: Mon, 21 Mar 2011 13:26:33 +0100
Message-ID: <AANLkTinS87obXcgbcFZ8L-UjZUQL96SzpHp84Y6-yX6v@mail.gmail.com>
References: <AANLkTi=HJjqrvv-PFO3VjhrHzBsLZmAbN0yU47WScWd_@mail.gmail.com>
	<20110321112932.GF16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 13:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1eBz-0005pn-Vu
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1CUM0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 08:26:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57657 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1CUM0e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 08:26:34 -0400
Received: by yxs7 with SMTP id 7so2375237yxs.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 05:26:33 -0700 (PDT)
Received: by 10.236.67.9 with SMTP id i9mr5061696yhd.306.1300710393107; Mon,
 21 Mar 2011 05:26:33 -0700 (PDT)
Received: by 10.236.105.137 with HTTP; Mon, 21 Mar 2011 05:26:33 -0700 (PDT)
X-Originating-IP: [192.100.120.41]
In-Reply-To: <20110321112932.GF16334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169589>

Hi Jeff,

I have tested the patch and it works like a charm!.

Tested-by: Maxin B. John <maxin@maxinbjohn.info>


On Mon, Mar 21, 2011 at 12:29 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 20, 2011 at 11:10:55PM +0200, Maxin john wrote:
>
>> While using "git bisect visualize" on my PC running Ubuntu 10.10, I
>> came across this error:
>>
>> $ git bisect visualize
>> eval: 1: gitk: not found
>> git: 'bisect' is not a git command. See 'git --help'.
>>
>> Did you mean this?
>> =A0 =A0 =A0 bisect
>> $
>
> Yuck. Definitely non-optimal.
>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index c21e33c..fefe212 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -290,7 +290,8 @@ bisect_visualize() {
>> =A0 =A0 =A0 =A0 then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case
>> "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+s=
et}"
>> in
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '') =A0 =A0 set git log ;;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set*) =A0 set gitk ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set*) =A0 is_gitk_present
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set gitk ;;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
>
> The point of this code is to use "gitk" if we can (i.e., if we have a
> grahpical display of some sort), and "git log" otherwise. Shouldn't "=
we
> are missing gitk" also cause us to fallback to using "git log"? IOW,
> something like:
>
> =A0if test -n "${DISPLAY+set}..." && is_gitk_present; then
> =A0 =A0set gitk
> =A0else
> =A0 =A0set git log
> =A0fi
>

Yes. it is much better than just exiting if "gitk" is not present.

>> +is_gitk_present () {
>> + =A0 =A0 =A0 GIT_GITK=3D$(which gitk)
>> + =A0 =A0 =A0 test -n "$GIT_GITK" || {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "Cannot find 'gitk' in the PA=
TH"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 }
>> +}
>
> I don't think this is a portable use of which. In particular, I seem =
to
> recall SunOS which printing some junk to stderr like "no foo in /bin
> /usr/bin etc...". I think it even then returns a successful exit code=
,
> just to make it totally useless.
>
> I think we tend to use the shell's "type" builtin for this, which has=
 a
> usable exit code.

"type" seems to be a better choice than using "which" for this case.

> So the patch would look like:
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index c21e33c..3b3156f 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -288,10 +288,12 @@ bisect_visualize() {
>
> =A0 =A0 =A0 =A0if test $# =3D 0
> =A0 =A0 =A0 =A0then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "${DISPLAY+set}${SESSIONNAME+set}$=
{MSYSTEM+set}${SECURITYSESSIONID+set}" in
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 '') =A0 =A0 set git log ;;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set*) =A0 set gitk ;;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -n "${DISPLAY+set}${SESSIONNAME=
+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type gitk >/dev/null 2>&1; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set gitk
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set git log
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$1" in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git*|tig) ;;
>
> but I didn't test it at all.
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Warm Regards,
Maxin B. John
