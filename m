From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow selection of different cleanup modes for commit messages
Date: Fri, 21 Dec 2007 23:59:34 -0800
Message-ID: <7v3atv17o9.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	<7vlk7plydv.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
	<20071221173521.GA3494@steel.home>
	<7v8x3n4tbe.fsf@gitster.siamese.dyndns.org>
	<20071221230851.GA3260@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5zHG-0003IQ-9O
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbXLVH7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 02:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXLVH7o
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 02:59:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXLVH7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 02:59:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F04876E59;
	Sat, 22 Dec 2007 02:59:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C6D6E58;
	Sat, 22 Dec 2007 02:59:35 -0500 (EST)
In-Reply-To: <20071221230851.GA3260@steel.home> (Alex Riesen's message of
	"Sat, 22 Dec 2007 00:08:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69123>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Fri, Dec 21, 2007 22:43:49 +0100:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > The patch is on top of my previos patches. Junio, if you wish, I can
>> > squash and resend.
>> 
>> That would be a sane thing to do.
>
> Done

Thanks.  I am afraid I have to ask you to either refute my
misunderstanding or a second round.

> +--cleanup=<mode>::
> +	This option sets how the commit message is cleaned up.
> +	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
> +	and 'default'. The 'default' mode will strip leading and
> +	trailing empty lines and #commentary from the commit message
> +	only if the message is to be edited. Otherwise only whitespace
> +	removed. The 'verbatim' mode wont change message at all,
> +	'whitespace' removes just leading/trailing whitespace lines
> +	and 'strip' removes both whitespace and commentary.

(minor) s/wont/does not/

> @@ -394,20 +410,24 @@ static int prepare_log_message(const char *index_file, const char *prefix)
>  		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
>  	}
>  
> +	if (!no_edit) {
> +		if (in_merge)
> +			fprintf(fp,
> +				"#\n"
> +				"# It looks like you may be committing a MERGE.\n"
> +				"# If this is not correct, please remove the file\n"
> +				"#	%s\n"
> +				"# and try again.\n"
> +				"#\n",
> +				git_path("MERGE_HEAD"));
> +		if (cleanup_mode != CLEANUP_NONE)
> +			fprintf(fp,
> +				"\n"
> +				"# Please enter the commit message for your changes.\n");
> +		if (cleanup_mode == CLEANUP_DEFAULT)
> +			fprintf(fp,
> +				"# (Comment lines starting with '#' will not be included)\n");

Can't cleanup_mode be CLEANUP_ALL at this point, and if so
shouldn't this insn be given as well?

In addition, if:

 - we are talking with editor, and
 - the mode is verbatim, and
 - we added any "#" line ourselves (e.g. in_merge adds the insn
   shown above, or perhaps we added "git status" output),

then perhaps we would want to say that "#" lines need to be
stripped by the user; otherwise it will be left in the commit.

> @@ -431,10 +451,13 @@ static int message_is_empty(struct strbuf *sb, int start)
>  	const char *nl;
>  	int eol, i;
>  
> +	if (cleanup_mode == CLEANUP_NONE && sb->len)
> +		return 0;
> +
>  	/* See if the template is just a prefix of the message. */
>  	strbuf_init(&tmpl, 0);
>  	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
> -		stripspace(&tmpl, 1);
> +		stripspace(&tmpl, !no_edit);

We at this point know that some stripping would happen.  The
template needs to be cleaned the same way as the commit message
was stripped.  Is checking no_edit the right thing to do?  What
if cleanup_mode was CLEANUP_ALL and there is no editing going
on?

> @@ -813,7 +846,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (p != NULL)
>  		strbuf_setlen(&sb, p - sb.buf + 1);
>  
> -	stripspace(&sb, 1);
> +	if (cleanup_mode != CLEANUP_NONE)
> +		stripspace(&sb, cleanup_mode == CLEANUP_DEFAULT ?
> +			   !no_edit: cleanup_mode == CLEANUP_ALL);

When writing such a long ? : expression, laying it out like:

	condition
        ? if-true
        : if-false

would be easier to read.  You tilt your head sideways 90
degrees, just like you read a smiley ;-), and you will see the
parse tree.

But I suspect, assuming that the two issues around CLEANUP_DEFAULT vs
CLEANUP_ALL I mentioned above are indeed bugs, it may be cleaner
to:

  - parse the options; you get one of NONE/DEFAULT/SPACE/ALL

  - convert DEFAULT to SPACE or ALL if editor is in effect.

  - do not worry about no_editor or DEFAULT in the rest of the
    code when calling stripspace().  The only values you will
    see are NONE, SPACE or ALL.

> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 21ac785..6219378 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -89,4 +89,44 @@ test_expect_success 'verbose' '
>  
>  '
>  
> +test_expect_success 'verbatim commit messages' '
> +

These tests check too many things at once, and it would be very
hard to diagnose when breakage does happen.  Please split them
perhaps into three separate tests like this:

> +	echo >>negative &&
> +	{ echo;echo "# text";echo; } >expect &&
> +	git commit --cleanup=verbatim -t expect -a &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
> +	diff -u expect actual &&

This is one test --- making sure the commit body match the
unedited template verbatim, except the status part to be shown
in the editor.  But we are not using editor in this test and I
thought the point of this --cleanup=verbatim exercise was that
the "status" part is not even have to be added to the commit log
message when editor is not in effect...  Isn't the "head -n 3"
just sweeping a bug under the rug?

> +	echo >>negative &&
> +	git commit --cleanup=verbatim -F expect -a &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> +	diff -u expect actual &&

And this is another test.

> +	echo >>negative &&
> +	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
> +	diff -u expect actual

And this is yet another.

> +'

Also, the tests do not check "-F file -e", "-m msg -e" etc.  We
would want to make sure the right insn are shown to the user in
the editor, wouldn't we?
