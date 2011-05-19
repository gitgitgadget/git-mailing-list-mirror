From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] notes remove: --stdin reads from the standard input
Date: Thu, 19 May 2011 08:50:00 +0200
Message-ID: <4DD4BD98.6040805@drmicha.warpmail.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com> <1305764061-21303-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx3i-0003fc-7R
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634Ab1ESGuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:50:03 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40106 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932236Ab1ESGuC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 02:50:02 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 60B9E20D89;
	Thu, 19 May 2011 02:50:02 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 19 May 2011 02:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=z0qsxLzIBro2EVr6ET2HOM7JVVA=; b=KUgTV/+6SAl2tscnXQ0vZQe5DbPzYVjy51d08/s03RJOg159NCTpf7CSTE7QsnR/FvM+EMsu0B0rHpKfWI6B2jQWrGmR0Ot+QAMkheecgkDcyRd2PukjtUQYYpF22wwVdHwoYHBG5kClDG1xf9DP5VYua8A718iiB0FLDRYiRz8=
X-Sasl-enc: 9z153hB/fwMMgRtytcAYdYm7aoaG1r7HmosbeaTPfHlE 1305787802
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6DEE140410A;
	Thu, 19 May 2011 02:50:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1305764061-21303-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173938>

Junio C Hamano venit, vidit, dixit 19.05.2011 02:14:
> Teach the command to read object names to remove from the standard
> input, in addition to the object names given from the command line.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * The logical conclusion of the series.

So that makes 4/3 to be... ;)

I'm torn between asking for a rev-list interface and being happy with
--stdin. I guess we have other places where we allow lists of objects in
argv and stdin (instead of rev-list), and since this targets all kinds
of objects, it's more natural as is (than with with the rev-list interface).

> ---
>  Documentation/git-notes.txt |    7 ++++++-
>  builtin/notes.c             |   14 +++++++++++++-
>  t/t3301-notes.sh            |   33 +++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 6b92060..42e4823 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
>  'git notes' merge --commit [-v | -q]
>  'git notes' merge --abort [-v | -q]
> -'git notes' remove [--missing-ok] [<object>...]
> +'git notes' remove [--missing-ok] [--stdin] [<object>...]
>  'git notes' prune [-n | -v]
>  'git notes' get-ref
>  
> @@ -159,6 +159,11 @@ OPTIONS
>  	Do not consider it an error to request removing notes from an
>  	object that does not have notes attached to it.
>  
> +--stdin::
> +	Also read the object names to remove notes from from the standard
> +	input (there is no reason you cannot combine this with object
> +	names from the command line).
> +
>  -n::
>  --dry-run::
>  	Do not remove anything; just report the object names whose notes
> diff --git a/builtin/notes.c b/builtin/notes.c
> index ca045f8..23954e0 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -972,10 +972,13 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
>  static int remove_cmd(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned flag = 0;
> +	int from_stdin = 0;
>  	struct option options[] = {
>  		OPT_BIT(0, "missing-ok", &flag,
>  			"attempt to remove non-existent note is not an error",
>  			MISSING_OK),
> +		OPT_BOOLEAN(0, "stdin", &from_stdin,
> +			    "read object names from the standard input"),
>  		OPT_END()
>  	};
>  	struct notes_tree *t;
> @@ -986,7 +989,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
>  
>  	t = init_notes_check("remove");
>  
> -	if (!argc) {
> +	if (!argc && !from_stdin) {
>  		retval = remove_one_note(t, "HEAD", flag);
>  	} else {
>  		while (*argv) {
> @@ -994,6 +997,15 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
>  			argv++;
>  		}
>  	}
> +	if (from_stdin) {
> +		struct strbuf sb = STRBUF_INIT;
> +		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
> +			int len = sb.len;
> +			if (len && sb.buf[len - 1] == '\n')
> +				sb.buf[--len] = '\0';
> +			retval |= remove_one_note(t, sb.buf, flag);
> +		}
> +	}
>  	if (!retval)
>  		commit_notes(t, "Notes removed by 'git notes remove'");
>  	free_notes(t);
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index bdd4036..2c52f21 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -473,6 +473,39 @@ test_expect_success 'removing with --missing-ok but bogus ref' '
>  	test "$before" = "$after"
>  '
>  
> +test_expect_success 'remove reads from --stdin' '
> +	before=$(git rev-parse --verify refs/notes/commits) &&
> +	test_when_finished "git update-ref refs/notes/commits $before" &&
> +	git rev-parse HEAD^^ HEAD^^^ >input &&
> +	git notes remove --stdin <input &&
> +	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
> +	test 2 = $(wc -l <actual) &&
> +	git ls-tree -r --name-only refs/notes/commits >actual &&
> +	>empty &&
> +	test_cmp empty actual
> +'

Same comment as for 1/3 applies here.

> +
> +test_expect_success 'remove --stdin is also atomic' '
> +	before=$(git rev-parse --verify refs/notes/commits) &&
> +	test_when_finished "git update-ref refs/notes/commits $before" &&
> +	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
> +	test_must_fail git notes remove --stdin <input &&
> +	after=$(git rev-parse --verify refs/notes/commits) &&
> +	test "$before" = "$after"
> +'
> +
> +test_expect_success 'removing with --stdin --missing-ok' '
> +	before=$(git rev-parse --verify refs/notes/commits) &&
> +	test_when_finished "git update-ref refs/notes/commits $before" &&
> +	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
> +	git notes remove --missing-ok --stdin <input &&
> +	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
> +	test 2 = $(wc -l <actual) &&
> +	git ls-tree -r --name-only refs/notes/commits >actual &&
> +	>empty &&
> +	test_cmp empty actual
> +'
> +
>  test_expect_success 'list notes with "git notes list"' '
>  	git notes list > output &&
>  	test_cmp expect output
