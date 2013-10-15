From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: on broken command chains in tests (was: Re: [PATCH] status: show
 commit sha1 in "You are currently)
Date: Tue, 15 Oct 2013 15:35:16 +0200
Message-ID: <20131015133516.GC26156@goldbirke>
References: <1381507117-11519-1-git-send-email-ralf.thielow@gmail.com>
 <20131011174210.GS9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Matthieu.Moy@imag.fr,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 15:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW4mp-0001eB-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 15:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab3JONfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 09:35:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab3JONfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 09:35:43 -0400
Received: from localhost6.localdomain6 (g226140223.adsl.alicedsl.de [92.226.140.223])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MOVaj-1VQJc00XR7-005W7n; Tue, 15 Oct 2013 15:35:17 +0200
Content-Disposition: inline
In-Reply-To: <20131011174210.GS9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:1AMHxI1smzxFrAfKb9t+D6j0PrmSaYvJjbmmJz5MsXj
 9lKmtntUpeeghhWfVlmrCcU0wz6usATqVrjL+2QH939KwXtOXl
 RWT4HY8fE63rj8QdubODRQAPai9Xu5C0/bmPhFjBifNYtkHW4g
 rbj6BNAdOL/hiBWHWeech/YUvk8UKMXHBS0/zLX3i5I2E3Ask+
 DJoWWb1ceaNCVOiL4P3ZUvb0e5o3oVbHL92+O+URqnCa3MxnQQ
 nU0R8/0nR1CGgCSy+MdwhhA2bkdvWo6QcO/hA1cgeZdo9R8Jpf
 Fbm0WDFl+rKTFx+ccx9zFRWvjdX8IRflN4Yw1+4BM4+WRNTMQ4
 ODdHhB24hj+UyYpBuV80ySfWUnSllKX21xynMSfbs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236183>

Hi,

On Fri, Oct 11, 2013 at 10:42:10AM -0700, Jonathan Nieder wrote:
> -- >8 --
> Subject: status test: add missing && to <<EOF blocks
>=20
> When a test forgets to include && after each command, it is possible
> for an early command to succeed but the test to fail, which can hide
> bugs.

Surely you meant "succeed" and "fail" the other way around :)

> Checked using the following patch to the test harness:
>=20
> 	--- a/t/test-lib.sh
> 	+++ b/t/test-lib.sh
> 	@@ -425,7 +425,17 @@ test_eval_ () {
> 		eval </dev/null >&3 2>&4 "$*"
> 	 }
>=20
> 	+check_command_chaining_ () {
> 	+	eval >&3 2>&4 "(exit 189) && $*"
> 	+	eval_chain_ret=3D$?
> 	+	if test "$eval_chain_ret" !=3D 189
> 	+	then
> 	+		error 'bug in test script: missing "&&" in test commands'
> 	+	fi
> 	+}
> 	+
> 	 test_run_ () {
> 	+	check_command_chaining_ "$1"
> 		test_cleanup=3D:
> 		expecting_failure=3D$2
> 		setup_malloc_check

Clever.

If I do a

  -               error 'bug in test script: missing "&&" in test comma=
nds'
  +               say_color error 'error: bug in test script: missing "=
&&" in test commands'

to avoid erroring out and skipping the rest of the test script on the
first broken command chain, then we can see that we have a lot of
broken command chains in the test suite:

  $ for t in t[0-9][0-9][0-9][0-9]*.sh ; do ./$t ; done |grep -c '^erro=
r:.*missing "&&" in test commands$'
  345

After a cursory look most of them seem to be the simple "missing &&"
type, but there are some funny ones, too.


G=E1bor
