From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 11:14:27 -0700
Message-ID: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:14:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4cvt-00044t-EW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 20:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1IPSOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 14:14:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab1IPSOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 14:14:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F03B555C6;
	Fri, 16 Sep 2011 14:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	J8OzF4O1bjmEgCEgrZChh62eHw=; b=X12vLslGcMavBNHwyWGg8tHeT8GhG3NyK
	nyNTMPe9QaueBkc+P+j7VLIHrBEAreyQUmMhwn9fyaS40k1C9Rd4TgL8aH2gF6RQ
	vquaAH7WfrEEgsFhD80oaF4UFciQ0N1tY/pEeGBqqIKGrm+e2k4V47JLxauLr6oU
	7St4xOvLCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Gig
	C5aZeKnSZOjA7UDY6H+3cu9DZIfncyy6n/bZdTDHUAVH1K0hFwe3khMUndVHkN7k
	4oCboOXbjE5PJrLeNzQXkdqwbJddzZodpANZ2s+o7dwAJzzD1VyHy/NfDN0MC0lG
	STIGZ2WfFcETERuBmOVMDrkDWYXtoUeLq6OO8yZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7FD655C4;
	Fri, 16 Sep 2011 14:14:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DAC455C3; Fri, 16 Sep 2011
 14:14:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8214692-E08F-11E0-8CFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181541>

What should happen if you run this command?

	$ git ls-remote -h

It does not give a short-help for the command. Instead because "-h" is a
synonym for "--heads", it runs "git ls-remote --heads", and because there
is no remote specified on the command line, we run it against the default
"origin" remote, hence end up doing the same as

	$ git ls-remote --heads origin

Fix this counter-intuitive behaviour by special casing a lone "-h" that
does not have anything else on the command line and calling usage().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-remote.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1022309..41c88a9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -43,6 +43,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 
+	if (argc == 2 && !strcmp("-h", argv[1]))
+		usage(ls_remote_usage);
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
