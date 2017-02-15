Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265B91FC44
	for <e@80x24.org>; Wed, 15 Feb 2017 10:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdBOKqz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 15 Feb 2017 05:46:55 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:1187 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdBOKqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 05:46:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 42B4E1E2FB4;
        Wed, 15 Feb 2017 11:46:50 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4DkcdffxyoQ1; Wed, 15 Feb 2017 11:46:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id C36421E3138;
        Wed, 15 Feb 2017 11:46:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fiDhMC_w5c3T; Wed, 15 Feb 2017 11:46:49 +0100 (CET)
Received: from [192.168.178.70] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 607721E2FB4;
        Wed, 15 Feb 2017 11:46:49 +0100 (CET)
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref
 given
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com>
 <20170214212404.31469-2-cornelius.weig@tngtech.com>
 <CAM0VKjkqdto83Qo8PVbxt-2r8prQguNbAtNELxj5AmJEgugC_Q@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>,
        j6t@kdbg.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <1cff1dea-baeb-3576-ad33-04b2c5d233d8@tngtech.com>
Date:   Wed, 15 Feb 2017 11:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkqdto83Qo8PVbxt-2r8prQguNbAtNELxj5AmJEgugC_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although I'm not convinced that completion of modified files is unnecessary, I'm at least persuaded that not all users would welcome such a change. Given the hint from Gabor that Alt-/ forces filesystem completion, there is even no big win in stopping to offer further refnames after one has already been given.

If you think that this would be desirable, find a revised version below. Otherwise drop it.


On 02/15/2017 04:11 AM, SZEDER Gábor wrote:
> On Tue, Feb 14, 2017 at 10:24 PM,  <cornelius.weig@tngtech.com> wrote:
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>> Note that one corner-case is not covered by the current implementation:
>> if a refname contains a ':' and is followed by '--' the completion would
>> not recognize the valid refname.
> 
> I'm not sure what you mean here.  Refnames can't contain ':'.

Yes, my bad. I was confusing it with the case where filename and ref name are identical.

>> +               while [ $c -lt $cword ]; do
>> +                       i="${words[c]}"
>> +                       case "$i" in
>> +                       --) seen_double_dash=1 ;;
>> +                       -*|?*:*) ;;
>> +                       *) ref="$i"; break ;;
> 
> I haven't tried it, but this would trigger on e.g. 'git checkout -b
> new-feature <TAB>', wouldn't it?

Correct, good eyes.

> What about
> 
>   $ echo "unintentional change" >>tracked-file && git add -u
>   $ git rm important-file
>   $ git checkout HEAD <TAB>
> 
> ?  It seems it will offer neither 'tracked-file' nor 'important-file',
> but I think it should offer both.

Ideally yes. The latter of the two would also not work with Alt/.


-------------------------------------------------------------------
From d0e0c9af8a30dec479c393ae7fe75205c9b3b229 Mon Sep 17 00:00:00 2001
From: Cornelius Weig <cornelius.weig@tngtech.com>
Date: Tue, 14 Feb 2017 21:01:45 +0100
Subject: [PATCH] completion: checkout: complete paths when ref given

Git-checkout completes words starting with '--' as options and other
words as refs. Even after specifying a ref, further words not starting
with '--' are completed as refs, which is invalid for git-checkout.

With this commit completion suppresses refname suggestion after finding
what looks like a refname. Words before a '--' not starting with a '-'
and containing no ':' are considered to be refnames.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c6e1c774d..42e6463b67 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1059,7 +1059,16 @@ _git_bundle ()
 
 _git_checkout ()
 {
-	__git_has_doubledash && return
+	local c=2 seen_ref=""
+	while [ $c -lt $cword ]; do
+		case "${words[c]}" in
+		--) return ;;
+		-b|-B|--orphan|--branch) ((c++)) ;;
+		-*|*:*) ;;
+		*) seen_ref="y" ;;
+		esac
+		((c++))
+	done
 
 	case "$cur" in
 	--conflict=*)
@@ -1072,13 +1081,16 @@ _git_checkout ()
 			"
 		;;
 	*)
-		# check if --track, --no-track, or --no-guess was specified
-		# if so, disable DWIM mode
-		local flags="--track --no-track --no-guess" track=1
-		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
-			track=''
+		if [ -z "$seen_ref" ]
+		then
+			# check for --track, --no-track, or --no-guess
+			# if so, disable DWIM mode
+			local flags="--track --no-track --no-guess" track=1
+			if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
+				track=''
+			fi
+			__gitcomp_nl "$(__git_refs '' $track)"
 		fi
-		__gitcomp_nl "$(__git_refs '' $track)"
 		;;
 	esac
 }
-- 
2.11.1

