From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Wed, 24 Mar 2010 11:29:50 -0700
Message-ID: <7vvdclk1y9.fsf@alter.siamese.dyndns.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
 <20100322142204.GB8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 19:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVLG-0007EU-9D
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 19:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0CXSaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 14:30:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab0CXSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 14:30:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A83A5C51;
	Wed, 24 Mar 2010 14:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DrZidXCQhCNrgodX6PUzeUffuPk=; b=LoGe4l
	Ak9+ShoDbjMd6J9eIw9usCbNW6spLsZqWr/O3iOG0wW37O/eQS0B74i1S2wtuqzk
	WwznsoJVJNRCjRb9M+CJ8hy1GhB3jIiKSKyp3HHYCFK7GqZ8s6naY3xVC7JOpggM
	FI87Xv8xRrl4ehBw5nRmm+so741vwvXhjvVlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WpNu1G9GBmQFEoogBMedYvpa6r3ve+Dj
	CTOkwHI5uuzo9txCvYnDg2ewQuN9IaSRwvQ33Ia8Wa2MpaDX91csfQemf4RNvGOl
	y72N3IXy56TwSs4jK+aSBHPCCKRXTxfVUWivvsxr2TCw+KJU78pthjDTPYl1l96d
	se5eh1b7AAU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0223BA5C4F;
	Wed, 24 Mar 2010 14:29:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 378B2A5C4D; Wed, 24 Mar
 2010 14:29:52 -0400 (EDT)
In-Reply-To: <20100322142204.GB8916@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 22 Mar 2010 07\:22\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EDBA3D4-3773-11DF-9A6C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143100>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If stdout has already been closed by the CGI and die() gets called,
> the CGI will fail to write the "Status: 500 Internal Server Error" to
> the pipe, which results in die() being called again (via safe_write).
> This goes on in an infinite loop until the stack overflows and the
> process is killed by SIGSEGV.
>
> Instead set a flag on the first die() invocation and perform no
> action during recursive die() calls.  This way failures to write the
> error messages to the stdout pipe do not result in an infinite loop.

Hmm.  I would need something like this on top, but there must be a better
way.  Ideas?

-- >8 --
Subject: [PATCH] fixup! http-backend.c: Don't infinite loop

Now die_webcgi() actually can return during a recursive call into it,
causing

    http-backend.c:554: error: 'noreturn' function does return

Work it around with a somewhat ugly workaround.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-backend.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f4d49b6..d3ec6f0 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -536,7 +536,7 @@ static void service_rpc(char *service_name)
 	strbuf_release(&buf);
 }
 
-static NORETURN void die_webcgi(const char *err, va_list params)
+static void die_webcgi(const char *err, va_list params)
 {
 	static int dead;
 
@@ -606,7 +606,7 @@ int main(int argc, char **argv)
 	int i;
 
 	git_extract_argv0_path(argv[0]);
-	set_die_routine(die_webcgi);
+	set_die_routine((void *)die_webcgi);
 
 	if (!method)
 		die("No REQUEST_METHOD from server");
-- 
1.7.0.3.435.g097f4
