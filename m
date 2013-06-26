From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Wed, 26 Jun 2013 15:00:26 -0700
Message-ID: <1372283778-sup-5704@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org> <1372190294-sup-1398@pimlott.net> <7v61x127bw.fsf@alter.siamese.dyndns.org> <1372198415-sup-2114@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrxlV-00010H-I9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3FZWAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:00:34 -0400
Received: from pimlott.net ([72.249.23.100]:39486 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab3FZWAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Content-Type; bh=bEjWzWM5ot89MadXYcpLriWHtzwH7gFTMLgGUafWZdQ=;
	b=IriFY9rpWgnsyMcUIARHsWOGFJdpCqu1ZJ/TasnJYBvbSIFNUaaIUHMO2rRKqP7+k/W1G93Fg97ERTh826Dfgeq2X0EImRlsKN28dagdeRNCYt+++o1MakfeVtRYxBuuujVnVzFtEKHs2UG6/k00hLPXlyQoGqAjbrOAFXSyGYs=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UrxlK-0001k5-HP; Wed, 26 Jun 2013 15:00:26 -0700
In-reply-to: <1372198415-sup-2114@pimlott.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229062>

Excerpts from Andrew Pimlott's message of Tue Jun 25 16:03:52 -0700 2013:
> Thomas's patch didn't do this: fixup! or squash! after the first is
> simply discarded, so you see:
> 
>     pick d78c915 original
>     fixup 0c6388e fixup! original
>     fixup d15b556 fixup! original
>     fixup 1e39bcd fixup! original
> 
> But it will be a simple change to keep all the fixup!s and squash!s.  I
> will do this (and try to make up for the carelessness of my previous
> patch).

In order to test this, I wrote a helper function to dump the rebase -i
todo list.  Would you like this introduced in its own patch, or
combined?  See below.

Andrew

---8<---
Subject: [PATCH] lib-rebase: set_cat_todo_editor

Add a helper for testing rebase -i todo lists.  This can be used to verify
the expected user experience, even for todo list changes that do not affect
the outcome of rebase.

Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 t/lib-rebase.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 4b74ae4..d118dd6 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -66,6 +66,19 @@ EOF
 	chmod a+x fake-editor.sh
 }
 
+# After set_cat_todo_editor, rebase -i will write the todo list (ignoring
+# blank lines and comments) to stdout, and exit failure.
+
+set_cat_todo_editor () {
+	echo "#!$SHELL_PATH" >fake-editor.sh
+	cat >> fake-editor.sh <<\EOF
+grep "^[^#]" "$1"
+exit 1
+EOF
+	chmod a+x fake-editor.sh
+	test_set_editor "$(pwd)/fake-editor.sh"
+}
+
 # checks that the revisions in "$2" represent a linear range with the
 # subjects in "$1"
 test_linear_range () {
-- 
1.7.10.4
