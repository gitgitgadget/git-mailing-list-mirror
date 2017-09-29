Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F6D20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 03:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdI2Dvs (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 23:51:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51762 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751219AbdI2Dvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 23:51:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3705AF4D5;
        Thu, 28 Sep 2017 23:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=biu0R34gwddt/eD1UeTbCU4IWeU=; b=pkORzh
        pxvWWatve4n+dhCbUB9QxTz7TnCGOtB5+61jHBt1HBgJNlZm7bmhAKZ7vTbokSt8
        t3F2gVNt3aOeu998ZCq+y5nkOkIJzsfpHIpbMlNhe/pOQh3z5y5E+wOvDeORiABg
        QFHSBeG0i9dQUxmL8rwwFcbOCgYwhSrBuSgTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qVpruSuggbuHy9y4Z3gtH6uaL7EI0Kej
        UHzscG51AUSCDreXjVSGD4LSbdf5jvXdn5j1PuK2M+cr0ebJWOEIxLq150kt2sFa
        cPvu1GxyYTLDggB5CSMSgTx0ZooptTbrNAVq4Tmjm2TjtiRDqrcLrfU0cIpQ1HIy
        xpFoQ1tVMN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA932AF4D4;
        Thu, 28 Sep 2017 23:51:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C40C7AF4CF;
        Thu, 28 Sep 2017 23:51:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com>
        <0cb786584bd2669763c303f80072baa3693efc33.1506654123.git.e@nanocritical.com>
Date:   Fri, 29 Sep 2017 12:51:43 +0900
In-Reply-To: <0cb786584bd2669763c303f80072baa3693efc33.1506654123.git.e@nanocritical.com>
        (Eric Rannaud's message of "Thu, 28 Sep 2017 20:09:36 -0700")
Message-ID: <xmqqy3oyxiuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82DA88B8-A4C9-11E7-9163-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> Junio, this last version addresses your last remark regarding the
> potential for the cat $input_file sequence to block when the FIFOs are
> unbuffered.
>
> The concern is mainly theoretical (*if* the shell function is used
> correctly): fast-import will not start writing to its own output until
> it has fully consumed its input (as the only command generating output
> should be the last one). Nevertheless, in this version the write is done
> in the background.

I agree that the concern is theoretical.  Without this fix, we may
not be able to feed the input fully up to the final 'progress
checkpoint' command---because the other side is not reading, we may
get stuck while attempting to write "checkpoint" or "progress
checkpoint", and may never get to read what fast-import says to get
us unstuck.

But if we wanted to solve the theoretical issue (i.e. the command
sequence the user of this helper shell function gives us _might_
trigger an output from fast-import) fully, I do not think
backgrounding the feeding side is sufficient.  The code that reads
fd#9 would need to become a while loop that reads and discards extra
output until we see the "progress checkpoint", at least, perhaps
like the attached patch.

But even with such a fix, we are still at the mercy of the caller of
the helper---the helper will get broken if the input happened to
have a "progress checkpoint" command itself.  There has to be a
"good enough" place to stop.

I think that your patch the last round that feeds fd#8 in the
foreground (i.e. fully trusting that the caller is sensibly giving
input that produces no output) is already a good place to stop.

Your patch this round that feeds fd#8 in the background, plus the
attached patch (i.e. not trusting the caller as much and allowing it
to use commands that outputs something, within reason), would also
be a good place to stop.

But I am not sure your patch this round alone is a good place to
stop.  It somehow feels halfway either way.

 t/t9300-fast-import.sh | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 74ba70874b..d47560b634 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3159,18 +3159,17 @@ background_import_then_checkpoint () {
 		echo "progress checkpoint"
 	) >&8 &
 
-	error=0
-	if read output <&9
-	then
-		if ! test "$output" = "progress checkpoint"
+	error=1 ;# assume the worst
+	while read output <&9
+	do
+		if test "$output" = "progress checkpoint"
 		then
-			echo >&2 "no progress checkpoint received: $output"
-			error=1
+			error=0
+			break
 		fi
-	else
-		echo >&2 "failed to read fast-import output"
-		error=1
-	fi
+		# otherwise ignore cruft
+		echo >&2 "cruft: $output"
+	done
 
 	if test $error -eq 1
 	then
@@ -3186,6 +3185,17 @@ background_import_still_running () {
 	fi
 }
 
+test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra output' '
+	cat >input <<-INPUT_END &&
+	progress foo
+	progress bar
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input &&
+	background_import_still_running
+'
+
 test_expect_success PIPE 'V: checkpoint updates refs after reset' '
 	cat >input <<-\INPUT_END &&
 	reset refs/heads/V
-- 
2.14.2-820-gd7428e091c



