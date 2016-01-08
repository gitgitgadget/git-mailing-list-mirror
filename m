From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary
 backquotes
Date: Fri, 8 Jan 2016 21:07:48 +0100
Message-ID: <56901714.60505@kdbg.org>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
 <1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 21:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHdKG-0007qS-KK
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 21:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbcAHUHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 15:07:52 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:38738 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641AbcAHUHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 15:07:51 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pcb851J4Zz5tlC;
	Fri,  8 Jan 2016 21:07:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6413451DD;
	Fri,  8 Jan 2016 21:07:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283580>

Am 08.01.2016 um 12:06 schrieb Elia Pinto:
> Instead of making the shell expand 00* and invoke 'echo' with it,
> and then capturing its output as command substitution, just use
> the result of expanding 00* directly.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>   t/t9001-send-email.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I notices there are two patches in this series that touch 
t/t9001-send-email.sh. The other one is 9/10, and it claims to be an 
automated conversion. But that cannot be true because it would have 
removed the backquotes that are addressed in this patch.

>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 05949a1..bcbed38 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1488,7 +1488,7 @@ test_cover_addresses () {
>   	clean_fake_sendmail &&
>   	rm -fr outdir &&
>   	git format-patch --cover-letter -2 -o outdir &&
> -	cover=`echo outdir/0000-*.patch` &&

This expands the pattern and stores the result in $cover, provided there 
exists at least one file that matches the pattern. If such file does not 
exist, the pattern is stored verbatim in $cover.

> +	cover="outdir/0000-*.patch" &&

This does not expand the pattern and stores the pattern verbatim in $cover.

>   	mv $cover cover-to-edit.patch &&

This line succeeds because there pattern is expanded and matches only 
one file.

>   	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&

In this line, "$cover" is not expanded, and a file named '0000-*.patch' 
will be dropped into subdirectory 'outdir'.

>   	git send-email \

The command that is truncated here looks like this:

         git send-email \
                 --force \
                 --from="Example <nobody@example.com>" \
                 --no-to --no-cc \
                 "$@" \
                 --smtp-server="$(pwd)/fake.sendmail" \
                 outdir/0000-*.patch \
                 outdir/0001-*.patch \
                 outdir/0002-*.patch \
                 2>errors >out &&

Since it uses a pattern that would match a the oddly named file and 
since at this point the original 0000-whatever* file was moved away, the 
pattern still matches only one 0000-* file. The test still succeeds, so 
you did not notices that it has now slightly different behavior.

As much as I would like to remove a sub-process, I think it is better to 
keep the $(echo 0000-*) in this case.
