From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Sat, 22 Mar 2014 10:32:37 +0100
Message-ID: <532D58B5.1080309@web.de>
References: <20140224073348.GA20221@sigill.intra.peff.net> <20140224074905.GE9969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 10:33:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRIJE-0002v7-RX
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 10:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbaCVJdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 05:33:11 -0400
Received: from mout.web.de ([212.227.15.14]:55603 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaCVJdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 05:33:08 -0400
Received: from [192.168.178.27] ([79.253.149.120]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M7snk-1XMXcA0zmy-00vSFD; Sat, 22 Mar 2014 10:33:06
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140224074905.GE9969@sigill.intra.peff.net>
X-Provags-ID: V03:K0:Wx48tXhLavYbDVkQMrAAzYJnMvPb5TCsdPhnWilFJLIKwiLhX2f
 4hDxKbh4Iv1ltwUc7HOxpCxdp0KwJh8oHYuW0snFYRuKT+Er3e3AAISfl0j6mv+EwlfCJMa
 7UdUDkCRrqpp7xJ1EcBMVdP91nrILOKaI6/YEz5xQBfceLNQaltPT94aBqgnCCfhEJdhpe4
 pja49ndLXtXPeGCuhTLhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244764>

Am 24.02.2014 08:49, schrieb Jeff King:
> Many code paths assume that show_date and show_ident_date
> cannot return NULL. For the most part, we handle missing or
> corrupt timestamps by showing the epoch time t=0.
>
> However, we might still return NULL if gmtime rejects the
> time_t we feed it, resulting in a segfault. Let's catch this
> case and just format t=0.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This test is of questionable portability, since we are depending on
> gmtime's arbitrary point to decide that our input is crazy and return
> NULL. The value is sufficiently large that I'd expect most to do so,
> though, so it may be safe.

Just came around to testing on FreeBSD 10 amd64; the new test in t4212 
fails there:

--- expect      2014-03-22 08:29:44.000000000 +0000
+++ actual      2014-03-22 08:29:44.000000000 +0000
@@ -1 +1 @@
-Thu Jan 1 00:00:00 1970 +0000
+Sun Jan 0 00:00:00 1900 -0700
not ok 9 - absurdly far-in-future dates produce sentinel
#
#               commit=$(munge_author_date HEAD 999999999999999999) &&
#               echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
#               git log -1 --format=%ad $commit >actual &&
#               test_cmp expect actual
#

# failed 1 among 9 test(s)

Looks like we get a cleared struct tm instead of a NULL pointer.  It 
seems to be a long-standing bug; 
http://www.freebsd.org/cgi/query-pr.cgi?pr=kern/145341 was filed in 
April 2010.

> On 32-bit systems, of course, the test does nothing (it is just hitting
> the integer overflow code path). But that's OK, since the output is the
> same for both cases.
>
>   date.c                 | 6 ++++--
>   t/t4212-log-corrupt.sh | 8 ++++++++
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/date.c b/date.c
> index 90b28f7..e1a2cee 100644
> --- a/date.c
> +++ b/date.c
> @@ -184,8 +184,10 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
>   		tz = local_tzoffset(time);
>
>   	tm = time_to_tm(time, tz);
> -	if (!tm)
> -		return NULL;
> +	if (!tm) {

Would it make sense to work around the FreeBSD issue by adding a check 
like this?

	if (!tm || tm->tm_year < 70) {

> +		tm = time_to_tm(0, 0);
> +		tz = 0;
> +	}
>
>   	strbuf_reset(&timebuf);
>   	if (mode == DATE_SHORT)
> diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
> index ba25a2e..3fa1715 100755
> --- a/t/t4212-log-corrupt.sh
> +++ b/t/t4212-log-corrupt.sh
> @@ -81,4 +81,12 @@ test_expect_success 'date parser recognizes time_t overflow' '
>   	test_cmp expect actual
>   '
>
> +# date is within 2^63-1, but enough to choke glibc's gmtime
> +test_expect_success 'absurdly far-in-future dates produce sentinel' '
> +	commit=$(munge_author_date HEAD 999999999999999999) &&
> +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
> +	git log -1 --format=%ad $commit >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
>
