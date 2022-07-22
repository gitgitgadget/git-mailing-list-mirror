Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4838C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 20:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiGVU0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVU0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 16:26:03 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 13:26:00 PDT
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75F29812
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 13:26:00 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D15E71F54E;
        Fri, 22 Jul 2022 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1658521089;
        bh=i37vyns58p60dRIYKOYmrWsYWaB5Nxekph5yakLpkN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F75ppPpdK0N0LuKew8dThbEifbfQqwDr33gbK6lvJsBVRvIC1Mzdy5Q3497n83loc
         RAa9MRW4UowUO2V/TJwC+BdAOXIgoYSZEXPKSQygAyrvsYf/piIEhC29/Yico/8YNu
         cKliPXgQ98JCwPH0mUnJ+0WLQhA28Xux6E3e6WhY=
Date:   Fri, 22 Jul 2022 20:18:09 +0000
From:   Eric Wong <e@80x24.org>
To:     Britton Kerin <britton.kerin@gmail.com>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: git-send-email doesn't entirely understand --subject (or
 --in-reply-to)
Message-ID: <20220722201809.GA21894@dcvr>
References: <CAC4O8c-Tf11CpwuRudyrpXv5bGshuyEenV9kKrs0zRWER-+yHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC4O8c-Tf11CpwuRudyrpXv5bGshuyEenV9kKrs0zRWER-+yHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Britton Kerin <britton.kerin@gmail.com> wrote:
> I'm not absolutely sure this is git's fault but I tried to use the
> reply mechanism described here:
> 
>      https://public-inbox.org/git/20220718232843.151392-1-britton.kerin@gmail.com/#R
> 
> whic is to say this:
> 
>      git send-email \
>          --in-reply-to=20220718232843.151392-1-britton.kerin@gmail.com \
>          --to=britton.kerin@gmail.com \
>          --cc=git@vger.kernel.org \
>          --cc=gitster@pobox.com \
>          --cc=newren@gmail.com \
>          --subject='Re: BUG: git-check-ignore documentation doesn'\''t
> come close to describing what it really does' \
>          /path/to/YOUR_REPLY
> 
> and it failed like this:

+cc meta@public-inbox.org since that's where the instructions come from.

> $ git send-email     --in-reply-to=xmqqtu7lc587.fsf@gitster.g
> --to=britton.kerin@gmail.com   --subject='Re: BUG: git-check-ignore
> documentation doesn'\''t come close to describing what it really does'
> ~/my_reply_git_checkignore_bug_post
> /home/bkerin/my_reply_git_checkignore_bug_post
> No subject line in /home/bkerin/my_reply_git_checkignore_bug_post? at
> /usr/lib/git-core/git-send-email line 720.
> 
> Until I added this line to the top of
> /home/bkerin/my_reply_git_checkignore_bug_post:
> 
>      Subject: Re: BUG: git-check-ignore documentation doesn't come
> close to describing what it really does
> 
> maybe this is normal but it seems weird given the presence of
> --in-reply-to and --subject and the fact that I didn't need to copy
> any other headers in.

I suppose making this change to https://80x24.org/public-inbox.git
is in order:
--------8<--------
Subject: [PATCH] www: drop --subject from "git send-email" instructions

Apparently, --subject doesn't work[1] with "git send-email" in
this context.  So drop the CLI arg and add a note to tell the
user to set a "Subject:" line in their response body, instead.

[1] I'm not sure if --subject ever worked as I thought it would,
    or if it's a regression.  In either case, there are current
    versions of git where it doesn't, so just tell users to use
    the currently supported method.

Link: https://80x24.org/lore/git/CAC4O8c-Tf11CpwuRudyrpXv5bGshuyEenV9kKrs0zRWER-+yHA@mail.gmail.com/
---
 lib/PublicInbox/Reply.pm |  3 ---
 lib/PublicInbox/View.pm  |  3 +++
 t/reply.t                | 10 ++--------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/lib/PublicInbox/Reply.pm b/lib/PublicInbox/Reply.pm
