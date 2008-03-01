From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for git rebase --abort
Date: Sat, 01 Mar 2008 01:17:28 -0800
Message-ID: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org>
References: <1204322927-22407-1-git-send-email-mh@glandium.org>
 <7v63w7bb06.fsf@gitster.siamese.dyndns.org>
 <20080301073612.GA26767@glandium.org> <20080301074511.GB26767@glandium.org>
 <20080301081511.GA30613@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 10:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVNrP-00021D-P4
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 10:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYCAJRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 04:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYCAJRs
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 04:17:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYCAJRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 04:17:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0383B2CB3;
	Sat,  1 Mar 2008 04:17:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E46912CB1; Sat,  1 Mar 2008 04:17:37 -0500 (EST)
In-Reply-To: <20080301081511.GA30613@glandium.org> (Mike Hommey's message of
 "Sat, 1 Mar 2008 09:15:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75645>

Mike Hommey <mh@glandium.org> writes:

> On Sat, Mar 01, 2008 at 08:45:11AM +0100, Mike Hommey wrote:
>> On Sat, Mar 01, 2008 at 08:36:12AM +0100, Mike Hommey wrote:
>> > On Fri, Feb 29, 2008 at 03:26:01PM -0800, Junio C Hamano wrote:
>> > > Mike Hommey <mh@glandium.org> writes:
>> > > 
>> > > >  The failing test is the third. I don't have enough knowledge in git-rebase
>> > > >  to write an appropriate fix, but the problem seems to be in
>> > > >  move_to_original_branch, where testing head_name doesn't seem appropriate.
>> > > 
>> > > Please mark such an "expected to succeed but fails due to
>> > > suspected bug" with test_expect_failure.
>> > 
>> > I was kind of expecting the bug would be fixed before the test be
>> > included ;)
>> 
>> ... and the test actually passes with v1.5.0. I'll bisect.
>
> ... and I'm even the one to blame
> fb6e4e1f3f048898677f3cf177bfcaf60123bd5c is first bad commit

Heh, didn't you say you don't have enough knowledge in git-rebase? ;-)

I've applied the test with the following fixups.

 t/t3407-rebase-abort.sh |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index abdecc9..94bdd72 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -24,33 +24,33 @@ test_expect_success setup '
 '
 
 test_expect_success 'rebase --abort' '
-	! git rebase master &&
+	test_must_fail git rebase master &&
 	git rebase --abort &&
 	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
 '
 
-# In case previous test failed
-git reset --hard pre-rebase >&3 2>&4
-rm -rf .dotest # Should be changed whenever rebase stop using .dotest
+test_expect_failure 'rebase --abort after --skip' '
+	# Clean up the state from the previous one
+	git reset --hard pre-rebase
+	rm -rf .dotest
 
-test_expect_success 'rebase --abort after --skip' '
-	! git rebase master &&
-	! git rebase --skip &&
+	test_must_fail git rebase master &&
+	test_must_fail git rebase --skip &&
 	test $(git rev-parse HEAD) = $(git rev-parse master) &&
-	sh -x ../../git-rebase --abort &&
+	git rebase --abort &&
 	test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase)
 '
 
-# In case previous test failed
-git reset --hard pre-rebase >&3 2>&4
-rm -rf .dotest # Should be changed whenever rebase stop using .dotest
