From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 14:05:25 -0700
Message-ID: <7vd3e4k162.fsf@alter.siamese.dyndns.org>
References: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 23:05:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDN2U-0005tl-G6
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 23:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1JJVF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 17:05:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab1JJVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 17:05:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20B9749E7;
	Mon, 10 Oct 2011 17:05:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ICcZKEebgHoW5nW2LLb/4BKa+YY=; b=R8T4PPIzy2XxOYmwaaRP
	/lm+YEUaRCvzfSAeijfHVlwZW1t8oEIWxmhfmH2SbDbut4mLaxnGZyxFk9aCE4u3
	ng5tJEFGWQzmYvDYN4OAd8QAitWOhckCyLIYvzWfe7LTwTt4aNU6QS7S7bM+0yWf
	MULNOXg/9TJrAEY0LmOyPsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=p0FRN93jWnbnaiXM91GdeSNl+d3H7OT763NEmGO3nH3XLX
	0hMrtUCcbprJa4Rs6gl9qsmsXVKsjZGw+FL+77jghpwOM7qizW7KJeFmGoFMH3A+
	OKAxRLowFQymIV6BhsSs6ThOZrkBH3vuKT/+0EBv6zSZza9EBlund95quFOfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184B049E6;
	Mon, 10 Oct 2011 17:05:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B3D049E5; Mon, 10 Oct 2011
 17:05:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 940C70B8-F383-11E0-87F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183259>

Jay Soffian <jaysoffian@gmail.com> writes:

> Implemented internally instead of as "git merge --no-commit && git commit"
> so that "merge --edit" is otherwise consistent (hooks, etc) with "merge".
>
> Note: the edit message does not include the status information that one
> gets with "commit --status" and it is cleaned up after editing like one
> gets with "commit --cleanup=default". A later patch could add the status
> information if desired.
>
> Note: previously we were not calling stripspace() after running the
> prepare-commit-msg hook. Now we are, stripping comments and
> leading/trailing whitespace lines if --edit is given, otherwise only
> stripping leading/trailing whitespace lines if not given --edit.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---

Thanks.

> +static void prepare_to_commit(void)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +	strbuf_addbuf(&msg, &merge_msg);
> +	strbuf_addch(&msg, '\n');
> +	write_merge_msg(&msg);
>  	run_hook(get_index_file(), "prepare-commit-msg",
>  		 git_path("MERGE_MSG"), "merge", NULL, NULL);
> -	read_merge_msg();
> +	if (option_edit) {
> +		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
> +			abort_commit(NULL);
> +	}
> +	read_merge_msg(&msg);
> +	stripspace(&msg, option_edit);
> +	if (!msg.len)
> +		abort_commit(_("Empty commit message."));
> +	strbuf_release(&merge_msg);
> +	strbuf_addbuf(&merge_msg, &msg);
> +	strbuf_release(&msg);
>  }

An abstraction very nicely done.

I am not sure about the '\n' you unconditionally added at the end of the
existing message.

I think running stripspace(&msg, option_edit) is a good change, even
though some people might feel it is a regression. "git commit" also cleans
up the whitespace cruft left by prepare-commit-message hook when the
editor is not in use, and this change makes it consistent.

> @@ -1015,6 +1041,36 @@ static int setup_with_upstream(const char ***argv)
> ...
> +static void write_merge_state(void)
> +{
> +	int fd;
> +	struct commit_list *j;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	for (j = remoteheads; j; j = j->next)
> +		strbuf_addf(&buf, "%s\n",
> +			sha1_to_hex(j->item->object.sha1));
> +	fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
> +	if (fd < 0)
> +		die_errno(_("Could not open '%s' for writing"),
> +			  git_path("MERGE_HEAD"));
> +	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
> +		die_errno(_("Could not write to '%s'"), git_path("MERGE_HEAD"));
> +	close(fd);
> +	strbuf_addch(&merge_msg, '\n');
> +	write_merge_msg(&merge_msg);
> +	fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +	if (fd < 0)
> +		die_errno(_("Could not open '%s' for writing"),
> +			  git_path("MERGE_MODE"));
> +	strbuf_reset(&buf);
> +	if (!allow_fast_forward)
> +		strbuf_addf(&buf, "no-ff");
> +	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
> +		die_errno(_("Could not write to '%s'"), git_path("MERGE_MODE"));
> +	close(fd);
> +}

Again very nicely done.

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 87aac835a1..8c6b811718 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -643,4 +643,19 @@ test_expect_success 'amending no-ff merge commit' '
>  
>  test_debug 'git log --graph --decorate --oneline --all'
>  
> +cat >editor <<\EOF
> +#!/bin/sh
> +# strip comments and blank lines from end of message
> +sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
> +EOF
> +chmod 755 editor

I am not sure about this one. Wouldn't this want to be editing the given
file to make sure that the edited content appear in the result, not just
testing the additional stripspace() call you added in the codepath?

> +test_expect_success 'merge --no-ff --edit' '
> +	git reset --hard c0 &&
> +	EDITOR=./editor git merge --no-ff --edit c1 &&
> +	verify_parents $c0 $c1 &&
> +	git cat-file commit HEAD | sed "1,/^$/d" > actual &&
> +	test_cmp actual expected
> +'
> +
>  test_done

So perhaps this one on top? I am just suspecting that your additional '\n'
is to make sure we do not write out a file with an incomplete line with
this patch, but that change is not explained in your commit log message,
so I am not sure.

 builtin/merge.c  |    3 ++-
 t/t7600-merge.sh |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8dbf4a..09ffc07 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -867,7 +867,8 @@ static void prepare_to_commit(void)
 {
 	struct strbuf msg = STRBUF_INIT;
 	strbuf_addbuf(&msg, &merge_msg);
-	strbuf_addch(&msg, '\n');
+	if (msg.len && msg.buf[msg.len-1] != '\n')
+		strbuf_addch(&msg, '\n');
 	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 8c6b811..3008e4e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -645,6 +645,12 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 cat >editor <<\EOF
 #!/bin/sh
+# Add a new message string that was not in the template
+(
+	echo "Merge work done on the side branch c1"
+	echo
+	cat <"$1"
+) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
 sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
 EOF
@@ -654,7 +660,9 @@ test_expect_success 'merge --no-ff --edit' '
 	git reset --hard c0 &&
 	EDITOR=./editor git merge --no-ff --edit c1 &&
 	verify_parents $c0 $c1 &&
-	git cat-file commit HEAD | sed "1,/^$/d" > actual &&
+	git cat-file commit HEAD >raw &&
+	grep "work done on the side branch" raw &&
+	sed "1,/^$/d" >actual raw &&
 	test_cmp actual expected
 '
 
