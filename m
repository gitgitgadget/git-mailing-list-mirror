Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5938220285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdHZI2Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:25 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49707 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751868AbdHZI2Y (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:24 -0400
X-AuditID: 1207440f-a43ff70000007960-00-59a1312723e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.8D.31072.72131A95; Sat, 26 Aug 2017 04:28:23 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHig004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:19 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
Date:   Sat, 26 Aug 2017 10:28:00 +0200
Message-Id: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsUixO6iqKtuuDDS4MlSGYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVce3cUpaCdcIVSxdvZWtg/M/XxcjBISFgIrFtqkQXIxeHkMAOJok/3/cxQTinmCTOzjjB
        0sXIycEmoCuxqKeZCcQWEVCTmNh2iAWkiFlgOaNEx9vzYAlhAS+JDy03WEFsFgFVia8v3oM1
        8wqYS/w8eYgdxJYQkJfY1XaRdQIj1wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkl
        eqkppZsYIYHAv4Oxa73MIUYBDkYlHt6IwgWRQqyJZcWVuYcYJTmYlER5HTQWRgrxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4V2hBJTjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJ
        ynBwKEnwdugDNQoWpaanVqRl5pQgpJk4OEGG8wANzwCp4S0uSMwtzkyHyJ9iVJQS53UASQiA
        JDJK8+B6YZH6ilEc6BVh3igDoCoeYJTDdb8CGswENFhREGxwSSJCSqqBcYZiqbRnz+X7EUkR
        l9o4gu/wqH1xrH47q2eN2oKs/VtNymOXe+hssT24yOqq8VS9gJrlci8Nlm2IlYrY8Nz+E9dy
        i869ntlR33YVNin/nnDs3+bb6gkrEvm+S/vqOGwV9D+9NTtFJCF804710Qnb1ULimyOWx/19
        csKkbbrmjuD2tOff/vRMUmIpzkg01GIuKk4EAEwTDoOvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While putzing around in the notes code quite some time ago, I found
this comment:

    /*
     * Determine full path for this non-note entry:
     * The filename is already found in entry.path, but the
     * directory part of the path must be deduced from the subtree
     * containing this entry. We assume here that the overall notes
     * tree follows a strict byte-based progressive fanout
     * structure (i.e. using 2/38, 2/2/36, etc. fanouts, and not
     * e.g. 4/36 fanout). This means that if a non-note is found at
     * path "dead/beef", the following code will register it as
     * being found on "de/ad/beef".
     * On the other hand, if you use such non-obvious non-note
     * paths in the middle of a notes tree, you deserve what's
     * coming to you ;). Note that for non-notes that are not
     * SHA1-like at the top level, there will be no problems.
     *
     * To conclude, it is strongly advised to make sure non-notes
     * have at least one non-hex character in the top-level path
     * component.
     */

This was enough of a nerd snipe to get me to dig into the code.

It turns out that the comment is incorrect, but there was nevertheless
plenty that could be cleaned up in the area:

* Make macro `GIT_NIBBLE` safer by adding some parentheses
* Remove some dead code
* Fix some memory leaks
* Fix some obsolete and incorrect comments
* Reject "notes" that are not blobs

I hope the result is also easier to understand.

This branch is also available from my Git fork [1] as branch
`load-subtree-cleanup`.

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (12):
  notes: make GET_NIBBLE macro more robust
  load_subtree(): remove unnecessary conditional
  load_subtree(): reduce the scope of some local variables
  load_subtree(): fix incorrect comment
  load_subtree(): separate logic for internal vs. terminal entries
  load_subtree(): check earlier whether an internal node is a tree entry
  load_subtree(): only consider blobs to be potential notes
  get_oid_hex_segment(): return 0 on success
  load_subtree(): combine some common code
  get_oid_hex_segment(): don't pad the rest of `oid`
  hex_to_bytes(): simpler replacement for `get_oid_hex_segment()`
  load_subtree(): declare some variables to be `size_t`

 notes.c | 136 +++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 66 insertions(+), 70 deletions(-)

-- 
2.11.0

