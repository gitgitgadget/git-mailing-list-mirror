From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] grep: don't segfault
Date: Mon, 18 Jan 2010 22:55:07 +0100
Message-ID: <871vhnhydg.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWzZD-0004VF-6W
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 22:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab0ARVzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 16:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069Ab0ARVzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 16:55:16 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:41482 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057Ab0ARVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 16:55:15 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C997B8180DC
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:55:10 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E2CD5818139
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:55:07 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 83B7A2133B; Mon, 18 Jan 2010 22:55:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137407>


Today, git grep -l '^	' failed with a segfault.
I tracked it down to a26345b6085340ebd61e156aa8154a80196bee0f.
Debugging it, I found that look_ahead calls regexec with a "bol"
argument pointing to a buffer that is not NUL-terminated.
Yet regexec requires the NUL-termination.  Without that, its
initial strlen will read beyond the end of the buffer.

    $ valgrind ./git grep -l '^  '
    Memcheck, a memory error detector
    Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
    Using Valgrind-3.5.0 and LibVEX; rerun with -h for copyright info
    Command: ./git grep -l ^

    Conditional jump or move depends on uninitialised value(s)
       at 0x4A06318: __GI_strlen (mc_replace_strmem.c:284)
       by 0x3AF00C04C4: regexec@@GLIBC_2.3.4 (regexec.c:243)
       by 0x496A0A: look_ahead (grep.c:644)
       by 0x496D24: grep_buffer_1 (grep.c:726)
       by 0x497161: grep_buffer (grep.c:852)
       by 0x432720: grep_file (builtin-grep.c:201)
       by 0x432854: grep_cache (builtin-grep.c:230)
       by 0x433F2F: cmd_grep (builtin-grep.c:621)
       by 0x40488D: run_builtin (git.c:257)
       by 0x404A28: handle_internal_command (git.c:401)
       by 0x404B1D: run_argv (git.c:443)
       by 0x404C9A: main (git.c:514)
    ...

That buffer is read by builtin-grep.c(grep_file) and here's the code.
You can see from the allocation of "sz + 1" and read of one less
that there is already room for the required trailing NUL byte:

	sz = xsize_t(st.st_size);
	i = open(filename, O_RDONLY);
	if (i < 0)
		goto err_ret;
	data = xmalloc(sz + 1);
	if (st.st_size != read_in_full(i, data, sz)) {
		error("'%s': short read %s", filename, strerror(errno));
		close(i);
		free(data);
		return 0;
	}
	close(i);
>>>     data[sz] = 0;    <======  added line
	if (opt->relative && opt->prefix_length)
		filename = quote_path_relative(filename, -1, &buf, opt->prefix);
	i = grep_buffer(opt, filename, data, sz);

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
This is relative to the head of git's next branch,
d7346b15ca5bda881f5abc37b0844e9b35c8cffc
I noticed the segfault by running the same command in
libvirt's git repository, but it's not consistently reproducible.

 builtin-grep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 4dd5aaf..da854fa 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -196,6 +196,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		return 0;
 	}
 	close(i);
+	data[sz] = 0;
 	if (opt->relative && opt->prefix_length)
 		filename = quote_path_relative(filename, -1, &buf, opt->prefix);
 	i = grep_buffer(opt, filename, data, sz);
--
1.6.4.4.1.ga2634
