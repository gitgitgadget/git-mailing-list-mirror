From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9502: do not assume GNU tar
Date: Tue, 18 Dec 2012 21:03:13 -0800
Message-ID: <7vehimd46m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 06:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlBof-00060Q-JS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 06:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab2LSFDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 00:03:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2LSFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 00:03:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57D946067;
	Wed, 19 Dec 2012 00:03:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	M11mwgs00ZyHbksu0sBiMB5biA=; b=fUFlWd7azqdUY3CD28zJfWWdXZ426v9uI
	HLUCMn/yJsHkkJ3ABEUeiWeCK9Xx5pOX06RpQS05MEX4WAkcAmMwB+Pis226XxH7
	Z8HCwY+6EtCN6QOPxZmvdy5P7tjNnqmqbotnky7N+A7ElIsrZy65wuDNTeYybGRo
	3guEW3hZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ztq
	jMa1x8CfTqL9bvd2rhQNS0aMtVaXAKrMLuoWBQCQcmqdFkPallDXBJAJxTTKVAtP
	GJ1dbHx8glFZQM792SmpdTW1pEcREvUYEYtkECC8SlXdE3g6fUvpYBSRIBTqWnVe
	HAUuo8pAPY6eV8hoTQGBZNqil3Q0vsVtn9SJCvE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4588A6066;
	Wed, 19 Dec 2012 00:03:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99DEE6064; Wed, 19 Dec 2012
 00:03:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64E946B8-4999-11E2-AC2B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211803>

The check_snapshot function inspects and makes sure that not cruft
outside the repository hierarchy is added to the tar archive, by
insisting that the output from "tar tf" on the resulting archive
does not contain anything that does not begin with "$prefix/".
There are two issues with this implementation:

 - Traditional tar implemenations that do not understand
   pax_global_header will write it out as if it is a plain file at
   the top-level;

 - Some implementations of tar does not add trailing slash when
   showing a directory entry (i.e. the output line for the entire
   archive will show "$prefix", not "$prefix/").

Fix them so that what we want to validate can be tested with
traditional tar implementations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9502-gitweb-standalone-parse-output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 731e64c..c662298 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -40,7 +40,7 @@ check_snapshot () {
 	echo "basename=$basename"
 	grep "filename=.*$basename.tar" gitweb.headers >/dev/null 2>&1 &&
 	"$TAR" tf gitweb.body >file_list &&
-	! grep -v "^$prefix/" file_list
+	! grep -v -e "^$prefix$" -e "^$prefix/" -e "^pax_global_header$" file_list
 }
 
 test_expect_success setup '
-- 
1.8.1.rc2.196.g90926c8
