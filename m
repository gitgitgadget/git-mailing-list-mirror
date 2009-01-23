From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Make has_commit non-static
Date: Thu, 22 Jan 2009 17:13:55 -0800
Message-ID: <7v7i4m6cz0.fsf@gitster.siamese.dyndns.org>
References: <1232671630-19683-1-git-send-email-goulding@vivisimo.com>
 <497913E4.6050806@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 02:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAe1-00034M-Sg
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZAWBOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 20:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbZAWBON
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:14:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZAWBOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:14:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4337F93AE4;
	Thu, 22 Jan 2009 20:14:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4A5D93AE3; Thu,
 22 Jan 2009 20:14:06 -0500 (EST)
In-Reply-To: <497913E4.6050806@vivisimo.com> (Jake Goulding's message of
 "Thu, 22 Jan 2009 19:48:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2390C7F8-E8EB-11DD-B6F1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106817>

Jake Goulding <goulding@vivisimo.com> writes:

> Moving has_commit from branch to a common location in preparation for
> using it in tag.

has_commit() may have been a good enough name when it was a static in
builtin-branch.c but with much wider visibility, it is not specific
enough.

Perhaps you would want to rename it to something more descriptive.

Also it seems that your patch is garbled and won't apply.  A blank
context line lost the leading (and only) SP, and long lines are wrapped.

> Signed-off-by: Jake Goulding <goulding@vivisimo.com>
> ---
>  builtin-branch.c |   15 ---------------
>  commit.c         |   15 +++++++++++++++
>  commit.h         |    1 +
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/builtin-branch.c b/builtin-branch.c
> index 82d6fb2..bb42911 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -193,21 +193,6 @@ struct ref_list {
>  	int kinds;
>  };
>
> -static int has_commit(struct commit *commit, struct commit_list
> *with_commit)
> -{
> -	if (!with_commit)
> -		return 1;
> -	while (with_commit) {
> -		struct commit *other;
> -
> -		other = with_commit->item;
> -		with_commit = with_commit->next;
> -		if (in_merge_bases(other, &commit, 1))
> -			return 1;
> -	}
> -	return 0;
> -}
> -
>  static int append_ref(const char *refname, const unsigned char *sha1,
> int flags, void *cb_data)
>  {
>  	struct ref_list *ref_list = (struct ref_list*)(cb_data);
> diff --git a/commit.c b/commit.c
> index c99db16..5ccb338 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -705,6 +705,21 @@ struct commit_list *get_merge_bases(struct commit
> *one, struct commit *two,
>  	return get_merge_bases_many(one, 1, &two, cleanup);
>  }
>
> +int has_commit(struct commit *commit, struct commit_list *with_commit)
> +{
> +	if (!with_commit)
> +		return 1;
> +	while (with_commit) {
> +		struct commit *other;
> +
> +		other = with_commit->item;
> +		with_commit = with_commit->next;
> +		if (in_merge_bases(other, &commit, 1))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  int in_merge_bases(struct commit *commit, struct commit **reference,
> int num)
>  {
>  	struct commit_list *bases, *b;
> diff --git a/commit.h b/commit.h
> index 3a7b06a..1b8444f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -133,6 +133,7 @@ extern int is_repository_shallow(void);
>  extern struct commit_list *get_shallow_commits(struct object_array *heads,
>  		int depth, int shallow_flag, int not_shallow_flag);
>
> +int has_commit(struct commit *, struct commit_list *);
>  int in_merge_bases(struct commit *, struct commit **, int);
>
>  extern int interactive_add(int argc, const char **argv, const char
> *prefix);
> -- 
> 1.6.0.4
