From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH next] t7407: use 'cut' utility rather than bash's substring
 expansion notation
Date: Thu, 20 Aug 2009 11:24:54 +0200
Message-ID: <200908201124.54193.johan@herland.net>
References: <QHfHFS_5JGiL-O8GMDfdfscFUdxV1xVObzr6e5LPleagDRd7bCg8I9YUwL9xkbgM64vyf_EVLLg@cipher.nrlssc.navy.mil>
 <200908200856.30359.johan@herland.net>
 <7vskfnq6q5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 11:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me3tK-00055R-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 11:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZHTJY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 05:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbZHTJY4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 05:24:56 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57926 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751779AbZHTJYz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 05:24:55 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOO00CJ84TJWA60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 11:24:55 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOO00BOZ4TIFO70@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 20 Aug 2009 11:24:55 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.20.91221
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7vskfnq6q5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126616>

On Thursday 20 August 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> >> - $sub1sha1 sub1 (${sub1sha1:0:7})
> >> - $sub2sha1 sub2 (${sub1sha1:0:7})
> >> + $sub1sha1 sub1 ($(echo $sub1sha1 | cut -c 1-7))
> >> + $sub2sha1 sub2 ($(echo $sub1sha1 | cut -c 1-7))
> >
> > Typo (both in the original, and the patch), should be:
> > 	$sub2sha1 sub2 ($(echo $sub2sha1 | cut -c 1-7))
> >
> >>   $sub3sha1 sub3 (heads/master)
> >>  EOF
> >
> > Otherwise:
> >
> > Acked-by: Johan Herland <johan@herland.net>
>
> Hmm, what does the command use to shorten these object names?  It may be
> safer and more correct to use "rev-parse --short" in case these object
> names were ambigous in their first 7 hexdigits.

git submodule status (which is what we're testing here) uses
'git describe' to generate the short object name (see
set_name_rev in git-submodule.sh). In this case, it falls back
to 'git describe --all --always', which calls find_unique_abbrev()
on the SHA1. 'git rev-parse --short' ends up calling the same
find_unique_abbrev(), so I guess it is better to use it here.

Try this instead:

From: Johan Herland <johan@herland.net>

Subject: [PATCH] t7407: Use 'rev-parse --short' rather than bash's substring expansion notation

The substring expansion notation is a bashism that we have not so far
adopted.  Use 'git rev-parse --short' instead, as this also handles
the case where the unique abbreviation is longer than 7 characters.

Suggested-by: Brandon Casey <casey@nrlssc.navy.mil>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7407-submodule-foreach.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 25ec281..2a52775 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -201,14 +201,16 @@ submodulesha1=$(cd clone3/nested1/nested2/nested3/submodule && git rev-parse HEA
 sub1sha1=$(cd clone3/sub1 && git rev-parse HEAD)
 sub2sha1=$(cd clone3/sub2 && git rev-parse HEAD)
 sub3sha1=$(cd clone3/sub3 && git rev-parse HEAD)
+sub1sha1_short=$(cd clone3/sub1 && git rev-parse --short HEAD)
+sub2sha1_short=$(cd clone3/sub2 && git rev-parse --short HEAD)
 
 cat > expect <<EOF
  $nested1sha1 nested1 (heads/master)
  $nested2sha1 nested1/nested2 (heads/master)
  $nested3sha1 nested1/nested2/nested3 (heads/master)
  $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
- $sub1sha1 sub1 (${sub1sha1:0:7})
- $sub2sha1 sub2 (${sub1sha1:0:7})
+ $sub1sha1 sub1 ($sub1sha1_short)
+ $sub2sha1 sub2 ($sub2sha1_short)
  $sub3sha1 sub3 (heads/master)
 EOF
 
-- 
1.6.4.304.g1365c.dirty

-- 
Johan Herland, <johan@herland.net>
www.herland.net
