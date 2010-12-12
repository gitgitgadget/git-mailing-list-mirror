From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: SIGPIPE in t9300-fast-import
Date: Sun, 12 Dec 2010 15:49:03 -0500
Message-ID: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: David Barr <david.barr@cordelta.com>
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 12 21:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRsvp-0000Jr-2K
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 21:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab0LLUtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 15:49:08 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:51437 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0LLUtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 15:49:07 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9905B1FFC43C; Sun, 12 Dec 2010 20:48:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 2ADA31FFC057;
	Sun, 12 Dec 2010 20:48:58 +0000 (UTC)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163490>

The new cat-blob test (9300.114) is failing for me on OS X, and has been since it's introduction in "85c6239 fast-import: let importers retrieve blobs":

---- 8< ----

ok 113 - setup: have pipes?

expecting success: 
	expect_id=$(git hash-object big) &&
	expect_len=$(wc -c <big) &&
	echo $expect_id blob $expect_len >expect.response &&

	rm -f blobs &&
	cat >frontend <<-\FRONTEND_END &&
	#!/bin/sh
	cat <<EOF &&
	feature cat-blob
	blob
	mark :1
	data <<BLOB
	EOF
	cat big
	cat <<EOF
	BLOB
	cat-blob :1
	EOF

	read blob_id type size <&3 &&
	echo "$blob_id $type $size" >response &&
	dd of=blob bs=$size count=1 <&3 &&
	read newline <&3 &&

	cat <<EOF &&
	commit refs/heads/copied
	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
	data <<COMMIT
	copy big file as file3
	COMMIT
	M 644 inline file3
	data <<BLOB
	EOF
	cat blob &&
	cat <<EOF
	BLOB
	EOF
	FRONTEND_END

	mkfifo blobs &&
	(
		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
		sh frontend 3<blobs |
		git fast-import --cat-blob-fd=3 3>blobs
	) &&
	git show copied:file3 >actual &&
	test_cmp expect.response response &&
	test_cmp big actual

0+1 records in
0+1 records out
8139 bytes transferred in 0.000062 secs (131297847 bytes/sec)
error: git-fast-import died of signal 13
not ok - 114 R: copy using cat-file
---- 8< ----

I don't have the tuits right now to dig into this, but "trash directory.t9300-fast-input" has a good response (`cmp expect.response response` is true), but has no refs/heads/copied.  I can run help provide diagnostics, if anyone needs more data.

~~ Brian

PS:  Isn't t9300 getting a little crazily long?  Is there a good way to split it up by feature or something? It runs quickly, but finding were something is failing is getting a little difficult.