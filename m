From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] apply: handle traditional patches with space in
 filename
Date: Wed, 18 Aug 2010 20:45:16 -0500
Message-ID: <20100819014516.GA7175@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C65BCD2.6000701@kdbg.org>
 <20100814022625.GA4199@burratino>
 <201008142037.50833.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 03:47:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OluDj-0007op-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 03:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970Ab0HSBrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 21:47:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53697 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab0HSBrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 21:47:00 -0400
Received: by gyd8 with SMTP id 8so469122gyd.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k1Cs66imDQlu/VqDug+KXqnIgr3gkyMwXhoaqe5OwCs=;
        b=KAGh6E/VBNgbUHMeL1MGaoIckhiHPtlHXuS7sJYy1oKgJxD+ymXy9ffYH/xuYpX5i6
         VBXEgRzTMkkzgrtLRqyWciCSbJV4KaOhOcdn/GvCyHai4AFEof+q0aM76u8Hfjkk0/wv
         tPwb10/UjBhBZ1YyG6Y1/Rqui76A63k2WiOAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CQWD/wd9YVCsHrHOv8VM34iIyHK2NYVzik24Iutt3QJZ9+sDhnT8+Wep74QlBYhNho
         ETQznIZ9JaF8hmimxckwk8uxCFBh6M4mgALuN+52sjs/AMMuAq060te6Iu6XDMnDzLev
         UigNgkb7e2L/1QVDNhbk9V4PeMsN+6RZFMnx8=
Received: by 10.150.53.13 with SMTP id b13mr1019705yba.419.1282182419552;
        Wed, 18 Aug 2010 18:46:59 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t2sm2787877yba.14.2010.08.18.18.46.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 18:46:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008142037.50833.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153901>

Johannes Sixt wrote:

> Why not just write an explicit test vector? The result of expand will be 
> constant, no?

Sorry for the long delay.  Here's a re-roll, meant to replace
jn/apply-filename-with-sp from pu.

Patch 1 fixes an edge case for git apply -p when traditional patches
have quotation marks in file names (so: an edge case of an edge).
But that is only a side-effect; the main purpose is to rearrange
code to prepare for patch 3.  Except for the commit message, it is
unchanged from the version in pu.

Patch 2 contains the funny-filenames tests.  Testing on Windows would
be welcome.  The test vectors are included in the patch to avoid a
source of non-determinism (for example, GNU diff could stop emiting
traditional patches some day).  The script used to generate them is
provided to make the test easy to change.

Patch 3 is basically as before, except that find_name_traditional()
calls find_name_common() directly now instead of redundantly checking
again for quotes at the beginning of filenames.  As before, the
purpose is to handle patches to files with whitespace in their
names, by trying to use the timestamp instead of arbitrary whitespace
as a name terminator (falling back to the old method if that fails).

Thanks for your help so far.  The code would be much worse without it.

Jonathan Nieder (3):
  apply: split quoted filename handling into new function
  tests: exercise "git apply" with weird filenames
  apply: handle traditional patches with space in filename

 builtin/apply.c                  |  251 ++++++++++++++++++++++++++++++++------
 t/t4120-apply-popt.sh            |   35 +++++-
 t/t4135-apply-weird-filenames.sh |   75 +++++++++++
 t/t4135/.gitignore               |    3 +
 t/t4135/add-plain.diff           |    5 +
 t/t4135/add-with backslash.diff  |    5 +
 t/t4135/add-with quote.diff      |    5 +
 t/t4135/add-with spaces.diff     |    5 +
 t/t4135/add-with tab.diff        |    5 +
 t/t4135/damaged.diff             |    5 +
 t/t4135/diff-plain.diff          |    5 +
 t/t4135/diff-with backslash.diff |    5 +
 t/t4135/diff-with quote.diff     |    5 +
 t/t4135/diff-with spaces.diff    |    5 +
 t/t4135/diff-with tab.diff       |    5 +
 t/t4135/git-plain.diff           |    7 +
 t/t4135/git-with backslash.diff  |    7 +
 t/t4135/git-with quote.diff      |    7 +
 t/t4135/git-with spaces.diff     |    7 +
 t/t4135/git-with tab.diff        |    7 +
 t/t4135/make-patches             |   45 +++++++
 21 files changed, 457 insertions(+), 42 deletions(-)
 create mode 100755 t/t4135-apply-weird-filenames.sh
 create mode 100644 t/t4135/.gitignore
 create mode 100644 t/t4135/add-plain.diff
 create mode 100644 t/t4135/add-with backslash.diff
 create mode 100644 t/t4135/add-with quote.diff
 create mode 100644 t/t4135/add-with spaces.diff
 create mode 100644 t/t4135/add-with tab.diff
 create mode 100644 t/t4135/damaged.diff
 create mode 100644 t/t4135/diff-plain.diff
 create mode 100644 t/t4135/diff-with backslash.diff
 create mode 100644 t/t4135/diff-with quote.diff
 create mode 100644 t/t4135/diff-with spaces.diff
 create mode 100644 t/t4135/diff-with tab.diff
 create mode 100644 t/t4135/git-plain.diff
 create mode 100644 t/t4135/git-with backslash.diff
 create mode 100644 t/t4135/git-with quote.diff
 create mode 100644 t/t4135/git-with spaces.diff
 create mode 100644 t/t4135/git-with tab.diff
 create mode 100755 t/t4135/make-patches

-- 
1.7.2.1.544.ga752d.dirty
