From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 10:23:14 +0200
Message-ID: <539FFAF2.3070002@web.de>
References: <cover.1402990051.git.jmmahler@gmail.com> <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 10:23:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwofx-00083l-N7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 10:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbaFQIXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 04:23:23 -0400
Received: from mout.web.de ([212.227.15.14]:57870 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932480AbaFQIXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 04:23:21 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M5wrF-1WY6ww2HRR-00xvmY; Tue, 17 Jun 2014 10:23:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
X-Provags-ID: V03:K0:7jgu8PsJi3VXuK/rCjHq3X5f9ZqGHaFVDLLfuEGu1Q9o+kRH28g
 J6FROyfODkVNA7eFtMw914bcQjBviChGQ1ieCn09subZwh9w+FUMPQC+xL6tkm6eKtfqbg6
 1AurMpkdQJ+MsWbqWmQuokDEG+MRw8EnKDY4ota7wLQkySPUuAZLmATnvXJ9N9Tw5Kmylu3
 sU6cgiONlSvQPu+EuQK/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251851>

On 2014-06-17 09.34, Jeremiah Mahler wrote:
> Add a strnncmp() function which behaves like strncmp() except it takes
> the length of both strings instead of just one.  It behaves the same as
> strncmp() up to the minimum common length between the strings.  When the
minimum common length? Isn'n t that 0?
Using the word "common", I think we could call it "common length".
(And more places below)

> strings are identical up to this minimum common length, the length
> difference is returned.
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  strbuf.c | 9 +++++++++
>  strbuf.h | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..4eb7954 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
>  	result[i] = '\0';
>  	return result;
>  }
> +
strncmp uses size_t, not int:
int strncmp(const char *s1, const char *s2, size_t n);

Is there a special reason to allow negative string length?
Some call sites use int when calling strncmp() or others,
that is one thing.
But when writing a generic strnncmp() function, I think
it should use size_t, unless negative values have a meaning and
are handled in the code.


> +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> +{
> +	int min_len = (len_a < len_b) ? len_a : len_b;
> +	int cmp = strncmp(a, b, min_len);

> +	if (cmp)
> +		return cmp;
> +	return (len_a - len_b);
> +}
