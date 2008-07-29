From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Advertise the ability to abort a commit
Date: Tue, 29 Jul 2008 13:51:00 -0700
Message-ID: <7vfxpsct3f.fsf@gitster.siamese.dyndns.org>
References: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk>
 <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwB2-0004RV-Fc
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 22:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYG2UvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG2UvK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 16:51:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbYG2UvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 16:51:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B2243B279;
	Tue, 29 Jul 2008 16:51:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B65363B278; Tue, 29 Jul 2008 16:51:02 -0400 (EDT)
In-Reply-To: <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
 (Anders Melchiorsen's message of "Tue, 29 Jul 2008 22:12:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 105A96F8-5DB0-11DD-8C35-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90681>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 9a11ca0..75eeb4b 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -555,6 +555,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
>  		fprintf(fp,
>  			"\n"
>  			"# Please enter the commit message for your changes.\n"
> +			"# To abort the commit, use an empty commit message.\n"
>  			"# (Comment lines starting with '#' will ");
>  		if (cleanup_mode == CLEANUP_ALL)
>  			fprintf(fp, "not be included)\n");

Thanks.  This sounds like a helpful message.

> @@ -1003,7 +1004,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
>  	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
>  		rollback_index_files();
> -		die("no commit message?  aborting commit.");
> +		die("no commit message.  aborting commit.");
>  	}
>  	strbuf_addch(&sb, '\0');
>  	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))


Sorry but I do not see a point in this hunk.

I am somewhere between neutral to mildly negative about changing "Abort
with error and do not create a commit if there is no message" to "Do not
create a commit if there is no message, and this condition is not an
error".  I further think the new message at the top is very helpful to the
end users, with the understanding that users who changed their mind after
running "git commit" _can_ deliberately trigger this _error condition_ to
prevent commit from happening.  I also agree this ability to trigger an
error can be called a feature.

This still calls die(), which means this is still an error condition.  I
do not see a point in changing that question mark (which hints "perhaps
you made a mistake, and that is the reason we are aborting") to a full
stop.  I think the current question mark is more helpful to people who did
not pay close attention to the new message at the top.

If the change _were_ to reword the message to more neutral sounding
"aborting commit due to missing log message.", and change die() to a
normal exit, that would be making this not an error.  As I already said, I
am mildly negative, but at least such a change would be internally
consistent.

I sense that the change from question mark to full stop might be showing
the desire to go in that direction, but in that case your change from the
question mark to full stop does not go far enough.
