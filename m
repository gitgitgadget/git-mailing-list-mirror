From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 11/19] tag.c: use ref transactions when doing updates
Date: Sat, 26 Apr 2014 00:58:35 +0200
Message-ID: <535AE89B.2000408@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com> <1398442494-23438-12-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 00:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdp4u-00049B-8C
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbaDYW6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:58:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61064 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287AbaDYW6i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 18:58:38 -0400
X-AuditID: 1207440c-f79656d000003eba-e5-535ae89db437
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.B0.16058.D98EA535; Fri, 25 Apr 2014 18:58:37 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3785.dip0.t-ipconnect.de [93.219.55.133])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3PMwZmG010173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 25 Apr 2014 18:58:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398442494-23438-12-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1J37IirYoOMLq0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj6Mt2xoJuwYoT11azNzBe4+1i5OSQEDCR+Nfd
	ywhhi0lcuLeerYuRi0NI4DKjxI9ZncwQznkmiRsNe4EyHBy8AtoSTUs4QEwWAVWJq/OEQHrZ
	BHQlFvU0M4GERQWCJP6cVQQJ8woISpyc+YQFxBYRsJNYf2shM4gtLOAj8eF6J9haIYEaibWv
	fjCB2JwCrhK3+3cyg4yREBCX6GkMAgkzC+hIvOt7wAxhy0tsfzuHeQKjwCwkG2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJDw5NnB+G2dzCFGAQ5GJR7e
	nTlRwUKsiWXFlbmHGCU5mJREeTOfAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ8B59AJTjTUms
	rEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnwZj8HahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxWh8MTBKQVI8QHt5Qdp5iwsSc4GiEK2nGHU5LjSsaGESYsnL
	z0uVEuddCHK4AEhRRmke3ApYMnrFKA70sTBvFsgoHmAig5v0CmgJE9CSggnhIEtKEhFSUg2M
	xj1nq8SYrSOYndhTFybd3suxznWHlvf8dVappz/I5d1xW6268+nx/y9qrzQ3J4qxvj9ir8Da
	4+X+p8/nv2jFwczqPTOmC+2w1NN98S5iZ8Z3q11pZ26dMuD7wjRdm/1f8fGmlOos 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247126>

On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
> Change tag.c to use ref transactions for all ref updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/tag.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 40356e3..dd53fb4 100644
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
> @@ -496,6 +495,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct commit_list *with_commit = NULL;
> +	struct ref_transaction *transaction;
> +	char *err = NULL;
>  	struct option options[] = {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
> @@ -641,11 +642,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (annotate)
>  		create_tag(object, tag, &buf, &opt, prev, object);
>  
> -	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
> -	if (!lock)
> -		die(_("%s: cannot lock the ref"), ref.buf);
> -	if (write_ref_sha1(lock, object, NULL) < 0)
> -		die(_("%s: cannot update the ref"), ref.buf);
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref.buf, object, prev,
> +				   0, !is_null_sha1(prev)) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +	  die(_("%s: cannot update the ref: %s"), ref.buf, err);

Formatting nit: die() should be indented by two TABs.

>  	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>  		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>  
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
