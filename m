Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A94EED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 17:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjIORBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjIORAy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 13:00:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACE30E3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 10:00:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2F419F1E6;
        Fri, 15 Sep 2023 13:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=E5mP3Fyx6yEb5OFiVKVEZReaC7kE24wwZIMVod
        WkrKk=; b=BFzab3HOjEyZmgLKEblEnJ1AUitGjk79q4ARZwKQIiiEQcgAhO2mvL
        bmYYK5q90vt9SSZLhKsYw9Or1cLzLVsP3jlz/u4igo3yu4KClxw/VAl2Sl1HAHML
        1bpsodxYiAYV7DYjvFenTBxVkHVbhTyZpf8PjgaH2I+pAaTnGNWU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FBED19F1DF;
        Fri, 15 Sep 2023 13:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 971FF19F1D3;
        Fri, 15 Sep 2023 13:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
Subject: Re: BUG: git-gui no longer executes hook scripts
In-Reply-To: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com> (Mark Levedahl's
        message of "Fri, 15 Sep 2023 12:45:31 -0400")
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
Date:   Fri, 15 Sep 2023 10:00:02 -0700
Message-ID: <xmqqa5tngynh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 507FECAC-53E9-11EE-A962-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> The commit titled "Work around Tcl's default |PATH| lookup",|aae9560,
> adds checking on all commands to be executed to assure these are on
> the PATH.

commit aae9560a355d4ab91385e49eae62fade2ddd27ef
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Nov 23 09:31:06 2022 +0100

    Work around Tcl's default `PATH` lookup
    
    As per https://www.tcl.tk/man/tcl8.6/TclCmd/exec.html#M23, Tcl's `exec`
    function goes out of its way to imitate the highly dangerous path lookup
    of `cmd.exe`, but _of course_ only on Windows:
    
            If a directory name was not specified as part of the application
            name, the following directories are automatically searched in
            order when attempting to locate the application:

In other words, if somebody tries to run ".git/hooks/pre-commit",
because a directory name _is_ given (i.e. ".git/hooks/" in this case),
the path lookup is *not* done.  Which is what I would expect, and then
"oh, only on Windows to match what cmd.exe does, the current directory
is early in the search order" should not be a problem.

    To avoid that, Git GUI already has the `_which` function that does not
    imitate that dangerous practice when looking up executables in the
    search path.
    
Sounds good, but ...

diff --git a/git-gui.sh b/git-gui.sh
index b0eb5a6ae4..cb92bba1c4 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -121,6 +121,62 @@ proc _which {what args} {
 	return {}
 }
 
+proc sanitize_command_line {command_line from_index} {
+	set i $from_index
+	while {$i < [llength $command_line]} {
+		set cmd [lindex $command_line $i]
+		if {[file pathtype $cmd] ne "absolute"} {
+			set fullpath [_which $cmd]
+			if {$fullpath eq ""} {
+				throw {NOT-FOUND} "$cmd not found in PATH"
+			}
+			lset command_line $i $fullpath

Shouldn't this "is it absolute" check with "$cmd" also check if $cmd
has either forward or backward slash in it?  I do not know about the
Windows cmd.exe convention, but with Unix background, I would be
surprised if dir/cmd gave by end users ran "C:\program
files\dir\cmd" (unless I happened to be in the "C:\program files\"
folder, that is).

Checking the use of _which with fixed arguments, it is used to spawn
git, gitk, nice, sh; and _which finding where they appear on the
search path does sound sane.  But _which does not seem to have the "if
given a command with directory separator, the search path does not
matter.  The caller means it is relative to the $cwd" logic at all,
so it seems it is the callers responsibility to make sure it does
not pass things like ".git/hooks/pre-commit" to it.

+		}
+
+		# handle piped commands, e.g. `exec A | B`
+		for {incr i} {$i < [llength $command_line]} {incr i} {
+			if {[lindex $command_line $i] eq "|"} {
+				incr i
+				break
+			}
+		}
+	}
+	return $command_line
+}
+
+# Override `exec` to avoid unsafe PATH lookup
+
+rename exec real_exec
+
+proc exec {args} {
+	# skip options
+	for {set i 0} {$i < [llength $args]} {incr i} {
+		set arg [lindex $args $i]
+		if {$arg eq "--"} {
+			incr i
+			break
+		}
+		if {[string range $arg 0 0] ne "-"} {
+			break
+		}
+	}
+	set args [sanitize_command_line $args $i]
+	uplevel 1 real_exec $args
+}
+
+# Override `open` to avoid unsafe PATH lookup
+
+rename open real_open
+
+proc open {args} {
+	set arg0 [lindex $args 0]
+	if {[string range $arg0 0 0] eq "|"} {
+		set command_line [string trim [string range $arg0 1 end]]
+		lset args 0 "| [sanitize_command_line $command_line 0]"
+	}
+	uplevel 1 real_open $args
+}
+
 ######################################################################
 ##
 ## locate our library
