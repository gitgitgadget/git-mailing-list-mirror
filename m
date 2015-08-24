From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] worktree: add 'list' command
Date: Mon, 24 Aug 2015 11:05:17 -0700
Message-ID: <xmqqpp2c4l5u.fsf@gitster.dls.corp.google.com>
References: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
	<1440280294-50679-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTw7Z-0004cr-1K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbbHXSFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:05:20 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34439 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbHXSFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:05:19 -0400
Received: by pabzx8 with SMTP id zx8so11758462pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KeOgDWCFyhoYOg573lsArL6Ytv1uyUzBxbk5YLmOpgU=;
        b=TZi+Quyg0FVUK7iv6JUpI6JOYtCMxK8Uq09YRkmZL28Ysv9AcA62+K+7n+yyOdRlBc
         41EYKorHqYkobv/Y4SszjbwWkle5NMaQDH7O/k/Mhk+JO8U2nPCiDMTPh73n0q0EH3KD
         3McgB1m5fJhW0ut8JdIzRYxuWn33FpCNIqnNodnr3H64aYxS071hVB1iTxhQQtHZT6x9
         CTOK2n7KoRTZRUkl1M2RsflkwZHks0Hxc/BLPlbyiQeBelFUar2QmYFgLmFCO2OF9u+F
         vra49kT1z5K5UC9pCVHnrIjUHkHmeAF8zUrqN5SbhSakgNxBaSz4YmJkT6wA+uSwSuuJ
         aSjg==
X-Received: by 10.66.249.166 with SMTP id yv6mr48062110pac.126.1440439519230;
        Mon, 24 Aug 2015 11:05:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id c6sm18231001pat.13.2015.08.24.11.05.18
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 11:05:18 -0700 (PDT)
In-Reply-To: <1440280294-50679-3-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Sat, 22 Aug 2015 17:51:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276471>

Michael Rappazzo <rappazzo@gmail.com> writes:

> +static int print_worktree_details(const char *path, const char *git_dir, void *cb_data)
> +{
> +	struct strbuf head_file = STRBUF_INIT;
> +	struct strbuf head_ref = STRBUF_INIT;
> +	struct stat st;
> +	struct list_opts *opts = cb_data;
> +	const char *ref_prefix = "ref: refs/heads/";
> +
> +	strbuf_addf(&head_file, "%s/HEAD", git_dir);
> +	if (!opts->path_only && !stat(head_file.buf, &st)) {
> +		strbuf_read_file(&head_ref, head_file.buf, st.st_size);

This does not work for traditional "symlinked HEAD", no?

I'd prefer to see the callback functions of for_each_worktree() not
to duplicate the logic we already have elsewhere in the system.
Such an incomplete attempt to duplication (as we see here) will lead
to unnecessary bugs (as we see here).

Conceptually, for-each-worktree should give us the worktree root
(i.e. equivalent to $GIT_WORK_TREE in the pre-multi-worktree world)
and the git directory (i.e. equivalent to $GIT_DIR in the
pre-multi-worktree world), and the callbacks should be able to do an
equivalent of

    system("git --work-tree=$GIT_WORK_TREE --git-dir=$GIT_DIR cmd")

where in this particular case "cmd" may be "symbolic-ref HEAD" or
something, no?

> +		strbuf_strip_suffix(&head_ref, "\n");
> +
> +		if (starts_with(head_ref.buf, ref_prefix)) {
> +			/* branch checked out */
> +			strbuf_remove(&head_ref, 0, strlen(ref_prefix));
> +		/* } else {
> +		 *  headless -- no-op
> +		 */
> +		}
> +		printf("%s  (%s)\n", path, head_ref.buf);

Is this new command meant to be a Porcelain?  This would not work as
a plumbing that produces a machine-parseable stable output.

I am not saying that it _should_; I do not know if we even need a
'list' command that is driven from an end-user script that gives
anything more than "where the work trees are".

My inclination is to suggest dropping the "which branch" code
altogether and only give "path_only" behaviour.

Thanks.
