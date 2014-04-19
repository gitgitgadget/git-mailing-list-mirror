From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/11] tag.c: use ref transactions when doing updates
Date: Sat, 19 Apr 2014 21:12:50 +0200
Message-ID: <5352CAB2.2000909@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbah8-00025T-3H
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbaDSTMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:12:55 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55364 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161024AbaDSTMx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 15:12:53 -0400
X-AuditID: 12074412-f79d46d000002e58-f9-5352cab4a31a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 97.E4.11864.4BAC2535; Sat, 19 Apr 2014 15:12:52 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JJCo0Z018819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 15:12:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-6-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvlVFCwwf4GeYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGnMbtTAWfpCteX/vC0sB4VayLkZNDQsBEYuHP
	KywQtpjEhXvr2boYuTiEBC4zSix5eYYdwjnHJPH58iQ2kCpeAW2Jk+t/M4LYLAKqEjcebgOz
	2QR0JRb1NDN1MXJwiAoESfw5qwhRLihxcuYTsAUiAnYS628tZAaxhQU8JSZ/2QIWFxKolDh+
	YxfYeE4BZ4kLE/6CjZEQEJfoaQwCCTML6Ei863vADGHLS2x/O4d5AqPALCQbZiEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkBAV2sG4/qTcIUYBDkYlHt4N
	AYHBQqyJZcWVuYcYJTmYlER5/64PChbiS8pPqcxILM6ILyrNSS0+xCjBwawkwjtjD1CONyWx
	siq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mCd9lJoEbBotT01Iq0zJwShDQT
	ByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7T3BEg7b3FBYi5QFKL1FKMux4WGFS1MQix5
	+XmpUuK8B0CKBECKMkrz4FbAEtIrRnGgj4UhRvEAkxncpFdAS5iAlvw9EwCypCQRISXVwLh3
	TcXnfZ/triZ7H35xsFlUuVMl+nCTxeV5DMs8brprxTDen/zM4PTGuBU7cjeuuzTn+J1QNqev
	XbMnc9gI+OrXvro1TbZqRz/f/xtWT6cyp73Ypr82bdkTqV2/P5nOEl5ncao8XpLT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246529>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Change tag.c to use ref transactions for all ref updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/tag.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 40356e3..dbeacc5 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -488,7 +488,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct strbuf ref = STRBUF_INIT;
>  	unsigned char object[20], prev[20];
>  	const char *object_ref, *tag;
> -	struct ref_lock *lock;
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int annotate = 0, force = 0, lines = -1;
> @@ -496,6 +495,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct commit_list *with_commit = NULL;
> +	struct ref_transaction *transaction;
>  	struct option options[] = {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
> @@ -641,11 +641,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (annotate)
>  		create_tag(object, tag, &buf, &opt, prev, object);
>  
> -	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
> -	if (!lock)
> -		die(_("%s: cannot lock the ref"), ref.buf);
> -	if (write_ref_sha1(lock, object, NULL) < 0)
> -		die(_("%s: cannot update the ref"), ref.buf);
> +	transaction = ref_transaction_begin();
> +	if (!transaction)
> +		die(_("%s: cannot start transaction"), ref.buf);
> +	if (ref_transaction_update(transaction, ref.buf, object, prev,
> +				   0, !is_null_sha1(prev)))
> +		die(_("%s: cannot update transaction"), ref.buf);
> +	if (ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
> +		die(_("%s: cannot commit transaction"), ref.buf);

I wonder whether these error messages are meaningful to the user.  To
the user, it's all just a failure to create the tag, right?  Does it
help to tell the user that the error was in the "start transaction",
"update transaction", or "commit transaction" phase?

In other words, maybe it would be just as good to do

if (!transaction ||
    ref_transaction_update(transaction, ref.buf, object, prev,
			   0, !is_null_sha1(prev)) ||
    ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
	die(_("%s: cannot update the ref"), ref.buf);

But then I would also hope that somebody (probably
ref_transaction_commit() now, but later maybe ref_transaction_update())
tells the user whether the problem was the inability to lock the
reference, or the consistency check of old_sha1, or whatever.

The next question is whether the generic error messages that the refs
code generates is good enough, or whether the caller would rather learn
about the reason for an error and generate its own, more specific error
message.  Please pay attention to this as you rewrite callers: by
relying more on centralized code, are we losing out unacceptably on
error message specificity?

Oh and by the way, given that you pass UPDATE_REFS_DIE_ON_ERR,
ref_transaction_commit() should never return a nonzero value, should it?

>  	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>  		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>  
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
