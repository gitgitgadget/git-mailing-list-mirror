From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] update-index: add untracked cache notifications
Date: Tue, 08 Dec 2015 11:03:47 -0800
Message-ID: <xmqq6108lq3w.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:03:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6NYJ-0005dF-NR
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 20:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbbLHTDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 14:03:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751960AbbLHTDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 14:03:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D891F3046B;
	Tue,  8 Dec 2015 14:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zWC5EPBaXKwiZNs8YRdJy32ucRQ=; b=NDTiNv
	IYK3avC2y2+3ZRivu6HOvhyRjHrA1AQe7x9z5y2QDfakA+iXaUU2MhmCCQufT8f+
	ZO2H6fZBaAAiXJhLQYvZoJuSG1M3OIu0qmKm6xY5IgV8SQqf0gqUPgrEeBK/bO4o
	K0z3INDQ6LeZOi8oHlPmgH0ly7dZEi8Kb0UiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVHSI+UYjbOCGkddluxS/9nz2F/6hdhA
	O9miv1YsBahKFlKV17MZondOZWxwc7nPgxySfMB4ojmVj3zrnmMvo30NuEm6Dykp
	PpkaFccQc0TldvV7pzgT9nEV5vvrd1+vr2jgflW5pJjInssmgwgi8U/QxyitMmIT
	qQtN/lJu5w4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF8223046A;
	Tue,  8 Dec 2015 14:03:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 349B030469;
	Tue,  8 Dec 2015 14:03:49 -0500 (EST)
In-Reply-To: <1449594916-21167-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 8 Dec 2015 18:15:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A1902BC-9DDE-11E5-A5E6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282171>

Christian Couder <christian.couder@gmail.com> writes:

> Doing:
>
>   cd /tmp
>   git --git-dir=/git/somewhere/else/.git update-index --untracked-cache
>
> doesn't work how one would expect. It hardcodes "/tmp" as the directory
> that "works" into the index, so if you use the working tree, you'll
> never use the untracked cache.

I think your "expectation" needs to be more explicitly spelled out.

"git -C /tmp --git-dir=/git/somewhere/else/.git" is a valid way to
use that repository you have in somewhere else to track things under
/tmp/ (as you are only passing GIT_DIR but not GIT_WORK_TREE, the
cwd, i.e. /tmp, is the root level of the working tree), and for such
a usage, the above command works as expected.  Perhaps

    Attempting to flip the untracked-cache feature on for a random index
    file with

       cd /random/unrelated/place
       git --git-dir=/somewhere/else/.git update-index --untracked-cache

    would not work as you might expect.  Because flipping the
    feature on in the index also records the location of the
    corresponding working tree (/random/unrelated/place in the above
    example), when the index is subsequently used to keep track of
    files in the working tree in /somewhere/else, the feature is
    disabled.

may be an improvement.

The index already implicitly records where the working tree was and
that is not limited to untracked-cache option.  For example, if you
have your repository and its working tree in /git/somewhere/else,
which does not have a path X, then doing:

    cd /tmp && >tmp/X
    git --git-dir=/git/somewhere/else/.git update-index --add X

would store X taken from /tmp in the index, so subsequent use of the
index "knows" about X that was taken outside /git/somewhere/else/
after the above command finishes and the subsequent use is made
without the --git-dir parameter, e.g.

    cd /git/somewhere/else/ && git diff-index --cached HEAD'

would say that you added X, even though /git/somewhere/else/ may not
have that X at all.  And this is not limited to update-index,
either.  You can temporarily use --git-dir with "git add X" and the
result would persist the same way in the index.

I think the moral of the story is that you are not expected to
randomly use git-dir and git-work-tree to point at different places
without knowing what you are doing, and we may need a way to help
people understand what is going on when it is done by a mistake.

The patch to show result from xgetcwd() and get_git_work_tree() may
be a step in the right direction, but if the user is not doing
anything fancy, "Testing mtime in /long/path/to/the/directory" would
be irritatingly verbose.

I wonder if it is easy to tell when the user is doing such an
unnatural thing.  Off the top of my head, when the working tree is
anywhere other than one level above $GIT_DIR, the user is doing
something unusual; I do not know if there are cases where the user
is doing something unnatural if $GIT_WORK_TREE is one level above
$GIT_DIR, though.

> With this patch "git update-index --untracked-cache" tells the user in
> which directory tests are performed and in which working directory the
> untracked cache is allowed.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..6f6b289 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -121,7 +121,7 @@ static int test_if_untracked_cache_is_supported(void)
>  	if (!mkdtemp(mtime_dir.buf))
>  		die_errno("Could not make temporary directory");
>  
> -	fprintf(stderr, _("Testing "));
> +	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>  	atexit(remove_test_directory);
>  	xstat_mtime_dir(&st);
>  	fill_stat_data(&base, &st);
> @@ -1122,9 +1122,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		}
>  		add_untracked_ident(the_index.untracked);
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
> +		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
>  	} else if (!untracked_cache && the_index.untracked) {
>  		the_index.untracked = NULL;
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
> +		fprintf(stderr, _("Untracked cache disabled\n"));
>  	}
>  
>  	if (active_cache_changed) {
