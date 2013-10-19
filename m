From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 10/11] read-cache.c: fix memory leaks caused by removed cache entries
Date: Sat, 19 Oct 2013 21:28:51 +0200
Message-ID: <8738nx2h70.fsf@thomasrast.ch>
References: <524A96FF.5090604@gmail.com> <524A9886.2030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 21:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXcDJ-0002Ap-8K
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 21:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3JST3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 15:29:10 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:36605 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab3JST3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 15:29:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id BCC8A4D650A;
	Sat, 19 Oct 2013 21:29:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id buJ4AqGpjKES; Sat, 19 Oct 2013 21:28:52 +0200 (CEST)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EF99E4D64C1;
	Sat, 19 Oct 2013 21:28:51 +0200 (CEST)
In-Reply-To: <524A9886.2030508@gmail.com> (Karsten Blees's message of "Tue, 01
	Oct 2013 11:40:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236405>

Karsten Blees <karsten.blees@gmail.com> writes:

> When cache_entry structs are removed from index_state.cache, they are not
> properly freed. Freeing those entries wasn't possible before because we
> couldn't remove them from index_state.name_hash.
>
> Now that we _do_ remove the entries from name_hash, we can also free them.
> Add free(cache_entry) to all call sites of name-hash.c::remove_name_hash in
> read-cache.c, as name-hash.c isn't concerned with cache_entry allocation.
>
> cmd_rm and unmerge_index_entry_at use cache_entry.name after removing the
> entry. Copy the name so that we don't access memory that has been freed.

Is this the version that is currently in pu?  There's a valgrind test
failure in current pu that bisects to 36850edb, which would seem to be
from this email but doesn't have the right author date.  Worse, I cannot
apply this on top of 36850edb^ because I don't have the 'index' blobs
for this patch.  Confusing.

In any case 36850edb currently breaks several valgrind tests.  You can
valgrind only t6022.16 like so (that one test is sufficient to track it
down and it's much faster that way):

  cd t  
  ./t6022-merge-rename.sh --valgrind-only=16

The valgrind error in t6022.16 looks like this:

  ==4959== Invalid read of size 1
  ==4959==    at 0x5682A38: vfprintf (vfprintf.c:1629)
  ==4959==    by 0x56AC564: vsnprintf (vsnprintf.c:119)
  ==4959==    by 0x542005: vreportf (usage.c:12)
  ==4959==    by 0x54216C: error_builtin (usage.c:42)
  ==4959==    by 0x54261B: error (usage.c:147)
  ==4959==    by 0x4FC681: read_index_unmerged (read-cache.c:1900)
  ==4959==    by 0x475CF1: reset_index (reset.c:68)
  ==4959==    by 0x476A72: cmd_reset (reset.c:346)
  ==4959==    by 0x405999: run_builtin (git.c:314)
  ==4959==    by 0x405B2C: handle_internal_command (git.c:477)
  ==4959==    by 0x405C46: run_argv (git.c:523)
  ==4959==    by 0x405DE2: main (git.c:606)
  ==4959==  Address 0x5bedb54 is 84 bytes inside a block of size 104 free'd
  ==4959==    at 0x4C2ACDA: free (vg_replace_malloc.c:468)
  ==4959==    by 0x4F9360: remove_index_entry_at (read-cache.c:482)
  ==4959==    by 0x4FA469: add_index_entry_with_check (read-cache.c:964)
  ==4959==    by 0x4FA5A4: add_index_entry (read-cache.c:993)
  ==4959==    by 0x4FC663: read_index_unmerged (read-cache.c:1899)
  ==4959==    by 0x475CF1: reset_index (reset.c:68)
  ==4959==    by 0x476A72: cmd_reset (reset.c:346)
  ==4959==    by 0x405999: run_builtin (git.c:314)
  ==4959==    by 0x405B2C: handle_internal_command (git.c:477)
  ==4959==    by 0x405C46: run_argv (git.c:523)
  ==4959==    by 0x405DE2: main (git.c:606)

If you need any more information/help, just ask :-)

-- 
Thomas Rast
tr@thomasrast.ch
