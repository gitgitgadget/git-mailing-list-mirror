Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD26EEB562
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjIHTTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjIHTTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 15:19:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C512C
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 12:19:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AE3B1A6C57;
        Fri,  8 Sep 2023 15:19:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=JM3p8wK+30XfrRwUjurU/k2yaYiORXMIDKgVHX
        iM2fo=; b=klr4L9Y1GWUk0QyFBTx4fFe1XDsHgjbXParuAKroJgeNcvQR8ziaTU
        dHXgWF67nERQtycUlNCanHz9exGIA4bCr+Dl+Kurea7hDZot06bVfSF5HOdhEIcS
        fHWM2fu2LA8T2s8aCDsSEos1Q0cUoqDWaTHfZVHVymo4dP2Esib/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02F211A6C56;
        Fri,  8 Sep 2023 15:19:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 630481A6C54;
        Fri,  8 Sep 2023 15:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: add `--ignore-missing-links` user option
In-Reply-To: <20230908174208.249184-1-karthik.188@gmail.com> (Karthik Nayak's
        message of "Fri, 8 Sep 2023 19:42:07 +0200")
References: <20230908174208.249184-1-karthik.188@gmail.com>
Date:   Fri, 08 Sep 2023 12:19:48 -0700
Message-ID: <xmqqwmx0sca3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADD29FA2-4E7C-11EE-9A2F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> The revision backend is used by multiple porcelain commands such as
> git-rev-list(1) and git-log(1). The backend currently supports ignoring
> missing links by setting the `ignore_missing_links` bit. This allows the
> revision walk to skip any objects links which are missing.

> Currently there is no way to use git-rev-list(1) to traverse the objects
> of the main object directory (GIT_OBJECT_DIRECTORY) and print the
> boundary objects when moving from the main object directory to the
> alternate object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES).

The above description needs tightened up a bit, I think.

What is left unsaid is that you arranged a repository to borrow from
an alternate object directory (or two), and plan to walk objects
with this bit on in the repository, while leaving the alternates
disabled.  Without stating that you plan to disable the alternates
while this mode of operation happens, nothing would happen when the
traversal goes from the main to the alternate because no links are
broken, no?

> By exposing this new flag `--ignore-missing-links`, users can set the
> required env variables (GIT_OBJECT_DIRECTORY and
> GIT_ALTERNATE_OBJECT_DIRECTORIES) along with the `--boundary` flag to
> find the boundary objects between object directories.

This command being a plumbing, there is not much reason to object to
surfacing features that already internally exist to the command line
option.    Having said that, 

 * Suppose your traversal with --ignore-missing-links from the tip
   of a branch reaches a tree object A, and the tree object A has a
   link to a blob B and a blob C.  But B is in a separate object
   store that you usually access via the alternate mechanism.
   Instead of barfing "The repository is corrupt---object A points
   at object B that does not exist", we pretend that A does not have
   the link to B and keep traversing, discovering C and other
   objects.

   That much we can read from the above and also the documentation
   part of the patch.  The interaction with --boundary needs to be
   clarified in this description and the documentation, though.  It
   is unclear if you show 'A' or 'B' in this scenario.

 * Some traversals use the ignore-missing-links bit implicitly and
   currently there is no way to turn it off.  Is it plausible that
   user may want to explicitly toggle it off, with the option
   negated, i.e. --no-ignore-missing-links?  I do not immediately
   see the utility of such an option, but that is only due to my
   lack of imagination.  For now, I think it makes sense not to
   allow negating this option, until somebody comes up with a useful
   use case.

> +--ignore-missing-links::
> +	When an object points to another object that is missing, pretend as if the
> +	link did not exist. These missing links are not written to stdout unless
> +	the --boundary flag is passed.

Does "git rev-list" ever writes "links"?  I thought not.  

"These missing objects are not written" would be more sensible, but
we never write missing objects with or without the option, so it
is not even worth saying.

When "--boundary" is passed, do they appear as if they are
available?  If not, then the above description is very misleading.

    During traversal, if an object that is referenced does not
    exist, pretend as if the reference itself does not exist,
    instead of dying of a repository corruption.  Running the
    command with the "--boundary" option makes these missing
    objects, together with the objects on the edge of revision
    ranges (i.e. true boundary objects), appear on the output,
    prefixed with '-'.

or something like that, perhaps?

> +# With `--ignore-missing-links`, we stop the traversal when we encounter a
> +# missing link.
> +test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
> +	test_stdout_line_count = 5 git -C main rev-list --ignore-missing-links HEAD
> +'
> +
> +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
> +# commits.
> +test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
> +	git -C main rev-list --ignore-missing-links --boundary HEAD >list-output &&
> +	test_stdout_line_count = 6 cat list-output &&
> +	test_stdout_line_count = 1 cat list-output | grep "^-"
> +'

These tests are way too loose.  Not only you want to see certain
number of boundary objects, you _know_ exactly which object should
be on the boundary, and you should check that instead.  That will
allow you to find a mistake to write commit 'A' that refers to a
missing commit 'B', when they wanted to write the missing comit 'B',
as a boundary object, for example.

Thanks.

