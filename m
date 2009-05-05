From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Tue, 05 May 2009 03:41:05 -0700
Message-ID: <7vvdof25oe.fsf@alter.siamese.dyndns.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
	<1241431142-8444-3-git-send-email-ft@bewatermyfriend.org>
	<7v8wlc4fqo.fsf@alter.siamese.dyndns.org>
	<20090505084916.GB26208@fsst.voodoo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Tue May 05 12:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1I6V-0003UG-NG
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 12:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZEEKlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 06:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZEEKlH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 06:41:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58522 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbZEEKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 06:41:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090505104106.VOUI17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 5 May 2009 06:41:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id nmh61b0024aMwMQ03mh6Rx; Tue, 05 May 2009 06:41:06 -0400
X-Authority-Analysis: v=1.0 c=1 a=hvk-ZFxnSJEA:10 a=cJbXrRuCTcsA:10
 a=02rWKl3eAAAA:8 a=3nZ9WDlM6peFXs-dVWkA:9 a=waQXFvr5pd_1khS8tbLT3XLclPsA:4
 a=iVFYgQKhOj0A:10
X-CM-Score: 0.00
In-Reply-To: <20090505084916.GB26208@fsst.voodoo.lan> (Frank Terbeck's message of "Tue\, 5 May 2009 10\:49\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118288>

Frank Terbeck <ft@bewatermyfriend.org> writes:

> ... That could potentially break
> people's existing scripts - either by new default behaviour or by the
> setting of format.coverletter of an individual user. That could still
> happen when using coverauto, so maybe my reasoning was flawed - given
> that Stephen raised the same question.

That part I agree with 100%.  A separate configuration variable does not
help here; it will not act as an "I know what I am doing" flag.

"rebase" is not a problem because both format-patch and rebase come from
the same git and people do not mix and match.  The only thing we need to
do is to make sure that rebase is updated to explicitly decline the cover
letter in the same or earlier version of git that adds this new option.

However, there are other people's scripts to worry about, and no matter
what you do, you cannot avoid breaking them if you introduce a
configuration variable that changes the behaviour of the command in a
backward incompatible way.  This could be a disruptive change that needs
to happen at a major revision boundary, if we were to add it.

> If so, do you want coverletter to default to zero (which wouldn't
> change the default behaviour) or do you want it to default to two?

The default between 0 and 2 does not matter much.  If people find this new
feature useful (if not, then this new feature is not worth adding), then
they will set it to non-zero themselves, and then get their scripts
broken.  In a sense, defaulting it to zero is just delaying an inevitable
breakage.

If we were to do this, we should rather default it to two from day one and
make sure we break people's scripts that (rightly) rely on format-patch
not producing covers that the caller never asked, to make sure they are
adjusted to decline cover explicitly.  And such a release should come with
a note in huge red letters that says "this new feature allows you not to
say --cover on the command line, and it is far more important than keeping
your scripts that run format-patch and process its output working.  You
must adjust your scripts to the new reality.  Sorry for the inconvenience,
and have a nice day."

I do not think I would stand behind such a release note, though.

For one thing, I do not see a huge need for this configuration variable.
Why is "--cover" too cumbersome to type, when you are already willing to
type "format-patch"?  You can alias the whole thing away to make it even
shorter.  For another, we do not simply break people's scripts knowingly.

For this feature to go forward, somebody has to find a way not to break
people's scripts even when the user uses it.  One possibility is to find a
nicer verb X and introduce "git X" command that does what "format-patch"
does but with a better default (and syntax --- people get confused by the
oldest form "git format-patch $commit", which does not behave like "git
log $commit" simply because the syntax predates the modern "revision
range" notation the "log" family supports, such as A..B).
