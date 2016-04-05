From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Timestamp of zero in reflog considered invalid
Date: Tue, 05 Apr 2016 08:52:02 -0700
Message-ID: <xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
References: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Erik Bray <erik.m.bray@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 17:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTH3-0003uG-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 17:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306AbcDEPwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 11:52:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753585AbcDEPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 11:52:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F6E151B69;
	Tue,  5 Apr 2016 11:52:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YuGgXcFq7DGkbAJZjW7mWM7eSDM=; b=gyxbGa
	LXbv1V0z4wmaUiFh/U0VcuVcywUh3b8xzj0V4z2Z3vfOZOqLmrrYBaA39Or6Hji2
	Jki4Pwh+yV7l7WNmq5+yDR0FsAYe4Xzjpnb0Rnxnj/X2K9OKw6jVgU1PfanZHm9Q
	zpRBXLi0NSrEVcBduLebcnjCS1xmTNiWd8tOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4srp+8NwClYPd+U1KPbrVAP9therUGO
	2Dgt71c5jDcAvFuE9CEP9alr8IB18S/t5rPNuAFpseH4wzhoh2N7Wr3X77+E0Q1e
	SbK0TIq2K4fMMXSa7XIvJcG9lockZaRuQl/mrF3VcsH0llPpUSpHbY+1z3vAmL3m
	UPvrn5yKoTc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4721B51B66;
	Tue,  5 Apr 2016 11:52:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B40BB51B65;
	Tue,  5 Apr 2016 11:52:03 -0400 (EDT)
In-Reply-To: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com>
	(Erik Bray's message of "Tue, 5 Apr 2016 13:28:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5769C8D4-FB46-11E5-BBAC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290786>

Erik Bray <erik.m.bray@gmail.com> writes:

> I tracked the issue to refs/files-backend.c in show_one_reflog_ent :
>
> https://github.com/git/git/blob/11529ecec914d2f0d7575e6d443c2d5a6ff75424/refs/files-backend.c#L2923
>
> in which
>
> !(timestamp = strtoul(email_end + 2, &message, 10)) ||
>
> implies an invalid reflog entry.  Why should 0 be treated as an
> invalid timestamp (even if it's unlikely outside of corner cases)?

Thanks for a report.

I think this dates back to 883d60fa (Sanitize for_each_reflog_ent(),
2007-01-08):

commit 883d60fa97c6397450fb129634054e0a6101baac
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Mon Jan 8 01:59:54 2007 +0100

    Sanitize for_each_reflog_ent()
    
    It used to ignore the return value of the helper function; now, it
    expects it to return 0, and stops iteration upon non-zero return
    values; this value is then passed on as the return value of
    for_each_reflog_ent().
    
    Further, it makes no sense to force the parsing upon the helper
    functions; for_each_reflog_ent() now calls the helper function with
    old and new sha1, the email, the timestamp & timezone, and the message.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

I do not see a corresponding "timestamp must be non-zero" check in
the lines removed by that commit.  I suspect that there was some
confusion as to how strtoul() signals an error condition when the
commit was written, or something.  I do not think existing
implementations of Git supports timestamps before the epoch (the
timestamp on the common object headers are read into unsigned long
variables and the code is not prepared to see anything negative
there), but if anything the code should be detecting errors from
strtoul() properly, i.e. if a timestamp is way long into the future
and does not fit in "unsigned long", we should detect it.

Checking the value against ULONG_MAX and errno==ERANGE would be an
improvement.  It may be debatable if we should silently ignore an
entry with an invalid timestamp, but that is a separate issue.

 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 4e15f60..ff24184 100644
--- a/refs.c
+++ b/refs.c
@@ -3701,7 +3701,8 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
 	    !(email_end = strchr(sb->buf + 82, '>')) ||
 	    email_end[1] != ' ' ||
-	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
+	    ((timestamp = strtoul(email_end + 2, &message, 10)) == ULONG_MAX &&
+	     errno == ERANGE) ||
 	    !message || message[0] != ' ' ||
 	    (message[1] != '+' && message[1] != '-') ||
 	    !isdigit(message[2]) || !isdigit(message[3]) ||
