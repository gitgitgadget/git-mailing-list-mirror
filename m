Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC8C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AD923602
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392980AbhAUA0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:26:30 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51218 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404135AbhATXZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 18:25:42 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l2MqM-009ZQM-Fj; Wed, 20 Jan 2021 16:24:54 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l2MqL-00Gutg-Ap; Wed, 20 Jan 2021 16:24:54 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 08A7D500F3B;
        Wed, 20 Jan 2021 16:24:53 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gyJwtzkoS3Bc; Wed, 20 Jan 2021 16:24:52 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 6591A500C8D;
        Wed, 20 Jan 2021 16:24:52 -0700 (MST)
Date:   Wed, 20 Jan 2021 16:24:47 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <20210120232447.GA35105@ellen>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210116042454.GA4913@ellen>
X-XM-SPF: eid=1l2MqL-00Gutg-Ap;;;mid=<20210120232447.GA35105@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: automerge implementation ideas for Windows
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 09:24:59PM -0700, Seth House wrote:
> The autocrlf test is breaking because the sed that ships with some mingw
> versions (and also some minsys and cygwin versions) will *automatically*
> remove carriage returns:

So the mingw builds of both sed and awk change carriage returns. So far
I haven't found documentation on it so I'm not aware of a portable way
to disable the behavior. Instead I've been playing with alternate
approaches. The two patches below work and pass the autocrlf test on
Windows, however they are first-draft implementations. Feedback welcome.

One other point of discussion: I would like to change the name of this
feature. "Automerge" is a bit of an overloaded term and, IMO, doesn't
describe this feature very well. Several of the GUI diff programs have
a feature that they call "automerge" or "auto merge", and there's a flag
for Meld already in Git called "mergetool.meld.useAutoMerge" which could
cause confusion.

Instead, I'd like to propose "mergetool.hideResolved" or the more
verbose "mergetool.hideResolvedConflicts" as the name. We're not really
merging anything (Git aleady did that before the mergetool is invoked),
but rather we're just not showing any conflicts that Git was already
able to resolve.

---------->8--------->8--------->8--------->8-------

#1: Use POSIX read and a while loop to emulate an awk-like approach:

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 246d6b76fc..94728dd518 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -240,19 +240,46 @@ checkout_staged_file () {
 }
 
 auto_merge () {
+	C0="<<<<<<< "
+	C1="||||||| "
+	C2="======="
+	C3=">>>>>>> "
+	inl=0
+	inb=0
+	inr=0
+
 	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
+
 	if test -s "$DIFF3"
 	then
-		C0="^<<<<<<< "
-		C1="^||||||| "
-		C2="^=======$(printf '\015')\{0,1\}$"
-		C3="^>>>>>>> "
-
-		sed -e "/$C0/,/$C1/d" -e "/$C2/,/$C3/d" "$DIFF3" >"$BASE"
-		sed -e "/$C1/,/$C3/d" -e "/$C0/d" "$DIFF3" >"$LOCAL"
-		sed -e "/$C0/,/$C2/d" -e "/$C3/d" "$DIFF3" >"$REMOTE"
+		touch "$LCONFL" "$BCONFL" "$RCONFL"
+
+		while read -r line
+		do
+			case $line in
+				$C0*) inl=1; continue ;;
+				$C1*) inl=0; inb=1; continue ;;
+				$C2*) inb=0; inr=1; continue ;;
+				$C3*) inr=0; continue ;;
+			esac
+
+			case 1 in
+				$inl) printf '%s\n' "$line" >>"$LCONFL" ;;
+				$inb) printf '%s\n' "$line" >>"$BCONFL" ;;
+				$inr) printf '%s\n' "$line" >>"$RCONFL" ;;
+				*)
+					printf '%s\n' "$line" >>"$LCONFL"
+					printf '%s\n' "$line" >>"$BCONFL"
+					printf '%s\n' "$line" >>"$RCONFL"
+				;;
+			esac
+		done < "$DIFF3"
+
+		mv -- "$LCONFL" "$LOCAL"
+		mv -- "$BCONFL" "$BASE"
+		mv -- "$RCONFL" "$REMOTE"
+		rm -- "$DIFF3"
 	fi
-	rm -- "$DIFF3"
 }
 
 merge_file () {
@@ -295,8 +322,11 @@ merge_file () {
 	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
+	LCONFL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_LCONFL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
+	RCONFL="$MERGETOOL_TMPDIR/${BASE}_REMOTE_RCONFL_$$$ext"
 	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
+	BCONFL="$MERGETOOL_TMPDIR/${BASE}_BASE_BCONFL_$$$ext"
 
 	base_mode= local_mode= remote_mode=

---------->8--------->8--------->8--------->8-------

#2: Call merge-file twice:

A much simpler implementation but probably less performant. Is it enough
to matter?

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 246d6b76fc..1cb45a7437 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -240,19 +240,10 @@ checkout_staged_file () {
 }
 
 auto_merge () {
-	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
-	if test -s "$DIFF3"
-	then
-		C0="^<<<<<<< "
-		C1="^||||||| "
-		C2="^=======$(printf '\015')\{0,1\}$"
-		C3="^>>>>>>> "
-
-		sed -e "/$C0/,/$C1/d" -e "/$C2/,/$C3/d" "$DIFF3" >"$BASE"
-		sed -e "/$C1/,/$C3/d" -e "/$C0/d" "$DIFF3" >"$LOCAL"
-		sed -e "/$C0/,/$C2/d" -e "/$C3/d" "$DIFF3" >"$REMOTE"
-	fi
-	rm -- "$DIFF3"
+	git merge-file --ours -q -p "$LOCAL" "$BASE" "$REMOTE" >"$LCONFL"
+	git merge-file --theirs -q -p "$LOCAL" "$BASE" "$REMOTE" >"$RCONFL"
+	mv -- "$LCONFL" "$LOCAL"
+	mv -- "$RCONFL" "$REMOTE"
 }
 
 merge_file () {
@@ -295,7 +286,9 @@ merge_file () {
 	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
 	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
 	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
+	LCONFL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_LCONFL_$$$ext"
 	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
+	RCONFL="$MERGETOOL_TMPDIR/${BASE}_REMOTE_RCONFL_$$$ext"
 	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
 
 	base_mode= local_mode= remote_mode=

