From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
 with --graph
Date: Mon, 07 Apr 2008 01:21:47 -0700
Message-ID: <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jimcq-0005DR-9a
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbYDGIWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbYDGIWE
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:22:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbYDGIWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:22:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF62AA650;
	Mon,  7 Apr 2008 04:21:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1DCEDA64F; Mon,  7 Apr 2008 04:21:54 -0400 (EDT)
In-Reply-To: <1207555281-9362-2-git-send-email-adam@adamsimpkins.net> (Adam
 Simpkins's message of "Mon, 7 Apr 2008 01:01:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78963>

Adam Simpkins <adam@adamsimpkins.net> writes:

> The old code took care of these cases for CMIT_FMT_ONELINE, but not for
> CMIT_FMT_USERFORMAT.  For CMIT_FMT_USERFORMAT, show_log() left each
> entry without a terminating newline.  The next call to show_log() would
> then try to print an extra blank line between entries.

The log family traditionally defined LF (or NUL when -z is in effect) as
separator between each pair of entries, not as terminator after each
entry.

This was because it would make much more sense to use separator semantics
when "git log -2" and "git log -1" is asked for.  The former gives the
tip, separator (typically an extra LF), and the second, while the latter
just shows the tip.  Neither case give extra LF after the last entry.
This worked only because each entry were supposed to end with its own LF,
so separator literally "separated" each entry with an extra blank line.

ONELINE however is special cased, because it makes no sense to give an
extran blank line to separate each entry.  Compactness is the point of the
format.

Switching separator semantics to terminator semantics in USERFORMAT
unconditionally is a bit problematic, because the userformat can be used
to format multi-line entries and in that case you may want the usual
"extra blank to separate" semantics, but it often is used to define an
alternate oneline format, in which case you do want terminator semantics
instead.

I suspect that --pretty=format: (i.e. userformat) should have a way to
explicitly tell which is wanted.  Perhaps we can keep the separator
semantics not to break existing users, and introduce a dummy expand item
(say, '%_') and when it appears in the pattern it would ask for the
terminator semantics instead?

In any case, I'm happy to see that somebody started looking into this, as
this "separator vs terminator" issue in userformat has been nagging me for
quite a while.  It might be good idea to have the change independently
from the graph extension first and then build the graph stuff on top of
the solidified base.  I dunno...
