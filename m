From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 19:29:38 +0200
Message-ID: <4F71F902.8090200@in.waw.pl>
References: <4F71E415.9030800@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net
To: Mathias Weber <mweb@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCaDb-0006CC-3y
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab2C0R3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:29:52 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56405 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab2C0R3q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:29:46 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SCaDI-0002zV-4o; Tue, 27 Mar 2012 19:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <4F71E415.9030800@gmx.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194060>

On 03/27/2012 06:00 PM, Mathias Weber wrote:
>
> The tag command does not support the --author option as the
> commit command. This adds the --author option to create
> annotated tags with a different author.

Consistency is good.

> Signed-off-by: Mathias Weber<mathew.weber@gmail.com>
> ---
>   builtin/tag.c |   26 +++++++++++++++++++++++---
>   1 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index fe7e5e5..416fa88 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -309,17 +309,34 @@ struct create_tag_options {
>
>   static void create_tag(const unsigned char *object, const char *tag,
>   		       struct strbuf *buf, struct create_tag_options *opt,
> -		       unsigned char *prev, unsigned char *result)
> +		       unsigned char *prev, unsigned char *result,
> +		       const char *force_author)
>   {
>   	enum object_type type;
>   	char header_buf[1024];
>   	int header_len;
>   	char *path = NULL;
> +	char *name, *email;
> +	const char *author_ident;
>
>   	type = sha1_object_info(object, NULL);
>   	if (type<= OBJ_NONE)
>   	    die(_("bad object type."));
>
> +	if (force_author) {
> +		const char *lb = strstr(force_author, "<");
> +		const char *rb = strchr(force_author, '>');
> +
> +		if (!lb || !rb)
> +			die(_("malformed --author parameter"));
> +			name = xstrndup(force_author, lb - force_author);
> +			email = xstrndup(lb + 2, rb - (lb + 2));

This part is identical to builtin/commit.c, it would be nice to refactor 
it into a function.

Zbyszek

> +
> +		author_ident = fmt_ident(name, email, getenv("GIT_AUTHOR_DATE"),
> +				IDENT_ERROR_ON_NO_NAME);
> +	} else
> +		author_ident = git_committer_info(IDENT_ERROR_ON_NO_NAME);
> +
>   	header_len = snprintf(header_buf, sizeof(header_buf),
>   			  "object %s\n"
>   			  "type %s\n"
> @@ -328,7 +345,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>   			  sha1_to_hex(object),
>   			  typename(type),
>   			  tag,
> -			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
> +			  author_ident);
>
>   	if (header_len>  sizeof(header_buf) - 1)
>   		die(_("tag header too big."));
> @@ -438,6 +455,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>   		delete = 0, verify = 0;
>   	const char *msgfile = NULL, *keyid = NULL;
>   	struct msg_arg msg = { 0, STRBUF_INIT };
> +	const char *force_author = NULL;
>   	struct commit_list *with_commit = NULL;
>   	struct option options[] = {
>   		OPT_BOOLEAN('l', "list",&list, "list tag names"),
> @@ -452,6 +470,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>   					"annotated tag, needs a message"),
>   		OPT_CALLBACK('m', "message",&msg, "message",
>   			     "tag message", parse_msg_arg),
> +		OPT_STRING(0, "author",&force_author, "author",
> +				 "override author for annotated tag"),
>   		OPT_FILENAME('F', "file",&msgfile, "read message from file"),
>   		OPT_BOOLEAN('s', "sign",&opt.sign, "annotated and GPG-signed tag"),
>   		OPT_STRING(0, "cleanup",&cleanup_arg, "mode",
> @@ -556,7 +576,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>   		die(_("Invalid cleanup mode %s"), cleanup_arg);
>
>   	if (annotate)
> -		create_tag(object, tag,&buf,&opt, prev, object);
> +		create_tag(object, tag,&buf,&opt, prev, object, force_author);
>
>   	lock = lock_any_ref_for_update(ref.buf, prev, 0);
>   	if (!lock)
