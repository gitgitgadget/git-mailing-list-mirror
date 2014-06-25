From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] replace: add a --raw mode for --edit
Date: Wed, 25 Jun 2014 15:33:42 -0700
Message-ID: <xmqqsims62m1.fsf@gitster.dls.corp.google.com>
References: <20140624094217.GA14216@sigill.intra.peff.net>
	<20140624094631.GD14514@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:33:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzvlK-0007Z0-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 00:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbaFYWdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 18:33:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59021 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046AbaFYWdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 18:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAFB922AB3;
	Wed, 25 Jun 2014 18:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oog8oRlPQGSdgttjcLMTvy/rvmw=; b=rqz6oF
	+eOehs3SHSCs9SUoB1+CYYvPmIoPhJnaku+tTQetPIeJLrbbsSpDtnqExPmSMIMn
	c+D1fW+Gt84OH5sdARUNGc9dPo1xTw6jgKRRcXSb0yi+Fj5kyDBpl0PHiVINC6KM
	V1wmVVNHsqQhl6KzgSRqGc1PeZM3MVEDhZnEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=revaQITKEaJjTC4PyVyAuw0prS43nvgi
	hQj1otyzvO7VGm2Lg42aCg/2wRTs0ZHmGlFmY8bU17CFZ5P3c14YGY+bczLARorr
	BQ7WNhv+cN020eP5Q2FiXOferal7tOeXQJ1HgKfwONVzX95iara+zdffFDVzi1pq
	hsRZ9sViZLo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFF3722AB1;
	Wed, 25 Jun 2014 18:33:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 10D7822AAA;
	Wed, 25 Jun 2014 18:33:37 -0400 (EDT)
In-Reply-To: <20140624094631.GD14514@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Jun 2014 05:46:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C03F4084-FCB8-11E3-8C4D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252470>

Jeff King <peff@peff.net> writes:

> One of the purposes of "git replace --edit" is to help a
> user repair objects which are malformed or corrupted.
> Usually we pretty-print trees with "ls-tree", which is much
> easier to work with than the raw binary data.  However, some
> forms of corruption break the tree-walker, in which case our
> pretty-printing fails, rendering "--edit" useless for the
> user.
>
> This patch introduces a "--raw" option, which lets you edit
> the binary data in these instances.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Hmmmmm, this feels almost like inviting accidents to make it easy
and limiting the attempt to only one shot at the "transformation"
step.

Will queue, but we can do the same with "cat-file $type >temp", do
some transformation on "temp", doubly make sure what is in "temp" is
sensible and then finally "hash-object -w -t $type temp".  And it
makes me feel uneasy that the new feature seems to make it harder to
do the "doubly make sure" part.

I dunno.

>  Documentation/git-replace.txt |  8 ++++++++
>  builtin/replace.c             | 31 +++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 61461b9..089dcac 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -73,6 +73,14 @@ OPTIONS
>  	newly created object. See linkgit:git-var[1] for details about
>  	how the editor will be chosen.
>  
> +--raw::
> +	When editing, provide the raw object contents rather than
> +	pretty-printed ones. Currently this only affects trees, which
> +	will be shown in their binary form. This is harder to work with,
> +	but can help when repairing a tree that is so corrupted it
> +	cannot be pretty-printed. Note that you may need to configure
> +	your editor to cleanly read and write binary data.
> +
>  -l <pattern>::
>  --list <pattern>::
>  	List replace refs for objects that match the given pattern (or
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 2584170..d1ea2c2 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -188,10 +188,12 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
>  }
>  
>  /*
> - * Write the contents of the object named by "sha1" to the file "filename",
> - * pretty-printed for human editing based on its type.
> + * Write the contents of the object named by "sha1" to the file "filename".
> + * If "raw" is true, then the object's raw contents are printed according to
> + * "type". Otherwise, we pretty-print the contents for human editing.
>   */
> -static void export_object(const unsigned char *sha1, const char *filename)
> +static void export_object(const unsigned char *sha1, enum object_type type,
> +			  int raw, const char *filename)
>  {
>  	struct child_process cmd = { NULL };
>  	int fd;
> @@ -202,7 +204,10 @@ static void export_object(const unsigned char *sha1, const char *filename)
>  
>  	argv_array_push(&cmd.args, "--no-replace-objects");
>  	argv_array_push(&cmd.args, "cat-file");
> -	argv_array_push(&cmd.args, "-p");
> +	if (raw)
> +		argv_array_push(&cmd.args, typename(type));
> +	else
> +		argv_array_push(&cmd.args, "-p");
>  	argv_array_push(&cmd.args, sha1_to_hex(sha1));
>  	cmd.git_cmd = 1;
>  	cmd.out = fd;
> @@ -217,7 +222,7 @@ static void export_object(const unsigned char *sha1, const char *filename)
>   * The sha1 of the written object is returned via sha1.
>   */
>  static void import_object(unsigned char *sha1, enum object_type type,
> -			  const char *filename)
> +			  int raw, const char *filename)
>  {
>  	int fd;
>  
> @@ -225,7 +230,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
>  	if (fd < 0)
>  		die_errno("unable to open %s for reading", filename);
>  
> -	if (type == OBJ_TREE) {
> +	if (!raw && type == OBJ_TREE) {
>  		const char *argv[] = { "mktree", NULL };
>  		struct child_process cmd = { argv };
>  		struct strbuf result = STRBUF_INIT;
> @@ -265,7 +270,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
>  	 */
>  }
>  
> -static int edit_and_replace(const char *object_ref, int force)
> +static int edit_and_replace(const char *object_ref, int force, int raw)
>  {
>  	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
>  	enum object_type type;
> @@ -281,10 +286,10 @@ static int edit_and_replace(const char *object_ref, int force)
>  
>  	check_ref_valid(old, prev, ref, sizeof(ref), force);
>  
> -	export_object(old, tmpfile);
> +	export_object(old, type, raw, tmpfile);
>  	if (launch_editor(tmpfile, NULL, NULL) < 0)
>  		die("editing object file failed");
> -	import_object(new, type, tmpfile);
> +	import_object(new, type, raw, tmpfile);
>  
>  	free(tmpfile);
>  
> @@ -297,6 +302,7 @@ static int edit_and_replace(const char *object_ref, int force)
>  int cmd_replace(int argc, const char **argv, const char *prefix)
>  {
>  	int force = 0;
> +	int raw = 0;
>  	const char *format = NULL;
>  	enum {
>  		MODE_UNSPECIFIED = 0,
> @@ -310,6 +316,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
>  		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
>  		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
> +		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
>  		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
>  		OPT_END()
>  	};
> @@ -329,6 +336,10 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		usage_msg_opt("-f only makes sense when writing a replacement",
>  			      git_replace_usage, options);
>  
> +	if (raw && cmdmode != MODE_EDIT)
> +		usage_msg_opt("--raw only makes sense with --edit",
> +			      git_replace_usage, options);
> +
>  	switch (cmdmode) {
>  	case MODE_DELETE:
>  		if (argc < 1)
> @@ -346,7 +357,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		if (argc != 1)
>  			usage_msg_opt("-e needs exactly one argument",
>  				      git_replace_usage, options);
> -		return edit_and_replace(argv[0], force);
> +		return edit_and_replace(argv[0], force, raw);
>  
>  	case MODE_LIST:
>  		if (argc > 1)
