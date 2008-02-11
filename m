From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix segfault
Date: Mon, 11 Feb 2008 15:28:45 -0800
Message-ID: <7vir0v6pjm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802112227400.3870@racer.site>
	<7vprv36qkt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOi5q-0004Im-Cv
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 00:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYBKX3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 18:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYBKX3L
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 18:29:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbYBKX3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 18:29:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8376832E4;
	Mon, 11 Feb 2008 18:29:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A1832E3;
	Mon, 11 Feb 2008 18:29:04 -0500 (EST)
In-Reply-To: <7vprv36qkt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Feb 2008 15:06:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73605>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> When the patch reports a line number that is larger than the number of
>> lines in the current version of the file, git-apply used to segfault.
>
> I have to wonder if the correct fix should be like this
> instead.  Under that condition, I think computation of the
> initial "try" value already oversteps the line[] array for the
> original image.

With tests...

 builtin-apply.c       |    3 ++
 t/t4105-apply-fuzz.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2b8ba81..177f541 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1809,6 +1809,9 @@ static int find_pos(struct image *img,
 	else if (match_end)
 		line = img->nr - preimage->nr;
 
+	if (line > preimage->nr)
+		line = preimage->nr;
+
 	try = 0;
 	for (i = 0; i < line; i++)
 		try += img->line[i].len;
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
new file mode 100755
index 0000000..9c2a9f5
--- /dev/null
+++ b/t/t4105-apply-fuzz.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='apply with fuzz and offset'
+
+. ./test-lib.sh
+
+dotest () {
+	
+	name="$1" && shift &&
+
+	test_expect_success "$name" "
+		git checkout-index -f -q -u file &&
+		git apply $* &&
+		diff -u expect file
+	"
+
+}
+
+test_expect_success setup '
+
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12
+	do
+		echo $i
+	done >file &&
+	git update-index --add file &&
+	for i in 1 2 3 4 5 6 7 a b c d e 8 9 10 11 12
+	do
+		echo $i
+	done >file &&
+	cat file >expect &&
+	git diff >O0.diff &&
+
+	sed -e "s/@@ -5,6 +5,11 @@/@@ -2,6 +2,11 @@/" >O1.diff O0.diff &&
+	sed -e "s/@@ -5,6 +5,11 @@/@@ -7,6 +7,11 @@/" >O2.diff O0.diff &&
+	sed -e "s/@@ -5,6 +5,11 @@/@@ -19,6 +19,11 @@/" >O3.diff O0.diff &&
+
+	sed -e "s/^ 5/ S/" >F0.diff O0.diff &&
+	sed -e "s/^ 5/ S/" >F1.diff O1.diff &&
+	sed -e "s/^ 5/ S/" >F2.diff O2.diff &&
+	sed -e "s/^ 5/ S/" >F3.diff O3.diff
+
+'
+
+dotest 'unmodified patch' O0.diff
+
+dotest 'minus offset' O1.diff
+
+dotest 'plus offset' O2.diff
+
+dotest 'big offset' O3.diff
+
+dotest 'fuzz with no offset' -C2 F0.diff
+
+dotest 'fuzz with minus offset' -C2 F1.diff
+
+dotest 'fuzz with plus offset' -C2 F2.diff
+
+dotest 'fuzz with big offset' -C2 F3.diff
+
+test_done
