From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] tree-walk: be more specific about corrupt tree errors
Date: Thu, 13 Feb 2014 09:25:40 +0100
Message-ID: <52FC8184.5090606@alum.mit.edu>
References: <20140212194956.GA3850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:25:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDrcD-00055a-2c
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaBMIZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:25:44 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45201 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529AbaBMIZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Feb 2014 03:25:43 -0500
X-AuditID: 12074413-f79076d000002d17-c4-52fc8186b7dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CA.14.11543.6818CF25; Thu, 13 Feb 2014 03:25:42 -0500 (EST)
Received: from [192.168.69.148] (p4FDD409C.dip0.t-ipconnect.de [79.221.64.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1D8Pex9031144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Feb 2014 03:25:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140212194956.GA3850@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqNve+CfIYAmzRdeVbiaLHy09zA5M
	Hs969zB6fN4kF8AUxW2TlFhSFpyZnqdvl8Cdcbath7Xgo1TF6pOfWBsY/4p0MXJySAiYSFzo
	7WOCsMUkLtxbz9bFyMUhJHCZUaL74G1mkISQwHkmiRevtUBsXgFtiXsb/4E1sAioSkyadogN
	xGYT0JVY1NMMFhcVCJZYffkBC0S9oMTJmU/AbBEBWYnvhzcydjFycDALiEv0/wMLCwt4Sdza
	dJsRYpWlxPp/x9hBbE4BK4lbd/exgpRLAJX3NAZBdKpLrJ8nBFLBLCAvsf3tHOYJjIKzkOya
	hVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxghYSu8g3HXSblD
	jAIcjEo8vBozfgcJsSaWFVfmHmKU5GBSEuW9UvcnSIgvKT+lMiOxOCO+qDQntfgQowQHs5II
	r4wEUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7HmSoYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChy44uBsQuS4gHam9UAsre4IDEXKArReopRl+N2
	269PjEIsefl5qVLivK71QEUCIEUZpXlwK2BJ6hWjONDHwrxCIKN4gAkObtIroCVMQEtSo36D
	LClJREhJNTDKbNzuPG069zmpq6ZfrV33NS1rly1QUYk/rrK2QXLn3le/3bcvLJu8/dHltQ8Z
	7s43bu4V0Y2dMyF6Y8f6haVihr4Ha3JMApbfUelbslhr+XGxJRfOM121KFobxBLx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242043>

On 02/12/2014 08:49 PM, Jeff King wrote:
> When the tree-walker runs into an error, it just calls
> die(), and the message is always "corrupt tree file".
> However, we are actually covering several cases here; let's
> give the user a hint about what happened.
> 
> Let's also avoid using the word "corrupt", which makes it
> seem like the data bit-rotted on disk. Our sha1 check would
> already have found that. These errors are ones of data that
> is malformed in the first place.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Michael and I have been looking off-list at some bogus trees (created by
> a non-git.git implementation). git-fsck unhelpfully dies during the
> tree-walk:
> 
>   $ git fsck
>   Checking object directories: 100% (256/256), done.
>   fatal: corrupt tree file
> 
> I think in the long run we want to either teach fsck to avoid the
> regular tree-walker or to set a special "continue as much as you can"
> flag. That will let us keep going to find more errors, do our usual fsck
> error checks (which are more strict), and especially report on _which_
> object was broken (we can't do that here because we are deep in the call
> stack and may not even have a real object yet).
> 
> This patch at least gives us slightly more specific error messages (both
> for fsck and for other commands). And it may provide a first step in
> clarity if we follow the "continue as much as you can" path.
> 
>  tree-walk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tree-walk.c b/tree-walk.c
> index 79dba1d..d53b084 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -28,11 +28,13 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
>  	unsigned int mode, len;
>  
>  	if (size < 24 || buf[size - 21])
> -		die("corrupt tree file");
> +		die("truncated tree file");
>  

I suggest splitting this into two separate checks, because the first
boolean definitely indicates a truncated file, whereas the second
boolean could indicate malformedness that is not caused by truncation.

Another tiny point: I suppose that the number "24" comes from

    A one-digit mode
    SP
    A one-character filename
    NUL
    20-byte SHA1

But given that you are detecting zero-length filenames a few lines
later, I think it makes logical sense to admit for that possibility
here, by reducing 24 -> 23.  (I realize that it doesn't change the end
result, because the only syntactically correct situation with length=23
would be a doubly-broken line that has a one-digit mode *and* a
zero-length filename, and it's arbitrary which of the forms of
brokenness we report in such a case.)

>  	path = get_mode(buf, &mode);
> -	if (!path || !*path)
> -		die("corrupt tree file");
> +	if (!path)
> +		die("malformed mode in tree entry");
> +	if (!*path)
> +		die("empty filename in tree entry");
>  	len = strlen(path) + 1;
>  
>  	/* Initialize the descriptor entry */
> @@ -81,7 +83,7 @@ void update_tree_entry(struct tree_desc *desc)
>  	unsigned long len = end - (const unsigned char *)buf;
>  
>  	if (size < len)
> -		die("corrupt tree file");
> +		die("truncated tree file");
>  	buf = end;
>  	size -= len;
>  	desc->buffer = buf;
> 

Otherwise, I think this is a nice improvement.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
