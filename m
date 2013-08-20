From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all requested bytes
Date: Tue, 20 Aug 2013 11:52:28 -0700
Message-ID: <xmqq4nak6vpv.fsf@gitster.dls.corp.google.com>
References: <521333AE.1090506@kdbg.org>
	<xmqqsiy476h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBr2h-0007GZ-CK
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3HTSwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:52:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3HTSwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1363A0B9;
	Tue, 20 Aug 2013 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eD5Z0Gl5PWFV+z3wvNVQ0WTbLXw=; b=PAiYkF
	DBa7ZBYLVOm2JUzgulz+qv/+X+xclK+ufwpYa29Cvs8VChZjkE8Jqlhuge8RJIsx
	H3Npe8oG0IFNIzRTtyi9QyyMQtuhyud9QL2Lc20uSrXA6swWhDg2YcIc8NymKryj
	YIM7Hozk68ZVsXvqkd6W31ewQ2fvv1I88rxbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nruyzC/bDLbz2+ZySXrX4BAA+7E89JDd
	wcggbnjsnnQoEjvcdNzhpTZ6Rs5E6h9VtX4uMVW2jQPYOyPz0qs0eE1rH62vwGns
	Wps4X5b9HGNUApLasCpHyDWp1RDdDmaGFBNhAhgE2+1qQrvk4IK4LeRC36v+xa+M
	+UfhYRr4koY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FB103A0B8;
	Tue, 20 Aug 2013 18:52:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC9043A0B6;
	Tue, 20 Aug 2013 18:52:29 +0000 (UTC)
In-Reply-To: <xmqqsiy476h4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 Aug 2013 08:00:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA296898-09C9-11E3-8703-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232630>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if there are more like this broken caller or xread and/or
> xwrite.

Here is a result of a quick audit (of 1.8.0.x codebase).

As xwrite() will not be splitting a single-byte request, the patch
to cat-file is more or less a theoretical fix, but if writing the
date string can fail in I/O error, writing a terminating LF after it
can fail the same way, so we should be consistent.

Everybody supports the side-band tranfer these days, so the patches
to receive-pack and upload-pack are also theoretical fixes, I
think.  Note that in the more recent codebase, safe_write() is gone
and we use write_or_die() instead in upload-pack.

 builtin/cat-file.c     | 2 +-
 builtin/receive-pack.c | 2 +-
 upload-pack.c          | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 00528dd..4beb4d8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -63,7 +63,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 					tz = strtol(ep, NULL, 10);
 					sp = show_date(date, tz, 0);
 					write_or_die(1, sp, strlen(sp));
-					xwrite(1, "\n", 1);
+					write_or_die(1, "\n", 1);
 					break;
 				}
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ff781fe..a41740d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -202,7 +202,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
 	if (use_sideband)
 		send_sideband(1, 2, msg, sz, use_sideband);
 	else
-		xwrite(2, msg, sz);
+		write_in_full(2, msg, sz);
 }
 
 static void rp_warning(const char *err, ...)
diff --git a/upload-pack.c b/upload-pack.c
index 2e90ccb..7a3e4fd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -64,11 +64,6 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 	if (fd == 3)
 		/* emergency quit */
 		fd = 2;
-	if (fd == 2) {
-		/* XXX: are we happy to lose stuff here? */
-		xwrite(fd, data, sz);
-		return sz;
-	}
 	return safe_write(fd, data, sz);
 }
 
