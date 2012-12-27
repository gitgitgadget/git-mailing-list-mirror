From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Wed, 26 Dec 2012 18:37:55 -0800
Message-ID: <7vip7omd8c.fsf@alter.siamese.dyndns.org>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
 <1356528674-2730-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:38:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3MQ-0000WR-DY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab2L0CiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:38:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab2L0Ch7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:37:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7013AADA2;
	Wed, 26 Dec 2012 21:37:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1Cwm7yDSrIHDFTCJ09ay4/BKew=; b=G7V4uj
	1JB74yAMMV3XkjMfb2mEUY1W8YAWhSif6jffwY2lZRuZ6+7BEYugptKF4PWo2orl
	5BebtgJFzucnRu2FqyR/DSs5ltTVZKDMg857wJUj3mcziuRnJEvCDA6+6gKe5pw8
	MKK7aX5nILCH6IrbQQROWIHGvp10Wq22FCdK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkyG44+jmdqK/ycWGEwgkE61QbyLQgqP
	TKjxnZ/NEAEIy3LbpcuoU0zchnvF/FFQaaqbIynfYa+uAPsmeHT+4g3+0mGYr0yx
	Qe7upq4g8dc7cSrBtNTU+2YKLCtoeUqs+hCQq2l0HBp11HoQLjWJebjuR3lfeNZE
	ucriPEuQYOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B397ADA1;
	Wed, 26 Dec 2012 21:37:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B42BEAD9E; Wed, 26 Dec 2012
 21:37:57 -0500 (EST)
In-Reply-To: <1356528674-2730-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 26 Dec 2012 14:31:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C8B2338-4FCE-11E2-8C0F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212189>

Antoine Pelisse <apelisse@gmail.com> writes:

> When looking for ignored files, we do not recurse into untracked
> directory, and simply consider the directory ignored status.

When asked to show ignored ones, instead of listing all ignored
files in such a directory, we just say "everything in this directory
is ignored"?

That sounds like a more desirable behaviour, than listing everything
there, at least to me, but perhaps I am missing something.

Care to add a test for this new behaviour?

> As a consequence, we don't see ignored files in those directories.
>
> Change that behavior by recursing into untracked directories, if not
> ignored themselves, searching for ignored files.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> Actually, the previous patch breaks the case where the directory is ignored.
> This one should fix both issues.
> Let me know if you see any other use case that could be an issue.
>
>  dir.c       | 7 +++++++
>  wt-status.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 5a83aa7..2863799 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1042,6 +1042,13 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  			return path_ignored;
>  	}
>
> +	/*
> +	 * Don't recurse into ignored directories when looking for
> +	 * ignored files, but still show the directory as ignored.
> +	 */
> +	if (exclude && (dir->flags & DIR_SHOW_IGNORED) && dtype == DT_DIR)
> +		return path_handled;
> +
>  	switch (dtype) {
>  	default:
>  		return path_ignored;
> diff --git a/wt-status.c b/wt-status.c
> index 2a9658b..7c41488 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -516,7 +516,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
>
>  	if (s->show_ignored_files) {
>  		dir.nr = 0;
> -		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
> +		dir.flags = DIR_SHOW_IGNORED;
>  		fill_directory(&dir, s->pathspec);
>  		for (i = 0; i < dir.nr; i++) {
>  			struct dir_entry *ent = dir.entries[i];
> --
> 1.8.1.rc3.12.g8864e38
