From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: always report ignored tracked directories
Date: Mon, 07 Jan 2013 11:06:20 -0800
Message-ID: <7vip78izir.fsf@alter.siamese.dyndns.org>
References: <20130105230303.GA5195@sigill.intra.peff.net>
 <1357510179-22852-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, tboegi@web.de, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 20:06:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsI21-0004lm-FN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 20:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab3AGTGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 14:06:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab3AGTGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 14:06:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B318AF0B;
	Mon,  7 Jan 2013 14:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5yTjnEnvYKAe/yjQFyVhN15OEw=; b=LtgGgb
	FmAfZ+PL50OyrZ4B/XyRa5oH4BhOC7kXXXAw7yEub8A6jeGuUXUdD8/P+eW5r/gh
	yOLfWlWv1UGXgDS7D0H1ztcR0NUwsua+y24YvlHoKy38+VBXZAs6kHrkV0fPcaAc
	opj938pYbMrZwD6r4CAsMjjwyuTuUuxdpcTPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJHp9/uS+UBo/tiRGgx9i17W5zSpwxZc
	ixN7hDaezUF48LMas1KLpv/2v3Kth1iy5z3z7fzBsw2PRAb2DQW8q9wA+0oEv2NU
	lRXh+lIysCNDeblNB4Esn36N8ZjVGV7PmvA8IEbNkRp1pjrQJtqyc01/UX6mhjwO
	Wp9sW3hNUZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0805AF0A;
	Mon,  7 Jan 2013 14:06:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A9C2AF09; Mon,  7 Jan 2013
 14:06:22 -0500 (EST)
In-Reply-To: <1357510179-22852-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sun, 6 Jan 2013 23:09:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5349688E-58FD-11E2-A8DF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212913>

Antoine Pelisse <apelisse@gmail.com> writes:

First, thanks for working on this.

The explanation is a bit confusing, especially for people like me,
as it does not make it clear that there are two kinds of "paths in
the index".  Files can be added to the index ("git add" and then
shown via "ls-files") and these are what we usually call "files in
the index".  But there is a separate "name hash" that keeps track of
"paths the index knows about" in play, and that is what is discussed
in the description.

> Tracked directories (i.e. directories containing tracked files)
> that are ignored must be reported as ignored if they contain
> untracked files.
>
> Currently, files in the index can't be reported as ignored and are
> automatically dropped from the list:

"file in the index" will never be ignored, period.  Some paths the
index knows about, namely, directory names in name hash, may need to
be reported as ignored.

It is not clear what "list" the above "dropped from the list" refers
to.  The list of paths that becomes the result of "status"?

>  - When core.ignorecase is false, directories (which are not directly
>  tracked) are not listed as part of the index, and the directory can be
>  shown as ignored.
>
>  - When core.ignorecase is true on the other hand, directories are
>  reported as part of the index, and the directory is dropped, thus not
>  displayed as ignored.
>
> Fix that behavior by allowing indexed file to be added when looking for
> ignored files.
>
>  - Ignored tracked and untracked directories are treated the same way
>  when looking for ignored files, so we should not care about their index
>  status.
>  - Files are dismissed by treat_file() if they belong to the
>  index, so that step would have been a no-op anyway.

Here is my attempt...

    When enumerating paths that are ignored, paths the index knows
    about are not included in the result.  The "index knows about"
    check is done by consulting the name hash, not the actual
    contents of the index:

     - When core.ignorecase is false, directory names are not in the
       name hash, and ignored ones are shown as ignored (directories
       can never be tracked anyway).

     - When core.ignorecase is true, however, the name hash keeps
       track of the names of directories, in order to detect
       additions of the paths under different cases.  This causes
       ignored directories to be mistakenly excluded when
       enumerating ignored paths.

    Stop excluding directories that are in the name hash when
    looking for ignored files in dir_add_name(); the names that are
    actually in the index are excluded much earlier in the callchain
    in treat_file(), so this fix will not make them mistakenly
    identified as ignored.

    Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
    Reviewed-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/dir.c b/dir.c
index 9b80348..f836590 100644
--- a/dir.c
+++ b/dir.c
@@ -672,7 +672,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -877,11 +878,7 @@ static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude,
 	if (exclude)
 		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
 	else if (dir->flags & DIR_SHOW_IGNORED) {
-		/*
-		 * Optimization:
-		 * Don't spend time on indexed files, they won't be
-		 * added to the list anyway
-		 */
+		/* Always exclude indexed files */
 		struct cache_entry *ce = index_name_exists(&the_index,
 		    path->buf, path->len, ignore_case);
 
