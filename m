From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] am -3: list the paths that needed 3-way fallback
Date: Wed, 28 Mar 2012 21:04:12 -0700
Message-ID: <7v1uocrr2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 06:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD6ax-00044E-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 06:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769Ab2C2EEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 00:04:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab2C2EEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 00:04:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42766780F;
	Thu, 29 Mar 2012 00:04:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	GfiaF/z4kuxxLFZtoXXlKJLgi0=; b=RRsJXO3f+qEYjQxu293KdojYlUHKdY/H1
	/6uMVbKsXP+s7CwLKqsiJXNbb48AYCfVwsX7UvecUx3/Sat/rbJD5tvKh4rB37VM
	UDgyJ3uVn78t4nx6LL78fJr8uFUPv5DOixpZm/Li2wI7VYSPW6LXSeo3lVYZ5H6k
	gcgB9/SDpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=s6D
	13j9BQBA9EMNmsgxnICphQNI+7sH3JcAoxDDaztenq3BYbw40e5uQvDNPh5m8SfS
	NZREe5fe8sJCUOMAMNLrRcsm3r/gv5PfU9DzdF8lHMBczcn6NA8M6u7LZNvpC2Qy
	VLKtHQUR1CxX91y4l4aht6YSybqnpBAQXzGMGWBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A61F780E;
	Thu, 29 Mar 2012 00:04:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9951A780B; Thu, 29 Mar 2012
 00:04:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3ED8010A-7954-11E1-834F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194225>

When applying a patch that was based on an older release with "am -3", I
often wonder changes to which files need to be reviewed with extra care to
spot mismerges, but there is no good indication.

The paths that needed 3-way fallback can easily be obtained by comparing
the synthesized (partial) base tree and the current HEAD and noticing only
additions and modifications (removals only show the sparseness of the fake
ancestor tree, which is not useful information at all).  List them in the
usual --name-status format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-am.sh |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 4da0dda..e686a17 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -138,6 +138,12 @@ fall_back_3way () {
     say Using index info to reconstruct a base tree...
 
     cmd='GIT_INDEX_FILE="$dotest/patch-merge-tmp-index"'
+
+    if test -z "$GIT_QUIET"
+    then
+	eval "$cmd git diff-index --cached --diff-filter=AM --name-status HEAD"
+    fi
+
     cmd="$cmd git apply --cached $git_apply_opt"' <"$dotest/patch"'
     if eval "$cmd"
     then
-- 
1.7.10.rc2.76.gd2b7f
