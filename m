From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 12:00:59 -0700
Message-ID: <xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKA7g-00058i-7v
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbbG1TBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:01:03 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33164 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbbG1TBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:01:01 -0400
Received: by pdbnt7 with SMTP id nt7so75105879pdb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eLbFg+UD/hhm+zus83cUxKRCby+IhZ/Ur97L2WC9XcI=;
        b=uaPyfMUPi1b1VwlzrH9boybxhlsA2fzu2WGQMrx6c1z1mspqS3GnTz3UbyUPnFAz3B
         yK4vGpCmD3Uhxy0U9KmlbR26QyVDwTEHvhQdSkmat0IGRfQQovZNVu1rygRHI3iVsfz2
         uQ+4NQXFWtqJBBBKyfKDYWNRk4yxnkdIHjmAxhVJil3UMN/u7ERj12pntKgCjd+BXXMK
         z8iznD9EnaXEqjSha/SutDoi1IuqDihiWx7DQ5WFmltcj5KoxJwYhVPP6GG0lKPo1ojq
         YB/0yPaZ+DIzfS04S1oB/JElliGFAAqHjSoHiIZ2+Zz6mXqeg4bOsDWcMwrHhpqNfIi/
         b8PQ==
X-Received: by 10.70.34.207 with SMTP id b15mr83882553pdj.151.1438110060903;
        Tue, 28 Jul 2015 12:01:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id qb10sm2478580pab.39.2015.07.28.12.00.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 12:00:59 -0700 (PDT)
In-Reply-To: <1438107144-24293-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 28 Jul 2015 14:12:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274814>

David Turner <dturner@twopensource.com> writes:

> All-caps files like NOTES_MERGE_REF are pseudorefs, and thus are
> per-worktree.  We don't want multiple notes merges happening at once
> (in different worktrees), so we want to make these refs true refs.
>
> So, we lowercase NOTES_MERGE_REF and friends.  That way, backends
> that distinguish between pseudorefs and real refs can correctly
> handle notes merges.
>
> This will also enable us to prevent pseudorefs from being updated by
> the ref update machinery e.g. git update-ref.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

This seems to do a bit more than what it claims to do.  As this kind
of changes are very error-prone to review, I did a bulk replace of
the three all-caps NOTES_*THING* and compared the result with what
this patch gives to spot this:

>  	# Fail to finalize merge
>  	test_must_fail git notes merge --commit >output 2>&1 &&
> -	# .git/NOTES_MERGE_* must remain
> -	test -f .git/NOTES_MERGE_PARTIAL &&
> -	test -f .git/NOTES_MERGE_REF &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
> -	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
> +	# .git/notes_merge_* must remain
> +	git rev-parse --verify notes_merge_partial &&
> +	git rev-parse --verify notes_merge_ref &&
> +	test -f .git/notes_merge_worktree/$commit_sha1 &&
> +	test -f .git/notes_merge_worktree/$commit_sha2 &&
> +	test -f .git/notes_merge_worktree/$commit_sha3 &&
> +	test -f .git/notes_merge_worktree/$commit_sha4 &&

The two "rev-parse --verify" looks semi-sensible [*1*];
notes_merge_partial is all lowercase and it refers to
$GIT_DIR/notes_merge_partial, because they are shared across working
tree. 

But then why are $GIT_DIR/notes_merge_worktree/* still checked with
"test -f"?  If they are not refs or ref-like things, why should they
be downcased?  If they are, why not "rev-parse --verify"?

[Footnote]

*1* I say "semi-" sensible, because it looks ugly.  All ref-like
    things immediately below $GIT_DIR/ are all-caps by convention.
    Perhaps it is a better idea to move it under refs/; "everything
    under refs/ is shared across working trees" is probably a much
    better rule than "all caps but HEAD is special".
