From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 10:59:36 -0700
Message-ID: <xmqqa98h8587.fsf@gitster.dls.corp.google.com>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
	<20140710040731.GD28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 19:59:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5IdN-0007ob-A1
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 19:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaGJR7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 13:59:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59599 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbaGJR7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 13:59:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3645F268A7;
	Thu, 10 Jul 2014 13:59:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bFTNDs4+pGnvajMiJp/WO9jjHu8=; b=UXPq9G
	1+KQCqkHOexwc0xC9fSS6zYjp+6WaZLOnY0ZqpW38Z/FQVrAwi9LPr3J1L549btv
	8vV9YWb9lacWe+65C6STGqn8oihK2Ecby6q0F81pEVjU14wLGyke0jzZVFrxh615
	usK7QzjVHOqFf29dosKDOhFMe2l4uTgZulFaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GhX8nBctoKZMcR/OjxmnUYdG1AdPwuy5
	RsqDkwdYhS4hkyW5ChvEzieAOwz2rkNg1KENCTe0hPIuora/AePqAt2y6WiOL1Xk
	lTuEi/DNWKc1yho/gKkdn5weoB51DtIA3AVbKLvl8szO11yHdKerYHvM3ZlrXx3Y
	fdzWbsZGDBU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C395268A6;
	Thu, 10 Jul 2014 13:59:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC98A268A1;
	Thu, 10 Jul 2014 13:59:22 -0400 (EDT)
In-Reply-To: <20140710040731.GD28401@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Jul 2014 00:07:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC669D7A-085B-11E4-8518-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253196>

Jeff King <peff@peff.net> writes:

> I know this is existing code you are moving, but I noticed it looks ripe
> for using skip_prefix. Perhaps while we are in the area we should do the
> following on top of your patch (I'd also be happy for it be squashed
> in, but that may be too much in one patch).

I am tempted to suggest going the other way around, i.e. queue (an
equivalent of) this on jk/skip-prefix and merge it to 'next' and
then 'master' quickly.

I can go either way, but I tend to prefer building new things on top
of obviously correct clean-up, not the other way around.

> -- >8 --
> Subject: [PATCH] tag: use skip_prefix instead of magic numbers
>
> We can make the parsing of the --sort parameter a bit more
> readable by having skip_prefix keep our pointer up to date.
>
> Signed-off-by: Jeff King <peff@peff.net>


 builtin/tag.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..1101c19 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -524,18 +524,14 @@ static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 	int *sort = opt->value;
 	int flags = 0;
 
-	if (*arg == '-') {
+	if (skip_prefix(arg, "-", &arg))
 		flags |= REVERSE_SORT;
-		arg++;
-	}
-	if (starts_with(arg, "version:")) {
-		*sort = VERCMP_SORT;
-		arg += 8;
-	} else if (starts_with(arg, "v:")) {
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
 		*sort = VERCMP_SORT;
-		arg += 2;
-	} else
+	else
 		*sort = STRCMP_SORT;
+
 	if (strcmp(arg, "refname"))
 		die(_("unsupported sort specification %s"), arg);
 	*sort |= flags;
