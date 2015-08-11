From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Tue, 11 Aug 2015 10:33:17 -0700
Message-ID: <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<1438693282-15516-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 19:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPDQW-0001iY-IB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbHKRdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 13:33:23 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33008 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbbHKRdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 13:33:20 -0400
Received: by pdrh1 with SMTP id h1so67817821pdr.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+YBp+6iVLHZNBpYwfQMPMWgAl83+g2Ak4SebDu+VY90=;
        b=veZoR7b0kzPUF7oTG1pP4OZHTtHvBF9R2wp1SrnvwdNFTvQx/jsc9VblISW3umTD5/
         HJtDi+hDiqx6W5MA3KYPwXl1kGnrHNwD5/QjOk8XbIDXngVRLqLPt246fB//HfZ4Cyss
         6pgEpI/lerE7T6rwVhpzngzAJqsv2nEOw4/qP1kVxq7iTHkgerSCO5PU8wIVHXkODdDj
         ZFD1CiZ9f/F2/3t1Dy6e8vyfSUxPoCraeqF0DMv6GW9APi6/fzYgQNjvQd8pe+eZ2Tkg
         9ybIBK80+ph3vWc/ptUeTZPEnGXrZqTbrFaahB5CUeGF/R3oJCiSL6m8xKr6eAWuXYSX
         KUGQ==
X-Received: by 10.70.134.134 with SMTP id pk6mr48225334pdb.143.1439314399703;
        Tue, 11 Aug 2015 10:33:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id z8sm3403099pas.42.2015.08.11.10.33.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 10:33:18 -0700 (PDT)
In-Reply-To: <1438693282-15516-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 4 Aug 2015 18:31:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275699>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add an option in 'filter_refs()' to use 'for_each_branch_ref()'
> and filter refs. This type checking is done by adding a
> 'FILTER_REFS_BRANCHES' in 'ref-filter.h'.
>
> Add an option in 'ref_filter_handler()' to filter different
> types of branches by calling 'filter_branch_kind()' which
> checks for the type of branch needed.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  ref-filter.h | 10 ++++++++--
>  2 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index de84dd4..c573109 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1044,6 +1044,46 @@ static const unsigned char *match_points_at(struct sha1_array *points_at,
>  	return NULL;
>  }
>  
> +/*
> + * Checks if a given refname is a branch and returns the kind of
> + * branch it is. If not a branch, 0 is returned.
> + */
> +static int filter_branch_kind(struct ref_filter *filter, const char *refname)
> +{
> +	int kind, i;
> +
> +	static struct {
> +		const char *prefix;
> +		int kind;

Make a mental note that this is signed int.

> +	} ref_kind[] = {
> +		{ "refs/heads/" , REF_LOCAL_BRANCH },
> +		{ "refs/remotes/" , REF_REMOTE_BRANCH },
> +	};
> +
> +	/*  If no kind is specified, no need to filter */
> +	if (!filter->branch_kind)
> +		return REF_NO_BRANCH_FILTERING;
> +
> +	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
> +		if (starts_with(refname, ref_kind[i].prefix)) {
> +			kind = ref_kind[i].kind;
> +			break;
> +		}
> +	}
> +
> +	if (ARRAY_SIZE(ref_kind) <= i) {
> +		if (!strcmp(refname, "HEAD"))
> +			kind = REF_DETACHED_HEAD;
> +		else
> +			return 0;
> +	}
> +
> +	if ((filter->branch_kind & kind) == 0)
> +		return 0;
> +
> +	return kind;
> +}

While this looks fine, I am not sure if this is a good interface for
filtering, though.

If you start from already having everything and want to limit things
down to "refs/heads/", this might make sense but it would be far
more efficient, if you know that you want to limit to "refs/heads/"
upfront, not to collect everything but just limit the collection to
those under "refs/heads/" without wasting cycles in the first place.

> diff --git a/ref-filter.h b/ref-filter.h
> index 5be3e35..b5a13e8 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -16,6 +16,12 @@
>  #define FILTER_REFS_INCLUDE_BROKEN 0x1
>  #define FILTER_REFS_ALL 0x2
>  #define FILTER_REFS_TAGS 0x4
> +#define FILTER_REFS_BRANCHES 0x8

Is this a sensible set of bits?  Does it make sense to have ALL and
TAGS at the same time (and what does that mean?)?

> +#define REF_DETACHED_HEAD   0x01
> +#define REF_LOCAL_BRANCH    0x02
> +#define REF_REMOTE_BRANCH   0x04
> +#define REF_NO_BRANCH_FILTERING 0x08

Where do these values go?  It is a returned by filter-branch-kind
for each ref, i.e. given "refs/heads/bar", it answers "Yeah, that is
a local branch".  Why are these values pretending to be a set of
bits that can be combined together, as if a branch can be both LOCAL
and REMOTE?  This does not make _any_ sense.


>  #define ALIGN_LEFT 0x01
>  #define ALIGN_RIGHT 0x02
> @@ -50,7 +56,7 @@ struct ref_sorting {
>  
>  struct ref_array_item {
>  	unsigned char objectname[20];
> -	int flag;
> +	int flag, kind;

For readability, do not define multiple structure fields on a single
line.

If you are storing a set of bits in an integer, use unsigned.  If it
is an enumeration, int is fine.

>  	const char *symref;
>  	struct commit *commit;
>  	struct atom_value *value;
> @@ -76,7 +82,7 @@ struct ref_filter {
>  
>  	unsigned int with_commit_tag_algo : 1,
>  		match_as_path : 1;
> -	unsigned int lines;
> +	unsigned int lines, branch_kind;

For readability, do not define multiple structure fields on a single
line.

>  };
>  
>  struct ref_filter_cbdata {
