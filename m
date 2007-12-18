From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 01:47:53 -0800
Message-ID: <7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org> <4767934F.7070706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Z3z-0005O5-84
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXLRJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbXLRJsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:48:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXLRJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:48:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E84453A5;
	Tue, 18 Dec 2007 04:48:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C8CD153A4;
	Tue, 18 Dec 2007 04:47:55 -0500 (EST)
In-Reply-To: <4767934F.7070706@op5.se> (Andreas Ericsson's message of "Tue, 18
	Dec 2007 10:30:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68721>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>>
>> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
>> are for the application to define, and for the implementation (iow, the
>> header files) to find out what set of names the application wants to
>> see.  You are making the application examine the symbol to see what
>> implementation it is on, which feels backwards to me.
>
>
>  #if defined(hpux) || defined(_hpux) || defined(__hpux)
>
> should work ok, although as you say, trying
>
>  #if _POSIX_VERSION < 200112
>  # include <non-POSIX.1-2001 headers>
>  #else
>  # include <sys/select.h>
>  #endif
>
> would probably be more suitable.

I cannot take credit for having said that (I didn't), but it sounds like
a sensible thing to compare _POSIX_VERSION with 200112L.  For previous
SUS, <sys/time.h> would have defined select(2), but that header file is
already included anyway.

Merijn, discarding the earlier patch I did to configure it out for
HP-UX, does the following patch based on Andreas's idea work for you?

---

 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..68a580f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#if _POSIX_VERSION >= 200112L
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
