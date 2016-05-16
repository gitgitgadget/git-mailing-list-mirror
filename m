From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/12] revamping git_check_attr() API
Date: Mon, 16 May 2016 14:05:33 -0700
Message-ID: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Pi6-0001Af-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbcEPVFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:05:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750777AbcEPVFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:05:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1268B1C726;
	Mon, 16 May 2016 17:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=v4GlR2JZR8o/mdBjpg+DUo5bUt4
	=; b=cijEHPIgYBEz7jm76pBmx+4/0oQ7vc/FNAhq5FlW+rjsXTS3fiOXm6UOOrn
	WCsQW8HDj6djRwg++10f75oWvKHAO2PWT0WJA9nivwly45ghlaOouYqEie0KuHU9
	KemaTx6KPyfUkeH6DmZC6zDgMxUFjGwe8YtMJbreOVFYiFj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=tOF47H0cogxaA47t574P4EeAn8KQ5
	8U/QJFM1IG/k1KjQ3SNIRksEbmBVWkX90111VX4PxPYw2amGMsXBda0SRP3rTRMH
	Ju7ddw/lmn0ngI87XYixts0I6Z1gbflarQBcickRFiu++LiGqX0rFez0ylKu3UAn
	U0dEn0x6ncOwgg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 091031C725;
	Mon, 16 May 2016 17:05:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4858C1C724;
	Mon, 16 May 2016 17:05:47 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
X-Pobox-Relay-ID: F610B4E2-1BA9-11E6-9831-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294786>

A common pattern to check N attributes for many paths is to

 (1) prepare an array A of N git_attr_check_elem items;
 (2) call git_attr() to intern the N attribute names and fill A;
 (3) repeatedly call git_check_attrs() for path with N and A;

A look-up for these N attributes for a single path P scans the
entire attr_stack, starting from the .git/info/attributes file and
then .gitattributes file in the directory the path P is in, going
upwards to find .gitattributes file found in parent directories.

An earlier commit 06a604e6 (attr: avoid heavy work when we know the
specified attr is not defined, 2014-12-28) tried to optimize out
this scanning for one trivial special case: when the attribute being
sought is known not to exist, we do not have to scan for it.  While
this may be a cheap and effective heuristic, it would not work well
when N is (much) more than 1.

What we would want is a more customized way to skip irrelevant
entries in the attribute stack, and the definition of irrelevance
is tied to the set of attributes passed to git_check_attrs() call,
i.e. the set of attributes being sought.  The data necessary for
this optimization needs to live alongside the set of attributes, but
a simple array of git_attr_check_elem simply does not have any place
for that.

Introduce "struct git_attr_check" that contains N, the number of
attributes being sought, and A, the array that holds N
git_attr_check_elem items, and a function git_check_attr() that
takes a path P and this structure as its parameters.  This structure
can later be extended to hold extra data necessary for optimization.

    Side Note: While in this series, I am not interested in
    specifying the exact optimization, it would help readers to give
    what is envisioned.  Even when the caller is interested in only
    a few attributes (say, "diff", "text" and "group-doc"), we'd walk
    the attribute entries in various .gitattributes files, perform
    the pattern match and collect attributes for the path.  An
    earlier commit 06a604e6 (attr: avoid heavy work when we know the
    specified attr is not defined, 2014-12-28) tried to optimize out
    this scanning for one trivial special case: where an asked-for
    attribute does not appear anywhere in these files, we know we do
    not have to scan at all.

    We can do much better.  We can scan these attribute entries that
    came from .gitattributes files once and mark the ones that affect
    one or more of the attributes we know the caller is interested
    in.  Then we only go through the marked entries.  E.g. if the
    caller is interested in "diff", "text" and "group-doc"
    attributes, we can mark entries that talks about any of "diff",
    "text", "group-doc" and "binary" attributes.  The last one is
    because it is an attribute macro that expands to affect "diff"
    and "text" (these attribute are unset by having "binary").

    The way git_attr_check() API is structured expects that the
    caller expresses the set of attributes it is interested in
    upfront, and reuses to ask the same question about many paths,
    and it is already optimized for the case where it does so in
    in-order recursive descent of a tree hierarchy by having an
    attr_stack that reads, pre-parses and caches contents of the
    .gitattributes files found in each directory hierarchy.  The
    cached optimization data that sits in "struct git_attr_check"
    would be effective for this expected access pattern.

    The optimization data cannot be file-scope static to attr.c,
    even though that might be easier to implement, in anticipation
    of having more than one "struct git_attr_check" working
    alternatingly, e.g. having more than one pathspec with
    ":(attr=X)" pathspec magic, i.e.

        git cmd ":(attr=X)dir/" ":(attr=Y)dir/ectory/"

    Each pathspec element is expected to keep its own "struct
    git_attr_check" in the custom data to support pathspec magic
    to match with attributes, and the optimization data kept there
    would survive repeated calls to git_check_attr() for the same
    path with different set of attributes.


The patches in the earliest part of the series have been sent to the
list already; there is no substantial change (I think I made a
typofix in the commit log message found by Eric).

  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()

Step 8 is to make sure I can catch all the existing callers and
update the API incrementally.

  attr: rename function and struct related to checking attributes

Step 9 is the most important one.  By updating the API to allow the
callers hold piece of information more than just a simple array of
<attr, value> pair, it paves the way to add data structures that
will help optimizing the lookup.  As a demonstration of the new API,
it converts one caller.  The immediate effect to the callers is that
they can lose moderate amount of code, but that is not the point of
this change.

  attr: (re)introduce git_check_attr() and struct git_attr_check

The two patches that follow converts remaining callers to the enw
API.

  attr: convert git_all_attrs() to use "struct git_attr_check"
  attr: convert git_check_attrs() callers to use the new API

The last step retires the old one and updates the document.

  attr: retire git_check_attrs() API

 Documentation/technical/api-gitattributes.txt |  62 ++++++-----
 archive.c                                     |  24 ++---
 attr.c                                        | 143 +++++++++++++++++++-------
 attr.h                                        |  31 ++++--
 builtin/check-attr.c                          |  55 +++++-----
 builtin/pack-objects.c                        |  19 +---
 commit.c                                      |   3 +-
 convert.c                                     |  26 ++---
 ll-merge.c                                    |  33 +++---
 userdiff.c                                    |  19 ++--
 ws.c                                          |  19 ++--
 11 files changed, 236 insertions(+), 198 deletions(-)

-- 
2.8.2-748-gfb85f76
