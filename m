Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D202018B
	for <e@80x24.org>; Tue, 21 Jun 2016 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbcFUONf (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 10:13:35 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35427 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcFUONf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 10:13:35 -0400
X-Greylist: delayed 1134 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2016 10:13:34 EDT
Received: by mail-ob0-f178.google.com with SMTP id c3so23951370obc.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 07:13:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nz8WUeGufnbel7zsJ29bpJJsHs+PblK30VCFLgt+5ks=;
        b=W6rKvzH/TkkYs/beE7VQ8t/uVYdGdeyF9LSWXjjm7YdjClHNv0NDhqDlR9tPw1NabZ
         FQWASYNuke0tQpkTdsZ977JithbAHXwRPZ5Xi3q5RBFA4g9iEJPEPEQ3ODz4yihB9Tde
         yhidPp8QqTbXWln65rBJnn7RQ+58CN3OkjZnHj2NOhSNr4FOdTQWfN8sdJZVur50KdA+
         S47xwb4uHu5TGV7eE6fo6uRTvZEpEva62GH+whRmv/ilX91wuqPeGLek2ogp72g+RDpB
         S5HsmtfkXeDI/6hR3K849KLnUVPFS8i9pBwKQSew8B9oart/ozumxpjJ2BNEAXVA8BWn
         cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nz8WUeGufnbel7zsJ29bpJJsHs+PblK30VCFLgt+5ks=;
        b=fZwo+5+JyqzqVxqkEz17aI+C3wLIEZOW8/0i1ih0lt80QnvDlEzD/UHneuU8BQD/gT
         DxbfzFWnRyV9WS4FUw27XXLSD+YJOEqy56O11GBU4lqGqR8yFQXK4oLglKQE0q7AX9Tg
         JZBWWmm5Whl3vCnhbytFUyuG/EW85aSvLDvb5MZuwIBo2yuNJPYooOnGlQXoGp46qD3B
         GQAqlh8QqHiaBaaG0WoCFnr+A6Rc9oKy3KvUDK0oeL/d/ef7VwbBCBh6Ma9Xxcm1yqXR
         6qWq/HZx54q2ittUhidWdERF+mGIwSTv9wFUeg4ID4kbUMSQvVB1phqIZn6lyG8lknAa
         Ct3g==
X-Gm-Message-State: ALyK8tInzLnDocMmGcTPl3nNCuVheGZsWhHJAsdLEnWD/djwuUnj4CGz2cbg56cXoOR2X6o+nmOytkEK/7oMPQ==
X-Received: by 10.157.11.9 with SMTP id a9mr14200563ota.10.1466516832223; Tue,
 21 Jun 2016 06:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.48.35 with HTTP; Tue, 21 Jun 2016 06:47:11 -0700 (PDT)
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
From:	Paul Tan <pyokagan@gmail.com>
Date:	Tue, 21 Jun 2016 21:47:11 +0800
Message-ID: <CACRoPnRvp7oguE2w2mcsEZfaX_fni8UhFCdsGQ3ZaijQprSHog@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Let log-tree and friends respect diffopt's `file` field
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

On Tue, Jun 21, 2016 at 6:34 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> - this uncovered a problem with builtin am, where it asked the diff
>   machinery to close the file stream, but actually called the log_tree
>   machinery (which might mean that this patch series inadvertently fixes
>   a bug where `git am --rebasing` would write the commit message to
>   stdout instead of the `patch` file when erroring out)

Please correct me if I'm wrong: looking at log-tree.c, the commit
message will not be printed when no_commit_id = 1, isn't it? This is
because we do not hit the code paths that write to stdout since
show_log() is not called.

Also, the return value of log_tree_commit() is actually a boolean
value, not an error status value, isn't it?

> This last point is a bigger issue, actually. There seem to be quite a
> few function calls in builtin/am.c whose return values that might
> indicate errors are flatly ignored. I see two calls to run_diff_index()
> whose return value then goes poof unchecked,

Thanks, future-proofing the builtin/am.c code is good, in case
run_diff_index() is updated to not call exit(128) on error in the
future.

> and several calls to
> write_state_text() and write_state_bool() with the same issue.

These functions will die() on error, so checking their error code is
not really useful. I'm not opposed to changing them to use the
write_file_gently() version though, although I don't see a need to
unless builtin/am.c is being libified.

> And I did
> not even try to review the code to that end, all I wanted was to verify
> that builtin am only has the close_file issue once (it does use it a
> second time, but that one is okay because it then calls
> run_diff_index(), i.e. the diff machinery).
>
> I am embarrassed to admit that these builtin am problems demonstrate
> that I, as a mentor of the builtin am project, failed to help make the
> patches as good as I expected myself to do.

Sorry to disappoint you :-(

Regards,
Paul
