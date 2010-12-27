From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Mon, 27 Dec 2010 09:18:17 -0800
Message-ID: <7vmxnrxhgm.fsf@alter.siamese.dyndns.org>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <201012252314.22541.jnareb@gmail.com> <20101226090731.GA21588@burratino>
 <201012270014.09962.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 18:18:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXGib-0004Um-18
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 18:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab0L0RSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 12:18:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab0L0RSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 12:18:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A82BB2B8B;
	Mon, 27 Dec 2010 12:19:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CmkFjIOEwDXlqnWo3VRg0BXsh5Q=; b=WtMJGT
	OuQMtYAXsR8Taz3u4XW9WrrgsjG78EmubnElPrftcua5haA5pxzWVA2njYbV81JN
	8JZKEgOGo+SYDtslmJuR7QS53McOrKPKEH0nMNjyRfOifjBmyHbMNb08X3nGIIYl
	Dnr7T7PB7Ar4E1RyWNsu19Rpvy4Gv01pUryzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUFpQSw6Hg8YpUHtF37TLJq5Z+0u9/rW
	ohENNuLF4hbPhk0ZkkbLIlDv62VwPXEgfGznfbFtSCXtho6mY1oulzBovEtVzq4w
	vsPsbTGm3ndjU3mSLonvTdrQEUUZXxZKFR6RlGoi1PfcQNkWFHxvo9EnWzotna9f
	9X/Pc4NXjIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37A7E2B88;
	Mon, 27 Dec 2010 12:19:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 198BA2B86; Mon, 27 Dec 2010
 12:18:51 -0500 (EST)
In-Reply-To: <201012270014.09962.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 27 Dec 2010 00\:14\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 65A56ED8-11DD-11E0-A768-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164221>

Jakub Narebski <jnareb@gmail.com> writes:

> 2. sub foo {
>     FOO: while (1) {
>    		...
>    	}
>    }
>
>    which should be marked with 'sub foo {', I think

I do not think Jonathan's patterns would be fooled by this; it wants to
catch only "package <anything>;" and "sub <anything> {".

Jonathan's pattern set allows them to be indented, and followed by some
garbage at the end., which we might want to tighten.  How many people
start 'package' and the outermost 'sub' indented?

 userdiff.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index fc2afe3..79569c4 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -62,8 +62,10 @@ PATTERNS("pascal",
 	 "|<>|<=|>=|:=|\\.\\."
 	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("perl",
-	 "^[ \t]*package .*;\n"
-	 "^[ \t]*sub .* \\{",
+	 "^package .*;\n"
+	 "^sub .* \\{\n"
+	 "^[A-Z]+ \\{\n"	/* BEGIN, END, ... */
+	 "^=head[0-9] ",	/* POD */
 	 /* -- */
 	 "[[:alpha:]_'][[:alnum:]_']*"
 	 "|0[xb]?[0-9a-fA-F_]*"
