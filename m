From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 13:50:27 -0700
Message-ID: <7v4pifzawc.fsf@gitster.siamese.dyndns.org>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	<7vveav21uv.fsf@gitster.siamese.dyndns.org>
	<20070831152153.GA30745@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:50:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDRv-0002mi-I8
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 22:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbXHaUue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759064AbXHaUue
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:50:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbXHaUue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:50:34 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DA8D812BF8E;
	Fri, 31 Aug 2007 16:50:51 -0400 (EDT)
In-Reply-To: <20070831152153.GA30745@muzzle> (Eric Wong's message of "Fri, 31
	Aug 2007 08:21:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57204>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Curious.  I wonder how can it trigger.
>> 
>> Presimably, that while (<$fh>) loop is reading from git-log, and
>> the first line would look like "commit [0-9a-f]{40}" and will
>> set $hash, do "next".  Which means the variable should have been
>> initialized by the time the part that complains about string eq
>> (which I think is "if ($c && $c eq $hash)" comparison) is
>> reached.
>
> This could be a sign of a bigger problem.
>
> Does git-log read .git/config and that could potentially change
> its default output format?  A quick scan of the docs say "no".
>
> I remember using git-rev-list in the original code because git-log was
> (is still?) considered porcelain and less suitable for automated
> parsing...

Yes, git-log is Porcelain, and it is subject to this kind of
breakage.

I was almost going to suggest us to change "*.color = true" to
mean 'auto'.  Because git can internally use pager and has a way
for the user to control enabling/disabling colors when the pager
is used, there is no _logical_ reason to enable pager when the
output is not going to a tty.

However, people from CVS/SVN background are used to type:

	$ scm log | less

because they are not used to our "by default we page" setup, and
it is very understandable that they would want "*.color = true"
in their configuration honored in such a usage.

We probably should do two things to resolve this.

 * Protect our scripts.  When parsing from "git log" and any
   other Porcelain, explicitly give --no-color.

 * Educate users.  Tool output, even from Porcelain, are not to
   be colored or molested in any other way, when going to
   anywhere other than a tty.

   Say in the FAQ "if you are tempted to say *.color = true,
   stop.  Learn not to type the extra '| less' and let the
   internal pager take care of paging for you and you will be
   much happier".

Additionally we could do the following, but if we do the above
two properly, there should be no need to:

 * Declare "*.color = true" will mean "*.color = auto" in the
   next version, now.

 * Actually switch "*.color = true" to mean "*.color = auto"
   in the next version (not 1.5.3 but the one after that).

 * Perhaps introduce "*.color = always" at the same time we do
   the above switch, but I think that has the same issue as the
   current "true" has, so I doubt this step is needed.
