From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] allowing hooks to ignore input?
Date: Fri, 12 Sep 2014 15:48:07 -0700
Message-ID: <xmqqzje48nh4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 00:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSZdX-0007F8-N8
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 00:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbaILWsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 18:48:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60517 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbaILWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 18:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A027839021;
	Fri, 12 Sep 2014 18:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	yex5e9XRwkQT/UuxSFWfs/QotE=; b=q4kFtaFezPtL8xGunO5OOZdJbF8hVy9HS
	zgjz2OYx/JkAQjIUZ8mU38nIpo7DwZE06FihHG60BjSL21PLM8tfKaOuBm40jZqz
	iBtkSrXWqGcFXD9rZetuKT4W+8l66DvJ63Jh33W9QTGk+rneMbOs74Rq9W8PuQkN
	JlN5TgD5eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=TSj
	EttAUy8YwGhgTJ879qUN9AoQseheISPOWFKduXgzioMbJe2EIEHmV0EuxJM0MI7J
	AEtqJhoBRRL/R0oD1RKGRtK59lsKQ/CCRcgc8Cx8+evnFgZPJ/Yy5JPIQ4qFqPre
	smT96F9sbT03nLQh9Yf2IffHhJMTc5q9e9m9CD8E=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97AF039020;
	Fri, 12 Sep 2014 18:48:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E57E3901F;
	Fri, 12 Sep 2014 18:48:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE11644E-3ACE-11E4-9CD1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256951>

The pre-receive and post-receive hooks were designed to be an
improvement over old style update and post-update hooks that used to
take the update information on the command line and were limited by
the command line length limit.  They take the same information from
their standard input.  It has been mandatory for these new style
hooks to consume the update information fully from the standard
input stream.  Otherwise, they would risk killing the receive-pack
process via SIGPIPE.

This is easy, and it has already been done by existing hooks that
are written correctly, to work around, if a hook does not want to
look at all the information, by sending its standard input to
/dev/null (perhaps a niche use of hook might need to know only the
fact that a push was made, without having to know what objects have
been pushed to update which refs).

However, because there is no good way to consistently fail hooks
that do not consume the input fully, it can lead to a hard to
diagnose "once in a blue moon" phantom failure.

I wonder if this "you must consume the input fully", which is a
mandate that is not enforced strictly, is not helping us to catch
mistakes in hooks more than it is hurting us.  Perhaps we can do
something like the attached patch to make it optional for them to
read the input we feed?

I dunno.

 builtin/receive-pack.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 30560a7..9d9d16d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -17,6 +17,7 @@
 #include "version.h"
 #include "tag.h"
 #include "gpg-interface.h"
+#include "sigchain.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -500,6 +501,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 		return code;
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	while (1) {
 		const char *buf;
 		size_t n;
@@ -511,6 +514,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	close(proc.in);
 	if (use_sideband)
 		finish_async(&muxer);
+
+	sigchain_pop(SIGPIPE);
+
 	return finish_command(&proc);
 }
 
