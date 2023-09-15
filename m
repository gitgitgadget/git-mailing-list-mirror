Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA16EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjIORPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjIORP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:15:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59DE7F
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:15:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3F732C873;
        Fri, 15 Sep 2023 13:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fuLh6hgSkRvpQ7vCJ3JpOhb7hvNMNexoy/YUU4
        Ym0tk=; b=h4kXYw0R2mdWrwSYgheQmCRqmkx1U/mkcmPXxhQkuo50CHjOZKaUgN
        lxFbcwXObYm4C4F1r5PN8gduZa/ka+T6iW3pLePOMF1AUX4W2nHrVxTjW8P4tg8V
        KHZpeWv6D3uDuoBtWthouaGRbW+PE7NnZ54jT7d3kzI1EhETCI1qo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBAE72C872;
        Fri, 15 Sep 2023 13:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C85D2C871;
        Fri, 15 Sep 2023 13:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
Subject: Re: BUG: git-gui no longer executes hook scripts
In-Reply-To: <xmqqa5tngynh.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Sep 2023 10:00:02 -0700")
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
        <xmqqa5tngynh.fsf@gitster.g>
Date:   Fri, 15 Sep 2023 10:15:18 -0700
Message-ID: <xmqq5y4bgxy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7262D99A-53EB-11EE-AB8D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shouldn't this "is it absolute" check with "$cmd" also check if $cmd
> has either forward or backward slash in it?
>
> Checking the use of _which with fixed arguments, it is used to spawn
> git, gitk, nice, sh; and _which finding where they appear on the
> search path does sound sane.  But _which does not seem to have the "if
> given a command with directory separator, the search path does not
> matter.  The caller means it is relative to the $cwd" logic at all,
> so it seems it is the callers responsibility to make sure it does
> not pass things like ".git/hooks/pre-commit" to it.

In other words, something along this line may go in the right
direction (I no longer speak Tcl, and this is done with manual in
one hand, while typing with the other hand).

 git-gui.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git c/git-gui.sh w/git-gui.sh
index 8bc8892c40..45d8f48b39 100755
--- c/git-gui/git-gui.sh
+++ w/git-gui/git-gui.sh
@@ -119,11 +119,15 @@ proc sanitize_command_line {command_line from_index} {
 	while {$i < [llength $command_line]} {
 		set cmd [lindex $command_line $i]
 		if {[file pathtype $cmd] ne "absolute"} {
-			set fullpath [_which $cmd]
-			if {$fullpath eq ""} {
-				throw {NOT-FOUND} "$cmd not found in PATH"
+			if {1 < [llength [file split $cmd]]]} {
+			    set cmdpath [_which $cmd]
+			    if {$cmdpath eq ""} {
+				    throw {NOT-FOUND} "$cmd not found in PATH"
+			    }
+			} else {
+				set cmdpath $cmd
 			}
-			lset command_line $i $fullpath
+			lset command_line $i $cmdpath
 		}
 
 		# handle piped commands, e.g. `exec A | B`
