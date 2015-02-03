From: Mike Hommey <mh@glandium.org>
Subject: use-after-free leads to git-blame writing garbage in error message
Date: Tue, 3 Feb 2015 18:17:15 +0900
Message-ID: <20150203091715.GA25445@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 10:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZc0-0001Gs-OL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 10:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbbBCJRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 04:17:32 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43516 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbbBCJR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 04:17:29 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YIZbf-0002qG-MD; Tue, 03 Feb 2015 18:17:15 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263314>

Symptoms:
  $ git blame HEAD -- foo
  fatal: no such path foo in <random garbage>

Expected output:
  $ git blame HEAD -- foo
  fatal: no such path foo in HEAD

Bisect says this was introduced in 1da1e07c835e900337714cfad6c32a8dc0b36ac3

valgrind output looks like this:
==4738== Memcheck, a memory error detector
==4738== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
==4738== Using Valgrind-3.10.0 and LibVEX; rerun with -h for copyright info
==4738== Command: ./git-blame HEAD -- foo
==4738== 
==4738== Invalid read of size 1
==4738==    at 0x58B6F00: vfprintf (vfprintf.c:1636)
==4738==    by 0x58E1298: vsnprintf (vsnprintf.c:119)
==4738==    by 0x5107ED: vreportf (usage.c:12)
==4738==    by 0x510823: die_builtin (usage.c:36)
==4738==    by 0x510A82: die (usage.c:103)
==4738==    by 0x41318F: cmd_blame (blame.c:2716)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738==  Address 0x5f042d0 is 0 bytes inside a block of size 5 free'd
==4738==    at 0x4C29E90: free (vg_replace_malloc.c:473)
==4738==    by 0x4C1621: object_array_release_entry.isra.0 (object.c:354)
==4738==    by 0x4C1F73: object_array_clear (object.c:380)
==4738==    by 0x4E8E05: prepare_revision_walk (revision.c:2739)
==4738==    by 0x41153E: cmd_blame (blame.c:2705)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738== 
==4738== Invalid read of size 1
==4738==    at 0x58E50D0: _IO_default_xsputn (genops.c:475)
==4738==    by 0x58B6EC1: vfprintf (vfprintf.c:1636)
==4738==    by 0x58E1298: vsnprintf (vsnprintf.c:119)
==4738==    by 0x5107ED: vreportf (usage.c:12)
==4738==    by 0x510823: die_builtin (usage.c:36)
==4738==    by 0x510A82: die (usage.c:103)
==4738==    by 0x41318F: cmd_blame (blame.c:2716)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738==  Address 0x5f042d0 is 0 bytes inside a block of size 5 free'd
==4738==    at 0x4C29E90: free (vg_replace_malloc.c:473)
==4738==    by 0x4C1621: object_array_release_entry.isra.0 (object.c:354)
==4738==    by 0x4C1F73: object_array_clear (object.c:380)
==4738==    by 0x4E8E05: prepare_revision_walk (revision.c:2739)
==4738==    by 0x41153E: cmd_blame (blame.c:2705)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738== 
==4738== Invalid read of size 1
==4738==    at 0x58E50DE: _IO_default_xsputn (genops.c:474)
==4738==    by 0x58B6EC1: vfprintf (vfprintf.c:1636)
==4738==    by 0x58E1298: vsnprintf (vsnprintf.c:119)
==4738==    by 0x5107ED: vreportf (usage.c:12)
==4738==    by 0x510823: die_builtin (usage.c:36)
==4738==    by 0x510A82: die (usage.c:103)
==4738==    by 0x41318F: cmd_blame (blame.c:2716)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738==  Address 0x5f042d2 is 2 bytes inside a block of size 5 free'd
==4738==    at 0x4C29E90: free (vg_replace_malloc.c:473)
==4738==    by 0x4C1621: object_array_release_entry.isra.0 (object.c:354)
==4738==    by 0x4C1F73: object_array_clear (object.c:380)
==4738==    by 0x4E8E05: prepare_revision_walk (revision.c:2739)
==4738==    by 0x41153E: cmd_blame (blame.c:2705)
==4738==    by 0x405B52: run_builtin (git.c:351)
==4738==    by 0x405B52: handle_builtin (git.c:530)
==4738==    by 0x404C69: main (git.c:653)
==4738== 
fatal: no such path foo in HEAD
==4738== 
==4738== HEAP SUMMARY:
==4738==     in use at exit: 733,417 bytes in 807 blocks
==4738==   total heap usage: 1,505 allocs, 698 frees, 915,428 bytes allocated
==4738== 
==4738== LEAK SUMMARY:
==4738==    definitely lost: 0 bytes in 0 blocks
==4738==    indirectly lost: 0 bytes in 0 blocks
==4738==      possibly lost: 0 bytes in 0 blocks
==4738==    still reachable: 733,417 bytes in 807 blocks
==4738==         suppressed: 0 bytes in 0 blocks
==4738== Rerun with --leak-check=full to see details of leaked memory
==4738== 
==4738== For counts of detected and suppressed errors, rerun with: -v
==4738== ERROR SUMMARY: 9 errors from 3 contexts (suppressed: 0 from 0)

Cheers,

Mike
