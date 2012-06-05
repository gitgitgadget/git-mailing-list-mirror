From: Jeff King <peff@peff.net>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 03:56:15 -0400
Message-ID: <20120605075614.GE25809@sigill.intra.peff.net>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
 <7vhauqsue3.fsf@alter.siamese.dyndns.org>
 <CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
 <7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
 <vpqpq9ejnxs.fsf@bauges.imag.fr>
 <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbocn-0005j6-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2FEH4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 03:56:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43125
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2FEH4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 03:56:17 -0400
Received: (qmail 14782 invoked by uid 107); 5 Jun 2012 07:56:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 03:56:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 03:56:15 -0400
Content-Disposition: inline
In-Reply-To: <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199214>

On Tue, Jun 05, 2012 at 09:23:47AM +0200, Stefan Beller wrote:

> So I am using /dev/sda4 on /home type ext4 (rw), but my user account
> has its home directory encrypted via ecryptfs.

It's very likely that ecryptfs is the problem, then. Googling around, I
find conflicting reports on whether it actually supports ACLs or not.

At the top of the test script we check that "setfacl" doesn't report an
error, and assume that ACLs work if it doesn't. Maybe that test needs to
be more comprehensive, like the patch below. What happens when you run
t1304 with this patch (my expectation is that it will just skip the acl
tests)?

-- >8 --
Subject: t1304: improve setfacl prerequisite setup

Some filesystems will cause "setfacl" to report success, even
though they do not seem to behave sanely enough for our
tests. Let's make sure that not only does setfacl work, but
that we can read back the result.

Since we're making the setup more complex, let's move it
into its own test. This will hide the output for us unless
the user wants to run "-v" to see it (and we don't need to
bother printing anything about setfacl failing; the
remaining tests will properly print "skip" due to the
missing prerequisite).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1304-default-acl.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 2b962cf..be954f0 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -14,16 +14,13 @@ umask 077
 # We need an arbitrary other user give permission to using ACLs. root
 # is a good candidate: exists on all unices, and it has permission
 # anyway, so we don't create a security hole running the testsuite.
-
-setfacl_out="$(setfacl -m u:root:rwx . 2>&1)"
-setfacl_ret=$?
-
-if test $setfacl_ret != 0
-then
-	say "Unable to use setfacl (output: '$setfacl_out'; return code: '$setfacl_ret')"
-else
-	test_set_prereq SETFACL
-fi
+test_expect_success 'checking for a working acl setup' '
+	if setfacl -m u:root:rwx . &&
+	   getfacl . | grep user:root:rwx
+	then
+		test_set_prereq SETFACL
+	fi
+'
 
 if test -z "$LOGNAME"
 then
