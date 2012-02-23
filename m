From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/4] Making an elephant out of a getline() bug
Date: Thu, 23 Feb 2012 10:42:20 +0100
Message-ID: <cover.1329988335.git.trast@student.ethz.ch>
References: <7vty2i5ie2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VCP-0007kC-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab2BWJmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:42:33 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:34756 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab2BWJmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:42:31 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:27 +0100
Received: from thomas.inf.ethz.ch (129.132.209.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:28 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <7vty2i5ie2.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.209.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191341>

So you all made very good points, and I don't want to repeat them.
Junio's analysis

> Perhaps we would want to squash something like this to the test to avoid
> "seq", using J6t's idea.  The issue is that we do not write the end of
> line for the long boundary (because it is hidden from us), keep reading
> and rejecting bogus letters, and then the tip is written without
> terminating the boundary line.  So checking boundary line is not a very
> useful test, but "fetch" and "list-heads" are.

is of course also correct for the case where the overlong line is in a
boundary commit.  (The analysis about the accidentally-leading '-' is
also correct and can create a boundary line where there was none, like
in the perl case.)

The patches in this round are:

[1] new; following up on Peff's complaint that I should document
    strbuf_getwholeline_fd, I found that the strbuf_get*line
    documentation was also lacking.

[2] previously (1/2), now with documentation added

[3] new; Junio corrected me on the ': > file' spelling, which I added
    because the start of the test used it too.  So let's just fix it
    outright to match the Git style all over.

[4] previously (2/2), now incorporating a strbuf_release and the
    suggestions for the tests as sent by Junio.  I upped the %0982 a
    bit as it felt *too* tailored for the old bug, and this way
    everyone can see immediately that it will exceed the 1024 char
    limit (without thinking about the length of a sha and accounting
    for \0 and \n).

Thomas Rast (4):
  strbuf: improve strbuf_get*line documentation
  bundle: put strbuf_readline_fd in strbuf.c with adjustments
  t5704: match tests to modern style
  bundle: use a strbuf to scan the log for boundary commits

 Documentation/technical/api-strbuf.txt |   19 +++++++++++--
 bundle.c                               |   36 +++++++-----------------
 strbuf.c                               |   16 +++++++++++
 strbuf.h                               |    1 +
 t/t5704-bundle.sh                      |   47 ++++++++++++++++----------------
 5 files changed, 67 insertions(+), 52 deletions(-)

-- 
1.7.9.1.430.g4998543
