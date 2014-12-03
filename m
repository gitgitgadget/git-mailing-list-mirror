From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] refs.c: add a transaction function to append a
 reflog entry
Date: Tue, 2 Dec 2014 19:15:19 -0800
Message-ID: <20141203031519.GF6527@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw0PX-0003xi-DF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 04:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbaLCDPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 22:15:24 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42058 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaLCDPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 22:15:23 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so16197666igd.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 19:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SGLaJ/KBiSAujKnDNvR5Q/hAK93Ba5/K6Pc5HoQxjgc=;
        b=CXmewQeLJEYxjQcx61eF28ILjxBfvL6alOlnZ7IJody4hEN5urV7o7gTiB+4ZkGaN3
         YbJOUHcR9OxrLQfQFB7CqXbQe6GmcmXhlyZW5EP8ece0pvB9lcC5nz7YXlykIQqBK6iW
         NynI6FtofVxPo7mWzXe0XcaLnGNvdWyZQDoSBHSRIlr6yhqXSZvxfDpQsFJv+ZhHvQqA
         gl3AvD3/sfL+UsJwJErOZvq8H4Kf0ZAAOPJocyFD8OEdnfi8lQAIs1XCFCiMzR3eZnL6
         Ok7c1qi/K1nDyMXvinOhUmOxOoPovfGv4tBfjJo/hQHnkFYFOVubk7t0HLe2IUCTOiAA
         Nlxw==
X-Received: by 10.107.168.18 with SMTP id r18mr2671599ioe.76.1417576522221;
        Tue, 02 Dec 2014 19:15:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id lr5sm13112169igb.16.2014.12.02.19.15.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 19:15:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417506402-24257-4-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260619>

Stefan Beller wrote:

> When performing a reflog transaction update, only write to the reflog iff
> msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
> an update that only truncates but does not write. This change only affects
> whether or not a reflog entry should be generated and written. If msg == NULL
> then no such entry will be written.
>
> Orthogonal to this we have a boolean flag REFLOG_TRUNCATE which is used to
> tell the transaction system to "truncate the reflog and thus discard all
> previous users".
>
> At the current time the only place where we use msg == NULL is also the
> place, where we use REFLOG_TRUNCATE. Even though these two settings are
> currently only ever used together it still makes sense to have them through
> two separate knobs.
>
> This allows future consumers of this API that may want to do things
> differently. For example someone can do:
>   msg="Reflog truncated by Bob because ..." + REFLOG_TRUNCATE
> and have it truncate the log and have it start fresh with an initial message
> that explains the log was truncated. This API allows that.
>
> During one transaction we allow to make multiple reflog updates to the
> same ref. This means we only need to lock the reflog once, during the first
> update that touches the reflog, and that all further updates can just write the
> reflog entry since the reflog is already locked.

