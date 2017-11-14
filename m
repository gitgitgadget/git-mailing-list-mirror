Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92142201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbdKNJ20 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Nov 2017 04:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbdKNJ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:28:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA1AAAAB5;
        Tue, 14 Nov 2017 09:28:21 +0000 (UTC)
Subject: Re: [RFC 3/3] log: add an option to generate cover letter from a
 branch tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
 <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <92c426bc-5ce9-da7c-5f10-66b5fc46825b@suse.de>
Date:   Tue, 14 Nov 2017 10:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/11/2017 à 07:14, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>
>> -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
>> -	const char *msg;
>> +	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n\n";
> Hmmmm.

The \n from fprintf(rev->diffopt.file, "%s\n", sb.buf); added an extra line after the cover which is fine for the default one but changed the commit value (at least at some point while I was playing with scissors)
so I moved it up there to avoid adding a if() around the fprintf

>
>> @@ -1021,17 +1021,21 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>>  	if (!branch_name)
>>  		branch_name = find_branch_name(rev);
>>  
>> -	msg = body;
>>  	pp.fmt = CMIT_FMT_EMAIL;
>>  	pp.date_mode.type = DATE_RFC2822;
>>  	pp.rev = rev;
>>  	pp.print_email_subject = 1;
>> -	pp_user_info(&pp, NULL, &sb, committer, encoding);
>> -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
>> -	pp_remainder(&pp, &msg, &sb, 0);
>> -	add_branch_description(&sb, branch_name);
>> -	fprintf(rev->diffopt.file, "%s\n", sb.buf);
>>  
>> +	if (!cover_at_tip_commit) {
>> +		pp_user_info(&pp, NULL, &sb, committer, encoding);
>> +		pp_title_line(&pp, &body, &sb, encoding, need_8bit_cte);
>> +		pp_remainder(&pp, &body, &sb, 0);
>> +	} else {
>> +		pretty_print_commit(&pp, cover_at_tip_commit, &sb);
>> +	}
>> +	add_branch_description(&sb, branch_name);
>> +	fprintf(rev->diffopt.file, "%s", sb.buf);
>> +	fprintf(rev->diffopt.file, "---\n", sb.buf);
>>  	strbuf_release(&sb);
> I would have expected that this feature would not change anything
> other than replacing the constant string *body we unconditionally
> print with the log message of the empty commit at the tip, so from
> that expectation, I was hoping that a patch looked nothing more than
> this:
>
>  builtin/log.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 6c1fa896ad..0af19d5b36 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -986,6 +986,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
> +			      struct commit *cover,
>  			      int quiet)
>  {
>  	const char *committer;
> @@ -1021,7 +1022,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!branch_name)
>  		branch_name = find_branch_name(rev);
>  
> -	msg = body;
> +	if (cover)
> +		msg = get_cover_from_commit(cover);
> +	else
> +		msg = body;
>  	pp.fmt = CMIT_FMT_EMAIL;
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>
>
> plus a newly written function get_cover_from_commit().  Why does
> this patch need to change a lot more than that, I have to wonder.

The added code is to avoid the get_cover_from_commit generating a single strbuf that needs to be reparse/resplit by pp_user_info/pp_title_line/pp_remainder.
There was a helper that did the right job in my case so I took it ;)

The triple dash is so that the diffstat/shortlog as not seen as part of the cover letter.
As said in the cover letter for this series, it kinda breaks legacy behaviour right now.
It should either be printed only for cover-at-tip, or a new separator should be added.

>
> This is totally unrelated, but I wonder if it makes sense to do
> something similar for branch.description, too.  If the user has a
> meaningful description prepared with "git branch --edit-desc", it is
> somewhat insulting to the user to still add "*** BLURB HERE ***".

I guess so.
And the branch description should probably not be added when using cover-at-tip either.

