From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Mon, 28 Oct 2013 22:58:39 +0100
Message-ID: <87k3gxkqgg.fsf@linux-k42r.v.cablecom.net>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <blees@dcon.de>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaupt-0007qV-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700Ab3J1V6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:58:54 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:55387 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab3J1V6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:58:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A52184D6414;
	Mon, 28 Oct 2013 22:58:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U6MT0P3aCQQ7; Mon, 28 Oct 2013 22:58:41 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D20DE4D656F;
	Mon, 28 Oct 2013 22:58:40 +0100 (CET)
In-Reply-To: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Oct 2013 12:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236869>

Hi Karsten

Junio C Hamano <gitster@pobox.com> writes:

> * kb/fast-hashmap (2013-10-22) 12 commits
>  - remove old hash.[ch] implementation
>  - read-cache.c: fix memory leaks caused by removed cache entries

I found more valgrind breakage related to this commit, in t2101.[3567]
(sorry for only reporting them so late, I probably missed them in the
last run).  E.g. I get this:

  $ ./t2101-update-index-reupdate.sh --valgrind-only=3
  ok 1 - update-index --add
  ok 2 - update-index --again

  expecting success: git update-index --remove --again &&
           git ls-files -s >current &&
           cmp current expected
  ==21665== Invalid read of size 1
  ==21665==    at 0x4C2C762: __GI_strlen (mc_replace_strmem.c:405)
  ==21665==    by 0x484B0E: update_one (update-index.c:305)
  ==21665==    by 0x485466: do_reupdate (update-index.c:582)
  ==21665==    by 0x4858FB: reupdate_callback (update-index.c:696)
  ==21665==    by 0x4EB5E7: get_value (parse-options.c:96)
  ==21665==    by 0x4EBEC5: parse_long_opt (parse-options.c:302)
  ==21665==    by 0x4EC5CD: parse_options_step (parse-options.c:474)
  ==21665==    by 0x486115: cmd_update_index (update-index.c:824)
  ==21665==    by 0x405999: run_builtin (git.c:314)
  ==21665==    by 0x405B2C: handle_internal_command (git.c:477)
  ==21665==    by 0x405C46: run_argv (git.c:523)
  ==21665==    by 0x405DE2: main (git.c:606)
  ==21665==  Address 0x5bee774 is 84 bytes inside a block of size 90 free'd
  ==21665==    at 0x4C2ACDA: free (vg_replace_malloc.c:468)
  ==21665==    by 0x4F9360: remove_index_entry_at (read-cache.c:482)
  ==21665==    by 0x4F9536: remove_file_from_index (read-cache.c:522)
  ==21665==    by 0x4841DF: remove_one_path (update-index.c:68)
  ==21665==    by 0x48422E: process_lstat_error (update-index.c:83)
  ==21665==    by 0x4846BB: process_path (update-index.c:211)
  ==21665==    by 0x484AC2: update_one (update-index.c:301)
  ==21665==    by 0x485466: do_reupdate (update-index.c:582)
  ==21665==    by 0x4858FB: reupdate_callback (update-index.c:696)
  ==21665==    by 0x4EB5E7: get_value (parse-options.c:96)
  ==21665==    by 0x4EBEC5: parse_long_opt (parse-options.c:302)
  ==21665==    by 0x4EC5CD: parse_options_step (parse-options.c:474)
  [...]
  not ok 3 - update-index --remove --again
  #       git update-index --remove --again &&
  #                git ls-files -s >current &&
  #                cmp current expected

  ok 4 - first commit
  ok 5 - update-index again
  ok 6 - update-index --update from subdir
  ok 7 - update-index --update with pathspec
  # failed 1 among 7 test(s)
  1..7

The errors for tests 5-7 look like they're the same piece of code
breaking.

-- 
Thomas Rast
tr@thomasrast.ch
