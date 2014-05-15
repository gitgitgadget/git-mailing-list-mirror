From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/6] build argv_array into run-command
Date: Thu, 15 May 2014 04:29:44 -0400
Message-ID: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:29:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr36-0008GT-3n
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaEOI3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:29:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:52052 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750843AbaEOI3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:29:46 -0400
Received: (qmail 19926 invoked by uid 102); 15 May 2014 08:29:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:29:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:29:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249067>

The memory ownership of the "argv" array of a "struct child_process" can
be tricky. The child_process does not own the memory, but it must remain
valid until finish_command runs. That's easy for cases where we call
start_command and finish_command in the same function: you can use a
local array variable, or use an argv_array and cleanup afterwards.

But it's easy to screw up in cases where you want to start a command in
one function and finish it in another, either by pointing to invalid
storage during finish_command, or by leaking dynamically allocated
memory.

This series sticks an argv_array inside the "struct child_process",
which we clean up automatically.  Because some callers might not want to
use it, it's optional. If you provide "argv", we use that, and
otherwise fall back to the internal array.

The first commit below does that. The second fixes an uninitialized
memory access. 3, 4, and 5 plug memory leaks. 6 is just a cleanup for
consistency with the changes in 4 and 5.

And in 2, 3, and 5 we are introducing argv_array into new spots, which
simplifies the code and gets rid of magic numbers.

  [1/6]: run-command: store an optional argv_array
  [2/6]: run_column_filter: use argv_array
  [3/6]: git_connect: use argv_array
  [4/6]: get_helper: use run-command's internal argv_array
  [5/6]: get_exporter: use argv_array
  [6/6]: get_importer: use run-command's internal argv_array

-Peff
