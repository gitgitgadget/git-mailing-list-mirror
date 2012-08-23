From: mhagger@alum.mit.edu
Subject: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 10:10:25 +0200
Message-ID: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ScG-0007xd-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933698Ab2HWISE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:04 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:47955 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933655Ab2HWIR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:17:58 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:17:58 EDT
X-AuditID: 1207440f-b7fde6d00000095c-f7-5035e58d5d29
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B7.11.02396.D85E5305; Thu, 23 Aug 2012 04:10:54 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV0030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:10:52 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsUixO6iqNv31DTAYMYWJouuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3RvN63oKp
	ghXTXzxgaWA8ztvFyMEhIWAiMeu0VxcjJ5ApJnHh3nq2LkYuDiGBy4wSSz7cYAZJCAmcZZJ4
	v1YHxGYTkJJ42djDDmKLCKhJTGw7xAJiMwukSHQ872YEsYUF3CWuHD0JFmcRUJXY9KyLCcTm
	FXCRePG3jQlimaLEj+9rmCcwci9gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopea
	UrqJERIK/DsYu9bLHGIU4GBU4uF9YW4aIMSaWFZcmXuIUZKDSUmU998joBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3vB5QDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgTvnSdAjYJFqempFWmZOSUIaSYOThDBBbKBB2jDU5BC3uKCxNzizHSIolOMilLivCdBEgIg
	iYzSPLgBsKh9xSgO9I8w7zmQKh5gxMN1vwIazAQ0WO2qMcjgkkSElFQDY2LS6onJudKiKRvX
	3f2fIu5dft8jjvP1LJ5Uz4puEyY7eRXrlSGl3m+SWy/3n1r2U6Qq4ItjxOYtr99qJexJnvBm
	55lV6c2cSepiPeclPZiObj4W17HllvAnJWmRR8Zb0rjfy02XcvvvoD7V+8PuQu2Jn144/5Vd
	NEdmpttTzuTUFzf5G/OPKrEUZyQaajEXFScCAL5aiWy1AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204118>

From: Michael Haggerty <mhagger@alum.mit.edu>

There were various confusing things (and a couple of bugs) in the way
that fetch_pack() handled the list (nr_heads, heads) of references to
be sought from the remote:

* Different names were used for the list in different functions for no
  special reason.

* fetch_pack() modified the list in-place:

  * It moved entries around

  * It sometimes shrunk the list without informing the caller (which
    could lead to spurious error messages)

  * It overwrote the first byte of matching entries with NUL, leaving
    a sparse list that the caller had to interpret

  * Its interaction with the list was documented

* No error was reported if *all* requested references were missing
  from the remote.

I'm still suspicious about the logic related to args.fetch_all and
args.depth, but I don't think I've made anything worse.

This patch series applies to the merge between master and
jc/maint-push-refs-all, though the dependency on the latter is only
textual.

Michael Haggerty (17):
  t5500: add tests of error output for missing refs
  Rename static function fetch_pack() to http_fetch_pack()
  Fix formatting.
  Name local variables more consistently
  Do not check the same match_pos twice
  Let fetch_pack() inform caller about number of unique heads
  Pass nr_heads to do_pack_ref() by reference
  Pass nr_heads to everything_local() by reference
  Pass nr_heads to filter_refs() by reference
  Remove ineffective optimization
  filter_refs(): do not leave gaps in return_refs
  filter_refs(): compress unmatched refs in heads array
  cmd_fetch_pack: return early if finish_connect() returns an error
  Report missing refs even if no existing refs were received
  cmd_fetch_pack(): simplify computation of return value
  fetch_pack(): free matching heads
  fetch_refs(): simplify logic

 builtin/fetch-pack.c  | 128 ++++++++++++++++++++------------------------------
 fetch-pack.h          |  19 +++++---
 http-walker.c         |   4 +-
 t/t5500-fetch-pack.sh |  32 ++++++++++++-
 transport.c           |   8 ++--
 5 files changed, 101 insertions(+), 90 deletions(-)

-- 
1.7.11.3
