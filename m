From: Stefan Beller <sbeller@google.com>
Subject: [BUG?] setting ulimit in test suite broken for me
Date: Wed, 21 Jan 2015 10:59:06 -0800
Message-ID: <1421866746-29444-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jeanjacques.lafay@gmail.com, peff@peff.net
X-From: git-owner@vger.kernel.org Wed Jan 21 19:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0Us-00040Q-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbbAUS7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 13:59:19 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:63131 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbAUS7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 13:59:17 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so2878226igb.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bhe1zTrPuIQ50iqqQ/uRlBlDcIHlb2jPqDJvvVCRGF4=;
        b=mDBRZzWP1xdny40tSeRC7/CQ2s8tqLTcnQevLGV28kXVo7PV+1SHyatYRk9SGMLv4w
         pMZ79YIu92Hb4oTZ+aq23MalfJCptgFGYpf5UGzLBVeKAA6b1wqFUW0Loyl+RD34xUcr
         QBUxWh/e5EawUwhePu3l3KomDWA4MNahQKoe5VNcMDBT+mvcthNQlRFzS/h9GWv3gfGn
         tmi3TmoyZhPIh7qBL65Lp5qx6UCJgb9dVrWMEFr/idDSQaWA7WIyzajHZfcp/n25ygBD
         39hmWqmJ0c1Nw153PHspN2CJ/6gILlJ3Pelzv1D1nUCi0BLP1gVdEWDKgCV2W41tXt2w
         lGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bhe1zTrPuIQ50iqqQ/uRlBlDcIHlb2jPqDJvvVCRGF4=;
        b=QNgtbjK1zUSITVlxZ8WkWLLHpLsAUVX1Cio+KiYGS99pvX2VHF1/Orux9c/gZcL8Cr
         mikwCmcCzn+ZtV4CkngKc9obtJq0cWdwKIX5lyr9XTmT8N8bZSs2Uzb9sllKMYyNWVAB
         vXL2pQKhrCTow8+qItwTdIC18TDueaKY0CMLQz4aY8SOsRDckDZStWTdhAq2I6VJzv8y
         y1YRsstIAUGrmyQ5fZB6eyNmIwshfko8A8j1YjXCqLqGsZ9eKrQiudKbuwxRaC7oXUMd
         nKErtikQIaMi7/SwxqCfWrkw53j2O/I/1/QYsXtDHtwAxkVUGbTDJIhgOFdzTv2wca1c
         cEQw==
X-Gm-Message-State: ALoCoQlNMsIEX3GgQLObvptfyPkzJJh2U+h9E93/xqyvsgitwFfFY7LTRtLKTurVt8/6zf7nIIvd
X-Received: by 10.42.97.66 with SMTP id m2mr34243229icn.48.1421866756978;
        Wed, 21 Jan 2015 10:59:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id f1sm6530953igt.14.2015.01.21.10.59.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 10:59:16 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262741>

Hi,

so I wanted to create a new test for large transactions, which should look like:

	run_with_limited_open_files () {
		(ulimit -n 64 && "$@")
	}

	test_lazy_prereq ULIMIT 'run_with_limited_open_files true'

	test_expect_success ULIMIT 'large transaction creating branches does not burst open file limit' '
	(
		echo $(ulimit -n)
		for i in $(seq 65)
		do
			echo "create refs/heads/$i HEAD"
		done >large_input &&
		git update-ref --stdin <large_input &&
		git rev-parse --verify -q refs/heads/65
	)
	'

Mind the "echo $(ulimit -n)" in there as a debugging output.
So if I run the test with "-d -v" to actually see the debugging output,
I see ulimit -n set to 32768 instead of the desired 64.

So I assumed I made a mistake and looked at other places with a similar
pattern such as in t7004-tag.sh. Inserting a debug statement (as attached,
so I don't need (to trust) -d and -v as parameters for the test) in there
also doesn't report the desired stack size of 128, but rather the system
default of 8192. Is that just my system or does anybody else also run into
such a problem?

Running ulimit -{n,s} manually in a shell (/bin/sh) as well as bash does
work as expected as it correctly reports with ulimit -a as well as breaking
the tests I try to write.

Thanks,
Stefan

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7004-tag.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 35c805a..4f09cb4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1460,20 +1460,21 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 '
 
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
 test_lazy_prereq ULIMIT 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
 test_expect_success ULIMIT '--contains works in a deep repo' '
+	echo $(ulimit -s) > ../ulimit_recorded
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
 	do
 		echo "commit refs/heads/master
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
 data <<EOF
 commit #$i
 EOF"
 		test $i = 1 && echo "from refs/heads/master^0"
-- 
2.2.1.62.g3f15098
