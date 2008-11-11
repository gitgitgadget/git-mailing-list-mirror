From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Install issues
Date: Tue, 11 Nov 2008 13:11:45 -0800
Message-ID: <7vskpyynla.fsf@gitster.siamese.dyndns.org>
References: <20081110121739.15f77a01@pc09.procura.nl>
 <20081110113924.GR24201@genesis.frugalware.org>
 <20081110173101.3d76613b@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Nov 11 22:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00YV-0003qJ-DM
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbYKKVMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbYKKVMc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:12:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYKKVMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:12:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6360F7CDFF;
	Tue, 11 Nov 2008 16:12:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33FC37CDE1; Tue,
 11 Nov 2008 16:11:52 -0500 (EST)
In-Reply-To: <20081110173101.3d76613b@pc09.procura.nl> (H. Merijn Brand's
 message of "Mon, 10 Nov 2008 17:31:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 733A7626-B035-11DD-984C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100679>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>  	./test-sha1.sh
>  
>  check: common-cmds.h
> +	@`sparse </dev/null 2>/dev/null` || (\
> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
> +	    echo "Did you mean 'make test' instead?" ;\
> +	    exit 1 )

When you mean "grouping", using {} is much clearer to convey your
intention.  Use of needless (subshell) forces the reader to wonder if you
wanted to do something that affects the environment for later commands
inside, and in this case you didn't.

Why do you have sparse check inside a backtick to produce a string to be
interpreted as a command to be executed?

How about doing this instead?  'sparse' without any parameter exits with
success status silently; when you do not have the command, the shell will
complain with "sparse: command not found" anyway, so you only need to
suggest "make 'test'" and nothing else.

-- >8 --
Subject: Makefile: help people who run 'make check' by mistake

The target to run self test is 'make test', but there are people who try
'make check' and worse yet do not have sparse installed.

Suggest 'make test' target when they do not have 'sparse'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git c/Makefile w/Makefile
index 40309e1..d3137ca 100644
--- c/Makefile
+++ w/Makefile
@@ -1355,7 +1355,16 @@ check-sha1:: test-sha1$X
 	./test-sha1.sh
 
 check: common-cmds.h
-	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
+	if sparse; \
+	then \
+		for i in *.c; \
+		do \
+			sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; \
+		done; \
+	else \
+		echo 2>&1 "Did you mean 'make test'?"; \
+		exit 1; \
+	fi
 
 remove-dashes:
 	./fixup-builtins $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
