From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about preserved permissions
Date: Wed, 22 Aug 2007 15:09:17 -0700
Message-ID: <7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Aug 23 00:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INyOV-0002mn-03
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 00:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758571AbXHVWJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 18:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759341AbXHVWJj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 18:09:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547AbXHVWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 18:09:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B7301266A0;
	Wed, 22 Aug 2007 18:09:56 -0400 (EDT)
In-Reply-To: <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> (Benoit
	SIGOURE's message of "Wed, 22 Aug 2007 14:18:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56429>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> Someone on IRC pointed me to http://git.or.cz/gitwiki/
> ContentLimitations which says:
>
> "By design, git cannot track other aspects of the filesystem, including:
>   * File modes (except for the "executable" bit, and being symbolic
> link)"
>
> That's weird since the file mode is saved in the tree, isn't there a
> way to ask Git to restore this file mode?

The wording you quoted is wrong.  By design, we "chose not to"
track other aspects, even though the underlying data structure
has enough space to use other bit patterns.

We deliberately chose not to use that space, and this default is
very unlikely to change.

In very early days of git, we allowed the work tree modes 0644
vs 0664 propagated back to the index modes and regular file
modes recorded in the tree entries.  This caused unnecessary
pain for poeple merging real projects for no real gain
whatsoever, and the behaviour was fixed to minimally track,
hence we do not track anything but executable bits.

I do not oppose to a new per-project configuration option to
make use of the existing space to record differences vs 0644 vs
0664 vs 0600.  However, I have already seen the downsides, so:

 (1) I am not interested in implementing that myself;

 (2) the places that canonicalize the mode bits obtained from
     the filesystem to 0644 is fairly centralized so it would
     not be too hard to implement (and that is one good reason
     why I do _not_ have to be the person to do so);

 (3) however, (2) means that everybody calls that
     canonicalization logic, and the unintended side effects
     need to be audited for codepaths of all the callers, which
     means a large test suite is probably needed; and

 (4) to me, reviewing such a patch will be much lower priority
     than other patches for the above reasons.
