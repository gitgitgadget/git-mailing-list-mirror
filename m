From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 11:37:51 -0800
Message-ID: <7vzlxnrz00.fsf@gitster.siamese.dyndns.org>
References: <1194634238-3308-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZgG-00007J-Ox
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbXKITiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbXKITiA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:38:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35988 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366AbXKITh7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 14:37:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 52F792F9;
	Fri,  9 Nov 2007 14:38:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C71FB931AF;
	Fri,  9 Nov 2007 14:38:15 -0500 (EST)
In-Reply-To: <1194634238-3308-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 9 Nov 2007 13:50:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64254>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> This fixes the race in the last test in t3700-add.sh.
> add_files_to_cache() should leave the new index stat-clean, but some
> times it doesn't.  Calling refresh_cache() in a few places works
> around this for now.

Sorry, but this description based on my previous observation is
not quite right.

As we have been promising users that "git status" will clear
away the stat dirtiness, we should call refresh_cache() at the
end of prepare_index() regardless of the add_files_to_cache()
issue.  We need to refresh_cache() the whole thing, even if we
fixed add_files_to_cache() to add entries that are stat clean,
so this is not a workaround but implementation of the advertised
behaviour.  It does hide the problem add_files_to_cache() seems
to have, which we would need to fix independently.

I think the additional refresh_cache() for the user index you
did is also the right thing to do for the same reason.

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>
> Should we add the refresh_cache() call in add_files_to_cache() instea=
d?

I do not think so.  These two functions, add_files_to_cache()
and add_file_to_cache(), should make the entries they add to the
index stat-clean, but they should not spend extra cycles
scanning the whole index and re-statting the whole tree to
refresh entries the user did not mention.
