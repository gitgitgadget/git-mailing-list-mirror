From: Junio C Hamano <gitster@pobox.com>
Subject: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 01 Sep 2011 11:25:31 -0700
Message-ID: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 20:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzBxO-00072l-4f
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 20:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab1IASZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 14:25:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940Ab1IASZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 14:25:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 119E85A4B;
	Thu,  1 Sep 2011 14:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	FlVa3EZSDlV1zU7VGViie5UhCc=; b=NJYdNkCaeD8eI03muy5DsJQO+acH1EHIx
	qvStX2cC95Hj9JycbBwAdAC0LLEH01s8nifpwiXpzf8ST42nzWLM6KHhe+G7xzuv
	t/KwoOKtPG1cYQoYU+bNC6sFNme5f7+wiFvoiYsEIbStmhmKR0dLaYxseH6DCpjq
	/jeA6uTsXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=w4N
	6Cfn+MhD5E7McJepJF2fn45U4TP6DOHMfHPoTdPXxtSBgRVLt6UGo+us5bDxS/XB
	j3NVgIdV5XjBmExsKVd7pvYmzUp+urtwFQNU05pgtonC5M+AueEXbQC0QANmRcO/
	bB3viKsX9hRHr/rB3mzfZHa+3wlJaED3+SQ+LcMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 029A55A4A;
	Thu,  1 Sep 2011 14:25:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579BE5A49; Thu,  1 Sep 2011
 14:25:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C79DA7D8-D4C7-11E0-84E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180559>

Suggested reading:

  http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-commit-to-git.html

I am wondering if we are better off applying something along the lines of
this patch, so that with the default configuration, users can notice if
their upstream unexpectedly rewound their branches.

It would produce

	[remote]
        	url = git://.../git.git/
                fetch = refs/heads/*:refs/remotes/origin/*

upon cloning from my repository, and your "git fetch" will fail because
the pu (proposed updates) branch is constantly unwinding, but that can be
easily fixed with


	[remote]
        	url = git://.../git.git/
                fetch = refs/heads/*:refs/remotes/origin/*
                fetch = +refs/heads/pu:refs/remotes/origin/pu

as the explicit refspec trumps the wildcard one.

 builtin/remote.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..081fbbf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -116,11 +116,11 @@ static int add_branch(const char *key, const char *branchname,
 		const char *remotename, int mirror, struct strbuf *tmp)
 {
 	strbuf_reset(tmp);
-	strbuf_addch(tmp, '+');
-	if (mirror)
+	if (mirror) {
+		strbuf_addch(tmp, '+');
 		strbuf_addf(tmp, "refs/%s:refs/%s",
 				branchname, branchname);
-	else
+	} else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
 	return git_config_set_multivar(key, tmp->buf, "^$", 0);
