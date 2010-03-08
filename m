From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #02; Sun, 07)
Date: Mon, 08 Mar 2010 01:20:32 -0800
Message-ID: <7vk4tnw4nz.fsf@alter.siamese.dyndns.org>
References: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 10:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoZ8p-0002Fw-R1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 10:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab0CHJUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 04:20:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0CHJUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 04:20:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C7326A09BF;
	Mon,  8 Mar 2010 04:20:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yi5yx9yFK1lbC3B2JQuGpHA+AJo=; b=FBgZup
	CuTKgynOw8DSJKZme/G1aQ7yM8uwDK46uH6sybmtNuRyRSFpUXpUYIidJEB+t13o
	Gzl7BBqeQF1lSFdFKBn5M5d+8qoNlHS/KHO7sh2XHlkyvEiWpOS5lhlaCZ8DAqRm
	ZPexGnZzfPAtMfvU+SZSHYJmdoLL42qrFpDq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSfKxDulipg85G8CFFWaOA0UDYcPLoP/
	6TFf5M6H8Reh/grk0EXBmOBZifKfichIQwuP7StZfwvp+YWhtRjR7r/SoLjqaKJ0
	irVFln5zy+eT4gL2zqNqitIHKK+hfDFNhEaFemAvLjE24kURgOET7UMVFpsMZxF6
	wMjvN2qYcuM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CE1A09BD;
	Mon,  8 Mar 2010 04:20:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08773A09BA; Mon,  8 Mar
 2010 04:20:33 -0500 (EST)
In-Reply-To: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 07 Mar 2010 14\:49\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAFD51A0-2A93-11DF-940D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141756>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * sd/log-decorate (2010-02-17) 3 commits
>  - log.decorate: usability fixes
>  - Add `log.decorate' configuration variable.
>  - git_config_maybe_bool()
>
> Probably ready for 'next', except that people need to be warned about
> having to update their scripts to explicitly pass --no-decorate to keep
> them working.  A good idea to disable this when --pretty was given, just
> like notes are disabled by default, was floated.

After thinking about this a bit more, I do not think it is a good idea to
disable configured decoration when an explicit --pretty is given.  A patch
to do so would be a trivial two-liner:

diff --git a/builtin-log.c b/builtin-log.c
index 0afba31..d4090f1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -85,6 +85,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		if (rev->diffopt.nr_paths != 1)
 			usage("git logs can only follow renames on one pathname at a time");
 	}
+
+	if (rev->pretty_given)
+		decoration_style = 0;
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {

but there is one big difference between notes and decoration.  Decorations
are designed to be a small, one-per-ref tokens that would sit well on a
line that already has other essential informations, while notes are a lot
louder "in your face" annotations that occupy line(s) on their own.

So I think we are better off without the above patch.  Unless somebody
points out flaws in my thinking, I am planning to merge this to 'next'
shortly.
