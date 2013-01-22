From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 00:35:12 +0100
Message-ID: <CAFXTnz62H24G9Zp5EgG47MyNdDz0KddX2n34G_1-RV_yP-ELkA@mail.gmail.com>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
	<7vmww0nahd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 00:35:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxnNS-00048H-5L
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 00:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab3AVXfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 18:35:16 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:39953 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3AVXfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 18:35:14 -0500
Received: by mail-bk0-f52.google.com with SMTP id y7so1286907bkt.39
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mYD8xbG+3uWGjoyztkMxN4otjCjjM387rJwbJvGspmE=;
        b=IDmSiFeu+OfCe6vFWTcGuM79wlfyJw/fbtec92vwVeMVe5OJbfgXRorgz/MiWmctXe
         hS/EVmXsZG4OaBhQp7BkhKuMYNwDZ/4dIyh2VjcW5kahrB9SdrknC2e2pAzicI2mZW8i
         Ojij11AnHESOdvleAfFY+vl49c71scVecNrwRdv9NxlkE4SFs0lUAk7mB3BQuvHmozSt
         iI2CWkIl6H1TDrnbHnzVPzfqBc6PNN275oas1NRR+5I+RxAioKNNlwGxBBsLX1wn1STF
         0AZWkF8ySnJK4l63UqUNoPyFg9e4URUtnd6tmybpItuEV8eeuju4W/YSKfAowfID++4R
         sPuw==
X-Received: by 10.205.129.17 with SMTP id hg17mr6292588bkc.41.1358897713206;
 Tue, 22 Jan 2013 15:35:13 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Tue, 22 Jan 2013 15:35:12 -0800 (PST)
In-Reply-To: <7vmww0nahd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214261>

On Tue, Jan 22, 2013 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> +static struct option builtin_all_options[] = {
>> +     OPT_BOOLEAN('c', "clean", &only_clean, N_("only show clean repositories")),
>> +     OPT_BOOLEAN('d', "dirty", &only_dirty, N_("only show dirty repositories")),
>> +     OPT_END(),
>> +};
>
> Shouldn't this be more like OPT_SET_INT() on a same variable that is
> initialized to "all"?  Alternatively you could validate the input
> and die when both are given.

OPT_SET_INT() seems appropriate, will fix.

>
>> +int cmd_all(int argc, const char **argv, const char *prefix)
>> +{
>> +     struct strbuf path = STRBUF_INIT;
>> +
>> +     if (!getcwd(root, sizeof(root)))
>> +             return 1;
>> +
>> +     argc = parse_options(argc, argv, prefix, builtin_all_options,
>> +                          builtin_all_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>> +
>> +     unsetenv(GIT_DIR_ENVIRONMENT);
>> +     unsetenv(GIT_WORK_TREE_ENVIRONMENT);
>
> Don't you need to clear other variables whose uses are closely tied
> to a single repository, like GIT_INDEX_FILE, etc.?
>
> I suspect that explicitly exporting GIT_DIR and GIT_WORK_TREE (and
> nothing else) in handle_repo() to the location you discovered before
> you run the per-repository command via run_command_v_opt(), might be
> a better alternative.  The user could be sharing objects in all
> repositories by permanently setting GIT_OBJECT_DIRECTORY to a single
> place.
>

This sounds like a nice plan, I'll test it and send an updated patch.


>> diff --git a/command-list.txt b/command-list.txt
>> index 7e8cfec..f955895 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,6 +1,7 @@
>>  # List of known git commands.
>>  # command name                               category [deprecated] [common]
>>  git-add                                 mainporcelain common
>> +git-all                                 mainporcelain
>>  git-am                                  mainporcelain
>>  git-annotate                            ancillaryinterrogators
>>  git-apply                               plumbingmanipulators
>
> I am not very interested in this topic in the first place, but this
> does not (at least not yet) sound like a main Porcelain to me.

There doesn't seem to be a better category, but I'm open for suggestions.

>
> "all" may be a word other people may want to use to call collections
> of things other than "Git repositories", and that use may turn out
> to be more useful in general.  A name that makes it clear that this
> is about "repositories", i.e. along the lines of "git for-each-repo"
> or something, would be a better name that does not squat on such a
> short and sweet name.
>

In principle I agree with your reasoning on this, but in practice I
fail to see what other kind of things `git all` could naturally refer
to. Also, having a short and sweet way to perform the tasks
implemented by this patch was my main motivation for writing it [1],
hence `git for-each-repo` isn't as compelling (too much typing).
There's always aliases, but I'd prefer it if future git supported `git
all` by default.

-- 
larsh

[1] Originally as a shell script, used at $WORK for ~2 years
