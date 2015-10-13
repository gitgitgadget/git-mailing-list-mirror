From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 37/44] refs: break out a ref conflict check
Date: Tue, 13 Oct 2015 12:25:50 +0200
Message-ID: <561CDC2E.8060804@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-39-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 12:26:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlwmM-0005Bx-5d
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 12:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbJMKZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 06:25:54 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51069 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752519AbbJMKZx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 06:25:53 -0400
X-AuditID: 12074414-f794f6d000007852-16-561cdc3015b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 12.8E.30802.03CDC165; Tue, 13 Oct 2015 06:25:52 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9DAPobJ024318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 06:25:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-39-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqGtwRybM4PpxdYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BnH+v6zFXyUqOic4t7AeFG4i5GTQ0LAROL9
	up8sELaYxIV769m6GLk4hAQuM0q8P7KYHcI5yyTR9/MEK0gVr4C2xNy938FsFgFVidcrvrKB
	2GwCuhKLepqZQGxRgSCJFctfMELUC0qcnPkEbIOIgIPE5V1HmUFsYQEnie4p11kgFrQxSlxc
	vB2ogYODU8BL4ukfWZAaZgE9iR3Xf7FC2PISzVtnM09g5J+FZOwsJGWzkJQtYGRexSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESkCI7GI+clDvEKMDBqMTD+yJSJkyINbGs
	uDL3EKMkB5OSKK/bVaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6kFqAcb0piZVVqUT5MSpqD
	RUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IEr+NtoEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UETGFwNjEiTFA7T3/y2QvcUFiblAUYjWU4yKUuK8x0ESAiCJjNI8uLGwNPOK
	URzoS2HeUpDtPMAUBdf9CmgwE9BgI3YpkMEliQgpqQbG6M1NR7e+mrTq9oJ9/uZFyyqZBXlm
	T9hTKdEQ0sSwbIZY2Z0n+QeszX8n/WtijO8vPVnrHtLe+9Vp1mNXbp9THkV6QnM6+x7Mt/+b
	yLjh0ectb7yWsk1i42m+/+Or+g2GFsn2wBtHNu39q5ye/al9raDPXrXaJXvnHvD6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279494>

On 10/12/2015 11:51 PM, David Turner wrote:
> Create new function verify_no_descendants, to hold one of the ref
> conflict checks used in verify_refname_available.  Multiple backends
> will need this function, so it goes in the common code.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 33 ++++++++-------------------------
>  refs.c          | 22 ++++++++++++++++++++++
>  refs.h          |  7 +++++++
>  3 files changed, 37 insertions(+), 25 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index 5a3125d..3ae0274 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1101,6 +1101,28 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
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
> +	/* Look for the place where "$refname/" would be inserted in extras. */

The comment above is misleading. See my note at the bottom of this email
for an explanation.

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
> index 3aad3b8..f8becea 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -637,6 +637,13 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>  			const unsigned char *new_sha1, const char *msg,
>  			int flags, struct strbuf *err);
>  
> +/*
> + * Check for entries in extras that start with "$refname/", ignoring
> + * those in skip. If there is such an entry, then we have a conflict.
> + */
> +const char *find_descendant_ref(const char *refname,
> +				const struct string_list *extras,
> +				const struct string_list *skip);

The documentation is is not correct. As written, the function needs not
the refname as argument but the refname followed by '/'. Without the
trailing slash, "refs/heads/foo" would be blocked by "refs/heads/foobar".

>From the point of view of simplicity, it would be nice if this function
could take a refname (without the trailing slash) as argument. But then
it would basically be forced to allocate a new string, copy refname to
it, append a '/', then free the string again when it's done.
Alternatively, it could accept its refname argument in a strbuf and
temporarily append the '/'.

But neither one of these alternatives is so elegant, so maybe it's OK if
this function is documented to take a "directory name, including the
trailing '/'" as argument and rename the argument (e.g., to "dirname").

Please also document that "skip" and "extras" can be NULL, but if not
NULL they need to be sorted lists.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
