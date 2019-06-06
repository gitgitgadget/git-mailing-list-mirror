Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A681F462
	for <e@80x24.org>; Thu,  6 Jun 2019 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFFTCa (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 15:02:30 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42478 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfFFTC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 15:02:29 -0400
Received: by mail-qk1-f171.google.com with SMTP id b18so2152184qkc.9
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eIVOzHWVGA3LsnNq71RtpUgklvLOAPgAuchryN2nKS4=;
        b=EGisurSm7blVoUX0IeQoF7MsAFZ5RjdENd4YSqssSQKiTPqsEpkkiQv97ku9I1D6xT
         J4HkjcC64NWD38yozAPU3bc89on5vHf1cHabUGc7C+iC4S+27vaofVSFzxaIvmv9O3xs
         qAwUD1IF5L4twz1zkHvC5FHLhAmvjov5jSPKShZ9Ext/2Lhu0arMxB9xbfT/0ukr3/wA
         bEnjRhh2sZ5jwOXsApz9dg2LBQVWwibloy7K6nsJNol5Py414lJZoTP46CV7bq5eXhoH
         yA20vKifmqRwi+p/QoXG7hsUud+G87KPl0ZZ6nyVQr3u+KniSba5OUZVGbugXR4XG/hT
         zomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eIVOzHWVGA3LsnNq71RtpUgklvLOAPgAuchryN2nKS4=;
        b=WJBZGkeNMgJusYtuwvW0nkts34kzXBRt8mOXAcBpqRKzJNG+3y4YW/nEQSoRo8BxIZ
         U+XuvvolZOR9dMt1Bh+kPHpY3SwkSVNP7z7uVnssmceS85BpMsTrHS5n16khYNs+RbBe
         bBoFKzINt/J/zOT0Juw5kvWXJUi3zD13Pk+etRELnY/Kjyzwi0rsp3NTB2+gZR0xAkWw
         xOUpmEB7ZMmEoGDi5JsOf3KvVgfdgiOoJB/4qpURq6F08sPrnYFlX3Zh1GTwROaHrES/
         eWZHvRC7g+qLb29vZs1Q5jam6FtN6q1Csva2i0V67cdn+ZtOXSpi9WTct8l8G3OnLxeN
         gXMQ==
X-Gm-Message-State: APjAAAUDMUMfurVsDqQwnQTS0QaxrY3zXdUjIuxbIXzHVFJP+vtn0wfn
        oefSlNpiuS94j+EmNKJvCYPtgmwIeTEyHu+YVnQOuD6Gv8GRqw==
X-Google-Smtp-Source: APXvYqxqrPlNu9ABLWIOGyu4W2P56zTwj8Uj7+q07SCLtON6DmhXy1CJ7zkASZa6a41iOnzXTvY0WrPf3kSQC+OcZfs=
X-Received: by 2002:a37:ea16:: with SMTP id t22mr40670485qkj.337.1559847748229;
 Thu, 06 Jun 2019 12:02:28 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 6 Jun 2019 12:02:17 -0700
Message-ID: <CAJoAoZktk-w40MEsRZesvkX23Xn2uMUPiO_cMHa=-xfdyVHCWg@mail.gmail.com>
Subject: Is --filter-print-omitted correct/used/needed?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yesterday while down a rabbit hole, I discovered an interesting thing
about the 'omitted' object in many filters in
list-objects-filter-options.h.  It appears that when we call
list-objects.h:traverse_commit_list_filtered() with a non-NULL
'omitted' argument, we still perform a walk of all objects - that is,
the filtered walk is no more efficient than the unfiltered walk from
the same place via 'traverse_commit_list()'. I verified by calling
each and counting the objects:

161         if (0) {
162                 /* Unfiltered: */
163                 printf(_("Unfiltered object walk.\n"));
164                 traverse_commit_list(rev, walken_show_commit,
165                                 walken_show_object, NULL);
166         } else {
167                 printf(_("Filtered object walk with filterspec
'tree:1'.\n"));
168                 /*
169                  * We can parse a tree depth of 1 to demonstrate
the kind of
170                  * filtering that could occur eg during shallow
cloning.
171                  */
172                 parse_list_objects_filter(&filter_options,
"tree:1");
173
174                 traverse_commit_list_filtered(&filter_options,
rev,
175                         walken_show_commit, walken_show_object,
NULL, &omitted);
176         }
177
178         /* Count the omitted objects. */
179         oidset_iter_init(&omitted, &oit);
180
181         while ((oid = oidset_iter_next(&oit)))
182                 omitted_count++;
183
184         printf(_("Object walk completed. Found %d commits, %d
blobs, %d tags, "
185                "and %d trees; %d omitted objects.\n"),
commit_count,
186                blob_count, tag_count, tree_count, omitted_count);

I found that omitted_count was always equal to the difference between
sum(blob_count, tag_count, tree_count, commit_count) in the unfiltered
and filtered walks. I also found that the length of time required to
perform the unfiltered walk and the filtered-with-non-NULL-omitted
walk was the same, while the time required to perform the filtered
walk with NULL omitted was significantly shorter. (The walk in
question was over the latest release of Git master, plus the ten or so
commits in my feature branch.)

I was surprised! I figured that with filter "tree:1" that "omitted"
would contain only the objects on the "border" of the filter - that
is, I assumed it would contain the blobs and trees in the root git
dir, but none of those trees' blobs and trees. After talking with
jrnieder at length, it sounds like neither of us were clear on why
this "omitted" list would be needed beyond the initial development
stage of a new filter... Jonathan's impression was also that if we do
need the "omitted" list, it may be a bug that we're still traversing
objects which are only reachable from objects already omitted.

I grepped the Git source and found that we only provide a non-NULL
"omitted" when someone calls "git rev-list --filter-print-omitted",
which we verify with a simple test case for "blobs:none", in which
case the "border" objects which were omitted must be the same as all
objects which were omitted (since blobs aren't pointing to anything
else). I think if we had written a similar test case with some trees
we expect to omit we might have noticed sooner.

Since I was already in the rabbit hole, out of curiosity I did a
search on Github and only found one project referencing
--filter-print-omitted which wasn't a mirror of Git:
https://github.com/search?l=Python&q=%22--filter-print-omitted%22&type=Code

So, what do we use --filter-print-omitted for? Is anybody needing it?
Or do we just use it to verify this one test case? Should we fix it,
or get rid of it, or neither?

 - Emily
