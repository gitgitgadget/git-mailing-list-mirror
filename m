Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE65C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1722583
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgLVWlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLVWlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 17:41:25 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C994C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:40:45 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id u19so14419164edx.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 14:40:44 -0800 (PST)
X-Gm-Message-State: AOAM532xYpnZ0foe+zzE8njHXxTLCChV1ze/CJrFarNdl459P7IA64nq
        r7kOSFOLVpUTrvgVlYoqivfevmGxdCH6VvpEVwM=
X-Google-Smtp-Source: ABdhPJzkGy/6WHTN8V+uJhAkrFhEsvygjUntVqpEulfooHn990GeDhsqvqdMZYi947dqln+WoWEHDVh2RKnxhTrZU/o=
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr21543656edb.107.1608676841167;
 Tue, 22 Dec 2020 14:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20201221034452.307153-1-mattst88@gentoo.org>
In-Reply-To: <20201221034452.307153-1-mattst88@gentoo.org>
From:   Matt Turner <mattst88@gentoo.org>
Date:   Tue, 22 Dec 2020 17:40:29 -0500
X-Gmail-Original-Message-ID: <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
Message-ID: <CAEdQ38E9Fepp9gmidcf_HvFMacwPZBr0XgPT5HFs8bHw-SJDZQ@mail.gmail.com>
Subject: Re: [RFC PATCH gentoolkit] bin: Add merge-driver-ekeyword
To:     gentoo-portage-dev@lists.gentoo.org
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr:

I want to handle conflicts automatically on lines like

> KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

where conflicts frequently happen by adding/removing ~ before the
architecture names or adding/removing whole architectures. I don't
know if I should use a custom git merge driver or a custom git merge
strategy.


So the program in the patch below works, but it's not ideal, because
it rejects any hunks that don't touch the KEYWORDS=... assignment.

As I understand it, a custom git merge driver is intended to be used
to merge whole file formats, like JSON. As a result, you configure it
via gitattributes on a per-extension basis.

I really just want to make the default recursive git merge handle
KEYWORDS=... conflicts automatically, and I don't expect to be able to
make a git merge driver that can handle arbitrary conflicts in
*.ebuild files. If the merge driver returns non-zero if it was unable
to resolve the conflicts, but when it does so git evidently doesn't
fallback and insert the typical <<< HEAD ... === ... >>> markers.
Maybe I could make my merge driver insert those like git normally
does? Seems like git's  logic is probably a bit better about handling
some conflicts than my tool would be.

So... is a git merge strategy the thing I want? I don't know. There
doesn't seem to really be any documentation on writing git merge
strategies. I've only found [1] and [2].

Cc'ing git@vger.kernel.org, since I expect that's where the experts
are. Hopefully they have suggestions.


[1] https://stackoverflow.com/questions/23140240/git-how-do-i-add-a-custom-merge-strategy
[2] https://stackoverflow.com/questions/54528824/any-documentation-for-writing-a-custom-git-merge-strategy


