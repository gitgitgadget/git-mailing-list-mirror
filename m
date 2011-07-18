From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 28/48] merge-recursive: Split update_stages_and_entry;
 only update stages at end
Date: Mon, 18 Jul 2011 16:39:50 -0700
Message-ID: <7vvcuzb1kp.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-29-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixPq-0003Kl-LA
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab1GRXjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:39:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1GRXjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E823F41F1;
	Mon, 18 Jul 2011 19:39:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=t/L7dbdcb1CO8sBBfS6RNurbTKQ=; b=pEJ7+06IEUittgyUrMUO
	7sczT0m7MujCdSlkXhSe0rYJ1yYmBGqd7IHvNz56hrmL6MEwf3ayw/cnknq8Xo1B
	OSVKB72ApreYIkX44Yi+y+vALzHW7QkMfocUvAoUKhnEao+jPCzx2uVc6fr9xKNl
	7J/Nt3EwSFkvN5tVgaMiUBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=noOO9Bx9VFXd+lbWf4mb1ho51uh/juY25paYlhE8+N8E8O
	BwLlgG3lneKPgs3PJ2HLfhiMx2Kq8qBUbT3FohUPZm4vA/YsW7tTKy5tbeK0Sw3j
	I1FdwUVKSTjdlHanxmr/UWJCjtNRgmVysjJonKfG6n8tbV4NwIwVMBk3rLqW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E057641F0;
	Mon, 18 Jul 2011 19:39:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AAE041EF; Mon, 18 Jul 2011
 19:39:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BD5BEE6-B197-11E0-8CCE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177424>

Elijah Newren <newren@gmail.com> writes:

> Instead of having the process_renames logic update the stages in the index
> for the rename destination, have the index updated after process_entry or
> process_df_entry.  This will also allow us to have process_entry determine
> whether a file was tracked and existed in the working copy before the
> merge started.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c |   35 +++++++++++++++++------------------
>  1 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b4baa35..7878b30 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -90,6 +90,7 @@ struct stage_data {
>  	} stages[4];
>  	struct rename_df_conflict_info *rename_df_conflict_info;
>  	unsigned processed:1;
> +	unsigned involved_in_rename:1;
>  };
>  
>  static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
> @@ -516,15 +517,11 @@ static int update_stages(const char *path, const struct diff_filespec *o,
>  	return 0;
>  }
>  
> -static int update_stages_and_entry(const char *path,
> -				   struct stage_data *entry,
> -				   struct diff_filespec *o,
> -				   struct diff_filespec *a,
> -				   struct diff_filespec *b,
> -				   int clear)
> +static void update_entry(struct stage_data *entry,
> +			 struct diff_filespec *o,
> +			 struct diff_filespec *a,
> +			 struct diff_filespec *b)
>  {
> -	int options;
> -
>  	entry->processed = 0;
>  	entry->stages[1].mode = o->mode;
>  	entry->stages[2].mode = a->mode;
> @@ -532,7 +529,6 @@ static int update_stages_and_entry(const char *path,
>  	hashcpy(entry->stages[1].sha, o->sha1);
>  	hashcpy(entry->stages[2].sha, a->sha1);
>  	hashcpy(entry->stages[3].sha, b->sha1);
> -	return update_stages(path, o, a, b);
>  }
>  
>  static int remove_file(struct merge_options *o, int clean,
> @@ -1084,12 +1080,11 @@ static int process_renames(struct merge_options *o,
>  							      ren2->dst_entry);
>  			} else {
>  				remove_file(o, 1, ren1_src, 1);

Hopefully this unconditional removal from the working tree will be fixed
by the end of the series, at least for the virtual ancestor merges.

> -				update_stages_and_entry(ren1_dst,
> -							ren1->dst_entry,
> -							ren1->pair->one,
> -							ren1->pair->two,
> -							ren2->pair->two,
> -							1 /* clear */);
> +				update_entry(ren1->dst_entry,
> +					     ren1->pair->one,
> +					     ren1->pair->two,
> +					     ren2->pair->two);
> +				ren1->dst_entry->involved_in_rename = 1;

So the idea is to just record what the stage data should be, and delay
calling update_stages() until we run the content level merge?

> @@ -1291,6 +1287,7 @@ static void handle_delete_modify(struct merge_options *o,
>  }
>  
>  static int merge_content(struct merge_options *o,
> +			 unsigned involved_in_rename,
>  			 const char *path,
>  			 unsigned char *o_sha, int o_mode,
>  			 unsigned char *a_sha, int a_mode,
> @@ -1331,6 +1328,8 @@ static int merge_content(struct merge_options *o,
>  			reason = "submodule";
>  		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
>  				reason, path);
> +		if (involved_in_rename)
> +			update_stages(path, &one, &a, &b);
>  	}
>  
>  	if (df_conflict_remains) {
> @@ -1415,7 +1414,7 @@ static int process_entry(struct merge_options *o,
>  	} else if (a_sha && b_sha) {
>  		/* Case C: Added in both (check for same permissions) and */
>  		/* case D: Modified in both, but differently. */
> -		clean_merge = merge_content(o, path,
> +		clean_merge = merge_content(o, entry->involved_in_rename, path,
>  					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
>  					    NULL);
>  	} else if (!o_sha && !a_sha && !b_sha) {
> @@ -1459,7 +1458,7 @@ static int process_df_entry(struct merge_options *o,
>  		char *src;
>  		switch (conflict_info->rename_type) {
>  		case RENAME_NORMAL:
> -			clean_merge = merge_content(o, path,
> +			clean_merge = merge_content(o, entry->involved_in_rename, path,
>  						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
>  						    conflict_info->branch1);
>  			break;

Feels sane from a cursory look, but are there cases where we do update_entry()
above and end up not calling merge_content() at all?
