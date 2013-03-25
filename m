From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/3] Recursion-free unpack_entry and packed_object_info
Date: Mon, 25 Mar 2013 19:07:38 +0100
Message-ID: <cover.1364234154.git.trast@student.ethz.ch>
References: <87620faky3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBoc-0002Ip-4W
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450Ab3CYSHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:07:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34151 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314Ab3CYSHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:07:44 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Mar
 2013 19:07:41 +0100
Received: from linux-k42r.v.cablecom.net (129.132.10.215) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Mar
 2013 19:07:41 +0100
X-Mailer: git-send-email 1.8.2.266.g8176668
In-Reply-To: <87620faky3.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [129.132.10.215]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219054>

This is a fixed version of the initial patch, plus a two-patch
implementation of a recursion-free unpack_entry.  (I narrowly resisted
using "unrecursify" to describe it.)

I wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The stack/recursion is used _only_ for error recovery, no?  If we do
>> not care about retrying with a different copy of an object we find
>> in the delta chain, we can just update obj_offset with base_offset
>> and keep digging.  It almost makes me wonder if a logical follow-up
>> to this patch may be to do so, and rewrite the error recovery
>> codepath to just mark the bad copy and jump back to the very top,
>> retrying everything from scratch.
>
> I totally agree.  I'll try this again -- my last attempt just didn't
> work out...

Now I remember why it wasn't possible: we would have to go through the
blacklists at every iteration, whereas now we only check them in the
initial lookups.

I'm not sure it makes that much sense.  If we need to shave off some
speed in these functions, I would rather:

- write packed_object_info so that it runs with constant space, and
  restarts another implementation _with_ the recovery stack if it hits
  a problem;

- write unpack_entry so that it reuses the stack.  It can't do so by
  using a static buffer because it needs to be reentrant in the error
  case.


Thomas Rast (3):
  sha1_file: remove recursion in packed_object_info
  Refactor parts of in_delta_base_cache/cache_or_unpack_entry
  sha1_file: remove recursion in unpack_entry

 sha1_file.c | 411 +++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 266 insertions(+), 145 deletions(-)

-- 
1.8.2.266.g8176668
