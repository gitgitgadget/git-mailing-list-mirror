From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sh-setup: work around "unset IFS" bug in some shells
Date: Fri, 07 Dec 2012 14:34:49 -0800
Message-ID: <7va9tpfq46.fsf_-_@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
 <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
 <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com>
 <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6Vi-0006Lv-1m
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab2LGWex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:34:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257Ab2LGWex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 17:34:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD51883B;
	Fri,  7 Dec 2012 17:34:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FIBFm1swSKRXvY7xVwfIaai20H4=; b=thjIlo
	rWlT9WZ0fXW4weq8CcK0S8oglMKKvF4evarGC0CzTFvUMg1NsrD2SEBU6NI7Jn+E
	N75/uqhHOn//fVDJWx2IrrNz/Bhq0x6x93ZZWXb8hX7MtZfkdaNNxOEz+rN6K0ho
	4Dxb2Skz+sLWMiCUjPOZim8ft0zdLMqowHCYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E7pS82wJ8y78ybE05MtFlmYUOzMo2rxU
	ZLyjHKv9ORw7fU1ORu8yMUI9pqhNP1j4wY2luPHXWXTe0BcW4Y7Vt4utLoPWSZRR
	zlfhr4O9Nk06pVA7tcIizwDLZPWoplwW8NVqiMLHay7ZJSxio/j1FGpWFWp1Zr7A
	Gwf4GSUhd5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 389A3883A;
	Fri,  7 Dec 2012 17:34:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92FD88839; Fri,  7 Dec 2012
 17:34:51 -0500 (EST)
In-Reply-To: <7vobi5fu3c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 07 Dec 2012 13:08:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50AE4C22-40BE-11E2-AAC4-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211199>

With an unset IFS, field splitting is supposed to act as if IFS is
set to the usual SP HT LF, but Marc Branchaud reports that the shell
on FreeBSD 7.2 gets this wrong.

It is easy to set it to the default value manually, so let's do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-setup.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ee0e0bc..107c144 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -12,8 +12,11 @@
 # But we protect ourselves from such a user mistake nevertheless.
 unset CDPATH
 
-# Similarly for IFS
-unset IFS
+# Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
+# do not equate an unset IFS with IFS with the default, so here is
+# an explicit SP HT LF.
+IFS=' 	
+'
 
 git_broken_path_fix () {
 	case ":$PATH:" in
-- 
1.8.1.rc0.125.g5274144
