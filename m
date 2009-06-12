From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Jun 2009, #01; Fri, 12)
Date: Fri, 12 Jun 2009 12:04:35 +0200
Message-ID: <200906121204.37752.trast@student.ethz.ch>
References: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF3cy-0007Km-HI
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933288AbZFLKEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbZFLKEl
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:04:41 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:12427 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZFLKEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:04:40 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Jun 2009 12:04:41 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Jun 2009 12:04:41 +0200
User-Agent: KMail/1.11.90 (Linux/2.6.27.23-0.1-default; KDE/4.2.90; x86_64; ; )
In-Reply-To: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jun 2009 10:04:41.0169 (UTC) FILETIME=[33D5CC10:01C9EB45]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121399>

Junio C Hamano wrote:
> * tr/die_errno (Mon Jun 8 23:02:20 2009 +0200) 4 commits
>  - Use die_errno() instead of die() when checking syscalls
>  - Convert existing die(..., strerror(errno)) to die_errno()
>  - die_errno(): double % in strerror() output just in case
>  - Introduce die_errno() that appends strerror(errno) to die()

I had a look at your

  [526abe63] die_errno(): double % in strerror() output just in case

and it seems it doesn't cover all corner cases:

> @@ -64,8 +64,20 @@ void die_errno(const char *fmt, ...)
>  {
>  	va_list params;
>  	char fmt_with_err[1024];
> -
> -	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, strerror(errno));
> +	char str_error[256], *err;
> +	int i, j;
> +
> +	err = strerror(errno);
> +	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
> +		if ((str_error[j++] = err[i++]) != '%')
> +			continue;

If we copied a '%' here, but filled 'str_error', then

> +		if (j < sizeof(str_error) - 1)
> +			str_error[j++] = '%';
> +		else
> +			break;

we 'break' here, instead of tacking on another '%'.  This subsequently
leaves a single trailing '%' at the end of the string.  A possible fix
would be to use

+		else {
+			j--;
+			break;
+		}

instead, so that the terminator ends up on the second-to-last position
in the string, overwriting the lonely '%'.

> +	}
> +	str_error[j] = 0;
> +	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
>  
>  	va_start(params, fmt);
>  	die_routine(fmt_with_err, params);


I cannot find an explicit mention that trailing '%'s are bad, and my
printf() just ignores them, but 'man 3p printf' (showing a "POSIX
Programmer's Manual" entry that I can't seem to find on the web...) at
least states

  [after explaining all conversion specifiers]

  If a conversion specification does not match one of the above forms,
  the behavior is undefined. If any argument is not the correct type
  for the corresponding conversion specification, the behavior is
  undefined.


[I still like v2 better because it's far less complicated...]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
