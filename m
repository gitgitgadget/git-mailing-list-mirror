From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix testcase failure when extended attributes are in
 use
Date: Sun, 19 Oct 2008 12:59:06 -0700
Message-ID: <7viqro73w5.fsf@gitster.siamese.dyndns.org>
References: <20081011154107.GA14994@riemann.deskinm.fdns.net>
 <20081014021016.GB14994@riemann.deskinm.fdns.net>
 <7vbpxig4fb.fsf@gitster.siamese.dyndns.org>
 <20081019122419.GA2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, heikki.orsila@iki.fi
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:21:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KreU1-0008Lx-BU
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 22:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYJST7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYJST7U
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 15:59:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbYJST7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 15:59:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 945D971B6B;
	Sun, 19 Oct 2008 15:59:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 22CF871B69; Sun, 19 Oct 2008 15:59:13 -0400 (EDT)
In-Reply-To: <20081019122419.GA2015@riemann.deskinm.fdns.net> (Deskin
 Miller's message of "Sun, 19 Oct 2008 08:24:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A02C2C2-9E18-11DD-BD8F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98642>

Deskin Miller <deskinm@umich.edu> writes:

> My patch, on the other hand, is to deal with 'ls' output in case a file has
> certain filesystem extended attributes.  These could be e.g. POSIX ACLs, or a
> SELinux security context, or perhaps others.  If such an extended attribute is
> present, 'ls -l' will print permissions with a '+' appended, e.g.
> -rw-r--r--+
> Instead of
> -rw-r--r--
> ...
> For what it's worth, I've experienced this failure on my Ubuntu 8.04 laptop
> with SELinux permissive mode, so it's possible ls behaves slightly differently
> on other systems; I've not been able to determine this one way or another.

Is there way to explicitly tell "ls -l" not to do this, I have to wonder?

POSIX.1 says that the file mode written under the -l option is
"%c%s%s%s%c" (where the first %c is for type, three %s are for owner,
group and other perm, and the last %c is "optional alternate access method
flag").  If there is no alternate or additional access control method
associated with the file, the "optional alternate access method flag"
would be a single SP, otherwise it would be a printable character.

If we drop the default ACL from the trash directory like Matt's patch
does, does a file created in there (i.e. the ones we check with /bin/ls)
still have "alternate or additional access control method associated with"
it?

Somehow it feels wrong that you need your patch, but if you do, stripping
only the trailing '+' as your patch does not look sufficient, either.
Shouldn't we be stripping the last letter if the length of actual is
longer than strlen("-rwxrwxrwx"), as any printable can come there?

 t/t1301-shared-repo.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git c/t/t1301-shared-repo.sh i/t/t1301-shared-repo.sh
index 2275caa..653362b 100755
--- c/t/t1301-shared-repo.sh
+++ i/t/t1301-shared-repo.sh
@@ -20,6 +20,10 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	test $ret != "0"
 '
 
+modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
 for u in 002 022
 do
 	test_expect_success "shared=1 does not clear bits preset by umask $u" '
@@ -85,8 +89,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(ls -l .git/info/refs)" &&
-		actual=${actual%% *} &&
+		actual="$(modebits .git/info/refs)" &&
 		test "x$actual" = "x-$y" || {
 			ls -lt .git/info
 			false
@@ -98,8 +101,7 @@ do
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
-		actual="$(ls -l .git/info/refs)" &&
-		actual=${actual%% *} &&
+		actual="$(modebits .git/info/refs)" &&
 		test "x$actual" = "x-$x" || {
 			ls -lt .git/info
 			false
