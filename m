From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Bug in test-lib.sh: test_create_repo() / RFC
Date: Mon, 20 Apr 2009 16:51:18 +0200
Message-ID: <49EC8BE6.2030709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvurj-0005uy-SV
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbZDTOv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbZDTOv0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:51:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49715 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755548AbZDTOv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 10:51:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 70DF331C71A
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 10:51:25 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 20 Apr 2009 10:51:25 -0400
X-Sasl-enc: cTqQTtPqVZlILLykgZl3yhTlB/cX8i/M4/FDDS1g4CqZ 1240239085
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EEC742103A
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 10:51:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116997>

Hi there,

running the test suite with -v for the upcoming release exposed a
certain problem with test_create_repo() whose consequences I can't quite
fathom at the moment. That means: I don't know whether it's maint
material or forbidden fruits during rc-cycle...

Problem:
Since a6d63b7 (test-lib: avoid assuming that templates/ are in the
GIT_EXEC_PATH, 2009-02-04), test_create_repo() assumes to be called from
a directory such that `pwd`/../templates/blt/ contains templates for
git-init.

Several tests (see below) call test_create_repo() from a different
directory, which means the repo is created without any of the default
files (and that a mv .git/hooks .git/hooks-disabled later in the
function errors out). Now, for most tests this probably doesn't matter
at all but it's not nice.

RFC:
I see several possible solutions:

- Make sure all tests use test_create_repo() from t/. Cumbersome and
fragile.

- Simply use $(TEST_DIRECTORY)/../templates/blt/. Nice and easy. But
uses the templates from the git repo containing t/ even when testing
against and installed git (just like now, for most of the tests).

- Teach git a "--templates-dir" option similar to "--html-path" and use
that (from the git actually being tested). Means we use the templates
belonging to the tested git; but also means we can test only git
versions containing that new option.

What do you think?

Michael

Affected tests:
t0050-filesystem.sh
t1007-hash-object.sh
t1302-repo-version.sh
t2103-update-index-ignore-missing.sh
t4027-diff-submodule.sh
t5300-pack-object.sh
t5513-fetch-track.sh
t5600-clone-fail-cleanup.sh
t5601-clone.sh
t5700-clone-reference.sh
t5710-info-alternate.sh
t6026-merge-attr.sh
t7001-mv.sh
t7010-setup.sh
t7401-submodule-summary.sh
t7506-status-submodule.sh
t7508-status.sh
