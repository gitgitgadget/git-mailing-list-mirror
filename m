From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] notes remove: allow removing more than one
Date: Thu, 19 May 2011 08:43:25 +0200
Message-ID: <4DD4BC0D.2000805@drmicha.warpmail.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com> <1305764061-21303-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:43:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMwxb-0000Uh-Eh
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab1ESGnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:43:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46736 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932481Ab1ESGnb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 02:43:31 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C89C820D0D;
	Thu, 19 May 2011 02:43:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 19 May 2011 02:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jS8OfKMiwThZvUSRxa4GqIA6IV0=; b=Oxvsxm0nVAql/vgzn9ZOtBt2cDk0maLntybJv7gHBg3ujQOhTOR1mUjnoikdgT3W0+WEpuxlLtpl6TumCRC+WWOcssmMQ+IjjxZ8SE9qUCW0ljquM0TyJEfOn+YZoyNinkvcISZ4g2lkstKjzER6iB+iJ77h7At8Zs/FQsDKWus=
X-Sasl-enc: jdqT4CbXGv/4fimvc8J4+fJJCEZKZEDScMXQfd3OLhKo 1305787407
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72DF74459F1;
	Thu, 19 May 2011 02:43:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1305764061-21303-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173934>

Junio C Hamano venit, vidit, dixit 19.05.2011 02:14:
> While "xargs -n1 git notes rm" is certainly a possible way to remove notes
> from many objects, this would create one notes "commit" per removal, which
> is not quite suitable for seasonal housekeeping.
> 
> Allow taking more than one on the command line, and record their removal
> as a single atomic event if everthing goes well.
> 
> Even though the old code insisted that "git notes rm" must be given only
> one object (or zero, in which case it would default to HEAD), this
> condition was not tested. Add tests to handle the new case where we feed
> multiple objects, and also make sure if there is a bad input, no change
> is recorded.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-notes.txt |    7 +++--
>  builtin/notes.c             |   47 ++++++++++++++++++++++--------------------
>  t/t3301-notes.sh            |   19 +++++++++++++++++
>  3 files changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 913ecd8..e2e1c4c 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
>  'git notes' merge --commit [-v | -q]
>  'git notes' merge --abort [-v | -q]
> -'git notes' remove [<object>]
> +'git notes' remove [<object>...]
>  'git notes' prune [-n | -v]
>  'git notes' get-ref
>  
> @@ -106,8 +106,9 @@ When done, the user can either finalize the merge with
>  'git notes merge --abort'.
>  
>  remove::
> -	Remove the notes for a given object (defaults to HEAD).
> -	This is equivalent to specifying an empty note message to
> +	Remove the notes for given objects (defaults to HEAD). When
> +	giving zero or one object from the command line, this is
> +	equivalent to specifying an empty note message to
>  	the `edit` subcommand.
>  
>  prune::
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 1fb1f73..30cee0f 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -29,7 +29,7 @@ static const char * const git_notes_usage[] = {
>  	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>",
>  	"git notes merge --commit [-v | -q]",
>  	"git notes merge --abort [-v | -q]",
> -	"git notes [--ref <notes_ref>] remove [<object>]",
> +	"git notes [--ref <notes_ref>] remove [<object>...]",
>  	"git notes [--ref <notes_ref>] prune [-n | -v]",
>  	"git notes [--ref <notes_ref>] get-ref",
>  	NULL
> @@ -953,40 +953,43 @@ static int merge(int argc, const char **argv, const char *prefix)
>  	return result < 0; /* return non-zero on conflicts */
>  }
>  
> +static int remove_one_note(struct notes_tree *t, const char *name)
> +{
> +	int status;
> +	unsigned char sha1[20];
> +	if (get_sha1(name, sha1))
> +		return error(_("Failed to resolve '%s' as a valid ref."), name);
> +	status = remove_note(t, sha1);
> +	if (status)
> +		fprintf(stderr, _("Object %s has no note\n"), name);
> +	else
> +		fprintf(stderr, _("Removing note for object %s\n"), name);
> +	return status;
> +}
> +
>  static int remove_cmd(int argc, const char **argv, const char *prefix)
>  {
>  	struct option options[] = {
>  		OPT_END()
>  	};
> -	const char *object_ref;
>  	struct notes_tree *t;
> -	unsigned char object[20];
> -	int retval;
> +	int retval = 0;
>  
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_notes_remove_usage, 0);
>  
> -	if (1 < argc) {
> -		error(_("too many parameters"));
> -		usage_with_options(git_notes_remove_usage, options);
> -	}
> -
> -	object_ref = argc ? argv[0] : "HEAD";
> -
> -	if (get_sha1(object_ref, object))
> -		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
> -
>  	t = init_notes_check("remove");
>  
> -	retval = remove_note(t, object);
> -	if (retval)
> -		fprintf(stderr, _("Object %s has no note\n"), sha1_to_hex(object));
> -	else {
> -		fprintf(stderr, _("Removing note for object %s\n"),
> -			sha1_to_hex(object));
> -
> -		commit_notes(t, "Notes removed by 'git notes remove'");
> +	if (!argc) {
> +		retval = remove_one_note(t, "HEAD");
> +	} else {
> +		while (*argv) {
> +			retval |= remove_one_note(t, *argv);
> +			argv++;
> +		}
>  	}
> +	if (!retval)
> +		commit_notes(t, "Notes removed by 'git notes remove'");
>  	free_notes(t);
>  	return retval;
>  }
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 28e17c8..6a6daa9 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -435,6 +435,25 @@ test_expect_success 'removing non-existing note should not create new commit' '
>  	test_cmp before_commit after_commit
>  '
>  
> +test_expect_success 'removing more than one' '
> +	before=$(git rev-parse --verify refs/notes/commits) &&
> +	test_when_finished "git update-ref refs/notes/commits $before" &&
> +	git notes remove HEAD^^ HEAD^^^ &&
> +	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
> +	test 2 = $(wc -l <actual) &&
> +	git ls-tree -r --name-only refs/notes/commits >actual &&
> +	>empty &&
> +	test_cmp empty actual
> +'

You're not really testing that this removes the correct notes. Actually,
you're not even testing that this removes only 2 notes when there are
more than 2, are you? I might be a bit fussy, though. I like the feature
in general:

 git notes remove $(git rev-list <fancy-rev-spec>)

rocks :)

Although "notes remove" could grok a rev-spec and dwim --do-walk, come
to think of it. Would be even more gittish.

> +
> +test_expect_success 'removing is atomic' '
> +	before=$(git rev-parse --verify refs/notes/commits) &&
> +	test_when_finished "git update-ref refs/notes/commits $before" &&
> +	test_must_fail git notes remove HEAD^^ HEAD^^^ HEAD^ &&
> +	after=$(git rev-parse --verify refs/notes/commits) &&
> +	test "$before" = "$after"
> +'
> +
>  test_expect_success 'list notes with "git notes list"' '
>  	git notes list > output &&
>  	test_cmp expect output
