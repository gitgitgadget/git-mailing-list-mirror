From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pull: re-fix command line generation
Date: Sun, 24 Jan 2010 11:12:41 -0800
Organization: 
Message-ID: <7vvder71w6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 20:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7tC-0005aC-0X
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0AXTMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588Ab0AXTMr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:12:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0AXTMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:12:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE869344A;
	Sun, 24 Jan 2010 14:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=bO7K
	MjZ0Us3xvI5NmEp8lrrds4E=; b=tCbwNchXXVlBf/o4k/FiBxeYxCjjdJOin/3L
	2KhS9aZW3Mz529j9ZYex3gmhA2RbNBDryWCajnEtelctnVn85ENwwsAXghhrgKL6
	0X3grW7ofcxOhEZIygbTSyqyCfRTF7ry+HHyqOomaTE6tG2R0l7Mvw2mtJVcxTPo
	EkHWvxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=dlo
	KAmhg+eB18uXxz+EfsmFUriTLtziX5C/1VO+Y0MCQeFNlWtF0LIkD90ohoJgSTtG
	WT9qZVXtOM2S26h7wPQUSqbuCUyFju5avI5Xg4+Ccr+lyYQ+fEzMu81XNvMcVZBV
	x11KRKii8dvoeQepq3nXocx63DKHA7AxC8Ipgzew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB4C93449;
	Sun, 24 Jan 2010 14:12:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EDD593440; Sun, 24 Jan
 2010 14:12:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73C29E84-091C-11DF-B504-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137912>

14e5d40 (pull: Fix parsing of -X<option>, 2010-01-17) forgot that
merge_name needs to stay as a single non-interpolated string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just in case somebody is on 'master' and uses "pull --log"...

 git-pull.sh         |    2 +-
 t/t5524-pull-msg.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)
 create mode 100755 t/t5524-pull-msg.sh

diff --git a/git-pull.sh b/git-pull.sh
index 2de4c3a..38331a8 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -275,7 +275,7 @@ true)
 *)
 	eval="git-merge $diffstat $no_commit $squash $no_ff $ff_only"
 	eval="$eval  $log_arg $strategy_args $merge_args"
-	eval="$eval \"$merge_name\" HEAD $merge_head $verbosity"
+	eval="$eval \"\$merge_name\" HEAD $merge_head $verbosity"
 	;;
 esac
 eval "exec $eval"
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
new file mode 100755
index 0000000..8cccecc
--- /dev/null
+++ b/t/t5524-pull-msg.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='git pull message generation'
+
+. ./test-lib.sh
+
+dollar='$Dollar'
+
+test_expect_success setup '
+	test_commit initial afile original &&
+	git clone . cloned &&
+	(
+		cd cloned &&
+		echo added >bfile &&
+		git add bfile &&
+		test_tick &&
+		git commit -m "add bfile"
+	) &&
+	test_tick && test_tick &&
+	echo "original $dollar" >afile &&
+	git add afile &&
+	git commit -m "do not clobber $dollar signs"
+'
+
+test_expect_success pull '
+(
+	cd cloned &&
+	git pull --log &&
+	git log -2 &&
+	git cat-file commit HEAD >result &&
+	grep Dollar result
+)
+'
+
+test_done
-- 
1.6.6.1.557.g77031
