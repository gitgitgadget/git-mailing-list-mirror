From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-export: refactor get_tags_and_duplicates()
Date: Tue, 03 Sep 2013 12:44:57 -0700
Message-ID: <xmqqsixlr8p2.fsf@gitster.dls.corp.google.com>
References: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
	<1378019148-1565-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwXJ-00026D-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704Ab3ICTpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:45:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720Ab3ICTpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:45:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4F93E367;
	Tue,  3 Sep 2013 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u1SmKZz4AW0w19K8WyWAzP5V8nw=; b=pPz4dZ
	VKEG1EDrh+KsEz4MZ+/oq2LvHB0RdczgJthfWpduTtfb/hrHz/CiBIfWyQ1Fg5Vj
	LDVo7CQaEcq1ZJbtvjNxO3Mz9/c5hhhfhtqarcxpo45GXZEsIfH9RLFdzhpt5FS9
	a4H2FFiDTiaXh/iFj2b7rlby9xQPUwrQL8HoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJfYC6JIUYncMKzCl8ESpFQ+a03aOWKb
	+iuwK6K0ZMcOF8q04N0nVeDRm7X5mMFBRdEtGwdR0KqWTS65aGTEmQEwW7hzYAJQ
	Wh1fLLu1q6Wl+88XvRT5OROMMixF8t4AWfMocZAPqbybzG25LJ0IMPUBsBgR4ke2
	C8vsy0pguR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E569A3E364;
	Tue,  3 Sep 2013 19:45:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E1CB3E34A;
	Tue,  3 Sep 2013 19:45:00 +0000 (UTC)
In-Reply-To: <1378019148-1565-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 1 Sep 2013 02:05:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5247C332-14D1-11E3-BB33-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233766>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Split into a separate helper function get_commit() so that the part that
> finds the relevant commit, and the part that does something with it
> (handle tag object, etc.) are in different places.
>
> No functional changes.

Actually, the old code used to use commit unchecked if e->item->type
said it is OBJ_COMMIT but e->item was somehow NULL.  The new code
checks this case and skips with a warning(), which I think is an
improvement, if not a bugfix (it only makes it easier to diagnose a
bug in the code that populates rev_cmdline_entry).

Thanks; will queue.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c | 68 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 957392c..03e1090 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -485,9 +485,32 @@ static void handle_tag(const char *name, struct tag *tag)
>  	       (int)message_size, (int)message_size, message ? message : "");
>  }
>  
> +static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
> +{
> +	switch (e->item->type) {
> +	case OBJ_COMMIT:
> +		return (struct commit *)e->item;
> +	case OBJ_TAG: {
> +		struct tag *tag = (struct tag *)e->item;
> +
> +		/* handle nested tags */
> +		while (tag && tag->object.type == OBJ_TAG) {
> +			parse_object(tag->object.sha1);
> +			string_list_append(&extra_refs, full_name)->util = tag;
> +			tag = (struct tag *)tag->tagged;
> +		}
> +		if (!tag)
> +			die("Tag %s points nowhere?", e->name);
> +		return (struct commit *)tag;
> +		break;
> +	}
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>  {
> -	struct tag *tag;
>  	int i;
>  
>  	for (i = 0; i < info->nr; i++) {
> @@ -502,41 +525,26 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>  		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
>  			continue;
>  
> -		switch (e->item->type) {
> -		case OBJ_COMMIT:
> -			commit = (struct commit *)e->item;
> -			break;
> -		case OBJ_TAG:
> -			tag = (struct tag *)e->item;
> -
> -			/* handle nested tags */
> -			while (tag && tag->object.type == OBJ_TAG) {
> -				parse_object(tag->object.sha1);
> -				string_list_append(&extra_refs, full_name)->util = tag;
> -				tag = (struct tag *)tag->tagged;
> -			}
> -			if (!tag)
> -				die ("Tag %s points nowhere?", e->name);
> -			switch(tag->object.type) {
> -			case OBJ_COMMIT:
> -				commit = (struct commit *)tag;
> -				break;
> -			case OBJ_BLOB:
> -				export_blob(tag->object.sha1);
> -				continue;
> -			default: /* OBJ_TAG (nested tags) is already handled */
> -				warning("Tag points to object of unexpected type %s, skipping.",
> -					typename(tag->object.type));
> -				continue;
> -			}
> -			break;
> -		default:
> +		commit = get_commit(e, full_name);
> +		if (!commit) {
>  			warning("%s: Unexpected object of type %s, skipping.",
>  				e->name,
>  				typename(e->item->type));
>  			continue;
>  		}
>  
> +		switch(commit->object.type) {
> +		case OBJ_COMMIT:
> +			break;
> +		case OBJ_BLOB:
> +			export_blob(commit->object.sha1);
> +			continue;
> +		default: /* OBJ_TAG (nested tags) is already handled */
> +			warning("Tag points to object of unexpected type %s, skipping.",
> +				typename(commit->object.type));
> +			continue;
> +		}
> +
>  		/*
>  		 * This ref will not be updated through a commit, lets make
>  		 * sure it gets properly updated eventually.
