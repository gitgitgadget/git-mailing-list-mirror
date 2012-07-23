From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 13:49:55 -0700
Message-ID: <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:50:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPZs-00034s-Az
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab2GWUt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:49:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab2GWUt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:49:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 794E07945;
	Mon, 23 Jul 2012 16:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+mNfIlJeMyrmYtE10sPQo2agyPc=; b=dFDLrN
	kZCnchYpxEgzE90tuST7flkjQKF5qBVzK1tZd0cgs99z2Bk5xX8shkbRFRYCzmQe
	HMoHdbaDdjoOoEkCbFYNiTI71E1RMHCzsymeEAyakloD5vhyymb0t1YnhxLA4Y+/
	sr03hUNFPlV9tumoSJ6uG53anrmC27vL4/Szc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NFSBoxNz/EMn7uHl2TaQVQxTjfwiNxLI
	coiep792lHsclFJ+Phld4FJO8l2+RNb7N2KDLRGrge6KSxb4qV3R+5twIPQ784Ev
	UEaPrO0SA+Akh8C96T2g6LX86sLJcIrZ0t+DYM+GJFzuh7SwP3aZ1LnIlne9l3ZA
	N7OrPj93k0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66D817940;
	Mon, 23 Jul 2012 16:49:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB18A793F; Mon, 23 Jul 2012
 16:49:56 -0400 (EDT)
In-Reply-To: <20120723185218.GC27588@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jul 2012 14:52:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F608DA16-D507-11E1-8E36-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201978>

Jeff King <peff@peff.net> writes:

> If we launch an editor for the user to create a commit
> message, they may put significant work into doing so.
> Typically we try to check common mistakes that could cause
> the commit to fail early, so that we die before the user
> goes to the trouble.
>
> We may still experience some errors afterwards, though; in
> this case, the user is given no hint that their commit
> message has been saved. Let's tell them where it is.

Liberal use of atexit() for something like this makes me cringe
somewhat.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I did not bother protecting this with advice.* config, as it is unlikely
> to come up regularly. If somebody cares, they are welcome to add it on
> top.
>
>  builtin/commit.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 20cef95..149e07d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -116,6 +116,16 @@ static enum {
>  	STATUS_FORMAT_PORCELAIN
>  } status_format = STATUS_FORMAT_LONG;
>  
> +static int mention_abandoned_message;
> +static void maybe_mention_abandoned_message(void)
> +{
> +	if (!mention_abandoned_message)
> +		return;
> +	advise(_("Your commit message has been saved in '%s' and will be\n"
> +		 "overwritten by the next invocation of \"git commit\"."),
> +	       git_path(commit_editmsg));
> +}
> +
>  static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  {
>  	struct strbuf *buf = opt->value;
> @@ -848,6 +858,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			_("Please supply the message using either -m or -F option.\n"));
>  			exit(1);
>  		}
> +		atexit(maybe_mention_abandoned_message);
> +		mention_abandoned_message = 1;
>  	}
>  
>  	if (!no_verify &&
> @@ -1532,11 +1544,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (template_untouched(&sb) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
> +		mention_abandoned_message = 0;
>  		exit(1);
>  	}
>  	if (message_is_empty(&sb) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
> +		mention_abandoned_message = 0;
>  		exit(1);
>  	}
>  
> @@ -1579,6 +1593,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		die(_("cannot update HEAD ref"));
>  	}
>  
> +	mention_abandoned_message = 0;
>  	unlink(git_path("CHERRY_PICK_HEAD"));
>  	unlink(git_path("REVERT_HEAD"));
>  	unlink(git_path("MERGE_HEAD"));