index 592dfb62..091f20bc 100644
--- a/lib/PublicInbox/Reply.pm
+++ b/lib/PublicInbox/Reply.pm
@@ -68,7 +68,6 @@ sub mailto_arg_link {
 	my $obfs = $ibx->{obfuscate};
 	my $subj = $hdr->header('Subject') || '';
 	$subj = "Re: $subj" unless $subj =~ /\bRe:/i;
-	my $subj_raw = $subj;
 	my $mid = $hdr->header_raw('Message-ID');
 	push @arg, '--in-reply-to='.squote_maybe(mid_clean($mid));
 	my $irt = mid_href($mid);
@@ -98,8 +97,6 @@ sub mailto_arg_link {
 		}
 	}
 
-	push @arg, "--subject=".squote_maybe($subj_raw);
-
 	# I'm not sure if address obfuscation and mailto: links can
 	# be made compatible; and address obfuscation is misguided,
 	# anyways.
diff --git a/lib/PublicInbox/View.pm b/lib/PublicInbox/View.pm
index b90cb08b..fa96cca3 100644
--- a/lib/PublicInbox/View.pm
+++ b/lib/PublicInbox/View.pm
@@ -142,6 +142,9 @@ $info
   <a
 href="$se_url">$se_url</a>
 $link</pre>
+
+  Be sure your reply has a <b>Subject:</b> header at the top and a blank line
+  before the message body.
 EOF
 }
 
diff --git a/t/reply.t b/t/reply.t
index 41d72db2..7319e233 100644
--- a/t/reply.t
+++ b/t/reply.t
@@ -38,7 +38,6 @@ my $exp = [
     '--to=from@example.com',
     '--cc=cc@example.com',
     '--cc=to@example.com',
-    "--subject='Re: hihi'"
 ];
 
 is_deeply($arg, $exp, 'default reply is to :all');
@@ -46,8 +45,7 @@ $ibx->{replyto} = ':all';
 ($arg, $link) = PublicInbox::Reply::mailto_arg_link($ibx, $hdr);
 is_deeply($arg, $exp, '":all" also works');
 
-$exp = [ '--in-reply-to=blah@example.com', '--to=primary@example.com',
-	"--subject='Re: hihi'" ];
+$exp = [ '--in-reply-to=blah@example.com', '--to=primary@example.com' ];
 $ibx->{replyto} = ':list';
 ($arg, $link) = PublicInbox::Reply::mailto_arg_link($ibx, $hdr);
 is_deeply($arg, $exp, '":list" works for centralized lists');
@@ -57,7 +55,6 @@ $exp = [
 	 '--to=primary@example.com',
 	 '--cc=cc@example.com',
 	 '--cc=to@example.com',
-	"--subject='Re: hihi'"
 ];
 $ibx->{replyto} = ':list,Cc,To';
 ($arg, $link) = PublicInbox::Reply::mailto_arg_link($ibx, $hdr);
@@ -65,9 +62,7 @@ is_deeply($arg, $exp, '":list,Cc,To" works for kinda centralized lists');
 
 $ibx->{replyto} = 'new@example.com';
 ($arg, $link) = PublicInbox::Reply::mailto_arg_link($ibx, $hdr);
-$exp = [ '--in-reply-to=blah@example.com', '--to=new@example.com',
-	"--subject='Re: hihi'"
-];
+$exp = [ '--in-reply-to=blah@example.com', '--to=new@example.com' ];
 is_deeply($arg, $exp, 'explicit address works, too');
 
 $ibx->{replyto} = ':all';
@@ -78,7 +73,6 @@ $exp = [
     '--to=from@example$(echo .)com',
     '--cc=cc@example$(echo .)com',
     '--cc=to@example$(echo .)com',
-    "--subject='Re: hihi'"
 ];
 is_deeply($arg, $exp, 'address obfuscation works');
 is($link, '', 'no mailto: link given');