I'm having trouble parsing all of the above.  Can you explain the
motivation of the patch in a sentence or so?  Afterward that, if the
API is not self-explanatory, there could be a short explanation of it
(e.g., a list of functions and how they get used).

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -3557,6 +3557,12 @@ struct transaction {
>  	struct ref_update **ref_updates;
>  	size_t alloc;
>  	size_t nr;
> +
> +	/*
> +	 * Sorted list of reflogs to be committed,
> +	 * the util points to the lock_file
> +	 */
> +	struct string_list reflog_updates;

Grammar nit: where there is a comma here, there should be the end of a
sentence.

[...]
> @@ -3564,7 +3570,10 @@ struct transaction *transaction_begin(struct strbuf *err)
>  {
>  	assert(err);
>  
> -	return xcalloc(1, sizeof(struct transaction));
> +	struct transaction *ret = xcalloc(1, sizeof(struct transaction));
> +	string_list_init(&ret->reflog_updates, 1);

Can do

	ret->reflog_updates.strdup_strings = 1;

instead, since calloc already zeroed the memory.

[...]
> +/* Returns a fd, -1 on error. */
> +static int get_reflog_updates_fd(struct transaction *transaction,
> +				 const char *refname,
> +				 struct strbuf *err)
> +{
> +	char *path;
> +	struct lock_file *lock;
> +	struct string_list_item *item = string_list_insert(
> +						&transaction->reflog_updates,
> +						refname);
> +	if (!item->util) {

It can be clearer to handle the simple case first:

	if (item->util) {
		lock = item->util;
		return lock->fd;
	}

	item->util = xcalloc(...);

> +		item->util = xcalloc(1, sizeof(struct lock_file));
> +		lock = item->util;
> +		path = git_path("logs/locks/%s", refname);
> +		if (safe_create_leading_directories(path)) {
> +			strbuf_addf(err,
> +				    "creating temporary directories %s failed.",
> +				    path);

Looking at other callers, looks like something like

	if (scld(path)) {
		strbuf_addf(err, "could not create leading directories of '%s': %s",
			    path, strerror(errno));

is common.  That way, the message includes details from errno, it's
clear that one of the leading directories to $path, not $path itself,
was what could not be created, and there is no trailing '.' at the end
of the message.

> +		if (hold_lock_file_for_update(lock, path, 0) < 0) {
> +			strbuf_addf(err,
> +				    "creating temporary file %s failed.",
> +				    path);

hold_lock_file_for_update() is weird and has its own special error
message writing function:

			unable_to_lock_message(path, errno, err);

That lets it give advice to the user about why writing the .lock
file failed and how to fix it.

I have a series that simplifies by making it write directly to a
strbuf passed as an argument, but that's orthogonal to this patch.

[...]
> +int transaction_update_reflog(struct transaction *transaction,
> +			      const char *refname,
> +			      const unsigned char *new_sha1,
> +			      const unsigned char *old_sha1,
> +			      const char *email,
> +			      unsigned long timestamp, int tz,
> +			      const char *msg, int flags,
> +			      struct strbuf *err)

This is an intimidating list of arguments.  Would it make sense to
pack them into a struct, or to make the list less intimidating
some other way (e.g. combining email + timestamp + tz into an
ident string)?

[...]
> +	fd = get_reflog_updates_fd(transaction, refname, err);
> +	if (!fd)
> +		goto failure;

if (fd < 0)

[...]
> +	if (flags & REFLOG_TRUNCATE) {
> +		if (lseek(fd, 0, SEEK_SET) < 0 ||
> +			ftruncate(fd, 0)) {
> +			strbuf_addf(err, "Could not truncate reflog: %s. %s",
> +				    refname, strerror(errno));

Odd error message format (using '.' to separate the refname from
strerror(errno) is unusual).  Errors normally are supposed to start
with a lowercase letter, like

	cannot truncate reflog '%s': %s

> +			goto failure;
> +		}
> +	}

How does this cause the reflog to be populated in the !(flags &
REFLOG_TRUNCATE) case?

Maybe I am misunderstanding the API.  If I use
transaction_update_reflog() and have not updated the reflog
previously, isn't this supposed to just append a new entry to the
reflog?

[...]
> +failure:
> +	strbuf_release(&buf);
> +	/*
> +	 * As we are using the lock file API, any stale files left behind will
> +	 * be taken care of, no need to do anything here.
> +	 */

That's only true if the caller is going to exit instead of proceeding
to other work.

With current callers, I assume that's true.  So should this comment
say something like "No need to roll back stale lock files because
the caller will exit soon"?  Or should this roll back the lockfile
anyway, in case the caller wants to try again?

> +
> +	transaction->state = TRANSACTION_CLOSED;
> +	return 1;

The normal convention is -1 on error.

[...]
> @@ -3796,6 +3912,13 @@ int transaction_commit(struct transaction *transaction,
>  	}
>  	for (i = 0; i < delnum; i++)
>  		unlink_or_warn(git_path("logs/%s", delnames[i]));
> +
> +	/* Commit all reflog updates*/
> +	for_each_string_list_item(item, &transaction->reflog_updates) {
> +		struct lock_file *lock = item->util;
> +		commit_lock_file_to(lock, git_path("logs/%s", item->string));

Neat.

This seems like a good starting point.  Other code paths still write
to reflogs directly --- is there a plan to get them to use this code,
too, in a followup patch (e.g., by making write_ref_sha1() or
log_ref_write() use its own small transaction for the reflog update)?

Thanks and hope that helps,
Jonathan
