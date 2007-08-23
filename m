From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 00:03:18 -0700
Message-ID: <7vodgyvikp.fsf@gitster.siamese.dyndns.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
	<7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
	<20070823060052.GA25153@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO6j2-0007tK-9N
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbXHWHDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbXHWHDY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:03:24 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbXHWHDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:03:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C8E88125418;
	Thu, 23 Aug 2007 03:03:41 -0400 (EDT)
In-Reply-To: <20070823060052.GA25153@piper.oerlikon.madduck.net> (martin
	f. krafft's message of "Thu, 23 Aug 2007 08:00:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56463>

martin f krafft <madduck@madduck.net> writes:

> also sprach Junio C Hamano <gitster@pobox.com> [2007.08.23.0009 +0200]:
>> We deliberately chose not to use that space, and this default is
>> very unlikely to change.
>
> The downsides included change in SHA hash on mode change, as far as
> I can remember. Anything else?

More serious practical problem was that sane developers tend to
have either 022 or 002 umask.  You may check out my project
(whose regular files are either 0664 or 0775, according to my
umask settings), but the checkout honors your umask and you
would get 0644 or 0755 on your copies, and you would check in
with differemtn modes.  The merge I would do later with you
would get needless conflicts on modes.

What makes the mode conflict "needless" is that we are primarily
talking about source code control, by the way.  It is very
reasonable if you want to retarget git, probably borrowing most
of its infrastructure, to build a backup system to keep track of
files in /etc hierarchy.  It would be crucial for _your_ system
to keep track of owner/group and mode bits.  If the modes or
ownership conflict during a merge, that is _not_ needless
conflict at all --- the user needs to decide if /etc/shadow
should or should not be world readable, and send a nasty message
to whoever asked you to pull such a change to make the file
world readable after you detect such a mistake while you are
merging.  It becomes essential to your "backup" system.

But in the context of git project, and source code management,
which is its primary application, it is not worth to keep track
of such mode differences that come from umask differences of
contributors.  You could add such a full-mode-bits and ownership
support to git, but that would stay secondary at best.  It is
entirely possible that the code to support such an extension
would be too intrusive to clutter git codebase, at which point
the "backup" application may have to become a fork of git, not
part of it.
