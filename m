From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Index format v5
Date: Thu, 3 May 2012 21:11:38 +0200
Message-ID: <8762cdm651.fsf@thomas.inf.ethz.ch>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	<7vd36lf634.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>, <mhagger@alum.mit.edu>, <peff@peff.net>,
	<spearce@spearce.org>, <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 21:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1RJ-0007pJ-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab2ECTLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:11:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28916 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab2ECTLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:11:41 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 21:11:39 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 21:11:39 +0200
In-Reply-To: <7vd36lf634.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 May 2012 11:54:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196944>

Junio C Hamano <gitster@pobox.com> writes:

>> [6] The length of the file name was dropped, since each file name is
>>     nul terminated anyway.
>
> This is micronit, but I think we do this to save one strlen() for each
> read of the entry, except for unusually long paths where we fall back to
> strlen(). A change like this needs to be justified better than simply
> saying "because we _could_ compute in a different way by spending extra
> cycles".

(Partially also answering the whole "what are these offsets" confusion)

The bisectability has evolved to the point where we envision the
structure of a "flat list" (the directories, and the files in each
directory) to have the format

  offset to entry 1 [1]
  ....
  offset to entry n

  entry 1, consisting of:
    name, nul-terminated
    rest of data:
      for dirs: cache-tree sha1, offset to files, etc.
      for files: stat data, content sha1, flags, etc.

That makes bisection very easy: the offsets point at the start of each
string, so you just strcmp() and get on with it.

On the other hand, by the time you can look at the flags, it's too late
for the strlen() optimization anyway, so meh.  If you think it's
important, we can perhaps lay it out so the rest of the data goes
immediately after the pointer.  But so far it wasn't clear whether it's
fixed-size, or uses some smart compression scheme.  Tonight's edition
has a fixed length, so perhaps it would be preferable to keep the
length.


Footnotes: 
[1]  It probably doesn't matter whether this is relative to the position
of the offset, or absolute (in terms of file pointer).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
