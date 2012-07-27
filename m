From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] test: allow prerequisite to be evaluated lazily
Date: Fri, 27 Jul 2012 11:50:00 -0400
Message-ID: <20120727155000.GB11957@sigill.intra.peff.net>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
 <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
 <20120727154500.GA11957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 17:50:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sumns-0005jy-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 17:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2G0PuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 11:50:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38951 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab2G0PuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 11:50:03 -0400
Received: (qmail 20854 invoked by uid 107); 27 Jul 2012 15:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jul 2012 11:50:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2012 11:50:00 -0400
Content-Disposition: inline
In-Reply-To: <20120727154500.GA11957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202357>

On Fri, Jul 27, 2012 at 11:45:00AM -0400, Jeff King wrote:

> And of course with non-broken probes, "-v" would also help to see exactly
> when the probe is run, using which commands, and what output they
> produced. E.g., for SYMLINKS, we should probably drop the stderr
> redirection from the probe so we can see how "ln" complains.
> 
> It might also be worth doing a "say >&3" at the end of the check, too,
> to tell "-v" users the outcome.

Here is an updated version of my suggestion that does both of those
things.  I think it should just be squashed into your patch.

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2214388..d2ebe24 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -232,6 +232,26 @@ test_lazy_prereq () {
 	eval test_prereq_lazily_$1=\$2
 }
 
+test_run_prereq_ () {
+	script='
+mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
+(cd "$TRASH_DIRECTORY/prereq-test-dir" &&
+'"$2"'
+)
+'
+	say >&3 "checking prerequisite: $1"
+	say >&3 "$script"
+	test_eval_ "$script"
+	eval_ret=$?
+	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
+	if test "$eval_ret" = 0; then
+		say >&3 "prerequisite $1 ok"
+	else
+		say >&3 "prerequisite $1 not fulfilled"
+	fi
+	return $eval_ret
+}
+
 test_have_prereq () {
 	# prerequisites can be concatenated with ','
 	save_IFS=$IFS
@@ -251,16 +271,11 @@ test_have_prereq () {
 		*)
 			case " $lazy_testable_prereq " in
 			*" $prerequisite "*)
-				mkdir -p "$TRASH_DIRECTORY/prereq-test-dir"
-				if (
-					eval "script=\$test_prereq_lazily_$prerequisite" &&
-					cd "$TRASH_DIRECTORY/prereq-test-dir" &&
-					eval "$script"
-				)
+				eval "script=\$test_prereq_lazily_$prerequisite" &&
+				if test_run_prereq_ "$prerequisite" "$script"
 				then
 					test_set_prereq $prerequisite
 				fi
-				rm -fr "$TRASH_DIRECTORY/prereq-test-dir"
 				lazy_tested_prereq="$lazy_tested_prereq$prerequisite "
 			esac
 			;;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 878d000..35739b9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -661,7 +661,7 @@ test_i18ngrep () {
 
 test_lazy_prereq SYMLINKS '
 	# test whether the filesystem supports symbolic links
-	ln -s x y 2>/dev/null && test -h y 2>/dev/null
+	ln -s x y && test -h y
 '
 
 # When the tests are run as root, permission tests will report that
