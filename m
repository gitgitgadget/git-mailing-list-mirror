From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use a hash of the lock token as the suffix for PUT/MOVE
Date: Sat, 14 Feb 2009 00:34:09 -0800
Message-ID: <7vskmhwh6m.fsf@gitster.siamese.dyndns.org>
References: <49967321.10800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 09:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYG1y-0004Ey-9G
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 09:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbZBNIeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 03:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZBNIeQ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 03:34:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZBNIeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 03:34:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B83492B197;
	Sat, 14 Feb 2009 03:34:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E1B1E2B196; Sat,
 14 Feb 2009 03:34:10 -0500 (EST)
In-Reply-To: <49967321.10800@gmail.com> (Tay Ray Chuan's message of "Sat, 14
 Feb 2009 15:30:41 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42F27950-FA72-11DD-8878-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109844>

Tay Ray Chuan <rctay89@gmail.com> writes:

> After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
> lock tokens are in the URI forms in which they are received from the
> server, eg. 'opaquelocktoken:', 'urn:uuid:'.
>
> However, "start_put" (and consequently "start_move"), which attempts to
> create a unique temporary file using the UUID of the lock token,
> inadvertently uses the lock token in its URI form. These file
> operations on the server may not be successful (specifically, in
> Windows), due to the colon ':' character from the URI form of the lock
> token in the file path.
>
> This patch uses a hash of the lock token instead, guaranteeing only
> "safe" characters (a-f, 0-9) are used in the file path.
>
> The token's hash is generated when the lock token is received from the
> server in handle_new_lock_ctx, minimizing the number of times of
> hashing.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Thanks, very clearly written.

> diff --git a/http-push.c b/http-push.c
> index eefd64c..0a252dd 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -153,6 +153,7 @@ struct remote_lock
>  	char *url;
>  	char *owner;
>  	char *token;
> +	char *token_sha1_hex;

At this point, this new field is only used as a unique suffix, and
"sha1_hex" is a implementation detail of the mechanism to guarantee the
uniqueness.  Naming things for what they are is preferred over naming
things for how they are crafted.  Hence:

	char tmpfile_suffix[41];

would be a better definition here.

> @@ -558,7 +559,7 @@ static void start_put(struct transfer_request *request)
>
>  	append_remote_object_url(&buf, remote->url, hex, 0);
>  	strbuf_addstr(&buf, "_");
> -	strbuf_addstr(&buf, request->lock->token);
> +	strbuf_addstr(&buf, request->lock->token_sha1_hex, 41);

And replace these two strbuf_addstr() with:

	strbuf_add(&buf, request->lock->tmpfile_suffix, 41);

> @@ -1130,6 +1131,8 @@ static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
>  static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
>  {
>  	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
> +	git_SHA_CTX sha_ctx;
> +	unsigned char lock_token_sha1[20];
>
>  	if (tag_closed && ctx->cdata) {
>  		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
> @@ -1142,6 +1145,12 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
>  		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
>  			lock->token = xmalloc(strlen(ctx->cdata) + 1);
>  			strcpy(lock->token, ctx->cdata);
> +
> +			git_SHA1_Init(&sha_ctx);
> +			git_SHA1_Update(&sha_ctx, lock->token, strlen(lock->token));
> +			git_SHA1_Final(lock_token_sha1, &sha_ctx);
> +
> +			lock->token_sha1_hex = sha1_to_hex(lock_token_sha1);

The last one is wrong because string returned by sha1_to_hex() is
volatile.

	lock->tmpfile_suffix[0] = '_';
        memcpy(lock->tmpfile_suffix + 1, sha1_to_hex(sha1));

Other than that, I think this is a good patch.
