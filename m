From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph: avoid infinite loop in graph_show_commit()
Date: Tue, 25 Sep 2012 11:11:17 -0700
Message-ID: <7v6272vupm.fsf@alter.siamese.dyndns.org>
References: <1348323880-3751-1-git-send-email-pclouds@gmail.com>
 <loom.20120923T135253-178@post.gmane.org>
 <CACsJy8ApYKOU8v_-HkUC5uOb8gsheugKaXKMjbm0_-ygW_4jiQ@mail.gmail.com>
 <7vtxunvvr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org, adam@adamsimpkins.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 20:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGZbW-0004ML-JH
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 20:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2IYSLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 14:11:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab2IYSLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 14:11:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E640096CC;
	Tue, 25 Sep 2012 14:11:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5OBlE1gqcK9U6oh9BrPRzMV5e0I=; b=eBmqvk
	eWDMvTLHkn9bQQqgNBLg5rqP+cWiYxfZmwIbO37DnSWmnauuwKpB5XUbzP4xJmrI
	WwUMNEnMBADgbH9/Tcl41fFGgUhWUJE/h6dJSyWHUaCQ5Vlop2Md8oeOvecSZYEG
	NWwRUDDvd+TTOAz7phDcCU3HJqShR8P2LFGoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2YOrV/rxKNGd/WHztuAM9cymLW3Dvbt
	/rXQWNanYUlQ9zn4PUW3c4J13nSvrRaRlXvk/rac5JrzGrNgOlfgzkj69R2VCvY9
	Bkbcbi0GmaWg0BpwWHyGXOIXyAcXnigkax4sX/AaCQGcSKftctl7loQBCLnXd2+Z
	chJe4Ub7xUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3CAD96CB;
	Tue, 25 Sep 2012 14:11:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3198896C7; Tue, 25 Sep 2012
 14:11:19 -0400 (EDT)
In-Reply-To: <7vtxunvvr4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 24 Sep 2012 16:36:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 679A086A-073C-11E2-B55F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206369>

Junio C Hamano <gitster@pobox.com> writes:

> Has either of you tried the patch with the problematic case the
> other patch tries to solve?  Michal's old patch does smell like it
> is going in the better direction in that it stops looping when we
> know we would only be showing the padding, which is a sign that we
> are done with showing the commit.

I think this should suffice.  I do not know if Michal's patch is the
right fix, though.  It appears to me that "--graph" assumes one
commit is shown only once, but "diff-tree -m" and friends want to
show a merge commit twice and is fundamentally incompatible with the
assumption.  We might be off either fixing that in the "graph" code
(not with a band-aid like patches from you two to make it punt), or
forbidding the combination altogether.


 t/t4202-log.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be59d..14f73e3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -264,6 +264,16 @@ test_expect_success 'log --graph with merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --raw --graph -m with merge' '
+	git log --raw --graph --oneline -m master | head -n 500 >actual &&
+	grep "initial" actual
+'
+
+test_expect_success 'diff-tree --graph' '
+	git diff-tree --graph master^ | head -n 500 >actual &&
+	grep "one" actual
+'
+
 cat > expect <<\EOF
 *   commit master
 |\  Merge: A B
-- 
1.7.12.1.451.gb433296
