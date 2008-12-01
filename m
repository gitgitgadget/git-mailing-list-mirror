From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6 (v2)] Detecting HEAD more reliably while cloning
Date: Mon,  1 Dec 2008 06:12:49 -0800
Message-ID: <1228140775-29212-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Xd-0007j4-1k
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYLAONI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYLAONH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbYLAONF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76D5E83189
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A419683187 for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:12:56 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
X-Pobox-Relay-ID: 2B6EA3DA-BFB2-11DD-99E3-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102039>

This is another approach to the same problem that a repository cloned from
another repository whose default branch is not 'master' can use 'master'
as the default.

The current code has to guess where the HEAD in the original repository
points at, because the original protocol tells what object each ref points
at but does not talk about which other ref a symbolic ref points at.  The
implication of this is that if you prepare another branch that points at
your master, like this:

	$ git checkout -b another master

and keep that other branch checked out (and in sync with 'master'), a
clone made from such a repository may incorrectly have its HEAD pointing
at 'master', not 'another'.

Instead of introducing a full-fledged protocol extension, this round hides
the new information in the same place as the server capabilities list that
is used to implement protocol extension is hidden from older clients.
This way, it does not have to work around the code structure imposed by
the transport API, does not have to introduce an extra round trip, and
does not have to trigger an annoying (but harmless) error message when an
older client contacts a new uploader.

  [1/6] get_remote_heads(): refactor code to read "server capabilities"
  [2/6] connect.c::read_extra_info(): prepare to receive more than server
        capabilities
  [3/6] connect.c::read_extra_info(): find where HEAD points at
  [4/6] clone: find the current branch more explicitly
  [5/6] upload-pack: send the HEAD information
  [6/6] clone: test the new HEAD detection logic

The first four are the client side, the fifth one is the uploader side,
and the last one is the test.  After storing these patches in separate
files, you would build this history (on top of 'master'):

    git am 1 2 3 4
    git reset --hard HEAD~4    5---------------M---6
    git am 5                  /               /
    git merge HEAD@{2}        ---1---2---3---4
    git am 6

 builtin-clone.c  |   24 +++++++++++++++++++-----
 connect.c        |   47 +++++++++++++++++++++++++++++++++++++++++++----
 t/t5601-clone.sh |   11 +++++++++++
 upload-pack.c    |   14 +++++++++++---
 4 files changed, 84 insertions(+), 12 deletions(-)
