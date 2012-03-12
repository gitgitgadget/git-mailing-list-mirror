From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 17:41:49 +0100
Message-ID: <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
References: <20120312002046.041448832@1wt.eu>
	<1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
	<20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
	<20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
	<20120312152453.GB12405@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 17:41:59 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S78Jp-0006C6-Vy
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 17:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab2CLQlx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 12:41:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46686 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526Ab2CLQlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 12:41:51 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:41:50 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:41:50 +0100
In-Reply-To: <20120312152453.GB12405@1wt.eu> (Willy Tarreau's message of "Mon,
	12 Mar 2012 16:24:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192904>

[+cc Junio because of backwards-compat issues]

Willy Tarreau <w@1wt.eu> writes:

> On Mon, Mar 12, 2012 at 08:20:04AM -0700, Greg KH wrote:
>> 
>> I don't see a -b option to 'git am' in the manpage, am I missing
>> something here?
>
> It's in the master tree only right now, and the option is "--keep-non-patch"
> (could have been shorter). Currently rebuilding to test it :-)

Exactly.

The problem with -b is that it's a backwards-compatibility shorthand for
--binary, which used to pass --allow-binary-replacement (or --binary) to
git-apply.  However, that option was obsoleted in 2b6eef9 (Make apply
--binary a no-op., 2006-09-06) and has been a no-op for over 5 years.
It has also not been documented since cb3a160 (git-am: ignore --binary
option, 2008-08-09).

So perhaps we can safely claim -b for --keep-non-patch, like so:

diff --git i/Documentation/git-am.txt w/Documentation/git-am.txt
index ee6cca2..9ec9313 100644
--- i/Documentation/git-am.txt
+++ w/Documentation/git-am.txt
@@ -40,6 +40,7 @@ OPTIONS
 --keep::
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+-b::
 --keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
diff --git i/git-am.sh w/git-am.sh
index 0bd290b..4b071de 100755
--- i/git-am.sh
+++ w/git-am.sh
@@ -9,13 +9,13 @@ git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--resolved | --skip | --abort)
 --
 i,interactive   run interactively
-b,binary*       (historical option -- no-op)
+binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
 q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
-keep-non-patch  pass -b flag to git-mailinfo
+b,keep-non-patch pass -b flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
@@ -379,7 +379,7 @@ do
 	case "$1" in
 	-i|--interactive)
 		interactive=t ;;
-	-b|--binary)
+	--binary)
 		: ;;
 	-3|--3way)
 		threeway=t ;;
@@ -391,7 +391,7 @@ do
 		utf8= ;;
 	-k|--keep)
 		keep=t ;;
-	--keep-non-patch)
+	-b|--keep-non-patch)
 		keep=b ;;
 	-c|--scissors)
 		scissors=t ;;

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
