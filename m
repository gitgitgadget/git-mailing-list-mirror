From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Mon, 21 Jan 2008 00:32:50 -0800
Message-ID: <7v8x2j1sul.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
	<7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
	<7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
	<7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
	<7vhch71vvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:33:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGs6C-0000lq-Le
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106AbYAUIdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 03:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758083AbYAUIdN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:33:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038AbYAUIdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 03:33:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CC64B3D39;
	Mon, 21 Jan 2008 03:33:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E8C1C3D36;
	Mon, 21 Jan 2008 03:32:58 -0500 (EST)
In-Reply-To: <7vhch71vvb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Jan 2008 23:27:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71241>

--=-=-=

An update, with three attachments (sorry), but not final
resolution yet (sorry again) and I am going to bed.

t7501-commit-2.sh is a very reduced test script.  Drop it in t/
and run it like:

 $ while :; do sh ./t7501-commit-2.sh -i -v || break; done

I stops after running for a while with "Updated in-memory index
cleanup" patch (and does not seem to stop without).  Note that
this is before any of the lstat(2) reduction changes.

The attached "trace.log.old" is strace output from the round that
ran successfully, and "trace.log" is the same from the round
that failed.

The real place the logs start diverging is around line 240, the
good one runs two lstat(2) on "elif", opens "elif" in O_RDONLY
and closes it immediately (eh, what is it doing?  I do not even
see any read or mmap --- it is just open and close) and then
reads the config and attributes (presumably this is doing the
convert-to-git stuff).  The bad one runs three lstat(2) on it
and writes the next-index out, without even opening "elif".


--=-=-=
Content-Disposition: inline; filename=t7501-commit-2.sh
Content-Description: Reduced 7501 test

#!/bin/sh

test_description='reduced 7501'

. ./test-lib.sh

test_expect_success setup '

	>file &&
	git add file &&
	test_tick &&
	git commit -m initial

'

if test -f ../trace.log
then
	mv ../trace.log ../trace.log.old
fi

test_expect_success 'partial commit that involves removal (1)' '

	test_tick &&
	git rm --cached file &&
	mv file elif &&
	git add elif &&

	strace -f -o ../trace.log git commit -m "Partial: add elif" elif &&

	git diff-tree --name-status HEAD^ HEAD >current &&
	echo "A	elif" >expected &&
	diff expected current

'

test_done

--=-=-=
Content-Disposition: inline; filename=trace.log.old
Content-Description: strace output from a good run

