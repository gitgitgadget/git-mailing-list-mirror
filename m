From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across
 --continue
Date: Mon, 26 Jan 2009 13:49:24 -0800
Message-ID: <7vzlhd3fh7.fsf@gitster.siamese.dyndns.org>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
 <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
 <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRZM8-0002Zt-KA
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbZAZVtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZAZVtb
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:49:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbZAZVtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:49:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 225CF1D5B1;
	Mon, 26 Jan 2009 16:49:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 185EE1D5B6; Mon,
 26 Jan 2009 16:49:25 -0500 (EST)
In-Reply-To: <7veiyp4w2m.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 26 Jan 2009 13:05:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35AFD2A2-EBF3-11DD-9EC7-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107290>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
> ...
>> +sed 's/#/ /g' > expect-conflict-p <<'EOF'
>> +*   Merge branch 'third' into other
>> +|\##
>> +| * 6
>> +* |   Merge branch 'side' into other
>> +|\ \##
>> +| * | 5
>> +* | | 4
>> +|/ /##
>> +* | 3
>> +|/##
>> +* conflict
>> +* 2
>> +* 1
>> +EOF
>
> I do not like this very much.  Future improvements of the graph drawing
> algorithm (one obvious "flaw" you are exposing by the above is that it has
> trailing whitespaces that can be trimmed, and somebody else may be
> inclined to fix) would break the expectation this test vector has.
>
> Do you have to compare the topology this way, or are there other more
> reliable ways?

Perhaps something like this.

 t/t3412-rebase-root.sh |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git i/t/t3412-rebase-root.sh w/t/t3412-rebase-root.sh
index 29bb6d0..2408cf8 100755
--- i/t/t3412-rebase-root.sh
+++ w/t/t3412-rebase-root.sh
@@ -240,19 +240,24 @@ test_expect_success 'rebase -i --root with conflict (second part)' '
 '
 
 sed 's/#/ /g' > expect-conflict-p <<'EOF'
-*   Merge branch 'third' into other
-|\##
-| * 6
-* |   Merge branch 'side' into other
-|\ \##
-| * | 5
-* | | 4
-|/ /##
-* | 3
-|/##
-* conflict
-* 2
-* 1
+commit conflict3 conflict3~1 conflict3^2
+Merge branch 'third' into other
+commit conflict3^2 conflict3~4
+6
+commit conflict3~1 conflict3~2 conflict3~1^2
+Merge branch 'side' into other
+commit conflict3~1^2 conflict3~3
+5
+commit conflict3~2 conflict3~3
+4
+commit conflict3~3 conflict3~4
+3
+commit conflict3~4 conflict3~5
+conflict
+commit conflict3~5 conflict3~6
+2
+commit conflict3~6
+1
 EOF
 
 test_expect_success 'rebase -i -p --root with conflict (first part)' '
@@ -268,8 +273,9 @@ test_expect_success 'fix the conflict' '
 
 test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	git rebase --continue &&
-	git log --graph --topo-order --pretty=tformat:"%s" > conflict3 &&
-	test_cmp expect-conflict-p conflict3
+	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
+	git name-rev --stdin --name-only --refs=refs/heads/conflict3 >out &&
+	test_cmp expect-conflict-p out
 '
 
 test_done
