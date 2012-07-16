From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Mon, 16 Jul 2012 09:35:11 -0700
Message-ID: <7vipdn4qbk.fsf@alter.siamese.dyndns.org>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vtxxcc36v.fsf@alter.siamese.dyndns.org> <vpq1ukgai4e.fsf@bauges.imag.fr>
 <7vwr28agcq.fsf@alter.siamese.dyndns.org> <vpq1ukg82st.fsf@bauges.imag.fr>
 <20120713130021.GA2553@sigill.intra.peff.net>
 <vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
 <vpq1ukf68ow.fsf@bauges.imag.fr> <7vy5mn8v2k.fsf@alter.siamese.dyndns.org>
 <vpqmx3011la.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:35:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqoGY-0000FO-1T
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab2GPQfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:35:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2GPQfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 12:35:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61B7D8E61;
	Mon, 16 Jul 2012 12:35:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8uuvZMPGbz2/wGKaiqX1G5KuR4Q=; b=cseMfs
	tlEcNlrl621kcROV/S3USYkLaxUAGEnMl0bhDd6giRnpP6o6jfAfwnazwizDeTWW
	gZl7UpZXsVOmUI+uec9IiSnTBKzjgqABXep1RNdEP1S07muSct9RdLZl3eFEpCR3
	4AE7MqAL7wrpmShs4ZefcERt+zQATFx1pLK68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hIw9FEhYPGtz9vuHgE7WJloeKtCYP4IS
	SWSHHLO1nv9mHRe/bnqSD/vI2o1SqwbGdHEHd2JVYrvqRKk9xEkaFFjujcVVqNe9
	Ln1G/wRPnb6rcC0ZGU+++3NIuNwwveu296jJP7GN6MG/D+4Jtcc+LsYbTIFZ8QXD
	2/UA/1DVvUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDE08E60;
	Mon, 16 Jul 2012 12:35:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B93A08E5C; Mon, 16 Jul 2012
 12:35:12 -0400 (EDT)
In-Reply-To: <vpqmx3011la.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 16 Jul 2012 11:45:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37341E1E-CF64-11E1-A3D7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201527>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> 	if (use_global_config) {
>>                 if (is $HOME/.gitconfig usable?) {
>> 			use it;
>
> Yes, but when $HOME is unset, the question doesn't really make sense.
> Maybe the file exists, but we can't know since the user broke his
> configuration by unsetting $HOME. The intent was to avoid writing to the
> XDG file unless it was very clear that the user wanted it, so in doubt,
> dying seems the best option.

I would think that it is plausible that the user wanted to write
into XDG one and used "unset HOME" as a way to signal that wish. 

Are there ways to force writing into XDG ones without having to
remove the $HOME/ ones (perhaps the user wants to keep them for use
with older versions of Git on a different machine that shares the
same $HOME directory)?  Temporarily unsetting HOME may be how a user
might achieve it.

If you want to disallow such a use case, that is fine, but at least
the logic needs to be described in comment.  Perhaps based on one of
your rewrites earlier in the thread, like this?

 builtin/config.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 67945b2..a788409 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -387,13 +387,26 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		home_config_paths(&user_config, &xdg_config, "config");
 
-		if (user_config && access(user_config, R_OK) &&
+		if (!user_config)
+			/*
+			 * We do not know HOME/.gitconfig exists or
+			 * not, hence we do not know if we should
+			 * write to XDG location, so we error out even
+			 * if XDG_CONFIG_HOME is set and points at a
+			 * sane location.
+			 *
+			 * In other words, we forbid the user from
+			 * telling us to write to XDG location,
+			 * pretending that $HOME/.gitconfig does not
+			 * exist, by temporarily unsetting HOME.
+			 */
+			die("$HOME not set");
+
+		if (access(user_config, R_OK) &&
 		    xdg_config && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
-		else if (user_config)
-			given_config_file = user_config;
 		else
-			die("$HOME not set");
+			given_config_file = user_config;
 	}
 	else if (use_system_config)
 		given_config_file = git_etc_gitconfig();
