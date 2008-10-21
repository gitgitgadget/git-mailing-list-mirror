From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] commit: Warn about encodings unsupported by iconv.
Date: Mon, 20 Oct 2008 17:39:36 -0700
Message-ID: <7vmygy233r.fsf@gitster.siamese.dyndns.org>
References: <1224537918-14024-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 02:41:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks5J0-0002WP-OA
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 02:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYJUAju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYJUAju
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 20:39:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYJUAjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 20:39:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D5CB72D7F;
	Mon, 20 Oct 2008 20:39:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 78C0672D7E; Mon, 20 Oct 2008 20:39:43 -0400 (EDT)
In-Reply-To: <1224537918-14024-1-git-send-email-angavrilov@gmail.com>
 (Alexander Gavrilov's message of "Tue, 21 Oct 2008 01:25:18 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3982732-9F08-11DD-B311-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98752>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
> index 0453425..7f325a3 100644
> --- a/builtin-commit-tree.c
> +++ b/builtin-commit-tree.c
> @@ -45,6 +45,28 @@ static const char commit_utf8_warn[] =
>  "You may want to amend it after fixing the message, or set the config\n"
>  "variable i18n.commitencoding to the encoding your project uses.\n";
>  
> +static const char commit_bad_encoding_warn[] =
> +"Warning: commit encoding '%s' is not supported.\n"
> +"You may want to change the value of the i18n.commitencoding config\n"
> +"variable, and redo the commit. Use 'iconv --list' to see the list of\n"
> +"available encoding names.\n";
> +
> +static void verify_commit_encoding(const char *text, const char *encoding)
> +{
> +	if (is_encoding_utf8(encoding)) {
> +		if (!is_utf8(text))
> +			fprintf(stderr, commit_utf8_warn);
> +	}
> +#ifndef NO_ICONV
> +	else {
> +		char *conv = reencode_string("", "utf-8", encoding);
> +		if (!conv)
> +			fprintf(stderr, commit_bad_encoding_warn, encoding);
> +		free(conv);
> +	}
> +#endif
> +}
> +

I think the issue you are attempting to tackle is worth addressing, but I
am not sure if this is the best approach.

Commit_tree() does not re-encode the payload.

It just marks it with the encoding header.  Wouldn't that mean that it
should be possible for you to create a commit with its message encoded in
KOI-8, and mark the resulting commit as encoded as such, on a host that is
incapable of actually transcoding from KOI-8 to utf-8?  IOW, your being
able to encode from i18n.commitencoding to utf-8 does not have much to do
with the validity of the configuration variable.

It would clarify the issues to think about what this new code would do on
a host without iconv, if you do not have the above #ifndef/#endif pair.
The replacement reencode_string() implementation always returns NULL, so
the code will always warn.

I am guessing that the reason you added #ifndef/#endif is because what the
warning message says is incorrect.

 * "is not supported" is not correct.  "is not supported HERE" may be.

 * "is not supported" (nor "is not supported HERE") does not matter.  It
   is log-reading side that does the re-encoding, not the commit
   generating side.

 * what you would really want to say is "might be incorrectly spelled",
   but your problem is that you do not have a direct way to check that.

Another reason of your "#ifndef/#endif" would be that there is no way to
squelch the warning message after seeing it on a NO_ICONV platform.

But that suggests that the "#ifndef/#endif" is not a good way to squelch
the message.  What would you do, after seeing the warning message and
examining the situation, you know KOI-8 is a valid encoding name, your
editor is recording what you type in the commit log message in KOI-8, you
know you set i18n.commitencoding to KOI-8, and you know somehow your
system is incapable of reencode_string("", "utf-8" "KOI-8")?  There is no
way to squelch the message.

So perhaps you would need some "state" variable that says "I know this
i18n.commitencoding configuration is valid" if you go this route?  But the
reason for "I know" would be either (1) because we earlier tried
reencode_string() and it resulted in an Ok return, or (2) because the user
verified that the configuration is valid, even though on this particular
system it cannot be encoded to utf-8.  IOW, the latter one would be
"because the user tells us so" --- which would be the same as trusting
i18n.commitencoding from the beginning.  I dunno.

I actually have an alternative approach to suggest.

How about adding a new i18n.commit-reencode-logmessage option (boolean),
and when it is set, we actually re-encode from i18n.commitencoding to
"utf-8" before creating the commit object (and obviously we do not store
"encoding" header in the resulting commit)?  When the conversion fails, we
know it failed, so the warning you added does make sense in that context.
