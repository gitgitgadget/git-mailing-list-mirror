From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's happening with vr41xx_giu.c?
Date: Fri, 10 Jul 2009 09:20:22 -0700
Message-ID: <7vhbxkv7ax.fsf@alter.siamese.dyndns.org>
References: <4A5680B5.2090405@necel.com> <4A56B060.7090106@mips.com>
 <20090710104743.GB1288@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Dearman <chris@mips.com>,
	Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
	yuasa@linux-mips.org, linux-mips@linux-mips.org,
	git@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPIqB-0007Ir-9k
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 18:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbZGJQUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZGJQUg
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 12:20:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZGJQUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 12:20:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E70426D30;
	Fri, 10 Jul 2009 12:20:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0B1C26D2F; Fri,
 10 Jul 2009 12:20:25 -0400 (EDT)
In-Reply-To: <20090710104743.GB1288@linux-mips.org> (Ralf Baechle's message
 of "Fri\, 10 Jul 2009 11\:47\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98188F50-6D6D-11DE-8195-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123061>

Ralf Baechle <ralf@linux-mips.org> writes:

> 27fdd325dace4a1ebfa10e93ba6f3d25f25df674^ and apply Yoichi's patch using
> git am or git apply this will leave a zero byte drivers/char/vr41xx_giu.c.
> Patch(1) otoh will remove that file as expected.  The patch file Yoichi
> sent looks perfectly ok; here the headers of the vr41xx_giu.c bit:
>
> [...]
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/char/vr41xx_giu.c linux/drivers/char/vr41xx_giu.c
> --- linux-orig/drivers/char/vr41xx_giu.c        2009-06-29 10:06:58.329177629 +0900
> +++ linux/drivers/char/vr41xx_giu.c     1970-01-01 09:00:00.000000000 +0900
> @@ -1,680 +0,0 @@
> -/*

If you look for -E option in "man patch" and find that it says "causes
patch to remove output files that are empty after the patches have been
applied.", you will realize that your claim that "patch(1) otoh ... as
expected" does not match the reality for everybody.  It is true only if
you _are_ explicitly asking to remove such an empty file.

The recent diff specification (at least the one in POSIX.1) says that file
removal is marked by the UNIX epoch timestamp you see there, instead of a
more recent timestamp. IOW, you should _in theory_ be able to tell by
looking at the 1970-01-01 timestamp that the intention of this patch is
not to make the file empty, but is to remove.

But in practice, because traditionally GNU diff and other people's diff
placed pretty arbitrary garbage after the TAB that follows the filename,
patch does not rely on that convention to detect a removal patch.  Notice
that even -E option does not pay attention to that timestamp line, but
removes files that become _empty_.

Neither do we.  The patch application toolchain in "git" does not have -E
option and the above patch is interpreted just like traditional patch does
by default: the file goes empty.

The output from "git diff" is designed so that (1) it can distinguish the
removal case and the goes-empty case more clearly, and also that (2) it
can be safely used by patch(1).  A removal patch from git looks like:

    diff --git a/file b/file
    deleted file mode 100644
    index 363ef61..0000000
    --- a/file
    +++ /dev/null
    @@ -1 +0,0 @@
    -original contents

while "goes empty" patch looks like:

    diff --git a/file b/file
    index 363ef61..e69de29 100644
    --- a/file
    +++ b/file
    @@ -1 +0,0 @@
    -original contents

and when applied with git, they both produce "expected" results.

We _could_ add -E option to "git apply" and pass that through "git am" to
support projects like the kernel where 0-byte files are forbidden.  A
patch to do that shouldn't be too involved.