10888 execve("/opt/packrat/playpen/public/in-place/git/git.junio/t/../git", ["git", "commit", "-m", "Partial: add elif", "elif"], [/* 51 vars */]) = 0
10888 brk(0)                            = 0x6f7000
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998c000
10888 uname({sys="Linux", node="gitster", ...}) = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998d000
10888 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
10888 open("/etc/ld.so.cache", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10888 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libcurl.so.3", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`m\0\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=227856, ...}) = 0
10888 mmap(NULL, 1275080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b06499a1000
10888 mprotect(0x2b06499d7000, 1048576, PROT_NONE) = 0
10888 mmap(0x2b0649ad7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x36000) = 0x2b0649ad7000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libz.so.1", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@!\0\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=93504, ...}) = 0
10888 mmap(NULL, 2188616, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b0649b8d000
10888 mprotect(0x2b0649ba3000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b0649da3000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x16000) = 0x2b0649da3000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libcrypto.so.0.9.8", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\364"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=1510344, ...}) = 0
10888 mmap(NULL, 2571832, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b0649da4000
10888 mprotect(0x2b0649ef2000, 1048576, PROT_NONE) = 0
10888 mmap(0x2b0649ff2000, 143360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x14e000) = 0x2b0649ff2000
10888 mmap(0x2b064a015000, 11832, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b064a015000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libc.so.6", O_RDONLY)  = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\334\1\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0755, st_size=1391928, ...}) = 0
10888 mmap(NULL, 3498360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064a018000
10888 mprotect(0x2b064a165000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064a365000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x14d000) = 0x2b064a365000
10888 mmap(0x2b064a36a000, 16760, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b064a36a000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libgssapi_krb5.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20e\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=173640, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064a36f000
10888 mmap(NULL, 2269136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064a370000
10888 mprotect(0x2b064a399000, 2093056, PROT_NONE) = 0
10888 mmap(0x2b064a598000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x28000) = 0x2b064a598000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libkrb5.so.3", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300\221"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=635688, ...}) = 0
10888 mmap(NULL, 2730976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064a59a000
10888 mprotect(0x2b064a631000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064a831000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x97000) = 0x2b064a831000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libk5crypto.so.3", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320X\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=150656, ...}) = 0
10888 mmap(NULL, 2246952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064a835000
10888 mprotect(0x2b064a858000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064aa58000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x23000) = 0x2b064aa58000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libcom_err.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\f\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=7984, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064aa5a000
10888 mmap(NULL, 1054920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064aa5b000
10888 mprotect(0x2b064aa5d000, 1044480, PROT_NONE) = 0
10888 mmap(0x2b064ab5c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x1000) = 0x2b064ab5c000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libkrb5support.so.0", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\35\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=30408, ...}) = 0
10888 mmap(NULL, 2125648, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064ab5d000
10888 mprotect(0x2b064ab64000, 2093056, PROT_NONE) = 0
10888 mmap(0x2b064ad63000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x6000) = 0x2b064ad63000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libresolv.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0003\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=76664, ...}) = 0
10888 mmap(NULL, 2181896, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064ad64000
10888 mprotect(0x2b064ad75000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064af75000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x11000) = 0x2b064af75000
10888 mmap(0x2b064af77000, 6920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b064af77000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libidn.so.11", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340/\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=202368, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064af79000
10888 mmap(NULL, 1249152, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064af7a000
10888 mprotect(0x2b064afab000, 1044480, PROT_NONE) = 0
10888 mmap(0x2b064b0aa000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x30000) = 0x2b064b0aa000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libdl.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 \16\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=14624, ...}) = 0
10888 mmap(NULL, 2109728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b0ab000
10888 mprotect(0x2b064b0ad000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064b2ad000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x2000) = 0x2b064b2ad000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/usr/lib/libssl.so.0.9.8", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\31\1"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=291816, ...}) = 0
10888 mmap(NULL, 1338608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b2af000
10888 mprotect(0x2b064b2f0000, 1048576, PROT_NONE) = 0
10888 mmap(0x2b064b3f0000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x41000) = 0x2b064b3f0000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libkeyutils.so.1", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\v\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=7304, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064b3f6000
10888 mmap(NULL, 1054160, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b3f7000
10888 mprotect(0x2b064b3f9000, 1044480, PROT_NONE) = 0
10888 mmap(0x2b064b4f8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x1000) = 0x2b064b4f8000
10888 close(6)                          = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064b4f9000
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064b4fa000
10888 arch_prctl(ARCH_SET_FS, 0x2b064b4f9f10) = 0
10888 mprotect(0x2b064a365000, 12288, PROT_READ) = 0
10888 munmap(0x2b064998f000, 70263)     = 0
10888 brk(0)                            = 0x6f7000
10888 brk(0x718000)                     = 0x718000
10888 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", 4096) = 59
10888 access(".git/objects", X_OK)      = 0
10888 access(".git/refs", X_OK)         = 0
10888 lstat(".git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open(".git/HEAD", O_RDONLY)       = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 open(".git/config", O_RDONLY)     = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 stat(".git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", 1024) = 59
10888 chdir(".git")                     = 0
10888 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", 4096) = 64
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 chdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash") = 0
10888 chdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash") = 0
10888 open(".git/config", O_RDONLY)     = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10888 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(6, "", 214)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/packed-refs", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/MERGE_HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/MERGE_HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/MERGE_HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/MERGE_HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/MERGE_HEAD/HEAD", 0x7fff611379c0) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=104, ...}) = 0
10888 mmap(NULL, 104, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 104)       = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD", 0x7fff61137b30) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10888 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(6, "", 214)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff611378f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff611378f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff611378f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff611378f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff611378f0) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/pack", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 6
10888 fstat(6, {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10888 getdents(6, /* 2 entries */, 4096) = 48
10888 getdents(6, /* 0 entries */, 4096) = 0
10888 close(6)                          = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/info/alternates", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 136)       = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/info/grafts", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/shallow", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 brk(0x739000)                     = 0x739000
10888 brk(0x736000)                     = 0x736000
10888 munmap(0x2b064998f000, 49)        = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=104, ...}) = 0
10888 mmap(NULL, 104, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 104)       = 0
10888 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", 0x7fff61136b90, 4096) = -1 EINVAL (Invalid argument)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10888 rt_sigaction(SIGINT, {0x44bc70, [INT], SA_RESTORER|SA_RESTART, 0x2b064a0496a0}, {SIG_DFL}, 8) = 0
10888 getpid()                          = 10888
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 open(".git/config", O_RDONLY)     = 7
10888 fstat(7, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(7, "[core]\n\trepositoryformatversion "..., 4096) = 92
10888 read(7, "", 4096)                 = 0
10888 close(7)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 open(".gitattributes", O_RDONLY)  = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/info/attributes", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391", {st_mode=S_IFREG|0444, st_size=15, ...}) = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 write(6, "DIRC\0\0\0\2\0\0\0\1G\224S\266\0\0\0\0G\224S\266\0\0\0"..., 104) = 104
10888 close(6)                          = 0
10888 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10888", 0x7fff61136b90, 4096) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10888.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 7
10888 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 7, 0) = 0x2b064998f000
10888 close(7)                          = 0
10888 munmap(0x2b064998f000, 136)       = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391", {st_mode=S_IFREG|0444, st_size=15, ...}) = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 lstat("file", 0x7fff61137a80)     = -1 ENOENT (No such file or directory)
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 7
10888 close(7)                          = 0
10888 write(6, "DIRC\0\0\0\2\0\0\0\2G\224S\266\0\0\0\0G\224S\266\0\0\0"..., 176) = 176
10888 close(6)                          = 0
10888 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/pre-commit", X_OK) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/COMMIT_EDITMSG", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 write(6, "Partial: add elif\n", 18) = 18
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10888 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(6, "", 214)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff611376a0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff611376a0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff611376a0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff611376a0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff611376a0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10888 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(6, "", 214)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff611375f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff611375f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff611375f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff611375f0) = -1 ENOENT (No such file or directory)
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff611375f0) = -1 ENOENT (No such file or directory)
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 136)       = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 136)       = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10888.lock", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=176, ...}) = 0
10888 mmap(NULL, 176, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 176)       = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391", {st_mode=S_IFREG|0444, st_size=15, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391", {st_mode=S_IFREG|0444, st_size=15, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125", 0x7fff611379b0) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 gettimeofday({1200903094, 936786}, NULL) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_p1kDCU", O_RDWR|O_CREAT|O_EXCL, 0600) = 6
10888 brk(0x75a000)                     = 0x75a000
10888 brk(0x74a000)                     = 0x74a000
10888 brk(0x73a000)                     = 0x73a000
10888 brk(0x738000)                     = 0x738000
10888 write(6, "x\1+)JMU03a040031QH\315\311Lcx6\367\321\354M\27\2579{"..., 57) = 57
10888 fchmod(6, 0444)                   = 0
10888 close(6)                          = 0
10888 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_p1kDCU", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125") = -1 ENOENT (No such file or directory)
10888 mkdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7", 0777) = 0
10888 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_p1kDCU", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125") = 0
10888 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_p1kDCU") = 0
10888 brk(0x736000)                     = 0x736000
10888 getuid()                          = 1012
10888 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10888 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10888 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10888 close(6)                          = 0
10888 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10888 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10888 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10888 close(6)                          = 0
10888 open("/etc/nsswitch.conf", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 open("/etc/ld.so.cache", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10888 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libnss_compat.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\23\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=35632, ...}) = 0
10888 mmap(NULL, 2131176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b4fb000
10888 mprotect(0x2b064b502000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064b702000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x7000) = 0x2b064b702000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libnsl.so.1", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0A\0\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=93088, ...}) = 0
10888 mmap(NULL, 2198224, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b704000
10888 mprotect(0x2b064b719000, 2097152, PROT_NONE) = 0
10888 mmap(0x2b064b919000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x15000) = 0x2b064b919000
10888 mmap(0x2b064b91b000, 6864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b064b91b000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 70263)     = 0
10888 open("/etc/ld.so.cache", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10888 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b064998f000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libnss_nis.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000 \0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=43480, ...}) = 0
10888 mmap(NULL, 2139352, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064b91d000
10888 mprotect(0x2b064b927000, 2093056, PROT_NONE) = 0
10888 mmap(0x2b064bb26000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x9000) = 0x2b064bb26000
10888 close(6)                          = 0
10888 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10888 open("/lib/libnss_files.so.2", O_RDONLY) = 6
10888 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P \0\0\0"..., 832) = 832
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=43448, ...}) = 0
10888 mmap(NULL, 2139464, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2b064bb28000
10888 mprotect(0x2b064bb32000, 2093056, PROT_NONE) = 0
10888 mmap(0x2b064bd31000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x9000) = 0x2b064bd31000
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 70263)     = 0
10888 open("/etc/passwd", O_RDONLY)     = 6
10888 fcntl(6, F_GETFD)                 = 0
10888 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10888 lseek(6, 0, SEEK_CUR)             = 0
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=1663, ...}) = 0
10888 mmap(NULL, 1663, PROT_READ, MAP_SHARED, 6, 0) = 0x2b064998f000
10888 lseek(6, 1663, SEEK_SET)          = 1663
10888 munmap(0x2b064998f000, 1663)      = 0
10888 close(6)                          = 0
10888 uname({sys="Linux", node="gitster", ...}) = 0
10888 open("/etc/resolv.conf", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "search pv.oc.cox.net\nnameserver "..., 4096) = 44
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 stat("/etc/resolv.conf", {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10888 open("/etc/resolv.conf", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "search pv.oc.cox.net\nnameserver "..., 4096) = 44
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10888 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10888 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10888 close(6)                          = 0
10888 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10888 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10888 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10888 close(6)                          = 0
10888 open("/etc/host.conf", O_RDONLY)  = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=9, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "multi on\n", 4096)       = 9
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 open("/etc/hosts", O_RDONLY)      = 6
10888 fcntl(6, F_GETFD)                 = 0
10888 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=570, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "127.0.0.1\tlocalhost\n#127.0.1.1\tg"..., 4096) = 570
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 gettimeofday({1200903094, 941441}, NULL) = 0
10888 open("/usr/share/zoneinfo/UTC", O_RDONLY) = 6
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
10888 fstat(6, {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0"..., 4096) = 118
10888 lseek(6, -62, SEEK_CUR)           = 56
10888 read(6, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0"..., 4096) = 62
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/commit-msg", X_OK) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/COMMIT_EDITMSG", O_RDONLY) = 6
10888 read(6, "Partial: add elif\n", 8192) = 18
10888 read(6, "", 12400)                = 0
10888 close(6)                          = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", 0x7fff61137ad0) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", O_RDONLY) = -1 ENOENT (No such file or directory)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_BZH0dB", O_RDWR|O_CREAT|O_EXCL, 0600) = 6
10888 brk(0x75c000)                     = 0x75c000
10888 brk(0x74c000)                     = 0x74c000
10888 brk(0x73c000)                     = 0x73c000
10888 brk(0x73b000)                     = 0x73b000
10888 write(6, "x\1\205\316A\212\0021\20\205a\3279E]@\251\252$v\"2\214"..., 174) = 174
10888 fchmod(6, 0444)                   = 0
10888 close(6)                          = 0
10888 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_BZH0dB", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330") = -1 ENOENT (No such file or directory)
10888 mkdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1", 0777) = 0
10888 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_BZH0dB", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330") = 0
10888 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_BZH0dB") = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10888 read(6, "ref: refs/heads/master\n", 255) = 23
10888 read(6, "", 232)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10888 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(6, "", 214)                  = 0
10888 close(6)                          = 0
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", 0x7fff61136b70, 4096) = -1 EINVAL (Invalid argument)
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10888 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 7
10888 read(7, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10888 read(7, "", 214)                  = 0
10888 close(7)                          = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", {st_mode=S_IFREG|0444, st_size=174, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", O_RDONLY|O_NOATIME) = 7
10888 mmap(NULL, 174, PROT_READ, MAP_PRIVATE, 7, 0) = 0x2b064998f000
10888 close(7)                          = 0
10888 munmap(0x2b064998f000, 174)       = 0
10888 write(6, "c17ca051cb2649d9f7bed8021db2cfc0"..., 40) = 40
10888 write(6, "\n", 1)                 = 1
10888 close(6)                          = 0
10888 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs/heads", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs/heads/master", O_WRONLY|O_APPEND|O_CREAT, 0666) = 6
10888 write(6, "1bd44cb9d13204b0fe1958db0082f502"..., 160) = 160
10888 close(6)                          = 0
10888 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/HEAD", O_WRONLY|O_APPEND|O_CREAT, 0666) = 6
10888 write(6, "1bd44cb9d13204b0fe1958db0082f502"..., 160) = 160
10888 close(6)                          = 0
10888 rename("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master.lock", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master") = 0
10888 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD") = -1 ENOENT (No such file or directory)
10888 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_MSG") = -1 ENOENT (No such file or directory)
10888 rename("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index.lock", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index") = 0
10888 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10888.lock") = 0
10888 open(".git/config", O_RDONLY)     = 6
10888 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10888 read(6, "", 4096)                 = 0
10888 close(6)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/rr-cache", 0x7fff61137b90) = -1 ENOENT (No such file or directory)
10888 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/post-commit", X_OK) = -1 ENOENT (No such file or directory)
10888 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10888 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b064998f000
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b0649990000
10888 close(6)                          = 0
10888 munmap(0x2b0649990000, 136)       = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b0649990000
10888 close(6)                          = 0
10888 munmap(0x2b0649990000, 49)        = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", {st_mode=S_IFREG|0444, st_size=174, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/7ca051cb2649d9f7bed8021db2cfc08eb9b330", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 174, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b0649990000
10888 close(6)                          = 0
10888 munmap(0x2b0649990000, 174)       = 0
10888 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125", {st_mode=S_IFREG|0444, st_size=57, ...}) = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/a7/3843106991cb043bd823dd0bf7c821354cc125", O_RDONLY|O_NOATIME) = 6
10888 mmap(NULL, 57, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2b0649990000
10888 close(6)                          = 0
10888 munmap(0x2b0649990000, 57)        = 0
10888 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/c1/", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 6
10888 fstat(6, {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10888 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10888 getdents(6, /* 3 entries */, 4096) = 112
10888 getdents(6, /* 0 entries */, 4096) = 0
10888 close(6)                          = 0
10888 write(1, "Created commit c17ca05: Partial:"..., 42) = 42
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 open("elif", O_RDONLY)            = 6
10888 close(6)                          = 0
10888 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10888 write(1, " 0 files changed, 0 insertions(+"..., 50) = 50
10888 write(1, " create mode 100644 elif\n", 25) = 25
10888 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10888 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10888 close(1)                          = 0
10888 munmap(0x2b064998f000, 4096)      = 0
10888 exit_group(0)                     = ?

--=-=-=
Content-Disposition: inline; filename=trace.log
Content-Description: strace output from a bad run

10922 execve("/opt/packrat/playpen/public/in-place/git/git.junio/t/../git", ["git", "commit", "-m", "Partial: add elif", "elif"], [/* 51 vars */]) = 0
10922 brk(0)                            = 0x6f7000
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02877e000
10922 uname({sys="Linux", node="gitster", ...}) = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02877f000
10922 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
10922 open("/etc/ld.so.cache", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10922 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libcurl.so.3", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`m\0\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=227856, ...}) = 0
10922 mmap(NULL, 1275080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac028793000
10922 mprotect(0x2ac0287c9000, 1048576, PROT_NONE) = 0
10922 mmap(0x2ac0288c9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x36000) = 0x2ac0288c9000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libz.so.1", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@!\0\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=93504, ...}) = 0
10922 mmap(NULL, 2188616, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02897f000
10922 mprotect(0x2ac028995000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac028b95000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x16000) = 0x2ac028b95000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libcrypto.so.0.9.8", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\364"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=1510344, ...}) = 0
10922 mmap(NULL, 2571832, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac028b96000
10922 mprotect(0x2ac028ce4000, 1048576, PROT_NONE) = 0
10922 mmap(0x2ac028de4000, 143360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x14e000) = 0x2ac028de4000
10922 mmap(0x2ac028e07000, 11832, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ac028e07000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libc.so.6", O_RDONLY)  = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\334\1\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0755, st_size=1391928, ...}) = 0
10922 mmap(NULL, 3498360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac028e0a000
10922 mprotect(0x2ac028f57000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac029157000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x14d000) = 0x2ac029157000
10922 mmap(0x2ac02915c000, 16760, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ac02915c000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libgssapi_krb5.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20e\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=173640, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac029161000
10922 mmap(NULL, 2269136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac029162000
10922 mprotect(0x2ac02918b000, 2093056, PROT_NONE) = 0
10922 mmap(0x2ac02938a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x28000) = 0x2ac02938a000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libkrb5.so.3", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300\221"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=635688, ...}) = 0
10922 mmap(NULL, 2730976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02938c000
10922 mprotect(0x2ac029423000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac029623000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x97000) = 0x2ac029623000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libk5crypto.so.3", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320X\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=150656, ...}) = 0
10922 mmap(NULL, 2246952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac029627000
10922 mprotect(0x2ac02964a000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac02984a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x23000) = 0x2ac02984a000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libcom_err.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\f\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=7984, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02984c000
10922 mmap(NULL, 1054920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02984d000
10922 mprotect(0x2ac02984f000, 1044480, PROT_NONE) = 0
10922 mmap(0x2ac02994e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x1000) = 0x2ac02994e000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libkrb5support.so.0", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\35\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=30408, ...}) = 0
10922 mmap(NULL, 2125648, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02994f000
10922 mprotect(0x2ac029956000, 2093056, PROT_NONE) = 0
10922 mmap(0x2ac029b55000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x6000) = 0x2ac029b55000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libresolv.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0003\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=76664, ...}) = 0
10922 mmap(NULL, 2181896, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac029b56000
10922 mprotect(0x2ac029b67000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac029d67000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x11000) = 0x2ac029d67000
10922 mmap(0x2ac029d69000, 6920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ac029d69000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libidn.so.11", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340/\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=202368, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac029d6b000
10922 mmap(NULL, 1249152, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac029d6c000
10922 mprotect(0x2ac029d9d000, 1044480, PROT_NONE) = 0
10922 mmap(0x2ac029e9c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x30000) = 0x2ac029e9c000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libdl.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 \16\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=14624, ...}) = 0
10922 mmap(NULL, 2109728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac029e9d000
10922 mprotect(0x2ac029e9f000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac02a09f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x2000) = 0x2ac02a09f000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/usr/lib/libssl.so.0.9.8", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\31\1"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=291816, ...}) = 0
10922 mmap(NULL, 1338608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a0a1000
10922 mprotect(0x2ac02a0e2000, 1048576, PROT_NONE) = 0
10922 mmap(0x2ac02a1e2000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x41000) = 0x2ac02a1e2000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libkeyutils.so.1", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\v\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=7304, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02a1e8000
10922 mmap(NULL, 1054160, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a1e9000
10922 mprotect(0x2ac02a1eb000, 1044480, PROT_NONE) = 0
10922 mmap(0x2ac02a2ea000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x1000) = 0x2ac02a2ea000
10922 close(6)                          = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02a2eb000
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac02a2ec000
10922 arch_prctl(ARCH_SET_FS, 0x2ac02a2ebf10) = 0
10922 mprotect(0x2ac029157000, 12288, PROT_READ) = 0
10922 munmap(0x2ac028781000, 70263)     = 0
10922 brk(0)                            = 0x6f7000
10922 brk(0x718000)                     = 0x718000
10922 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", 4096) = 59
10922 access(".git/objects", X_OK)      = 0
10922 access(".git/refs", X_OK)         = 0
10922 lstat(".git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open(".git/HEAD", O_RDONLY)       = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 open(".git/config", O_RDONLY)     = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 stat(".git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", 1024) = 59
10922 chdir(".git")                     = 0
10922 getcwd("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", 4096) = 64
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 chdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash") = 0
10922 chdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash") = 0
10922 open(".git/config", O_RDONLY)     = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10922 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(6, "", 214)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/packed-refs", O_RDONLY) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/MERGE_HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/MERGE_HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/MERGE_HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/MERGE_HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/MERGE_HEAD/HEAD", 0x7fff82343bd0) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=104, ...}) = 0
10922 mmap(NULL, 104, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 104)       = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD", 0x7fff82343d40) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10922 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(6, "", 214)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff82343b00) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff82343b00) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff82343b00) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff82343b00) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff82343b00) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/pack", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 6
10922 fstat(6, {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10922 getdents(6, /* 2 entries */, 4096) = 48
10922 getdents(6, /* 0 entries */, 4096) = 0
10922 close(6)                          = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/info/alternates", O_RDONLY) = -1 ENOENT (No such file or directory)
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 136)       = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/info/grafts", O_RDONLY) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/shallow", O_RDONLY) = -1 ENOENT (No such file or directory)
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 brk(0x739000)                     = 0x739000
10922 brk(0x736000)                     = 0x736000
10922 munmap(0x2ac028781000, 49)        = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=104, ...}) = 0
10922 mmap(NULL, 104, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 104)       = 0
10922 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index", 0x7fff82342da0, 4096) = -1 EINVAL (Invalid argument)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10922 rt_sigaction(SIGINT, {0x44bc70, [INT], SA_RESTORER|SA_RESTART, 0x2ac028e3b6a0}, {SIG_DFL}, 8) = 0
10922 getpid()                          = 10922
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 write(6, "DIRC\0\0\0\2\0\0\0\1G\224S\267\0\0\0\0G\224S\266\0\0\0"..., 104) = 104
10922 close(6)                          = 0
10922 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10922", 0x7fff82342da0, 4096) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10922.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 7
10922 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 7, 0) = 0x2ac028781000
10922 close(7)                          = 0
10922 munmap(0x2ac028781000, 136)       = 0
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 lstat("elif", {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 lstat("file", 0x7fff82343c90)     = -1 ENOENT (No such file or directory)
10922 write(6, "DIRC\0\0\0\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 104) = 104
10922 close(6)                          = 0
10922 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/pre-commit", X_OK) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/COMMIT_EDITMSG", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 write(6, "Partial: add elif\n", 18) = 18
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10922 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(6, "", 214)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff823438b0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff823438b0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff823438b0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff823438b0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff823438b0) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10922 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(6, "", 214)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/HEAD", 0x7fff82343800) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/tags/HEAD", 0x7fff82343800) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/HEAD", 0x7fff82343800) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD", 0x7fff82343800) = -1 ENOENT (No such file or directory)
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/remotes/HEAD/HEAD", 0x7fff82343800) = -1 ENOENT (No such file or directory)
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 136)       = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 136)       = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10922.lock", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=104, ...}) = 0
10922 mmap(NULL, 104, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 104)       = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391", {st_mode=S_IFREG|0444, st_size=15, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10922 getuid()                          = 1012
10922 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10922 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10922 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10922 close(6)                          = 0
10922 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10922 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10922 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10922 close(6)                          = 0
10922 open("/etc/nsswitch.conf", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 open("/etc/ld.so.cache", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10922 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libnss_compat.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\23\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=35632, ...}) = 0
10922 mmap(NULL, 2131176, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a2ed000
10922 mprotect(0x2ac02a2f4000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac02a4f4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x7000) = 0x2ac02a4f4000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libnsl.so.1", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0A\0\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=93088, ...}) = 0
10922 mmap(NULL, 2198224, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a4f6000
10922 mprotect(0x2ac02a50b000, 2097152, PROT_NONE) = 0
10922 mmap(0x2ac02a70b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x15000) = 0x2ac02a70b000
10922 mmap(0x2ac02a70d000, 6864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ac02a70d000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 70263)     = 0
10922 open("/etc/ld.so.cache", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=70263, ...}) = 0
10922 mmap(NULL, 70263, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028781000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libnss_nis.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000 \0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=43480, ...}) = 0
10922 mmap(NULL, 2139352, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a70f000
10922 mprotect(0x2ac02a719000, 2093056, PROT_NONE) = 0
10922 mmap(0x2ac02a918000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x9000) = 0x2ac02a918000
10922 close(6)                          = 0
10922 access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
10922 open("/lib/libnss_files.so.2", O_RDONLY) = 6
10922 read(6, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P \0\0\0"..., 832) = 832
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=43448, ...}) = 0
10922 mmap(NULL, 2139464, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0x2ac02a91a000
10922 mprotect(0x2ac02a924000, 2093056, PROT_NONE) = 0
10922 mmap(0x2ac02ab23000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x9000) = 0x2ac02ab23000
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 70263)     = 0
10922 open("/etc/passwd", O_RDONLY)     = 6
10922 fcntl(6, F_GETFD)                 = 0
10922 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10922 lseek(6, 0, SEEK_CUR)             = 0
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=1663, ...}) = 0
10922 mmap(NULL, 1663, PROT_READ, MAP_SHARED, 6, 0) = 0x2ac028781000
10922 lseek(6, 1663, SEEK_SET)          = 1663
10922 munmap(0x2ac028781000, 1663)      = 0
10922 close(6)                          = 0
10922 uname({sys="Linux", node="gitster", ...}) = 0
10922 open("/etc/resolv.conf", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "search pv.oc.cox.net\nnameserver "..., 4096) = 44
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 stat("/etc/resolv.conf", {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10922 open("/etc/resolv.conf", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "search pv.oc.cox.net\nnameserver "..., 4096) = 44
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10922 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10922 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10922 close(6)                          = 0
10922 socket(PF_FILE, SOCK_STREAM, 0)   = 6
10922 fcntl(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
10922 connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
10922 close(6)                          = 0
10922 open("/etc/host.conf", O_RDONLY)  = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=9, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "multi on\n", 4096)       = 9
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 open("/etc/hosts", O_RDONLY)      = 6
10922 fcntl(6, F_GETFD)                 = 0
10922 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=570, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "127.0.0.1\tlocalhost\n#127.0.1.1\tg"..., 4096) = 570
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 gettimeofday({1200903095, 36084}, NULL) = 0
10922 open("/usr/share/zoneinfo/UTC", O_RDONLY) = 6
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
10922 fstat(6, {st_mode=S_IFREG|0644, st_size=118, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0"..., 4096) = 118
10922 lseek(6, -62, SEEK_CUR)           = 56
10922 read(6, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0"..., 4096) = 62
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/commit-msg", X_OK) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/COMMIT_EDITMSG", O_RDONLY) = 6
10922 read(6, "Partial: add elif\n", 8192) = 18
10922 read(6, "", 12400)                = 0
10922 close(6)                          = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", 0x7fff82343ce0) = -1 ENOENT (No such file or directory)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", O_RDONLY) = -1 ENOENT (No such file or directory)
10922 gettimeofday({1200903095, 36797}, NULL) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_bX9DDU", O_RDWR|O_CREAT|O_EXCL, 0600) = 6
10922 brk(0x75c000)                     = 0x75c000
10922 brk(0x74c000)                     = 0x74c000
10922 brk(0x73c000)                     = 0x73c000
10922 brk(0x73b000)                     = 0x73b000
10922 write(6, "x\1\205\316Aj\0031\f\205\341\254}\n]\240A\322\330\31;\204"..., 176) = 176
10922 fchmod(6, 0444)                   = 0
10922 close(6)                          = 0
10922 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_bX9DDU", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714") = -1 ENOENT (No such file or directory)
10922 mkdir("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94", 0777) = 0
10922 link("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_bX9DDU", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714") = 0
10922 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/tmp_obj_bX9DDU") = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", {st_mode=S_IFREG|0664, st_size=23, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/HEAD", O_RDONLY) = 6
10922 read(6, "ref: refs/heads/master\n", 255) = 23
10922 read(6, "", 232)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 6
10922 read(6, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(6, "", 214)                  = 0
10922 close(6)                          = 0
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 readlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", 0x7fff82342d80, 4096) = -1 EINVAL (Invalid argument)
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master.lock", O_RDWR|O_CREAT|O_EXCL, 0666) = 6
10922 lstat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", {st_mode=S_IFREG|0664, st_size=41, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master", O_RDONLY) = 7
10922 read(7, "1bd44cb9d13204b0fe1958db0082f502"..., 255) = 41
10922 read(7, "", 214)                  = 0
10922 close(7)                          = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", {st_mode=S_IFREG|0444, st_size=176, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", O_RDONLY|O_NOATIME) = 7
10922 mmap(NULL, 176, PROT_READ, MAP_PRIVATE, 7, 0) = 0x2ac028781000
10922 close(7)                          = 0
10922 munmap(0x2ac028781000, 176)       = 0
10922 write(6, "945b990ce4a77ccd314fbc9b33c59590"..., 40) = 40
10922 write(6, "\n", 1)                 = 1
10922 close(6)                          = 0
10922 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs/heads", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/refs/heads/master", O_WRONLY|O_APPEND|O_CREAT, 0666) = 6
10922 write(6, "1bd44cb9d13204b0fe1958db0082f502"..., 160) = 160
10922 close(6)                          = 0
10922 stat("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place", {st_mode=S_IFDIR|S_ISGID|0755, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio", {st_mode=S_IFDIR|S_ISGID|0775, st_size=98304, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t", {st_mode=S_IFDIR|S_ISGID|0775, st_size=8192, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/logs/HEAD", O_WRONLY|O_APPEND|O_CREAT, 0666) = 6
10922 write(6, "1bd44cb9d13204b0fe1958db0082f502"..., 160) = 160
10922 close(6)                          = 0
10922 rename("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master.lock", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/refs/heads/master") = 0
10922 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_HEAD") = -1 ENOENT (No such file or directory)
10922 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/MERGE_MSG") = -1 ENOENT (No such file or directory)
10922 rename("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index.lock", "/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/index") = 0
10922 unlink("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/next-index-10922.lock") = 0
10922 open(".git/config", O_RDONLY)     = 6
10922 fstat(6, {st_mode=S_IFREG|0664, st_size=92, ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 read(6, "[core]\n\trepositoryformatversion "..., 4096) = 92
10922 read(6, "", 4096)                 = 0
10922 close(6)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/rr-cache", 0x7fff82343da0) = -1 ENOENT (No such file or directory)
10922 access("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/hooks/post-commit", X_OK) = -1 ENOENT (No such file or directory)
10922 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10922 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ac028781000
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", {st_mode=S_IFREG|0444, st_size=136, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/1b/d44cb9d13204b0fe1958db0082f5028a16eb3a", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 136, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028782000
10922 close(6)                          = 0
10922 munmap(0x2ac028782000, 136)       = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028782000
10922 close(6)                          = 0
10922 munmap(0x2ac028782000, 49)        = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", {st_mode=S_IFREG|0444, st_size=176, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/5b990ce4a77ccd314fbc9b33c5959023a92714", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 176, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028782000
10922 close(6)                          = 0
10922 munmap(0x2ac028782000, 176)       = 0
10922 stat("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", {st_mode=S_IFREG|0444, st_size=49, ...}) = 0
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/df/2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078", O_RDONLY|O_NOATIME) = 6
10922 mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 6, 0) = 0x2ac028782000
10922 close(6)                          = 0
10922 munmap(0x2ac028782000, 49)        = 0
10922 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10922 write(1, "Created commit ", 15)   = 15
10922 open("/opt/packrat/playpen/public/in-place/git/git.junio/t/trash/.git/objects/94/", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 6
10922 fstat(6, {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
10922 fcntl(6, F_SETFD, FD_CLOEXEC)     = 0
10922 getdents(6, /* 3 entries */, 4096) = 112
10922 getdents(6, /* 0 entries */, 4096) = 0
10922 close(6)                          = 0
10922 write(1, "945b990: Partial: add elif\n", 27) = 27
10922 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
10922 close(1)                          = 0
10922 munmap(0x2ac028781000, 4096)      = 0
10922 exit_group(0)                     = ?

--=-=-=--
