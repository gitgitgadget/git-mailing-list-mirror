From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git mailinfo' whitespace bug
Date: Fri, 19 Feb 2010 21:51:19 -0800
Message-ID: <7vzl343160.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>,
	Don Zickus <dzickus@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 06:51:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiiFm-0001xn-UX
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 06:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab0BTFvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 00:51:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0BTFvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 00:51:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D36089BEB1;
	Sat, 20 Feb 2010 00:51:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dGsjVODdlU8nbqphxwCsFOJ4ch0=; b=I5WLM0
	zKYb3t96ruyVAoLA06fsPytB1R63yDn3iTg3xItvpiuJuMgITdPaLwma/YhDnIZH
	NfdHF5ybxtXbb9Brotvs7MG/hHV6/sNwZxpW87bCit5RMJTXS3TEFpoWhCnGIrew
	jM0pNHDRY+QBZRSXM7ccm+uTwGk2bIB27D9vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VuArxL5+JP2XVNhxIECDOVQPIBcA87yd
	LdweCe6IkiqUva0I0m2wAAnRZEhuIpItbNv9BZRt0e+Nflcb/zuoBN+pfBwELKfO
	d6WMd6PHkjoq4Yl0ZRtGebvL3sNRdup2/9InmbHCspOPfgrMFieAzlh7AByTPOdr
	qrW+nlYhUwo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0D99BEAF;
	Sat, 20 Feb 2010 00:51:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE239BEAE; Sat, 20 Feb
 2010 00:51:21 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 18 Feb 2010 10\:05\:27 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC761D42-1DE3-11DF-B1C4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140516>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I bisected it, and this bug was introduced almost two years ago. In commit 
> 3b6121f69b2 ("git-mailinfo: use strbuf's instead of fixed buffers"), to be 
> exact. I'm pretty sure the bug is that handle_commit_msg() was changed to 
> use 'strbuf_ltrim()' for the 'still_looking' case.
>
> Before commit 3b6121f69b2, it would create a new variable that had the 
> trimmed results ("char *cp = line;"), after that commit it would just trim 
> the line itself. Which is correct for the case of it being a header, but 
> if it's the first non-header line, it's wrong.

True; trimming the body is obviously wrong.

But when is it correct to ltrim a header line?  It means we are going to
accept a header (or header-looking line in body) that is indented.  I
don't know why 87ab799 (builtin-mailinfo.c 2007-03-12) was coded that way.


 builtin-mailinfo.c |    3 +--
 t/t5100/msg0015    |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a50ac22..ce2ef6b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -779,8 +779,7 @@ static int handle_commit_msg(struct strbuf *line)
 		return 0;
 
 	if (still_looking) {
-		strbuf_ltrim(line);
-		if (!line->len)
+		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
 			return 0;
 	}
 
diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
index 9577238..4abb3d5 100644
--- a/t/t5100/msg0015
+++ b/t/t5100/msg0015
@@ -1,2 +1,2 @@
-- a list
+  - a list
   - of stuff
