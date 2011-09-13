From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] request-pull: state exact commit object name
Date: Tue, 13 Sep 2011 15:28:16 -0700
Message-ID: <1315952896-17258-3-git-send-email-gitster@pobox.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <1315952896-17258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3bSu-0004eG-5Q
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 00:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932974Ab1IMW2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 18:28:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932958Ab1IMW2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 18:28:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4CA343FA
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QGnR
	LJAtrVlbHhJ8Or8mblfZnHY=; b=oaW6h04Le9VAAc+PZdNlqFvQLn5Ir0yyCwhd
	ggCDB58WbLQjDBdsHyYz0N+z7mRDT2C4eQDh6lu4KNYQDcv5d/gdqRtnTl1Zabjl
	WUGvaVRLFptN6G9ba3Y9Mq5oHseoR1whTIOIkOGOb483G4ZtskesY10e06XjW1zS
	WXsg31U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WGwGkv
	pUoBUwO/hNRWRBHu0EJn7/M8W6N6CChO/J90tZEqgPItc4unB0DBe4I2B1YZqmD4
	OcHjYLWLSiN6yYv0OhcUVCFPZI3/cgxfV57D/EC0PTyafsk4NoHh0gt1h6JBgoTm
	U2+6/e2T53jy39Jbf33tnMz2ErfTMVmTPWPks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CFD843F9
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6A3E43EC for
 <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g1e5814
In-Reply-To: <1315952896-17258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B002346A-DE57-11E0-BC54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181318>

A typical pull-request begins like this:

  The following changes since commit f696543dad6c7ba27b0c4fab167a5687263a9ba0:

    Flobar 2.4.3 (2011-09-13 12:34:56 +0900)

  are available in the git repository at:
    git://git.kernel.org/pub/flobar.git/ master

which is followed by the shortlog and expected diffstat. This tells you
where the requester based his work on in excruciating detail, but does not
tell you what you should expect to fetch, any more than "whatever happened
to be at the named branch when you happened to notice the request."

Update the message slightly to say:

    git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5020912116e7f82fd2d428f ;# master

so that the line still can be cut&pasted after "git fetch" (or "git
pull"), to form a command line that looks like:

    $ git <repository> <full commit object name> ;# branch

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh     |    2 +-
 t/t5150-request-pull.sh |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index fc080cc..b5a2d0f 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -70,7 +70,7 @@ git show -s --format='The following changes since commit %H:
   %s (%ci)
 
 are available in the git repository at:' $baserev &&
-echo "  $url $branch" &&
+echo "  $url $headrev ;# $branch" &&
 echo &&
 
 git shortlog ^$baserev $headrev &&
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 9cc0a42..e9d657e 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -70,9 +70,10 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	/ in the git repository at:$/!d
 	n
 	/^$/ n
-	s/^[ 	]*\(.*\) \([^ ]*\)/please pull\
+	s/^[ 	]*\(.*\) \([^ ]*\) ;# \([^ ]*\)/please pull\
 	\1\
-	\2/p
+	\2\
+	\3/p
 	q
 	EOT
 
@@ -145,6 +146,7 @@ test_expect_success 'pull request after push' '
 	{
 		read task &&
 		read repository &&
+		read head &&
 		read branch
 	} <digest &&
 	(
@@ -153,6 +155,7 @@ test_expect_success 'pull request after push' '
 		git pull --ff-only "$repository" "$branch"
 	) &&
 	test "$branch" = for-upstream &&
+	test "$head" = "$(GIT_DIR=downstream.git git rev-parse for-upstream)" &&
 	test_cmp local/mnemonic.txt upstream-private/mnemonic.txt
 
 '
@@ -170,10 +173,10 @@ test_expect_success 'request names an appropriate branch' '
 		git request-pull initial "$downstream_url" >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
-	cat digest &&
 	{
 		read task &&
 		read repository &&
+		read head &&
 		read branch
 	} <digest &&
 	{
@@ -193,7 +196,7 @@ test_expect_success 'pull request format' '
 	  SUBJECT (DATE)
 
 	are available in the git repository at:
-	  URL BRANCH
+	  URL OBJECT_NAME ;# BRANCH
 
 	SHORTLOG
 
-- 
1.7.7.rc1.1.g1e5814
