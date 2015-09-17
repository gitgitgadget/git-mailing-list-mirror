From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] strtoul_ui: reject negative values
Date: Thu, 17 Sep 2015 11:17:21 -0400
Message-ID: <55FAD981.5080808@xiplink.com>
References: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, max@max630.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 17 17:27:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcb5E-0005Vi-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbbIQP0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:26:44 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:39501 "EHLO
	smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160AbbIQP0o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 11:26:44 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2015 11:26:43 EDT
Received: from smtp19.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp19.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id E612A180295;
	Thu, 17 Sep 2015 11:16:58 -0400 (EDT)
Received: by smtp19.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 92E16180360;
	Thu, 17 Sep 2015 11:16:58 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Thu, 17 Sep 2015 15:16:58 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278121>

On 15-09-17 10:37 AM, Matthieu Moy wrote:
> strtoul_ui uses strtoul to get a long unsigned, then checks that casting
> to unsigned does not lose information and return the casted value.
> 
> On 64 bits architecture, checking that the cast does not change the value
> catches most errors, but when sizeof(int) == sizeof(long) (e.g. i386),
> the check does nothing. Unfortunately, strtoul silently accepts negative
> values, and as a result strtoul_ui("-1", ...) raised no error.
> 
> This patch catches negative values before it's too late, i.e. before
> calling strtoul. We still silently accept very large integers that wrap
> to a valid "unsigned int".
> 
> Reported-by: Max Kirillov <max@max630.net>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> So, here's a proper patch (I mean, a band-aid patch, but properly
> send ;-) ).
> 
> It should be merged before Kartik's series (or inserted at the start
> of the series) so that we get the fix before the test breakage.
> 
>  git-compat-util.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f649e81..1df82fa 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  	char *p;
>  
>  	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (strchr(s, '-'))
> +		return -1;

I think this is broken, in that it doesn't match strtoul's normal behaviour,
for strings like "1234-5678", no?

The test also doesn't work if the string has leading whitespace ("  -5").

>  	ul = strtoul(s, &p, base);
>  	if (errno || *p || p == s || (unsigned int) ul != ul)
>  		return -1;

Hmm, but we check *p here, so IIUC it's an error if the string has any
trailing non-digits.  Weird.

		M.
