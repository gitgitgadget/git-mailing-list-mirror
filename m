From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 17/19] refs.c: change update_ref to use a transaction
Date: Sat, 26 Apr 2014 01:28:47 +0200
Message-ID: <535AEFAF.9000908@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com> <1398442494-23438-18-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpY7-0001uQ-V4
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaDYX2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:28:51 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53087 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbaDYX2u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:28:50 -0400
X-AuditID: 1207440e-f79c76d000003e2c-8d-535aefb1562d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EC.7E.15916.1BFEA535; Fri, 25 Apr 2014 19:28:49 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3785.dip0.t-ipconnect.de [93.219.55.133])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3PNSmOm011536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 25 Apr 2014 19:28:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398442494-23438-18-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvxfVSwQVuruUXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj+fSVjAXz+CvajpxkbGD8xt3FyMkhIWAiMf3O
	S3YIW0ziwr31bF2MXBxCApcZJZofvmSCcM4zSSxYN4EFpIpXQFti3+V2RhCbRUBVYtnXk6wg
	NpuArsSinmagBg4OUYEgiT9nFSHKBSVOznwC1ioiYCex/tZCZhBbWMBHYs/Nb2CtQgI1EhuW
	nAQ7glPAVaKx4T8byBgJAXGJnsYgkDCzgI7Eu74HzBC2vMT2t3OYJzAKzEKyYRaSsllIyhYw
	Mq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAlRvh2M7etlDjEKcDAq8fDu
	yIkKFmJNLCuuzD3EKMnBpCTKK/saKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE9+gDoBxvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYK34R1Qo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoTuOLgZEKkuIB2hsE0s5bXJCYCxSFaD3FqMtxoWFFC5MQS15+
	XqqUOG//W6AiAZCijNI8uBWwhPSKURzoY2HeUpBRPMBkBjfpFdASJqAlBRPCQZaUJCKkpBoY
	q9h6b31dfzcpw3zvJMaY56KmGy/VWUzYU1by5taKxbd7J6m9t7gZUZPeFblCRn1j2RuNWYJy
	TS7PZK+9FNxxov3M3wPzfPN+d81YNpl79R22oq1fT3DPC73vmr3XrORAjd/yM13b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247134>

On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
> Change the update_ref helper function to use a ref transaction internally.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 1557c3c..95df4a9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3397,11 +3397,26 @@ int update_ref(const char *action, const char *refname,
>  	       const unsigned char *sha1, const unsigned char *oldval,
>  	       int flags, enum action_on_err onerr)
>  {
> -	struct ref_lock *lock;
> -	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
> -	if (!lock)
> +	struct ref_transaction *t;
> +	char *err = NULL;
> +
> +	t = ref_transaction_begin();
> +	if ((!t ||
> +	    ref_transaction_update(t, refname, sha1, oldval, flags,
> +				   !!oldval)) ||
> +	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {

You seem to have extra parentheses around the first || subexpression.

You also don't need the parentheses around the && expression because &&
binds more tightly than ||.

But using "!(t = NULL)" in the middle of a conditional expression is
pretty obscure.  I think you will change this in a later patch, so I
will defer my comments.

> +	     const char *str = "update_ref failed for ref '%s': %s";

Indentation error.

> +
> +		ref_transaction_rollback(t);
> +		switch (onerr) {
> +		case UPDATE_REFS_MSG_ON_ERR: error(str, refname, err); break;
> +		case UPDATE_REFS_DIE_ON_ERR: die(str, refname, err); break;
> +		case UPDATE_REFS_QUIET_ON_ERR: break;
> +		free(err);
> +		}
>  		return 1;
> -	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
> +	}
> +	return 0;
>  }
>  
>  static int ref_update_compare(const void *r1, const void *r2)
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
