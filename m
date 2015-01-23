From: Jeff King <peff@peff.net>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 13:55:58 -0500
Message-ID: <20150123185558.GC32191@peff.net>
References: <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
 <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
 <20150123133033.GA27692@peff.net>
 <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
 <20150123183737.GA32191@peff.net>
 <321a67762d18795b743b242618950849@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:56:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjOo-0004Gg-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbbAWS4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:56:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:37994 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751130AbbAWS4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:56:00 -0500
Received: (qmail 23231 invoked by uid 102); 23 Jan 2015 18:56:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 12:56:00 -0600
Received: (qmail 22749 invoked by uid 107); 23 Jan 2015 18:56:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 13:56:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 13:55:58 -0500
Content-Disposition: inline
In-Reply-To: <321a67762d18795b743b242618950849@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262946>

On Fri, Jan 23, 2015 at 07:46:36PM +0100, Johannes Schindelin wrote:

> > ? And then you can spell that first part as assert(), which I suspect
> > (but did not test) may shut up clang's warnings.
> 
> To be quite honest, I assumed that Git's source code was
> assert()-free. But I was wrong! So I'll go with that solution; it is
> by far the nicest one IMHO.

OK, here it is as a patch on top of js/fsck-opt. Please feel free to
squash rather than leaving it separate.

I tested with clang-3.6, and it seems to make the warning go away.

-- >8 --
Subject: [PATCH] fsck_msg_severity: range-check enum with assert()

An enum is passed into the function, which we use to index a
fixed-size array. We double-check that the enum is within
range as a defensive measure. However, there are two
problems with this:

  1. If it's not in range, we then use it to index another
     array of the same size. Which will have the same problem.
     We should probably die instead, as this condition
     should not ever happen.

  2. The bottom end of our range check is tautological
     according to clang, which generates a warning. Clang is
     not _wrong_, but the point is that we are trying to be
     defensive against something that should never happen
     (i.e., somebody abusing the enum).

We can solve both by switching to a separate assert().

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 15cb8bd..53c0849 100644
--- a/fsck.c
+++ b/fsck.c
@@ -107,7 +107,9 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 {
 	int severity;
 
-	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
+
+	if (options->msg_severity)
 		severity = options->msg_severity[msg_id];
 	else {
 		severity = msg_id_info[msg_id].severity;
-- 
2.3.0.rc1.287.g761fd19
