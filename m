Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93B31F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeAZSsA (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:48:00 -0500
Received: from [195.159.176.226] ([195.159.176.226]:33361 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeAZSr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:47:59 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1ef90S-0007zF-Q7
        for git@vger.kernel.org; Fri, 26 Jan 2018 19:45:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:     git@vger.kernel.org
From:   Tim Landscheidt <tim@tim-landscheidt.de>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
Date:   Fri, 26 Jan 2018 18:47:23 +0000
Organization: http://www.tim-landscheidt.de/
Message-ID: <87372s78zo.fsf@passepartout.tim-landscheidt.de>
References: <20180126095520.919-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Mail-Copies-To: never
Cancel-Lock: sha1:763TlgmYiCSHjY6vVCPhgNaiUTI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:

> When a conflict happens during a rebase, you often need to look at the
> original patch to see what the changes are. This requires opening your
> favourite pager with some random path inside $GIT_DIR.

> This series makes that experience a bit better, by providing a command
> to read the patch. This is along the line of --edit-todo and --quit
> where you can just tell git what to do and not bother with details.

> My main focus is "git rebase", but because rebase uses "git am" behind
> the scene, "git am" gains --show-patch option too.

> There was something more I wanted to do, like coloring to the patch.
> But that probably will come later. I'll try to merge these two
> 21-months-old patches first.

> […]

I dislike the approach to use a separate command/option.
The nice thing about rebase-apply/original-commit is that
you can use it in /any/ git command, i. e. you can do "git
log $whatever..rebase-apply/original-commit".

What I would do instead is (besides documenting it :-)) to
provide an alias that is more in line with ORIG_HEAD,
FETCH_HEAD, etc.; i. e. something along the lines of (pseudo
code, will probably not work):

| --- a/builtin/am.c
| +++ b/builtin/am.c
| @@ -1110,6 +1110,7 @@ static void am_next(struct am_state *state)
|  
|         oidclr(&state->orig_commit);
|         unlink(am_path(state, "original-commit"));
| +       delete_ref(NULL, "ORIG_COMMIT", NULL, 0);
|  
|         if (!get_oid("HEAD", &head))
|                 write_state_text(state, "abort-safety", oid_to_hex(&head));
| @@ -1441,6 +1442,7 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
|  
|         oidcpy(&state->orig_commit, &commit_oid);
|         write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
| +       update_ref_oid("am", "ORIG_COMMIT", &commit_oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
|  
|         return 0;
|  }

This (when working) would allow to use ORIG_COMMIT in place
of the mouthful rebase-apply/original-commit.

Tim

