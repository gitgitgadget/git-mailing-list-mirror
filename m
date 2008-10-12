From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Sun, 12 Oct 2008 22:29:37 +0200
Message-ID: <4ac8254d0810121329r2227d214qd7e4691aabf2c965@mail.gmail.com>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
	 <20081012200833.GC5255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 22:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp7aW-00052q-FW
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 22:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbYJLU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYJLU3k
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 16:29:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:22740 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbYJLU3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 16:29:40 -0400
Received: by wr-out-0506.google.com with SMTP id 69so894255wri.5
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xdY4GyCewxhMgJSAP5STnNcyIRdYkTp3qtO9+tcRGL8=;
        b=kMYNvc99IhxSgBzFfmvEeSrrsxma//zCMW/goPMCP524JZIbYnVncHFS7jE++2sd4u
         43GWRdjd/lEJl2q9BPOFPkvmNps2N8MDpROpHFLpyV/nG+c/blwELcLyxYGBEr/0BGqh
         5EXyBHfc2qez0oUncVLtuNpb/jYNowtxOvkOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VX8wJOqJmQvQhiIfuvhII8ChQIWs4b8kGWupnfkAIcbCM7F3Uomxb07dHauW+jcwCo
         2FFOELMYZtjQbL+ff/g3qZ28ZxvUaZDeI0zpb6/iRTEjeTe5R3a830RnOvU0MUYtSePo
         ez3wjt6XmTIZR6bXSKhlNtEkRqvfidFRxFRco=
Received: by 10.65.93.19 with SMTP id v19mr8795407qbl.36.1223843378040;
        Sun, 12 Oct 2008 13:29:38 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Sun, 12 Oct 2008 13:29:37 -0700 (PDT)
In-Reply-To: <20081012200833.GC5255@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98052>

On Sun, Oct 12, 2008 at 10:08 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> After fixing clone -q I noticed that pull -q is does not do what
>> it's supposed to do and implemented --quiet/--verbose by
>> adding it to builtin-merge and fixing two places in builtin-fetch.
>
>> diff --git a/builtin-merge.c b/builtin-merge.c
>> index 38266ba..1f601d4 100644
>> --- a/builtin-merge.c
>> +++ b/builtin-merge.c
>> @@ -101,7 +102,7 @@ static struct strategy *get_strategy(const char *name)
>>                       struct cmdname *ent = main_cmds.names[i];
>>                       for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
>>                               if (!strncmp(ent->name, all_strategy[j].name, ent->len)
>> -                                             && !all_strategy[j].name[ent->len])
>> +                                     && !all_strategy[j].name[ent->len])
>
> This hunk seems to just be whitespace formatting.  I'd rather not
> see it in a patch that is otherwise about --quiet/--verbose changes.
> One change per patch, please.  ;-)

Hi Shawn, thanks for the quick review.

This is a problem caused by my automagic editor
configuration and an oversight. ACK.

>> @@ -282,18 +287,20 @@ static void squash_message(void)
>>       if (prepare_revision_walk(&rev))
>>               die("revision walk setup failed");
>>
>> -     strbuf_init(&out, 0);
>> -     strbuf_addstr(&out, "Squashed commit of the following:\n");
>> -     while ((commit = get_revision(&rev)) != NULL) {
>> -             strbuf_addch(&out, '\n');
>> -             strbuf_addf(&out, "commit %s\n",
>> -                     sha1_to_hex(commit->object.sha1));
>> -             pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
>> -                     NULL, NULL, rev.date_mode, 0);
>> +     if(verbose || !quiet) {
>> +             strbuf_init(&out, 0);
>> +             strbuf_addstr(&out, "Squashed commit of the following:\n");
>> +             while ((commit = get_revision(&rev)) != NULL) {
>> +                     strbuf_addch(&out, '\n');
>> +                     strbuf_addf(&out, "commit %s\n",
>> +                                             sha1_to_hex(commit->object.sha1));
>> +                     pretty_print_commit(rev.commit_format, commit, &out, rev.abbrev,
>> +                                                             NULL, NULL, rev.date_mode, 0);
>> +             }
>> +             write(fd, out.buf, out.len);
>> +             close(fd);
>> +             strbuf_release(&out);
>>       }
>> -     write(fd, out.buf, out.len);
>> -     close(fd);
>> -     strbuf_release(&out);
>
> This entire hunk strikes me as being completely wrong.  The fd
> we are writing to is SQUASH_MSG.  It was opened earlier in the
> function and should be closed, even if we put nothing into the
> file.  Your change causes --quiet to leak the file descriptor.
>
> But even worse, I think your change causes SQUASH_MSG to lose its
> entire content, which makes "git merge --quiet --squash" behave
> very differently from what it does today, where it at least gives
> you a summary of the commits in the SQUASH_MSG file.
>
> IMHO this hunk shouldn't be here.

You are right, I was not 100% sure whether the assembled
message is only displayed or possibly also stored somewhere.
What would be the right place to quieten this one?
I should have tagged the mail as an RFC :-).

>> @@ -877,6 +885,8 @@ int cmd_merge(int argc, const char **argv, const
>> char *prefix)
>>
>>       argc = parse_options(argc, argv, builtin_merge_options,
>>                       builtin_merge_usage, 0);
>> +     if(!verbose && quiet)
>> +             show_diffstat = 0;
>
> Formatting nit, use "if (".

ACK.

>> @@ -1019,11 +1029,11 @@ int cmd_merge(int argc, const char **argv,
>> const char *prefix)
>>               char hex[41];
>>
>>               strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
>> -
>> -             printf("Updating %s..%s\n",
>> -                     hex,
>> -                     find_unique_abbrev(remoteheads->item->object.sha1,
>> -                     DEFAULT_ABBREV));
>> +             if(verbose || !quiet)
>
> Formatting nit, use "if (".

ACK.

>> diff --git a/git-pull.sh b/git-pull.sh
>> index 75c3610..d84ceb5 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -16,13 +16,17 @@ cd_to_toplevel
>>  test -z "$(git ls-files -u)" ||
>>       die "You are in the middle of a conflicted merge."
>>
>> -strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
>> +quiet= verbose= strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
>
> This line got a little long, maybe put the two new ones on a new
> line so we don't overrun the 80 column margin and there's an easier
> to read diff?

ACK.

I will fix the obvious and see what I can come up with for the
pretty_print hunk.
