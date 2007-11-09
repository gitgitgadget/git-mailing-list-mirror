From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 10:24:14 -0800
Message-ID: <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYXP-0005HT-5n
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXKISYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 13:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbXKISYX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:24:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38030 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXKISYW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 13:24:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EE4222F0;
	Fri,  9 Nov 2007 13:24:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FB2693030;
	Fri,  9 Nov 2007 13:24:39 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711091702190.4362@racer.site> (Johannes
	Schindelin's message of "Fri, 9 Nov 2007 17:05:17 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64242>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 9 Nov 2007, Kristian H=C3=B8gsberg wrote:
>
>> This fixes the race in the last test int t3700.
>
> Well, it is not a race.  My fault.  I thought it was.
>
> What you basically did was to make sure that the index is up-to-date =
after=20
> adding the files.  You might even want to say that in the commit mess=
age,=20
> and only then say that it fixes t3700, too.

Ah, it all makes sense.  I should have been more relaxed and
careful when I first read your t3700 patch.

If this were a breakage in racy-git-avoidance code, then
refresh_cache() Kristian added (or "add --refresh" immediately
after "git commit" in the test script) would have been fooled by
the same raciness and wouldn't have changed a thing.

This discussion exposes a problem with add_files_to_cache()
function.

Try this in a clean repository that tracks Makefile:

	$ git diff-files --name-only    ;# no output
        $ touch Makefile
        $ git diff-files --name-only
	Makefile
        $ git add -u
        $ git diff-files --name-only
	Makefile
        $ git add Makefile
        $ git diff-files --name-only    ;# no output

I think this is a broken behaviour.  As long as we are adding
the contents from a path on the filesystem to the corresponding
location in the index, it should sync the stat bits for the
entry in the index with the filesystem to make the entry
stat-clean.  IOW, we should not see stat-dirtiness reported
after "add -u".

The funny thing is that add_files_to_cache() run by "git add -u"
calls add_file_to_cache() to add the updated contents for
touched paths, but the latter function is used in the more
explicit "git add Makefile" codepath, without any magic
postprocessing after the function returns to sync the stat
info.  IOW, both "add -u" and "add Makefile" ends up calling
add_file_to_cache("Makefile") and I do not see why we are
getting different results.

And add_file_to_cache(), which calls add_file_to_index() on
the_index, does call the fill_stat_cache_info() to sync the stat
information by itself, as it should be.  I am still puzzled with
this.

So I think Kristian's two refresh_cache() do fix the issue, but
at the same time I _think_ it is a workaround for broken
add_files_to_cache() behaviour, which is what we should fix.
