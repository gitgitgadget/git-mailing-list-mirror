From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH 1/5] Teach cherry-pick to skip redundant commits if asked
Date: Mon, 11 Jan 2016 21:10:45 -0600
Message-ID: <87oacra3wq.fsf@waller.obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
	<1452488421-26823-2-git-send-email-greened@obbligato.org>
	<xmqqr3hnx6e2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 04:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIpMe-0004cc-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 04:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761174AbcALDLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 22:11:15 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:56262 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761070AbcALDLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 22:11:00 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIpNK-0007Tn-M2; Mon, 11 Jan 2016 21:12:02 -0600
In-Reply-To: <xmqqr3hnx6e2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jan 2016 11:28:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283762>

Junio C Hamano <gitster@pobox.com> writes:

>> +		OPT_END(),
>>  		OPT_END(),
>>  		OPT_END(),
>>  		OPT_END(),
>> @@ -106,6 +112,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>>  			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>>  			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>>  			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
>> +			OPT_BOOL(0, "skip-redundant-commits", &opts->skip_redundant_commits, N_("skip redundant, empty commits")),
>>  			OPT_END(),
>>  		};
>
> This however makes me wonder what should happen when both are
> specified.  Shouldn't this patch change the keep_redundant_commits
> field from a bool to a tristate that tells us what to do with
> redundant ones?  int/enum opts.redundant_commit can take 0 (fail,
> which would be the default), 1 (keep) or 2 (skip), or something
> like that.

This makes good sense.

>> diff --git a/sequencer.c b/sequencer.c
>> index 8c58fa2..12361e7 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -185,6 +185,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
>>  		else
>>  			advise(_("after resolving the conflicts, mark the corrected paths\n"
>>  				 "with 'git add <paths>' or 'git rm <paths>'\n"
>> +
>
> ???

Oops.  :)

>> @@ -614,6 +615,28 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>>  		res = allow;
>>  		goto leave;
>>  	}
>> +
>> +	// If told, do not try to commit things that don't make any
>> +	// changes.
>
> No C++/C99 comments, please.

Will fix.

>> +	if (opts->skip_redundant_commits) {
>> +		int index_unchanged = is_index_unchanged();
>> +		if (index_unchanged < 0) {
>> +			// Something bad happened readhing HEAD or the
>> +			// index.  Abort.
>> +			res = index_unchanged;
>> +			goto leave;
>> +		}
>> +		if (index_unchanged) {
>> +			fputs(_("Skipping redundant commit "), stderr);
>> +			fputs(find_unique_abbrev(commit->object.oid.hash,
>> +						 GIT_SHA1_HEXSZ),
>> +			      stderr);
>> +			fputs("\n", stderr);
>
> This is a bad i18n; we do not know the sentence "Skipping commit X"
> is translated to have X at the end of the sentence in all languages.
>
> 	fprintf(stderr, _("Skipping ... %s\n"), find_unique_abbrev(...));
>
> would allow it to be tranlated to "Commit X is getting skipped", for
> example.

Ok, thank you for the guidance.

>> diff --git a/sequencer.h b/sequencer.h
>> index 5ed5cb1..ad6145d 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -34,6 +34,7 @@ struct replay_opts {
>>  	int allow_empty;
>>  	int allow_empty_message;
>>  	int keep_redundant_commits;
>> +	int skip_redundant_commits;
>
> Continuing from the top-part of the comments, this may be better to
> be:
>
> 	enum {
>             REPLAY_REDUNDANT_FAIL = 0,
>             REPLAY_REDUNDANT_KEEP,
>             REPLAY_REDUNDANT_SKIP
> 	} redundant_commits;
>
> or something like that.

Agreed.

I've also resumed work on my earlier rebase --keep-redundant-commits
change.  I think I'm going to reorganize things and send the cherry-pick
changes separate from the rebase changes since the latter depends on the
former.  Then all of the redundant commit work on rebase can be in one
series for review.

                        -David
