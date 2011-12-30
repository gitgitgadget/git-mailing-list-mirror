From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] stash: Don't fail if work dir contains file named 'HEAD'
Date: Fri, 30 Dec 2011 11:15:42 +0100
Message-ID: <8739c28iwh.fsf@thomas.inf.ethz.ch>
References: <913BB2F9-3C51-44D0-BFEC-3A49A5EC9E15@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Fri Dec 30 11:16:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgZVR-0000ZW-LZ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 11:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab1L3KQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 05:16:01 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:8640 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505Ab1L3KP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 05:15:59 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 30 Dec
 2011 11:15:53 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (89.204.154.225) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 30 Dec
 2011 11:15:56 +0100
In-Reply-To: <913BB2F9-3C51-44D0-BFEC-3A49A5EC9E15@JonathonMah.com> (Jonathon
	Mah's message of "Thu, 29 Dec 2011 12:47:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [89.204.154.225]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187798>

Jonathon Mah <me@JonathonMah.com> writes:
> When performing a plain "git stash" (without --patch), git-diff would fail
> with "fatal: ambiguous argument 'HEAD': both revision and filename". The
> output was piped into git-update-index, masking the failed exit status.
> The output is now sent to a temporary file (which is cleaned up by
> existing code), and the exit status is checked. The "HEAD" arg to the
> git-diff invocation has been disambiguated too, of course.

Thanks, good catch.

> In patch mode, "git stash -p" would fail harmlessly, leaving the working
> dir untouched.

Note that this only affects stash -p, not add/reset/commit -p, because
it is the only one that does an extra patch dance on top of the
git-add--interactive work.  stash -p uses a 'diff-index -p HEAD'
invocation in the %patch_modes of git-add--interactive, but diff-index
doesn't need disambiguation as the first argument is always the (sole)
tree-ish.

I had to look and verify, so perhaps you can put a paragraph to this
effect in the commit message.

> -			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
> +			git diff --name-only -z HEAD -- > "$TMP-stagenames" &&
> +			git update-index -z --add --remove --stdin < "$TMP-stagenames" &&

Style nit: we usually spell it >foo.  I saw that git-stash is already
inconsistent, but let's at least not make it worse.

While reading this I also wondered if there was a good reason it didn't
just use 'add -u', and indeed: 7aa5d43 (stash: Don't overwrite files
that have gone from the index, 2010-04-18) changed it *away* from add -u
because that was broken.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
[...]
> +test_expect_success 'stash where working directory contains "HEAD" file' '
> +	git stash clear &&
> +	git reset --hard &&
> +	echo file-not-a-ref > HEAD &&
> +	git add HEAD &&
> +	git stash &&
> +	git diff-files --quiet &&
> +	git diff-index --cached --quiet HEAD &&
> +	test_tick &&

What's the tick good for if you don't create any commits after it?  You
should put it immediately before the 'git stash'.

> +	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&

This should probably have its arguments quoted, to avoid confusing
'test' if something goes horribly wrong (e.g. stash^ is not valid).
There are plenty of existing lines of this form in other tests however.

> +	git diff stash^..stash > output &&
> +	test_cmp output expect &&
> +	git stash drop

Perhaps this could go after the 'git stash' as a

  test_when_finished "git stash drop"

> +'

> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
[...]
> -# note: bar sorts before dir, so the first 'n' is always to skip 'bar'
> +# note: order of files with unstaged changes: HEAD bar dir/foo
>  
>  test_expect_success PERL 'saying "n" does nothing' '
> +	set_state HEAD HEADfile_work HEADfile_index &&
>  	set_state dir/foo work index &&
> -	(echo n; echo n) | test_must_fail git stash save -p &&
> -	verify_state dir/foo work index &&
> -	verify_saved_state bar
> +	(echo n; echo n; echo n) | test_must_fail git stash save -p &&
> +	verify_state HEAD HEADfile_work HEADfile_index &&
> +	verify_saved_state bar &&
> +	verify_state dir/foo work index
>  '

Other reviewers may want to read these hunks in word diff mode, where it
is far easier to verify that the functionality tested is a superset:

  test_expect_success PERL 'saying "n" does nothing' '
          {+set_state HEAD HEADfile_work HEADfile_index &&+}
          set_state dir/foo work index &&
          (echo n; echo {+n; echo+} n) | test_must_fail git stash save -p &&
          verify_state [-dir/foo work index-]{+HEAD HEADfile_work HEADfile_index+} &&
          verify_saved_state bar {+&&+}
  {+      verify_state dir/foo work index+}
  '

> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
[...]
>  test_expect_success 'stash save --include-untracked stashed the untracked files' '
>  	test "!" -f file2 &&
>  	test ! -e untracked &&
> -	git diff HEAD stash^3 -- file2 untracked >actual &&
> +	test "!" -f HEAD &&
> +	git diff HEAD stash^3 -- HEAD file2 untracked >actual &&

Again not something you started, but we may want to clean this up to say

  test_path_is_missing file2 &&
  test_path_is_missing untracked &&
  test_path_is_missing HEAD &&

etc.  This is nicer (gives a message) if the test fails.  It also barfs
if there is a freak bug that made HEAD a device or some such :-)


Anyway, except for the test_tick those were just style nits.  You can
add

  Acked-by: Thomas Rast <trast@student.ethz.ch>

when you reroll.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
