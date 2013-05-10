From: Junio C Hamano <gitster@pobox.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Fri, 10 May 2013 16:10:49 -0700
Message-ID: <7v38tuzb0m.fsf@alter.siamese.dyndns.org>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	<7vbo8j600q.fsf@alter.siamese.dyndns.org>
	<CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
	<7va9o2zba9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 01:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UawSm-00028u-2m
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 01:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab3EJXKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 19:10:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209Ab3EJXKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 19:10:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E691E323;
	Fri, 10 May 2013 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ol6eMyg5oFBac1TEQgR4YAMw0AE=; b=OA1UZZ
	xtXKwr0L8EzZduXZpWBNr8iiJ1+a5xckXeVJBw1a5scjOxWcjOOD3u57yXBdwmHy
	OFvymAVjH2W0hllhxWhR2xFRvjia/XQ+bp6zKaOBe5KdGes22PkWP3/OBH0qShId
	I/IHmxNwafOz7I5fLJ1mPzeJ5qkddomCsrUlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nnuOblXw4fFFG/oOaCttVbTleb72hczd
	FG/LxPN+3i9H8/0KC12oTNTZ7w4eYF1LSYmuvhDobowAoBY7NCIKmOYjGjeN0hvc
	h4qlMyuYG9kOXc2/TN88qmgNJeBPeOB3HwumTrB1AJmqB4+0ewNzZzhU77uBbh7J
	EQeyRVyCpt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17BC81E322;
	Fri, 10 May 2013 23:10:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E87F1E321;
	Fri, 10 May 2013 23:10:50 +0000 (UTC)
In-Reply-To: <7va9o2zba9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 10 May 2013 16:05:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB26495A-B9C6-11E2-A531-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223919>

Junio C Hamano <gitster@pobox.com> writes:

> Also I have a small suggestion I'd like you to try on top of it,
> which I'll be sending in a separate message.

The first hunk is to match other Makefile knobs the builders can
tweak with minimum documentation.

As you hinted that there may be other platforms that may want to use
the clipped-write, I would prefer to see this file _not_ directly
include any system headers, but let git-compat-util.h to absorb
platform differences instead.

Of course, inside this file, we do need to use the underlying
write(2), so immediately after including the header, we #undef write
so that this compilation unit will make a call to the platform
implementation of the function.

I do not expect the follow-up patch to Makefile to cause any
problem, but I'd like to see the change to compat/clipped-write.c
double checked on a real Mac OS X system, so that we can squash this
patch into your original.

Thanks.

 Makefile               | 3 +++
 compat/clipped-write.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7076b15..0434715 100644
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,9 @@ all::
 # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
 # doesn't support GNU extensions like --check and --statistics
 #
+# Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
+# INT_MAX bytes at once (e.g. MacOS X).
+#
 # Define HAVE_PATHS_H if you have paths.h and want to use the default PATH
 # it specifies.
 #
diff --git a/compat/clipped-write.c b/compat/clipped-write.c
index 9183698..b8f98ff 100644
--- a/compat/clipped-write.c
+++ b/compat/clipped-write.c
@@ -1,5 +1,5 @@
-#include <limits.h>
-#include <unistd.h>
+#include "../git-compat-util.h"
+#undef write
 
 /*
  * Version of write that will write at most INT_MAX bytes.
