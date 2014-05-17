From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 25/44] receive-pack.c: use a reference transaction
 for updating the refs
Date: Sat, 17 May 2014 17:35:38 +0200
Message-ID: <537781CA.1010208@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-26-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 17:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlgeJ-0002uO-TK
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432AbaEQPfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:35:42 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57336 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757412AbaEQPfl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 11:35:41 -0400
X-AuditID: 1207440e-f79026d000000c25-4f-537781cc5d92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 46.E9.03109.CC187735; Sat, 17 May 2014 11:35:40 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HFZcwr030013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 11:35:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-26-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHumsTzY4NdsbYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGw0/L2AoaZSouvNzP3sC4TqyLkZNDQsBE4u3s
	HkYIW0ziwr31bF2MXBxCApcZJb59PMwM4Zxnkti4+xwLSBWvgLbE3pW9YB0sAqoSL9beBIuz
	CehKLOppZupi5OAQFQiS+HNWEaJcUOLkzCdgJSICdhLrby1kBrGFBZIk2v73sYPYQgI1Eu1v
	l4LFOQVcJV7P2Qc2RkJAXKKnMQgkzCygI/Gu7wEzhC0vsf3tHOYJjAKzkGyYhaRsFpKyBYzM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCQpRvB2P7eplDjAIcjEo8vCtF
	yoOFWBPLiitzDzFKcjApifLaxgKF+JLyUyozEosz4otKc1KLDzFKcDArifDudgPK8aYkVlal
	FuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeHmBsSgkWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4rT+GJgpIKkeID2ioC08xYXJOYCRSFaTzHqcpy6c6yNSYglLz8v
	VUqcd249UJEASFFGaR7cClhCesUoDvSxMK80yCgeYDKDm/QKaAkT0JI3e0tBlpQkIqSkGhh7
	b3fvK5w3rbb8a8yzvhsVVyvu/g6R3nyv84/K/a9z06RLWB5XiLqrnJu0LF5GrLHzizD/Ob5N
	G6+2vphlWfbU4UDzzk7tiLmifZwVd0wdzWp95yTvF1r/58C1upl/eRkmn6p7Z94l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249473>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> Wrap all the ref updates inside a transaction to make the update atomic.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/receive-pack.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..5534138 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>  static int sent_capabilities;
>  static int shallow_update;
>  static const char *alt_shallow_file;
> +static struct strbuf err = STRBUF_INIT;
> +static struct ref_transaction *transaction;
>  
>  static enum deny_action parse_deny_action(const char *var, const char *value)
>  {
> @@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  	const char *namespaced_name;
>  	unsigned char *old_sha1 = cmd->old_sha1;
>  	unsigned char *new_sha1 = cmd->new_sha1;
> -	struct ref_lock *lock;
>  
>  	/* only refs/... are allowed */
>  	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
> @@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		    update_shallow_ref(cmd, si))
>  			return "shallow error";
>  
> -		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
> -					       0, NULL);
> -		if (!lock) {
> -			rp_error("failed to lock %s", name);
> -			return "failed to lock";
> -		}
> -		if (write_ref_sha1(lock, new_sha1, "push")) {
> -			return "failed to write"; /* error() already called */
> -		}
> +		if (ref_transaction_update(transaction, namespaced_name,
> +					   new_sha1, old_sha1, 0, 1, &err))
> +			return "failed to update";
>  		return NULL; /* good */
>  	}
>  }
> @@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
>  	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
>  
>  	checked_connectivity = 1;
> +	transaction = ref_transaction_begin();
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (cmd->error_string)
>  			continue;
> @@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
>  			checked_connectivity = 0;
>  		}
>  	}
> +	if (ref_transaction_commit(transaction, "push", &err))
> +		error("%s", err.buf);
> +	ref_transaction_free(transaction);
> +	strbuf_release(&err);
>  
>  	if (shallow_update && !checked_connectivity)
>  		error("BUG: run 'git fsck' for safety.\n"
> 

This patch is strange, because even if one ref_transaction_update() call
fails, subsequent updates are nevertheless also attempted, and the
ref_transaction_commit() is also attempted.  Is this an officially
sanctioned use of the ref_transactions API?  Should it be?  It might be
a way to give feedback to the user on multiple attempted reference
updates at once (i.e., address my comment about the last patch).

If this is sanctioned, then it might be appropriate for the transaction
to keep track of the fact that one or more reference updates failed, and
when *_commit() is called to fail the whole transaction.

In any case, I think it is important to document, as part of the API
docs, whether this is sanctioned or not, and if so, what exactly are its
semantics.

I've run out of time for today so I'm going to have to stop here.  FWIW
patches 01-23 looked OK aside from the comments that I have made.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
