Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0C620248
	for <e@80x24.org>; Fri,  1 Mar 2019 22:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCAWP4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 17:15:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCAWP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 17:15:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AB5112C956;
        Fri,  1 Mar 2019 17:15:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=4Q4A8lbI13GJ6angVLU5obrR3Nc=; b=Sghdpvo
        QZv911JxnfDyDuVdDIDy7o7SWh46TDCCsN50j3ixruk3BPGdhPmvUGJlraxu0Wby
        4qvLItSQElQtcfKF5qIMqlmkzimCFM+4fl4T64dVKJxHLIk0IhgCD3iNkATL27zd
        XrbchNe6199T1BIDhQyOfVS+xTdTxrxUbVgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=fRawd3hVx+rBrBOC8hZ4+btaEgZaYrh0m
        Si5wWCsHqrPzwG7lsDKB4pDa8pYcOi7VkXEjsfqyUsTKx0iC9NwT3Z1RsEqOE2Xu
        QvgJSZeVC2WB9k6k7/zcQndYYaclxQwoV0w0Ng85dFJku+zBqeWDkBPtz8KtSVPo
        lSsNHa0Csg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02F6112C955;
        Fri,  1 Mar 2019 17:15:54 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 890D812C954;
        Fri,  1 Mar 2019 17:15:53 -0500 (EST)
Date:   Fri, 1 Mar 2019 17:15:51 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190301221551.GD31362@zaya.teonanacatl.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301183017.GB30847@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 94280FC0-3C6F-11E9-ADE9-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Mar 01, 2019 at 12:34:40PM -0500, Todd Zullinger wrote:
> 
>> Jeff King wrote:
>>> I can reproduce your problem, though the test you included passes for me
>>> even with the current tip of master.
>> 
>> Oh, hrm.  I think the issue is that completion.commands needs to be
>> set in the global (or system-wide) config, via test_config_global
>> rather than the local repo config which test_config sets.
>> 
>> In hindsight, that seems obvious.  But it's probably worth noting
>> that where completion.commands is documented, for anyone who might
>> spend a few cycles trying to configure it on a per-repo basis before
>> realizing it doesn't work.
> 
> I think this is actually a bug. Normally code that is checking config
> before we've decide to do setup_git_directory() would use
> read_early_config(), which uses discover_git_directory() to tentatively
> see if we're in a repo, and if so to add it to the config sequence.
> 
> But this code uses the caching configset mechanism. And that code
> (rightly) does not use read_early_config(), because it has no idea if
> it's being called early or what.
> 
> I think we probably ought to be doing something like this:
> 
> diff --git a/git.c b/git.c
> index 2dd588674f..ba3690245e 100644
> --- a/git.c
> +++ b/git.c
> @@ -62,6 +62,13 @@ static int list_cmds(const char *spec)
>  {
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  	int i;
> +	int nongit;
> +
> +	/*
> +	 * Set up the repository so we can pick up any repo-level config (like
> +	 * completion.commands).
> +	 */
> +	setup_git_directory_gently(&nongit);
>  
>  	while (*spec) {
>  		const char *sep = strchrnul(spec, ',');

Hmm.  The comments in list_cmds_by_config() made me wonder
if not using a local repo config was intentional:

        /*
         * There's no actual repository setup at this point (and even
         * if there is, we don't really care; only global config
         * matters). If we accidentally set up a repository, it's ok
         * too since the caller (git --list-cmds=) should exit shortly
         * anyway.
         */

Is the cost of setting up a repository something which might
noticeably slow down interactive completion?  In my testing
today I haven't felt it, but I have loads of memory on this
system.

I did apply your change and that allows the test to use
test_config() rather than test_config_global().  The full
test suite passes, so the change doesn't trigger any new
issues we have covered by a test, at least.

If we wanted to respect local configs, how does this look?

-- 8< --
From: Jeff King <peff@peff.net>
Subject: [PATCH] git: read local config in --list-cmds

Normally code that is checking config before we've decide to do
setup_git_directory() would use read_early_config(), which uses
discover_git_directory() to tentatively see if we're in a repo,
and if so to add it to the config sequence.

But list_cmds() uses the caching configset mechanism and
(rightly) does not use read_early_config(), because it has no
idea if it's being called early.

Call setup_git_directory_gently() so we can pick up repo-level
config (like completion.commands).

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git.c b/git.c
index 2dd588674f..10e49d79f6 100644
--- a/git.c
+++ b/git.c
@@ -62,6 +62,13 @@ static int list_cmds(const char *spec)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int i;
+	int nongit;
+
+	/*
+	* Set up the repository so we can pick up any repo-level config (like
+	* completion.commands).
+	*/
+	setup_git_directory_gently(&nongit);
 
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
-- 8< --

-- 
Todd
