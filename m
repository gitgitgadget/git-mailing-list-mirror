From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Sat, 26 Apr 2014 01:16:21 +0200
Message-ID: <535AECC5.3090100@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com> <1398442494-23438-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpM6-0007tm-3n
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaDYXQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:16:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43761 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbaDYXQY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:16:24 -0400
X-AuditID: 12074413-f79076d000002d17-b8-535aecc79b6e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 52.E2.11543.7CCEA535; Fri, 25 Apr 2014 19:16:23 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3785.dip0.t-ipconnect.de [93.219.55.133])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3PNGMeX010979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 25 Apr 2014 19:16:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398442494-23438-17-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1D3+JirY4OYqI4uuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGjGUZBZ3SFV8/3GRrYPwh0sXIySEhYCJxZmET
	O4QtJnHh3nq2LkYuDiGBy4wSE9d8ZYdwzjNJnHjYytzFyMHBK6AtcfOZKIjJIqAqMfWiAUgv
	m4CuxKKeZiaQsKhAkMSfs4ogYV4BQYmTM5+wgNgiAnYS628tZAaxhQX8JdY+eMoGYgsJ1Ehc
	XLGIEcTmFHCVOPxwL9gYCQFxiZ7GIJAws4COxLu+B8wQtrzE9rdzmCcwCsxCsmEWkrJZSMoW
	MDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJTuEdjLtOyh1iFOBgVOLh
	3ZkTFSzEmlhWXJl7iFGSg0lJlFf2NVCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/RB0A53pTE
	yqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEbzbIUMGi1PTUirTMnBKENBMH
	J8hwLimR4tS8lNSixNKSjHhQhMYXA2MUJMUDtLcWpJ23uCAxFygK0XqKUZfjQsOKFiYhlrz8
	vFQpcd7Dr4CKBECKMkrz4FbAUtErRnGgj4UhLuEBpjG4Sa+AljABLSmYEA6ypCQRISXVwFh7
	MvCuzZcJ535c9LK93lthzvF6/vuLX2Sf81SWLut9b20g7iXBIZLAbn1bcJniF4nVTAHZEf28
	EpWaj2XcX1oeObPyc9tBIZsY1b/fnxv+sVT4rJrw7KDIz2UNpyO35F66wXBmze7s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247131>

On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
> Change create_branch to use a ref transaction when creating the new branch.
> ref_transaction_create will check that the ref does not already exist and fail
> otherwise meaning that we no longer need to keep a lock on the ref during the
> setup_tracking. This simplifies the code since we can now do the transaction
> in one single step.
> 
> If the forcing flag is false then use ref_transaction_create since this will
> fail if the ref already exist. Otherwise use ref_transaction_update.
> 
> This also fixes a race condition in the old code where two concurrent
> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
> did not protect against the ref already existsing. I.e. one thread could end up
> overwriting a branch even if the forcing flag is false.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  branch.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 660097b..23cde1e 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>  		   int force, int reflog, int clobber_head,
>  		   int quiet, enum branch_track track)
>  {
> -	struct ref_lock *lock = NULL;
>  	struct commit *commit;
>  	unsigned char sha1[20];
>  	char *real_ref, msg[PATH_MAX + 20];
> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>  		die(_("Not a valid branch point: '%s'."), start_name);
>  	hashcpy(sha1, commit->object.sha1);
>  
> -	if (!dont_change_ref) {
> -		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
> -		if (!lock)
> -			die_errno(_("Failed to lock ref for update"));
> -	}
> -
> -	if (reflog)
> -		log_all_ref_updates = 1;
> -
>  	if (forcing)
>  		snprintf(msg, sizeof msg, "branch: Reset to %s",
>  			 start_name);
> @@ -301,13 +291,34 @@ void create_branch(const char *head,
>  		snprintf(msg, sizeof msg, "branch: Created from %s",
>  			 start_name);
>  
> +	if (reflog)
> +		log_all_ref_updates = 1;
> +
> +	if (!dont_change_ref) {
> +		struct ref_transaction *transaction;
> +		char *err = NULL;
> +
> +		transaction = ref_transaction_begin();
> +		if (forcing) {
> +			if (!transaction ||
> +			    ref_transaction_update(transaction, ref.buf, sha1,
> +						   NULL, 0, 0) ||
> +			    ref_transaction_commit(transaction, msg, &err))
> +			  die_errno(_("%s: failed to write ref: %s"),
> +				    ref.buf, err);
> +		} else {
> +			if (!transaction ||
> +			    ref_transaction_create(transaction, ref.buf, sha1,
> +						   0) ||
> +			    ref_transaction_commit(transaction, msg, &err))
> +			  die_errno(_("%s: failed to write ref: %s"),
> +				    ref.buf, err);
> +		}

You've got some indentation problems above.

But actually, there seems like a lot of duplicated code here.  Couldn't
you instead do a single block with have_old set based on forcing:

    ref_transaction_update(transaction, ref.buf, sha1,
			   null_sha1, 0, !forcing)

?

> +	}
> +
>  	if (real_ref && track)
>  		setup_tracking(ref.buf + 11, real_ref, track, quiet);
>  
> -	if (!dont_change_ref)
> -		if (write_ref_sha1(lock, sha1, msg) < 0)
> -			die_errno(_("Failed to write ref"));
> -
>  	strbuf_release(&ref);
>  	free(real_ref);
>  }
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
