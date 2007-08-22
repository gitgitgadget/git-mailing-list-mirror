From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Wed, 22 Aug 2007 14:56:18 -0700
Message-ID: <7vejhvi67x.fsf@gitster.siamese.dyndns.org>
References: <20070822132359.GA13750@informatik.uni-freiburg.de>
	<11878139102715-git-send-email-david@olrik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ukleinek@informatik.uni-freiburg.de
To: David Jack Olrik <david@olrik.dk>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INyBo-0006qc-SQ
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbXHVV4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 17:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933125AbXHVV4c
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:56:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbXHVV4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 17:56:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C5AF512239B;
	Wed, 22 Aug 2007 17:56:49 -0400 (EDT)
In-Reply-To: <11878139102715-git-send-email-david@olrik.dk> (David Jack
	Olrik's message of "Wed, 22 Aug 2007 22:18:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56427>

David Jack Olrik <david@olrik.dk> writes:

> On 22/08/2007, at 15.23, Uwe Kleine-K=C3=83=C2=B6nig wrote:
>
>> > You'd then need to check against 2 instead of 1, which I find less
>> > obvious as we are testing for a '/' at the begining of the string.
>> If I understood the problem right you only need to test for the exit
>> code, that is the program test is not required at all.
>
> Ah, yes that's true. The following should make it more clear that we =
are
> looking at the first character.
>
>     if expr "$httpd_only" : "\/" >/dev/null

Then why not avoid the fork with something like:

	case "$httpd_only" in
        /*)
                ... begins with slash ...
	esac

By the way, I do not know if the use of "which" there is
portable.  Have Solaris folks tried this program ever?

How about doing it this way?

 * No need to use "cut"; just let IFS do its job.

 * No need to use "which"; we will need to do a discovery with
   custom paths anyway, so use the same logic for discovery from
   the normal $PATH as well.

 * The original code wanted to allow the httpd command that
   comes to the function to have arguments and preserve it but
   did so only for the case where the command was not specified
   with a full pathname.  Allow it for full-path case as well
   for consistency.

 * The original code returned without checking for error when
   httpd was specified without a full path, and checked and
   complained when it was.  Check the error exit for both cases.

---

 git-instaweb.sh |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..a17c9b3 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -29,32 +29,42 @@ test -z "$browser" && browser=3D'firefox'
 test -z "$port" && port=3D1234
=20
 start_httpd () {
-	httpd_only=3D"`echo $httpd | cut -f1 -d' '`"
-	if test "`expr index $httpd_only /`" -eq '1' || \
-				which $httpd_only >/dev/null
-	then
-		$httpd $fqgitdir/gitweb/httpd.conf
-	else
+	set x $httpd
+	shift
+
+	httpd=3D
+	case "$1" in
+	/*)
+		: full path -- no discovery
+		httpd=3D"$1"
+		;;
+	*)
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
-		for i in /usr/local/sbin /usr/sbin
+		paths=3D"$PATH:/usr/sbin:/usr/local/sbin"
+		oIFS=3D"$IFS"
+		IFS=3D:
+		for p in $paths
 		do
-			if test -x "$i/$httpd_only"
+			if test -x "$p/$1"
 			then
-				# don't quote $httpd, there can be
-				# arguments to it (-f)
-				$i/$httpd "$fqgitdir/gitweb/httpd.conf"
-				return
+				httpd=3D"$p/$1"
+				break
 			fi
 		done
-		echo "$httpd_only not found. Install $httpd_only or use" \
-		     "--httpd to specify another http daemon."
+		IFS=3D"$oIFS"
+		;;
+	esac
+	if test -z "$httpd"
+	then
+		echo "$1 not found. Install $1 or use --httpd to specify another htt=
p daemon."
 		exit 1
 	fi
-	if test $? !=3D 0; then
+	shift
+	"$httpd" "$@" "$fqgitdir/gitweb/httpd.conf" || {
 		echo "Could not execute http daemon $httpd."
 		exit 1
-	fi
+	}
 }
=20
 stop_httpd () {
