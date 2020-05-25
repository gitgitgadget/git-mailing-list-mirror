Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87BC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F0A2078B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 13:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgEYNIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 09:08:16 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41969 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388763AbgEYNIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 09:08:16 -0400
X-Originating-IP: 157.36.39.183
Received: from localhost (unknown [157.36.39.183])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B854820009;
        Mon, 25 May 2020 13:08:12 +0000 (UTC)
Date:   Mon, 25 May 2020 18:38:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "J. Paul Reed" <preed@sigkill.com>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-gui patch staging errors
Message-ID: <20200525130807.4ydporgaeva27del@yadavpratyush.com>
References: <20200512010750.GA7127@sigkill.com>
 <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
 <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <20200512204233.GA31807@sigkill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512204233.GA31807@sigkill.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the late reply.

On 12/05/20 01:42PM, J. Paul Reed wrote:
> 
> Hey Richard,

You replied to the wrong person ;-)

> Using your test case, I still get the error (which is, specifically an
> error dialog saying:
> 
>    Failed to stage selected line.
> 
>    error: patch failed: glacierupload.sh:55
>    error:glacierupload.sh: patch does not apply
> 
> Note that I'm highlighting the change in the source code, then
> right-clicking it and selecting "Stage lines for commit." ("Stage hunk for
> commit" also results in the error.)
> 
> If I stage the entire file by clicking on it in the upper-lefthand pane,
> things work fine.
> 
> This is a Gentoo box, so I wonder I happened to build Tcl without the
> appropriate unicode support (that one would find in most package-based
> distros)?
> 
> In briefly digging a bit more, it would seem that git gui is foisting the
> work onto "git apply" to create a patch and stage it? (If I'm reading the
> source correctly, It looks like the error dialog title is from
> https://github.com/prati0100/git-gui/blob/master/lib/diff.tcl#L700

You are close, but not quite there. We don't use "git apply" to _create_ 
a patch. We create the patch ourselves, and then pass it to git apply to 
stage/unstage the lines selected.

I suspect it is some encoding mismatch. Can you apply this patch below 
and send what the output is?

-- 8< --
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 871ad48..6226a89 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -851,8 +851,13 @@ proc apply_or_revert_range_or_line {x y revert} {
 		set first_l [$ui_diff index "$next_l + 1 lines"]
 	}
 
+	puts "Diff we will send to git-apply:"
+	puts -nonewline "$current_diff_header"
+	puts -nonewline "$wholepatch"
+
 	if {[catch {
 		set enc [get_path_encoding $current_diff_path]
+		puts "\nEncoding: $enc"
 		set p [eval git_write $apply_cmd]
 		fconfigure $p -translation binary -encoding $enc
 		puts -nonewline $p $current_diff_header
-- >8 --
 
> and then the error strings that populate the dialog are bubbled up from git
> apply.
> 
> Any ideas on what would make "git apply" potentially choke? I wonder if it
> has to do with a mixed file encoding?

git-gui not preparing the patch text properly would be a prime 
candidate.
 
> I tried setting both:
> 
> core.checkRoundTripEncoding true 
> gui.encoding utf-8
> 
> on that repo; git gui still errored out in the same way. 
> 
> I also tried changing gui.encoding to utf-16; no dice...
> 
> To reiterate, git add -i worked fine...

-- 
Regards,
Pratyush Yadav
