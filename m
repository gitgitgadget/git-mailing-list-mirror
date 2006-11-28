X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Tue, 28 Nov 2006 08:11:39 -0500
Message-ID: <20061128131139.GA10874@coredump.intra.peff.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de> <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 13:16:04 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.6/2252/Mon Nov 27 18:47:11 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32520>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp2o4-0007Wd-H2 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758654AbWK1NOl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758659AbWK1NOl
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:14:41 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:54750 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1758654AbWK1NOk (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:14:40 -0500
Received: from peff.net (66-23-211-5.clients.speedfactory.net [66.23.211.5])
 by zeus1.kernel.org (8.13.8/8.13.1) with SMTP id kASDCi5L021393 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 13:13:06 GMT
Received: (qmail 5757 invoked from network); 28 Nov 2006 08:11:49 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 28 Nov 2006 08:11:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Nov
 2006 08:11:39 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Nov 27, 2006 at 04:09:53PM -0800, Junio C Hamano wrote:

> Interesting.  While driving to work this morning I had the same
> thought.  A revision that does not appear in the output from
> 
> 	for file in $(list of files the commit touches)
>         do
> 		git blame v2.6.17..v2.6.18 -- $file
> 	done

Just for fun, I took a look at what we might see by ordering commits by
their "amount of blamedness". That is, the count of lines introduced by
a commit which were not later superseded. The script I used is below:

#!/bin/sh

start=$1; shift
end=$1; shift

start_sha1=`git-rev-parse $start^{}`
git-rev-list --parents $start..$end >revs
echo $start_sha1 >>revs
for i in `git-diff --raw -r $start $end | cut -f2`; do
  echo blaming $i... >&2
  git-blame -l -S revs $i | cut -d' ' -f1
done |
  grep -v $start_sha1 |
  sort | uniq -c | sort -rn |
  while read count hash; do
    echo "$count `git-rev-list --max-count=1 --pretty=oneline $hash`"
  done

The top 15 for v1.4.3 to v1.4.4 are:

1604 6973dcaee76ef7b7bfcabd2f26e76205aae07858 Libify diff-files.
1100 9f613ddd21cbd05bfc139d9b1551b5780aa171f6 Add git-for-each-ref: helper for language bindings
1050 cee7f245dcaef6dade28464f59420095a9949aac git-pickaxe: blame rewritten.
700 58e60dd203362ecb9fdea765dcc2eb573892dbaf Add support for pushing to a remote repository using HTTP/DAV
571 9f1afe05c3ab7228e21ba3666c6e35d693149b37 gitk: New improved gitk
524 197e8951abd2ebf2c70d0847bb0b38b16b92175b http-push: support for updating remote info/refs
504 83b5d2f5b0c95fe102bc3d1cc2947abbdf5e5c5b builtin-grep: make pieces of it available as library.
462 aa1dbc9897822c8acb284b35c40da60f3debca91 Update http-push functionality
344 a57a9493df00b6fbb3699fda8ceedf4ac0783ac6 Added Perl git-cvsimport-script
343 f8b28a4078a29cbf93cac6f9edd8d5c203777313 gitk: Add a tree-browsing mode
323 00449f992b629f7f7884fb2cf46ff411a2a4f381 Make git-fmt-merge-msg a builtin
285 fd8ccbec4f0161b14f804a454e68b29e24840ad3 gitk: Work around Tcl's non-standard names for encodings
283 9cf6d3357aaaaa89dd86cc156221b7b604e9358c Add git-index-pack utility
277 e4fbbfe9eccd37c0f9c060eac181ce05988db76c Add git-zip-tree
256 da7c24dd9c75d014780179f8eb843968919e4c46 gitk: Basic support for highlighting one view within another

The bottom 15 are:

1 076b2324cdca9a2825c569cf9ec02d219c237e26 show-branch: make it work in a subdirectory.
1 061303f0b50a648db8e0af23791fc56181f6bf93 cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}
1 057bc808b4aa2e7795f9bd395e68071301bc0b74 path-list: fix path-list-insert return value
1 04c13d38772c77997d8789ee2067cc351b66e2aa Save the maxwidth setting in the ~/.gitk file.
1 041a7308de3e6af36c5a6cc3412b542f42314f3f sha1_name.c: prepare to make get_tree_entry() reusable from others.
1 0360e99d06acfbb0fcb72215cf6749591ee53290 [PATCH] Fix git-rev-parse --default and --flags handling
1 02d3dca3bff6a67dead9f5b97dfe3576fe5b14e5 revision.c: fix "dense" under --remove-empty
1 02c5cba2007856465710aa37cd41b404372ab95b find_unique_abbrev() with len=0 should not abbreviate
1 02853588a48eddbaa42b58764960394e416d68bf Typofix in Makefile comment.
1 024701f1d88d79f3777bf45c82437f40a80b6eaa Make pack-objects chattier.
1 021b6e454944a4fba878651ebf9bfe0a3f6c3077 Make index file locking code reusable to others.
1 01ff767a3266a1876ce24a200c45786083768fda Merge branch 'lt/refs' into next
1 01385e275828c1116ea9bfcf827f82f450ee8f5f Comment fixes.
1 013049c985e4095106e545559c17bc594d56468d revert/cherry-pick: handle single quote in author name.
1 0086e2c854e3af3209915e4ec2f933bcef400050 Rename lost+found to lost-found.

This approach isn't without value; the top lines really _are_ important
changes, as they show where a lot of work (line-wise) went.  The bottom
lines are relatively unimportant (oh boy, comment fixes!).  But there
are obviously some one-liners that are very interesting. For example:
  1 0abc0260fa3419de649fcc1444e3d256a17ca6c7 pager: default to LESS=FRSX not LESS=FRS
generated quite a bit of discussion on the list, and end users would
care about it.

I think it's clear that "important commits" is going to be something we
determine through heuristics; blame-able lines is probably a heuristic
worth considering.

