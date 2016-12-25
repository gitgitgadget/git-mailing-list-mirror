Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7978B200E0
	for <e@80x24.org>; Sun, 25 Dec 2016 02:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbcLYCi5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 21:38:57 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:49102 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752965AbcLYCi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2016 21:38:56 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cKyYa-00042X-Cf; Sun, 25 Dec 2016 11:29:04 +0900
Date:   Sun, 25 Dec 2016 11:29:04 +0900
From:   Mike Hommey <mh@glandium.org>
To:     hvoigt@hvoigt.net, sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Corner case involving null sha1, alternates, cache misses, and
 submodule config API
Message-ID: <20161225022904.v2mixrnbitvlviuu@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As you might be aware, I'm working on a mercurial remote helper for git.
The way it stores metadata for mercurial manifests abuses "commit"
references in trees, which are normally used for submodules.

Some operations in the helper use git diff-tree on those trees to find
files faster than just using ls-tree on every commit would.

Anyways, long story short, it turns out that a combination of
everything mentioned in the subject of this email causes running git
diff-tree -r --stdin with a list of 300k+ pairs of commits to take 10
minutes, when (after investigation) adding --ignore-submodules=dirty
made it take 1 minute instead, for the exact same 3GB output.

It turns out, this all starts in is_submodule_ignored(), which contains:

        if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
                set_diffopt_flags_from_submodule_config(options, path);

And set_diffopt_flags_from_submodule_config calls:

        submodule_from_path(null_sha1, path);

And because there is no actual submodule involved, at some point that
null_sha1 ends up in the call to read_sha1_file from
submodule-config.c's config_from, which then proceeds to try to open the
null sha1 as a loose object in every alternate, doing multiple system
calls in each directory for something that is bound to fail. And to add
pain to injury, it repeats that for each and every line of input to git
diff-tree because the object cache doesn't care about storing negatives
(which makes perfect sense for most cases).

Even worse, when read_object returns NULL because the object doesn't
exist, read_sha1_file_extended calls has_loose_object which does
another set of system calls.

Now, while I realize my use case is very atypical, and that I should
just use --ignore-submodule=dirty, the fact that using the null sha1 can
trigger such behavior strikes me as a footgun that would be better
avoided. Especially when you factor the fact that
read_sha1_file_extended calls lookup_replace_object_extended, which
suggests one might interfere by creating a replace object for the null
sha1. (BTW, it's not entirely clear to me, in the context of actual
submodules, what the various --ignore-submodule options are supposed to
mean for trees that are not the current HEAD ; also, the manual page say
"all" is the default, but that doesn't appear to be true)

From a cursory look at the output of `git grep \\bnull_sha1` it doesn't
look like the null sha1 is used anywhere else in a similar fashion where
it can be attempted to be read as an object. So, one could consider this
is something the submodule config code should handle on its own by
treating the null_sha1 argument to submodule_from_path (really
config_from) specially. After all, gitmodule_sha1_from_commit already
avoids a get_sha1() call when it's given the null sha1.

OTOH, it seems submodule_from_path and submodule_from_name, the only two
public functions that end up in config_from(), are *always* called with
either the null sha1 or a literal null pointer. The *only* calls to
these functions that doesn't involve a null sha1 or a null pointer is
from test code. So all in all, I'm not entirely sure what this sha1
argument is all about in the first place.

However, an argument could be made that null_sha1 should be treated
specially at a lower level (read_sha1_file, I guess).

What would be sensible to do here?

Mike
