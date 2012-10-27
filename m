From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: crash on git diff-tree -Ganything <tree> for new files with textconv
 filter
Date: Sat, 27 Oct 2012 20:37:24 +0200
Message-ID: <508C29E4.5000801@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 20:37:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSBGR-0001IB-I0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 20:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759440Ab2J0Sha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 14:37:30 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:46749 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758499Ab2J0Sh3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2012 14:37:29 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id BA4661080BB;
	Sat, 27 Oct 2012 20:37:25 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id B8CAF3F83AD;
	Sat, 27 Oct 2012 20:37:25 +0200 (CEST)
Received: from [10.0.0.5] (188-22-33-156.adsl.highway.telekom.at [188.22.33.156])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-15.arcor-online.net (Postfix) with ESMTPA id 6F3531AB537;
	Sat, 27 Oct 2012 20:37:25 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 6F3531AB537
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351363045; bh=WIZLXb2XYgGnso5dP2TUg+kytRPquQaKwudeO2Y7RhU=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=NDXgPNQlIAc/JyAjJ8tLU5t3UY1B56fUtTwBEM8fKXRdPNukY5e71g9iB4g6jRtXw
	 bPtbYC0bt/6NZhJix0S/GqhQ26XHhf38MLpNfPPWbjpU6S/RI6WADaGzVP87AZLZpP
	 gt3ZMXnHmfITM+Y+P3qAJqBdR7US/rkE2u2USdmU=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208512>

Hi,

It seems "git diff-tree -Ganything <tree>" crashes[1] with a null
pointer dereference
when run on a commit that adds a file (pdf) with a textconv filter.

It can be reproduced with vanilla git by having a commit on top that
adds a file with a textconv filter and executing git diff-tree
-Ganything HEAD
But running git log -Ganything still works without a crash.
This problem seems to exist since the feature was first added in f506b8e8b5.

While testing I also noticed the -S and -G act on the original file
instead of the textconv munged data.
Is this intentional or caused by accessing the wrong data?
Wild guess: should we really access p->one->data and not mf1.ptr?

Is there some more information i should provide?

Greetings Peter

[1]
I am running msysgit v1.8.0.msysgit.0 (52d3a7583a)
and i tried added -G pickaxe support to gitk.
gitk runs git diff-tree -r -s --stdin -Gpattern

This is how i detected the crash the first time.
(but only because of a crash popup on Windows, gitk does not complain...)

For testing on vanilla git I used .git/config:
[diff "upcase2"]
    textconv = tr a-z A-Z <

.gitatrributes:
newtext diff=upcase2

Program received signal SIGSEGV, Segmentation fault.
[Switching to thread 3864.0x83c]
0x0049d90c in regexec (preg=0x22f900, string=0x0, nmatch=1,
pmatch=0x22f46c, eflags=0) at compat/regex/regexec.c:241
241           length = strlen (string);
(gdb) bt
#0  0x0049d90c in regexec (preg=0x22f900, string=0x0, nmatch=1,
pmatch=0x22f46c, eflags=0) at compat/regex/regexec.c:241
#1  0x004f5763 in diff_grep (p=0x109a530, o=0x550b48, regexp=0x22f900,
kws=0x0) at diffcore-pickaxe.c:110
#2  0x004f59dc in pickaxe (o=<value optimized out>, regexp=0x22f900,
kws=0xffffffff, fn=0x4f5620 <diff_grep>) at diffcore-pickaxe.c:40
#3  0x004f5bd4 in diffcore_pickaxe_grep (o=0x550b48) at
diffcore-pickaxe.c:154
#4  0x0048049a in diffcore_std (options=0x550b48) at diff.c:4630
#5  0x004dc16a in log_tree_diff_flush (opt=0x5508c0) at log-tree.c:697
#6  0x004dc32e in log_tree_commit (opt=0x5508c0, commit=0xffc620) at
log-tree.c:790
#7  0x004206dd in cmd_diff_tree (argc=<value optimized out>,
argv=0x3d24bc, prefix=0x0) at builtin/diff-tree.c:43
#8  0x00401a16 in handle_internal_command (argc=<value optimized out>,
argv=<value optimized out>) at git.c:306
#9  0x00401c00 in main (argc=6, argv=0x3d24b8) at git.c:513
(gdb) up
#1  0x004f5763 in diff_grep (p=0x109a530, o=0x550b48, regexp=0x22f900,
kws=0x0) at diffcore-pickaxe.c:110
110                     hit = !regexec(regexp, p->one->data, 1,
&regmatch, 0);
(gdb) info locals
regmatch = {rm_so = 17408640, rm_eo = 2291968}
textconv_one = (struct userdiff_driver *) 0x0
textconv_two = (struct userdiff_driver *) 0xe10468
mf1 = {ptr = 0x0, size = 0}
mf2 = {
  ptr = 0x2bbcaf0 ' ' <repeats 52 times>, "PROJECT
DESCRIPTION\r\n\r\n\r\nProject Number:", ' ' <repeats 19 times>,
"xxxxx\r\nProject Description:", ' ' <repeats 14 times>,
"xxxxxxxx\r\nxxxxx:", ' ' <repeats 11 times>..., size = 64185}
hit = <value optimized out>
(gdb) print p
$1 = (struct diff_filepair *) 0x109a530
(gdb) print *p
$2 = {one = 0x109a320, two = 0x109a428, score = 0, status = 0 '\0',
broken_pair = 0, renamed_pair = 0, is_unmerged = 0}
(gdb) print p->one
$3 = (struct diff_filespec *) 0x109a320
(gdb) print *p->one
$4 = {sha1 = '\0' <repeats 19 times>, path = 0x109a360
"xxxxxxxx/xxx/doc/xxxx xxxxx 1.4.pdf", data = 0x0, cnt_data = 0x0,
  funcname_pattern_ident = 0x0, size = 0, count = 1, xfrm_flags = 0,
rename_used = 0, mode = 0, sha1_valid = 0, should_free = 0,
should_munmap = 0,
  dirty_submodule = 0, is_stdin = 0, has_more_entries = 0, driver = 0x0,
is_binary = -1}
(gdb) print *p->two
$5 = {sha1 = "0aax\217\231)oBaAa(\021\234^'Q\236\230", path = 0x109a468
"xxxxxxxx/xxx/doc/xxxx xxxxx 1.4.pdf", data = 0x0,
  cnt_data = 0x0, funcname_pattern_ident = 0x0, size = 0, count = 1,
xfrm_flags = 0, rename_used = 0, mode = 33188, sha1_valid = 1,
should_free = 0,
  should_munmap = 0, dirty_submodule = 0, is_stdin = 0, has_more_entries
= 0, driver = 0xe10468, is_binary = -1}
(gdb) print textconv_one
$6 = (struct userdiff_driver *) 0x0
(gdb) print textconv_two
$7 = (struct userdiff_driver *) 0xe10468
(gdb) print *textconv_two
$10 = {name = 0xfe4fc0 "astextplain", external = 0x0, binary = -1,
funcname = {pattern = 0x0, cflags = 0}, word_regex = 0x0,
  textconv = 0xfe4fd8 "astextplain", textconv_cache = 0x0,
textconv_want_cache = 0}
(gdb)
