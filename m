From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 13/44] tag.c: use ref transactions when doing updates
Date: Sat, 17 May 2014 15:09:11 +0200
Message-ID: <53775F77.2070004@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-14-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 15:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WleMZ-0002jf-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 15:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbaEQNJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 09:09:15 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59612 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756517AbaEQNJO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 09:09:14 -0400
X-AuditID: 12074414-f79f86d000000b9f-39-53775f791daa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 93.DA.02975.97F57735; Sat, 17 May 2014 09:09:13 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HD9B3X023867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 09:09:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-14-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1K2MLw82mHuHy6LrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ0x9f8J9oLjIhXXnjg1MB4Q6GLk4JAQMJGYvka6
	i5ETyBSTuHBvPVsXIxeHkMBlRomD/58zQzjnmSSWLv/HCFLFK6AtcXblKyYQm0VAVWJWSysb
	iM0moCuxqKeZCWSoqECQxJ+zihDlghInZz5hAbFFBOwk1t9ayAxiCwv4SvR3LQQrFxKokfj8
	EWw6p4CrxJMr7xghThOX6GkMAgkzC+hIvOt7wAxhy0tsfzuHeQKjwCwkC2YhKZuFpGwBI/Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJDgFNnBeOSk3CFGAQ5GJR7eBPuy
	YCHWxLLiytxDjJIcTEqivLax5cFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHh3uwHleFMSK6tS
	i/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeD3igBoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQREaXwyMUZAUD9BeUZB23uKCxFygKETrKUZdjlN3jrUxCbHk5eel
	SgFdAHK4AEhRRmke3ApYKnrFKA70sTBvEMgoHmAag5v0CmgJE9CSN3tLQZaUJCKkpBoYV0hs
	D/v163Kapfn+QhP9z55lwd/ZLae9eW54/3rG8QdHvD5Vaums2L7PRcPf6+mRC9LV6S++52+T
	fTHJ7sydNaWpMfffJE30Zr+/J1j3GANfZ4tM2dS/F7XL+PbEnraIOT1jhc3pp+8n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249466>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> Change tag.c to use ref transactions for all ref updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/tag.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index c6e8a71..b05f9a5 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct strbuf ref = STRBUF_INIT;
>  	unsigned char object[20], prev[20];
>  	const char *object_ref, *tag;
> -	struct ref_lock *lock;
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int annotate = 0, force = 0, lines = -1;
> @@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct commit_list *with_commit = NULL;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
>  	struct option options[] = {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
> @@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
> +				   0, !is_null_sha1(prev), &err) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +		die("%s", err.buf);

If ref_transaction_begin() fails, then won't err still be empty?  (I
know it can't happen, and you know it can't happen, but should the
caller have to know that?)  It almost seems like ref_transaction_begin()
should have an err parameter, too.

It's kindof late for this question to pop into my head, but: have you
thought about embedding the err strbuf in the transaction object?  I
admit it would make the problem with ref_transaction_begin() even worse,
but maybe it would be a net win in terms of boilerplate?

>  	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>  		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>  
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
