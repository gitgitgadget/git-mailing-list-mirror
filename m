From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Thu, 6 Jan 2011 09:05:00 -0800
Message-ID: <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PatHD-0007UF-Au
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab1AFRFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 12:05:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52264 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab1AFRFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 12:05:21 -0500
Received: by iwn9 with SMTP id 9so16448263iwn.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 09:05:20 -0800 (PST)
Received: by 10.231.199.77 with SMTP id er13mr8669478ibb.44.1294333520671;
 Thu, 06 Jan 2011 09:05:20 -0800 (PST)
Received: by 10.231.168.3 with HTTP; Thu, 6 Jan 2011 09:05:00 -0800 (PST)
In-Reply-To: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164643>

On Wed, Jan 5, 2011 at 18:29, Zenaan Harkness <zen@freedbms.net> wrote:
> Bittorrent requires some stability around torrent files.
>
> Can packs be generated deterministically?

No.  We have been trying to avoid doing that, because it ties us into
one particular compression scheme.  We can't tune the algorithm and
get better compression later, because it would generate a different
pack.  We also rely on the system's libz to generate the compressed
data.  A version change to libz may generate a different encoding for
the same uncompressed data, simply because they made a tweak to how
the compression was performed.  Likewise our own delta compression
code can be tweaked to produce a different (but logically identical)
delta between the same two objects.

Right now packs aren't deterministic because they use multiple threads
to generate the deltas, the thread scheduling impacts which base
objects deltas are tried against because threads can steal work from
each other if one finishes before the other one.  Disabling threading
entirely slows down delta compression considerably on multi-core
machines, but does remove this work-stealing, making the pack
deterministic... but only for this exact Git binary, with this same
shared libz.  If the system libz or Git changes, all bets are off.

We've been down this road before; we don't want to box ourselves into
a tight corner by setting for all time these tunable portions of the
compression algorithms.

-- 
Shawn.
