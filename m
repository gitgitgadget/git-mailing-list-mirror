From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] merge-recursive triggered "BUG"
Date: Wed, 16 Mar 2011 17:39:07 -0700
Message-ID: <7v4o7260no.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 01:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q01FK-0005Dx-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 01:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab1CQAjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 20:39:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1CQAjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 20:39:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 259094FB2;
	Wed, 16 Mar 2011 20:40:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=WKAbgSzshZbUGgrlY6vBzCSDy
	dI=; b=JycjpVmVRwUoZkMQ4ajjebebQdBRl4IuEQ3S3OSgp1elxfbwkWUpehhmK
	zNGJ/BocZalODqpNzIY/MJAzlJRNEDu2pbDucGkqcTDSfEjNdOYOHxnUxShgdtVE
	BzQwA72ItHKcM86RorAhY+lOsM3j+vWUCUcqsDQOcGZurk/P5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ugov0B5ZdAXj3gkYnis
	KSYt9OtnvCgb6JcxyCaSjwUMW0qGrmQYXwbaDY5+h2ZWo3HJce7GsFlQ9NTaHXct
	hgH/LP0IvhJuKizYsGXBr8gB5lpixS1sHgsQzZlRTdYegOHNfZ7oI+OSwH5yhxgz
	WHgvdReuIhrbi/EFIUXE8jKw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0423B4FB1;
	Wed, 16 Mar 2011 20:40:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0ADCE4FA5; Wed, 16 Mar 2011
 20:40:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31BEE956-502F-11E0-B516-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169209>

As a part of my today's merge, I used 'next' that contains b2c8c0a
(merge-recursive: When we detect we can skip an update, actually skip it,
2011-02-28) to merge 'maint' into 'master' to propagate older releases up.

It triggered a "BUG" per merged path, and I bisected this breakage down to
the said commit. Luckily 'master' is not contaminated with the breakage,
so I used it to finish today's work.

When I push out the result from today, you can reproduce it with

    git checkout 0631623 ;# master to acquire changes from maint
    git merge [-s recursive] fbcda3c

I suspect that the new codepath introduced by b2c8c0a needs to pay
attention to the merge depth (for example, does it make any sense at all
to run lstat() when you are doing recursive common parent synthesis?), but
I didn't dig into it.

The command fails with this output:

error: addinfo_cache failed for path 'builtin/add.c'
error: addinfo_cache failed for path 'builtin/apply.c'
error: addinfo_cache failed for path 'builtin/branch.c'
error: addinfo_cache failed for path 'builtin/checkout.c'
error: addinfo_cache failed for path 'builtin/commit.c'
error: addinfo_cache failed for path 'builtin/config.c'
error: addinfo_cache failed for path 'builtin/diff-files.c'
error: addinfo_cache failed for path 'builtin/diff.c'
error: addinfo_cache failed for path 'builtin/fast-export.c'
error: addinfo_cache failed for path 'builtin/grep.c'
error: addinfo_cache failed for path 'builtin/hash-object.c'
error: addinfo_cache failed for path 'builtin/init-db.c'
error: addinfo_cache failed for path 'builtin/log.c'
error: addinfo_cache failed for path 'builtin/merge.c'
error: addinfo_cache failed for path 'builtin/push.c'
error: addinfo_cache failed for path 'builtin/rerere.c'
error: addinfo_cache failed for path 'builtin/update-index.c'
error: addinfo_cache failed for path 't/t7810-grep.sh'
BUG: There are unmerged index entries:
BUG: 1 builtin/add.cBUG: 2 builtin/add.cBUG: 3 builtin/add.cBUG: 1 builtin/apply.cBUG: 2 builtin/apply.cBUG: 3 builtin/apply.cBUG: 1 builtin/branch.cBUG: 2 builtin/branch.cBUG: 3 builtin/branch.cBUG: 1 builtin/checkout.cBUG: 2 builtin/checkout.cBUG: 3 builtin/checkout.cBUG: 1 builtin/commit.cBUG: 2 builtin/commit.cBUG: 3 builtin/commit.cBUG: 1 builtin/config.cBUG: 2 builtin/config.cBUG: 3 builtin/config.cBUG: 1 builtin/diff-files.cBUG: 2 builtin/diff-files.cBUG: 3 builtin/diff-files.cBUG: 1 builtin/diff.cBUG: 2 builtin/diff.cBUG: 3 builtin/diff.cBUG: 1 builtin/fast-export.cBUG: 2 builtin/fast-export.cBUG: 3 builtin/fast-export.cBUG: 1 builtin/grep.cBUG: 2 builtin/grep.cBUG: 3 builtin/grep.cBUG: 1 builtin/hash-object.cBUG: 2 builtin/hash-object.cBUG: 3 builtin/hash-object.cBUG: 1 builtin/in
 it-db.cBUG: 2 builtin/init-db.cBUG: 3 builtin/init-db.cBUG: 1 builtin/log.cBUG: 2 builtin/log.cBUG: 3 builtin/log.cBUG: 1 builtin/merge.cBUG: 2 builtin/merge.cBUG: 3 builtin/merge.cBUG: 1 builtin/push.cBUG: 2 builtin/push.cBUG: 3 builtin/push.cBUG: 1 builtin/rerere.cBUG: 2 builtin/rerere.cBUG: 3 builtin/rerere.cBUG: 1 builtin/update-index.cBUG: 2 builtin/update-index.cBUG: 3 builtin/update-index.cBUG: 1 t/t7810-grep.shBUG: 2 t/t7810-grep.shBUG: 3 t/t7810-grep.shfatal: Bug in merge-recursive.c


Thanks.
