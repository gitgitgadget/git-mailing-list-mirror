From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] sane_execvp(): ignore non-directory on PATH
Date: Tue, 31 Jul 2012 12:46:13 -0700
Message-ID: <7vobmviuii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 21:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIOe-0001yZ-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab2GaTqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:46:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023Ab2GaTqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:46:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 349A290E6;
	Tue, 31 Jul 2012 15:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	tN9ZXE7W3KptAML81nq2zXWSc4=; b=BJ4jA5/rHXc0Y573wCuG9fYxyu22C1RJ7
	JTaykckocoRMNpl7bE6DAbiFZqNjen5MqBmeNZGd7b2JKoS+KXCWmj57y2NU3AWa
	h4qYu/R/mpJBHe3GEPl6Hns4DuKzQFnyAz/OnMus4RP7cGWrXvjV1PWbG+X+2q/o
	xUNmrxGkA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=tqqxbf3pxeSVvwESGLtZ9LolxQZLqGafUPiRQntjAaj1hcxxMkDUUiks
	9lbr0NAHnIaCj8ZY++Rb0w6ja2RxkTUhZtthye8cIGRdevS4cl0Bgre4QAIFSnya
	wDOa1PkwpSAxoAcPFKqlT4pVtPnyllpI6+cYdeD4eAPOB+BJ5yE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0F290E5;
	Tue, 31 Jul 2012 15:46:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71CD390E4; Tue, 31 Jul 2012
 15:46:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63B4B774-DB48-11E1-915B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202676>

When you have a non-directory on your PATH, a funny thing happens:

	$ PATH=$PATH:/bin/sh git foo
	fatal: cannot exec 'git-foo': Not a directory?

Worse yet, as real commands always take precedence over aliases,
this behaviour interacts rather badly with them:

	$ PATH=$PATH:/bin/sh git -c alias.foo=show git foo -s
	fatal: cannot exec 'git-foo': Not a directory?

This is because an ENOTDIR error from the underlying execvp(2) is
reported back to the caller of our sane_execvp() wrapper as-is.  By
translating it to ENOENT, just like the case where we _might_ have
the command in an unreadable directory, fixes it.  Without an alias,
we would get

	git: 'foo' is not a git command. See 'git --help'.

and we use the 'foo' alias when it is available.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We can view this as a follow-up to 38f865c (run-command: treat
   inaccessible directories as ENOENT, 2012-03-30).

 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 805d41f..f9b7db2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -77,6 +77,8 @@ int sane_execvp(const char *file, char * const argv[])
 	 */
 	if (errno == EACCES && !strchr(file, '/'))
 		errno = exists_in_PATH(file) ? EACCES : ENOENT;
+	else if (errno == ENOTDIR && !strchr(file, '/'))
+		errno = ENOENT;
 	return -1;
 }
 
