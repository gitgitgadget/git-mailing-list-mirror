From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] merge: reduce set of parents consistently
Date: Tue, 17 Apr 2012 13:34:42 -0700
Message-ID: <1334694886-27756-1-git-send-email-gitster@pobox.com>
References: <CA+55aFyZYnAxJc8YT=GEnq-fdXbHCXyx937KNBngn69Zuxmcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKF71-0006fv-Vl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab2DQUeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 16:34:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2DQUet convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 16:34:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84D7629D
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:in-reply-to:content-type
	:content-transfer-encoding; s=sasl; bh=Xy2k2Hd+0cY28pJkEJd0dt1EU
	8s=; b=k3jKBs6WxuwlK3zzgJe2+AIJ2MFA+LgjlkP/fMepgHgb/8NWzbHPN+p7C
	7bDr1N5YDi2OvqCZTt4a428ZoH2s8RDRvNKJqoEHbhDUvqVj659NO2TfrlRkiMtY
	kUPpa7P/1XCZBi8/v/uWSnQnE3kSykXBzX/VC2QkfdU55YQOiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:in-reply-to:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fqP7tEbvWNa5+XNyPfQ
	SKU5AUt18BgFIdtT3AxCG1W90eKsTM6SenpHFFWt7oDBOem5nUDDHh4vhu0Lcdol
	4iDMWo9oD5sWGUVGKhKre23sGmG29Q2EW5SyMBjCkKobBBVoG2ublRlCJ7RGEcB9
	//ycTLFflTlztWnvMQwOaZs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DAAF629C
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 318536297 for
 <git@vger.kernel.org>; Tue, 17 Apr 2012 16:34:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.332.g1863c
In-Reply-To: <CA+55aFyZYnAxJc8YT=GEnq-fdXbHCXyx937KNBngn69Zuxmcgg@mail.gmail.com>
X-Pobox-Relay-ID: C6756F8A-88CC-11E1-832C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195799>

So this is my attempt to address "Eek, why does your Octopus record man=
y
irrelevant parents?!?!?!" issue from Linus and Micha=C5=82 (but without=
 reusing
any code from them, except for the initial test).

In the original code, the variable remoteheads held the list of parents
read from the command line, and it was used throughout the code to see =
how
many parents the resulting merge will have (used to see if we use twohe=
ad
or octopus strategy), except that right before we come up with the set =
of
parents to record in the resulting merge commit, we discarded redundant
ones.

The updated code instead reduces the parents right after we read them.
This even detects the case where our HEAD is an ancestor of one of the
commits being merged, in which case HEAD will not be recorded unless we
are deliberately recording a fast-forward case as a real merge.

Junio C Hamano (3):
  builtin/merge.c: remove "remoteheads" global variable
  builtin/merge.c: collect other parents early
  builtin/merge.c: reduce parents early

Micha=C5=82 Kiedrowicz (1):
  git-merge: test octopus with redundant parents

 builtin/merge.c               |  142 +++++++++++++++++++++++++--------=
--------
 t/t6028-merge-up-to-date.sh   |   17 ++++-
 t/t7602-merge-octopus-many.sh |   10 ++-
 3 files changed, 108 insertions(+), 61 deletions(-)

--=20
1.7.10.332.g1863c
