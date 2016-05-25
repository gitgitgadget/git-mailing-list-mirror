From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 00:36:55 -0700
Message-ID: <xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5TNM-0003xV-6H
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 09:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbcEYHhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 03:37:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbcEYHg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 03:36:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A8AA18A5E;
	Wed, 25 May 2016 03:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SnULnVbWIrGm58PxCPZNFnyJUfM=; b=wOB5x1
	b90EHvRdn6ZqoOnesja+PEk/5QB7UNQOXjA0SKPGiZhZ+EsLOlKBuEuvpVQJ7uah
	oZLizsDyoj8QzOfgGxtz1ku1gqD6cR5ieWr7UJ9QC8tDfgroLrWSG4j70T0yvDha
	OfktMRDrcK75q1jl4vUl9eQGow+kAIrdqQ/CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+No7+RJio2VQHtXedEevxd5mVLJuef6
	gAR2O2JsqzMCR8erIfseK1jFFA8EerDU5q+Ft2E+Nfbh6VZfIzF3ugKUzIsDPnK0
	d5vmpHA3Warr1daXlv24X3IEoX2YLHkYLaLSAju0I5C+cXlsXOJJ+14F8DVMN82U
	XD2uWh64PJc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51DE818A5D;
	Wed, 25 May 2016 03:36:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A969918A5B;
	Wed, 25 May 2016 03:36:57 -0400 (EDT)
In-Reply-To: <20160525020609.GA20123@zoidberg> (Edward Thomson's message of
	"Tue, 24 May 2016 21:06:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75E2DBDA-224B-11E6-926E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295567>

Edward Thomson <ethomson@edwardthomson.com> writes:

> Users on deficient filesystems that lack an execute bit may still
> wish to add files to the repository with the appropriate execute
> bit set (or not).  Although this can be done in two steps
> (`git add foo && git update-index --chmod=+x foo`), providing the
> `--chmod=+x` option to the add command allows users to set a file
> executable in a single command that they're already familiar with.
>
> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
> ---

I think we should tone down the first sentence of the proposed
commit log message.  With "s/deficient //" the paragraph still reads
perfectly well.  Even when an underlying filesystem is capable of
expressing executable bit, we can set core.filemode to false to
emulate the behaviour on DOS, so perhaps

    The executable bit will not be set for paths in a repository
    with core.filemode set to false, but the users may still wish to
    add files to ...

or something like it?

Giving an easy to use single-command short-hand for a common thing
that takes two commands is a worthy goal.  Another way to do the
above is

	git update-index --add --chmod=+x foo

and from that point of view, we do not need this patch, but that is
still a mouthful ;-)  I think it is a good idea to teach "git add",
an end-user facing command, to be more helpful.

At the design level, I have a few comments.

 * Unlike the command "chmod", which is _only_ about changing modes,
   "add --chmod" updates both the contents and modes in the index,
   which may invite "I only want to change modes--how?"

	Note. We had an ancient regression at 227bdb18 (make
	update-index --chmod work with multiple files and --stdin,
	2006-04-23), where "update-index --chmod=+x foo" stopped
	being "only flip the executable bit without hashing the
	contents" and that was done purely by mistake.  There is no
	longer a good answer to that question, which makes the above
	worry less of an issue.

 * This is about a repository with core.filemode=0; I wonder if
   something for a repository with core.symlinks=0 would also help?
   That is, would it be a big help to users if they can prepare a
   text file that holds symbolic link contents and add it as if it
   were a symlink with "git add", instead of having to run two
   commands, "hash-objects && update-index --cacheinfo"?

 * I am not familiar with life on filesystems with core.filemode=0;
   do files people would want to be able to "add --chmod=+x" share
   common trait that can be expressed with .gitattributes mechanism?

   What I am wondering is if a scheme like the following would work
   well, in addition to your patch:

   1. Have these in .gitattributes:

      *		-executable
      *.bat	executable text
      *.exe	executable binary
      *.com	executable binary

      A path with Unset "executable" attribute is explicitly marked
      as "not executable"; a path with Set "executable" attribute is
      marked as "executable", i.e. "needing chmod=+x".

   2. Teach "git add" to take the above hint _only_ in a repository
      where core.filemode is false and _only_ when adding a new path
      to the index.

   If something like this works well enough, users do not have to
   type --chmod=+x too often when doing "git add"; your patch
   becomes an escape hatch that is only needed when the attributes
   system gets it wrong.


Now some comments on the actual code.

> +static int chmod_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	char *flip = opt->value;
> +	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
> +		return error("option 'chmod' expects \"+x\" or \"-x\"");
> +	*flip = arg[0];
> +	return 0;
> +}

I know you mimicked the command line parser of update-index, but you
didn't have to, and you shouldn't have.

The command line semantics of update-index is largely "we read one
option and prepare to make its effect immediately available", which
predates parse-options where its attitude for command line parsing
is "we first parse all options and figure out what to do, and then
we work on arguments according to these options".  Because of these
vastly different attitudes, the way builtin/update-index.c uses
parse-options API is atypical.  The only reason it uses callback is
because it wants to allow you to say this:

    git update-index --chmod=+x foo bar --chmod=-x baz

and register foo and bar as executable, while baz as non-executable.

The way update-index uses parse-options API is not something you
want to mimick when adding a similar option to a more modern command
like "git add", whose attitude toward command line parsing is quite
different.  Modern command line parsing typically takes "the last
one wins" semantics, i.e.

    git add --chmod=-x --chmod=+x foo

would make foo executable.

If I were doing this patch, I'd just allocate a file scope global
"static char *chmod_arg;" and OPT_STRING("chmod") to set it, After
parse_options() returns, I'd do something like:

	if (chmod_arg) {
        	if (strcmp(chmod_arg, "-x") && strcmp(chmod_arg, "+x"))
			die("--chmod param must be either -x or +x");
	}

> @@ -661,6 +663,10 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  
>  	if (trust_executable_bit && has_symlinks)
>  		ce->ce_mode = create_ce_mode(st_mode);
> +	else if (force_executable)
> +		ce->ce_mode = create_ce_mode(0777);
> +	else if (force_notexecutable)
> +		ce->ce_mode = create_ce_mode(0666);

This is an iffy design decision.

Even when you are in core.filemode=true repository, if you
explicitly said

	git add --chmod=+x READ.ME

wouldn't you expect that the path would have executable bit in the
index, whether it has it as executable in the filesystem?  The above
if/else cascade, because trust-executable-bit is tested first, will
ignore force_* flags altogether, won't it?  It also is strange that
the decision to honor or ignore force_* flags is also tied to
has_symlinks, which is a totally orthogonal concept.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f14a665..e551eaf 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -332,4 +332,23 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
>  
> +test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
> +	echo foo >foo1 &&
> +	git add --chmod=+x foo1 &&
> +	case "$(git ls-files --stage foo1)" in
> +	100755" "*foo1) echo pass;;
> +	*) echo fail; git ls-files --stage foo1; (exit 1);;
> +	esac
> +'
> +
> +test_expect_success 'git add --chmod=-x stages an executable file with -x' '
> +	echo foo >xfoo1 &&
> +	chmod 755 xfoo1 &&
> +	git add --chmod=-x xfoo1 &&
> +	case "$(git ls-files --stage xfoo1)" in
> +	100644" "*xfoo1) echo pass;;
> +	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
> +	esac
> +'
> +
>  test_done
