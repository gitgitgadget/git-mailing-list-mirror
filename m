From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 39/43] refs: break out a ref conflict check
Date: Mon, 05 Oct 2015 11:06:53 +0200
Message-ID: <56123DAD.9010204@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-40-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 11:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1jZ-0005Ar-6B
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbJEJG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:06:57 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62207 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbbJEJG4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 05:06:56 -0400
X-AuditID: 1207440c-f79e16d000002a6e-82-56123dafb9e5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 31.70.10862.FAD32165; Mon,  5 Oct 2015 05:06:55 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9596rt7001831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 05:06:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-40-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqLveVijM4NpdUYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BnX+lcxFXQrVDw+9ZGlgfG4RBcjJ4eEgInE
	8a6lbBC2mMSFe+uBbC4OIYHLjBKTHn9ghXDOMUl8m/KKCaSKV0Bb4t+9m+wgNouAqsTWdc/A
	utkEdCUW9TSD1YgKBEmsWP6CEaJeUOLkzCcsILaIgIPE5V1HmUFsYQEnifdTd0Fta2OUeNiy
	GqyZU8BL4vHFTawgNrOAnsSO67+gbHmJ7W/nME9g5J+FZO4sJGWzkJQtYGRexSiXmFOaq5ub
	mJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESlDw7GL+tkznEKMDBqMTDK5EkGCbEmlhWXJl7
	iFGSg0lJlLdWRyhMiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvKzOgHG9KYmVValE+TEqag0VJ
	nFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgjfZBqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8l
	tSixtCQjHhSV8cXAuARJ8QDtPW8Nsre4IDEXKArReopRUUqc1xhkrgBIIqM0D24sLNW8YhQH
	+lKYdyVIFQ8wTcF1vwIazAQ0uF8ebHBJIkJKqoHRZtVLDhbdI1ZckwJvxO2ae2PtuQkblq1R
	4/jcWmFgVW3v+ePVixUL+PNevulazqXyLn5et/3Kv0tfbI1sO/zsY7Oyzo1c0+vrJeWnfmBM
	Dt23OrPj4KMXUWyr1T/ueqnygVnJ+lhqthmzYn/10j/qTVr/Hgrc+JiwUOPJrlmz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279052>

On 09/29/2015 12:02 AM, David Turner wrote:
> Create new function verify_no_descendants, to hold one of the ref
> conflict checks used in verify_refname_available.  Multiple backends
> will need this function, so it goes in the common code.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 33 ++++++++-------------------------
>  refs.c          | 28 ++++++++++++++++++++++++++++
>  refs.h          |  4 ++++
>  3 files changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 943604c..8815111 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -753,6 +753,7 @@ static int verify_refname_available_dir(const char *refname,
>  					struct strbuf *err)
>  {
>  	const char *slash;
> +	const char *extra_refname;
>  	int pos;
>  	struct strbuf dirname = STRBUF_INIT;
>  	int ret = -1;
> @@ -858,33 +859,15 @@ static int verify_refname_available_dir(const char *refname,
>  		}
>  	}
>  
> -	if (extras) {
> -		/*
> -		 * Check for entries in extras that start with
> -		 * "$refname/". We do that by looking for the place
> -		 * where "$refname/" would be inserted in extras. If
> -		 * there is an entry at that position that starts with
> -		 * "$refname/" and is not in skip, then we have a
> -		 * conflict.
> -		 */
> -		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
> -		     pos < extras->nr; pos++) {
> -			const char *extra_refname = extras->items[pos].string;
> -
> -			if (!starts_with(extra_refname, dirname.buf))
> -				break;
> -
> -			if (!skip || !string_list_has_string(skip, extra_refname)) {
> -				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
> -					    refname, extra_refname);
> -				goto cleanup;
> -			}
> -		}
> +	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> +	if (extra_refname) {
> +		strbuf_addf(err,
> +			    "cannot process '%s' and '%s' at the same time",
> +			    refname, extra_refname);
> +	} else {
> +		ret = 0;
>  	}
>  
> -	/* No conflicts were found */
> -	ret = 0;
> -
>  cleanup:
>  	strbuf_release(&dirname);
>  	return ret;
> diff --git a/refs.c b/refs.c
> index 1c2dd79..17a364a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -994,6 +994,34 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
>  	return PEEL_PEELED;
>  }
>  
> +const char *find_descendant_ref(const char *refname,
> +				const struct string_list *extras,
> +				const struct string_list *skip)
> +{
> +	int pos;
> +	if (!extras)
> +		return NULL;
> +
> +	/*
> +	 * Check for entries in extras that start with "$refname/". We
> +	 * do that by looking for the place where "$refname/" would be
> +	 * inserted in extras. If there is an entry at that position
> +	 * that starts with "$refname/" and is not in skip, then we
> +	 * have a conflict.
> +	 */

Would you please turn this comment (or something like it) into a
docstring for this function in refs.h?

> +	for (pos = string_list_find_insert_index(extras, refname, 0);
> +	     pos < extras->nr; pos++) {
> +		const char *extra_refname = extras->items[pos].string;
> +
> +		if (!starts_with(extra_refname, refname))
> +			break;
> +
> +		if (!skip || !string_list_has_string(skip, extra_refname))
> +			return extra_refname;
> +	}
> +	return NULL;
> +}
> +
>  /* backend functions */
>  int refs_initdb(struct strbuf *err, int shared)
>  {
> diff --git a/refs.h b/refs.h
> index da29232..cf1780e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -571,6 +571,10 @@ enum ref_type ref_type(const char *refname);
>  
>  int copy_reflog_msg(char *buf, const char *msg);
>  
> +const char *find_descendant_ref(const char *refname,
> +				const struct string_list *extras,
> +				const struct string_list *skip);
> +
>  int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>  			const unsigned char *new_sha1, const char *msg,
>  			int flags, struct strbuf *err);
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
