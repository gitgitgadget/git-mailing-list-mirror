From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Mon, 30 Apr 2012 19:20:16 +0200
Message-ID: <87vckhuofj.fsf@thomas.inf.ethz.ch>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
	<xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
	<xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
	"David Michael Barr" <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuGw-0002DG-4h
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab2D3RUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 13:20:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40664 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575Ab2D3RUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 13:20:19 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 30 Apr
 2012 19:20:17 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Apr
 2012 19:20:16 +0200
In-Reply-To: <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com> (Junio
	C. Hamano's message of "Fri, 27 Apr 2012 16:02:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196580>

Hi Junio,

I seem to have completely missed the earlier series at

  http://thread.gmane.org/gmane.comp.version-control.git/194660

My bad.

Thomas has been working on a prototype converter over the past few days,
with results similar to (but not quite as good as) your numbers

    $ ls -l .git/index*
    -rw-r----- 1 jch eng 25586488 2012-04-03 15:27 .git/index
    -rw-r----- 1 jch eng 14654328 2012-04-03 15:38 .git/index-4

while taking a different approach with different tradeoffs.

Nevertheless...

> +  (Version 4) In version 4, the entry path name is prefix-compressed
> +    relative to the path name for the previous entry (the very first
> +    entry is encoded as if the path name for the previous entry is an
> +    empty string).  At the beginning of an entry, an integer N in the
> +    variable width encoding (the same encoding as the offset is encoded
> +    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
> +    by a NUL-terminated string S.  Removing N bytes from the end of the
> +    path name for the previous entry, and replacing it with the string S
> +    yields the path name for this entry.
[..]
> +  (Version 4) In version 4, the padding after the pathname does not
> +  exist.

I think there are actually several separate ideas here:

* The prefix compression.  Thomas is not using this idea; we've been
  toying with making the index bisectable (within each directory) for
  fast single-entry lookups, which inherently conflicts with this.  The
  directory-like layout partially achieves the same (elides common path
  components).

* The varint encoding (or offset encoding, but "varint" is something you
  can google :-).  David suggested using it on stat() data, combined
  with zigzag encoding and delta against the first entry in the
  directory, which gives some good compression results.  Profiling will
  have to say whether the extra decoding effort is worth the space
  savings.

* The lack of variable padding, which is a good idea -- in any case I
  seem to remember Shawn complaining about it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