On Sun, Dec 20, 2020 at 10:44 PM Matt Turner <mattst88@gentoo.org> wrote:
>
> Since the KEYWORDS=... assignment is a single line, git struggles to
> handle conflicts. When rebasing a series of commits that modify the
> KEYWORDS=... it's usually easier to throw them away and reapply on the
> new tree than it is to manually handle conflicts during the rebase.
>
> git allows a 'merge driver' program to handle conflicts; this program
> handles conflicts in the KEYWORDS=... assignment. E.g., given an ebuild
> with these keywords:
>
> KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
>
> One developer drops the ~alpha keyword and pushes to gentoo.git, and
> another developer stabilizes hppa. Without this merge driver, git
> requires the second developer to manually resolve the conflict.  With
> the custom merge driver, it automatically resolves the conflict.
>
> gentoo.git/.git/config:
>
>         [core]
>                 ...
>                 attributesfile = ~/.gitattributes
>         [merge "keywords"]
>                 name = KEYWORDS merge driver
>                 driver = merge-driver-ekeyword %O %A %B
>
>  ~/.gitattributes:
>
>         *.ebuild merge=keywords
>
> Signed-off-by: Matt Turner <mattst88@gentoo.org>
> ---
> One annoying wart in the program is due to the fact that ekeyword
> won't work on any file not named *.ebuild. I make a symlink (and set up
> an atexit handler to remove it) to work around this. I'm not sure we
> could make ekeyword handle arbitrary filenames given its complex multi-
> argument parameter support. git merge files are named .merge_file_XXXXX
> according to git-unpack-file(1), so we could allow those. Thoughts?
>
>  bin/merge-driver-ekeyword | 125 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100755 bin/merge-driver-ekeyword
>
> diff --git a/bin/merge-driver-ekeyword b/bin/merge-driver-ekeyword
> new file mode 100755
> index 0000000..6e645a9
> --- /dev/null
> +++ b/bin/merge-driver-ekeyword
> @@ -0,0 +1,125 @@
> +#!/usr/bin/python
> +#
> +# Copyright 2020 Gentoo Authors
> +# Distributed under the terms of the GNU General Public License v2 or later
> +
> +"""
> +Custom git merge driver for handling conflicts in KEYWORDS assignments
> +
> +See https://git-scm.com/docs/gitattributes#_defining_a_custom_merge_driver
> +"""
> +
> +import atexit
> +import difflib
> +import os
> +import shutil
> +import sys
> +
> +from typing import List, Optional, Tuple
> +
> +from gentoolkit.ekeyword import ekeyword
> +
> +
> +def keyword_array(keyword_line: str) -> List[str]:
> +    # Find indices of string inside the double-quotes
> +    i1: int = keyword_line.find('"') + 1
> +    i2: int = keyword_line.rfind('"')
> +
> +    # Split into array of KEYWORDS
> +    return keyword_line[i1:i2].split(' ')
> +
> +
> +def keyword_line_changes(old: str, new: str) -> List[Tuple[Optional[str],
> +                                                           Optional[str]]]:
> +    a: List[str] = keyword_array(old)
> +    b: List[str] = keyword_array(new)
> +
> +    s = difflib.SequenceMatcher(a=a, b=b)
> +
> +    changes = []
> +    for tag, i1, i2, j1, j2 in s.opcodes():
> +        if tag == 'replace':
> +            changes.append((a[i1:i2], b[j1:j2]),)
> +        elif tag == 'delete':
> +            changes.append((a[i1:i2], None),)
> +        elif tag == 'insert':
> +            changes.append((None, b[j1:j2]),)
> +        else:
> +            assert tag == 'equal'
> +    return changes
> +
> +
> +def keyword_changes(ebuild1: str, ebuild2: str) -> List[Tuple[Optional[str],
> +                                                              Optional[str]]]:
> +    with open(ebuild1) as e1, open(ebuild2) as e2:
> +        lines1 = e1.readlines()
> +        lines2 = e2.readlines()
> +
> +        diff = difflib.unified_diff(lines1, lines2, n=0)
> +        assert next(diff) == '--- \n'
> +        assert next(diff) == '+++ \n'
> +
> +        hunk: int = 0
> +        old: str = ''
> +        new: str = ''
> +
> +        for line in diff:
> +            if line.startswith('@@ '):
> +                if hunk > 0: break
> +                hunk += 1
> +            elif line.startswith('-'):
> +                if old or new: break
> +                old = line
> +            elif line.startswith('+'):
> +                if not old or new: break
> +                new = line
> +        else:
> +            if 'KEYWORDS=' in old and 'KEYWORDS=' in new:
> +                return keyword_line_changes(old, new)
> +        return None
> +
> +
> +def apply_keyword_changes(ebuild: str,
> +                          changes: List[Tuple[Optional[str],
> +                                              Optional[str]]]) -> int:
> +    # ekeyword will only modify files named *.ebuild, so make a symlink
> +    ebuild_symlink = ebuild + '.ebuild'
> +    os.symlink(ebuild, ebuild_symlink)
> +    atexit.register(lambda: os.remove(ebuild_symlink))
> +
> +    for removals, additions in changes:
> +        args = []
> +        for rem in removals:
> +            # Drop leading '~' and '-' characters and prepend '^'
> +            i = 1 if rem[0] in ('~', '-') else 0
> +            args.append('^' + rem[i:])
> +        if additions:
> +            args.extend(additions)
> +        args.append(ebuild_symlink)
> +
> +        result = ekeyword.main(args)
> +        if result != 0:
> +            return result
> +    return 0
> +
> +
> +def main(argv):
> +    if len(argv) != 4:
> +        sys.exit(-1)
> +
> +    O = argv[1] # %O - filename of original
> +    A = argv[2] # %A - filename of our current version
> +    B = argv[3] # %B - filename of the other branch's version
> +
> +    # Get changes from %O to %B
> +    changes = keyword_changes(O, B)
> +    if not changes:
> +        sys.exit(-1)
> +
> +    # Apply O -> B changes to A
> +    result: int = apply_keyword_changes(A, changes)
> +    sys.exit(result)
> +
> +
> +if __name__ == "__main__":
> +    main(sys.argv)
> --
> 2.26.2
>
