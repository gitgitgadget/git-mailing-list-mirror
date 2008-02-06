From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [v8] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Wed, 06 Feb 2008 00:33:49 -0800
Message-ID: <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
References: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de>
	<12021001351967-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfjl-0003BD-69
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758751AbYBFIeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 03:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbYBFIeA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:34:00 -0500
Received: from rune.pobox.com ([208.210.124.79]:58734 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbYBFId7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 03:33:59 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A31B0193CEB;
	Wed,  6 Feb 2008 03:34:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 438E4193B74;
	Wed,  6 Feb 2008 03:34:13 -0500 (EST)
In-Reply-To: <12021001351967-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Mon, 4 Feb 2008 05:42:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72770>

Steffen Prohaska <prohaska@zib.de> writes:

> This repaces v7 of the patch and includes the following changes
>  - Commit message defends safecrlf=warn default.
>  - refactored to lines max 84 chars long.
>
>     Steffen
>
> ---- snip ---
>
> CRLF conversion bears a slight chance of corrupting data.
> ...

Is this meant for application?

If so please do not do "^---- snip ---".  More than three dashes
at the beginning of line discards everything after that from the
commit log message so "git am -i" becomes very cumbersome.  And
that is the reason you often see "-- >8 --" scissors mark from
me (notice two dashes, not three).

> autocrlf=true will convert CRLF to LF during commit and LF to
> CRLF during checkout.  A file that contains a mixture of LF and
> CRLF before the commit cannot be recreated by git.  For text
> files this does not really matter because we do not care about
> the line endings anyway; ...

That is a wrong explanation.  It is not that we do not _care_.

Far from it.  With autocrlf, we _deeply_ care about the line
endings of text files to be canonical with LF in the repository
data, and canonical with platform convention in the work tree
data.  A file with mixed LF and CRLF have _wrong_ line endings
in the work tree data, hence it actively gets _corrected_.

So it is not _anyway_.  It is what we _want to happen_.

> ... but for binary files that are
> accidentally classified as text the conversion can corrupt data.

Correct.

> In mixed Windows/Unix environments text files quite easily can
> end up containing a mixture of CRLF and LF line endings and git
> should handle such situations gracefully.  For example, a user
> could copy a CRLF file from Windows to Unix and mix it with an
> existing LF file there.  The result would contain both types of
> line endings.

Correct, but I do not think this is necessary for this commit,
as you have established already that canonicalization is what we
want for text and what we want to avoid for binary.  Just skip
these 6 lines and the thought will still flow naturally.

> Unfortunately, the desired effect of cleaning up text files with
> mixed line endings and the undesired effect of corrupting binary
> files cannot be distinguished.  In both cases CRLF endings are
> removed in an irreversible way.  For text files this is the right
> thing to do, while for binary file it corrupts data.

"CRLF" are not even "endings" in a binary file.  I'd suggest
rewriting the above paragraph as "... distinguished.  In both
cases, CRLF pairs are removed in an irreversible way."  The rest
of the paragraph is redundant --- you've said that twice already
(and I suggested to remove the second one earlier).

> In a sane environment, committing and checking out the same file
> should not modify the original file in the work tree.

Is "In a sane environment, " needed?  In what environment is it
permissible that checkout followed by commit gives a different
result?

> ... For
> autocrlf=input the original file must not contain CRLF.  For
> autocrlf=true the original file must not contain LF without
> preceding CR.  Otherwise the conversion is irreversible.  Note,
> git might be able to recreate the original file with different
> autocrlf settings, but in the current environment checking out
> will yield a file that differs from the file before the commit.

I suspect this also may be redundant.  You've already explained
that existing autocrlf conversion are lossy with respect to
mixed LF and CRLF.  I think it is easier to read if we drop
everything from "In a sane environment, " up to here.

> This patch adds a mechanism that can either warn the user about
> an irreversible conversion or can even refuse to convert.  The
> mechanism is controlled by the variable core.safecrlf, with the
> following values
>  - false: disable safecrlf mechanism
>  - warn: warn about irreversible conversions
>  - true: refuse irreversible conversions

Please end the line "following values" with a colon and have a
blan line after that.

> The default is to warn.  Users are only affected by this default
> if core.autocrlf is set.  But the current default of git is to
> leave core.autocrlf unset, so users will not see warnings unless
> they deliberately chose to activate the autocrlf mechanism.

Very sensible.

> The safecrlf mechanism's details depend on the git command.  If
> safecrlf is active (not false), files in the work tree must not
> be modified in an irreversible way without giving the user a
> chance to backup the original file.  However, for read-only
> operations that do not modify files in the work tree git should
> not print annoying warnings.
>
> git apply behave as requested by by safecrlf.  Even though
> git apply writes changes directly back to the work tree, the
> user still can get the original files back by checking out from
> the index or HEAD.  git apply should only be run on a clean
> work tree.

I think the conclusion "should" in the last sentence is wrong.
Running "apply" to get effects from more than one patches is a
norm, and you are telling the readers they are doing a wrong
thing if the did so.

With "apply", we are talking about "patches", which means we are
talking about "text", which by definition is outside of what
"safecrlf" cares about.  That is why apply does not need to be
molested.

	Side note.  Maybe when we apply a --binary patch, we
	should read the target image from the work tree without
	"convert-to-git" regardless of what the autocrlf nor the
	gitattributes say.  I did not check if we already do
	that, though.

The rest of the commit log message looked fine.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4e222f1..7ebee51 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -139,6 +139,56 @@ core.autocrlf::
>  	"text" (i.e. be subjected to the autocrlf mechanism) is
>  	decided purely based on the contents.
>  
> +core.safecrlf::
> +	If true, makes git check if converting `CRLF` as controlled by
> +	`core.autocrlf` is reversible.  Git will verify if a command
> +	modifies a file in the work tree either directly or indirectly.
> +	For example, committing a file followed by checking out the
> +	same file should yield the original file in the work tree.  If
> +	this is not the case for the current setting of
> +	`core.autocrlf`, git will reject the file.  The variable can
> +	be set to "warn", in which case git will only warn about an
> +	irreversible conversion but continue the operation.
> ++
> +CRLF conversion bears a slight chance of corrupting data.
> +...
> +mechanism.

The same comment about redundancy applies here.

> diff --git a/convert.c b/convert.c
> index 80f114b..94c70f4 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -85,8 +85,36 @@ static int is_binary(unsigned long size, struct text_stat *stats)
>  	return 0;
>  }
>  
> +static void check_safe_crlf(const char* path, int action,
> +                            struct text_stat* stats, enum safe_crlf checksafe)

Asterisk comes near the variable name not type: "const char *path".

> +{
> +	if (action == CRLF_INPUT || auto_crlf <= 0) {
> +		/*
> +		 * CRLFs would not be restored by checkout:
> +		 * check if we'd remove CRLFs
> +		 */
> +		if (stats->crlf) {
> +			if (checksafe == SAFE_CRLF_WARN)
> +				warning("CRLF will be replaced by LF in %s.", path);
> +			else
> +				die("CRLF would be replaced by LF in %s.", path);

What happens when checksafe == SAFE_CRLF_FALSE, I had to wonder,
until looking at the caller.

			else /* i.e. SAFE_CRLF_FAIL */

would have been easier to follow.

> diff --git a/sha1_file.c b/sha1_file.c
> index 66a4e00..4179949 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2358,7 +2358,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
>  	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
>  		struct strbuf nbuf;
>  		strbuf_init(&nbuf, 0);
> -		if (convert_to_git(path, buf, size, &nbuf)) {
> +		if (convert_to_git(path, buf, size, &nbuf,
> +		                   write_object ? safe_crlf : 0)) {
>  			munmap(buf, size);
>  			buf = strbuf_detach(&nbuf, &size);
>  			re_allocated = 1;

Very nicely done ;-).
