From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvs revision number -> git commit name?
Date: Wed, 27 Jan 2010 00:38:52 -0800
Message-ID: <7vpr4wq6w3.fsf@alter.siamese.dyndns.org>
References: <hbf.20100126bda0@bombur.uio.no>
 <bc341e101001261453u16124186i298a53ead0b4eee2@mail.gmail.com>
 <201001270043.44614.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Crane <git@aaroncrane.co.uk>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3Qg-0003kg-PA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0A0IjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584Ab0A0IjG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:39:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0A0IjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 03:39:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20A0A94EBC;
	Wed, 27 Jan 2010 03:39:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FoqPmP5TvsLSYdn59LaJlnFCJqE=; b=kFDbWa
	gl4ffx15rWog83NwwnOSnDruhfprmDWry89lkeNPqPdx1OT/qnLQ5QcaFejIl/he
	XaQ6GgEj31pDOloi421ZvlzJJUwkLmTHHhSm0B2w0S1tfhCCYIcGZmpLE+cAT+A6
	NqRekqKyoVW4MVu+XTK6zs3N3/Wl5/ayH+06A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hPClNqPzSa0IoN+n1lyVr6Jrhno7mv40
	VqQzcA0C6TI1q3YWQWnvn2CvtNMLYuLz+NLox5U53yP2oWInLUuTc4EYr8z/dsZy
	k8WzLqQ+WY10ZkEFbjo1O6SQOu4/mN/Ea/kh6budVuACrImbV54gFmZTVNf96qqu
	WKgff1XJEik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD88794EB6;
	Wed, 27 Jan 2010 03:38:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B960694EB5; Wed, 27 Jan
 2010 03:38:53 -0500 (EST)
In-Reply-To: <201001270043.44614.johan@herland.net> (Johan Herland's message
 of "Wed\, 27 Jan 2010 00\:43\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 699BFD10-0B1F-11DF-B339-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138116>

Johan Herland <johan@herland.net> writes:

> The notes feature is still very new, and there are still outstanding patches 
> to be merged, but the basics are there in v1.6.6.

By the way, we should seriously rethink how notes should propagate through
rebases and amends.  I've been using this in my post-applypatch hook
lately:

-- >8 -- cut here -- >8 --
#!/bin/sh
GIT_DIR=.git
dotest="$GIT_DIR/rebase-apply"

prec=4 &&
this=$(cat 2>/dev/null "$dotest/next") &&
msgnum=$(printf "%0${prec}d" $this) &&
test -f "$dotest/$msgnum" &&
message_id=$(sed -n '
	/^Message-I[Dd]:[ 	]*\(<.*>\)[ 	]*$/{
		s//\1/p
		q
	}
	/^$/q
' "$dotest/$msgnum") &&
test -n "$message_id" &&
GIT_NOTES_REF=refs/notes/amlog \
	git notes edit -m "Message-Id: $message_id" HEAD
-- 8< -- upto here -- 8< --

together with this in $HOME/.gitconfig

-- >8 -- cut here -- >8 --
[alias]
	lgm = "!sh -c 'GIT_NOTES_REF=refs/notes/amlog git log \"$@\" || :' -"
-- 8< -- upto here -- 8< --

so that I can say:

	$ git lgm -1 jh/maint-config-file-prefix
        commit 65807ee697a28cb30b8ad38ebb8b84cebd3f255d
        Author: Johan Herland <johan@herland.net>
        Date:   Tue Jan 26 16:02:16 2010 +0100

            builtin-config: Fix crash when using "-f <relative path>" from non-root dir

            When your current directory is not ...
	    ...

        Notes:
            Message-Id: <201001261602.16876.johan@herland.net>

A few observations I made myself so far:

 - I used to fix minor issues (styles, decl-after-stmt, etc.) using
   rebase-i long after running "am" in bulk, but these days I find myself
   going back to my "inbox" and fix them in MUA; this is only because I
   know these notes do not propagate across rebases and amends---adjusting
   the workflow to the tool's limitation is not very good.

 - The interface to tell tools to use which notes ref to use should be
   able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=a:b
   just like PATH=a:b:c...); I am fairly certain that we would want to
   store different kind of information in separate notes trees and
   aggregate them, as we gain experience with notes.

 - There should be an interface to tell tools to use which notes refs via
   command line options; "!alias" does not TAB-complete, and "git lgm"
   above doesn't, either. "git log --notes=notes/amlog --notes=notes/other"
   would probably be the way to go.

 - While reviewing the "inbox", I sometimes wonder if I applied a message
   to somewhere already, but there is no obvious way to grep in the notes
   tree and get the object name that a note is attached to.  Of course I
   know I can "git grep -c johan@herland.net notes/amlog" and it will give
   me something like:

    notes/amlog:65807ee697a28cb30b8ad38ebb8b84cebd3f255d:1
    notes/amlog:c789176020d6a008821e01af8b65f28abc138d4b:1

   but this won't scale and needs scripting to mechanize, once we start
   rebalancing the notes tree with different fan-outs.  The end user (me
   in this case) is interested in "set of objects that match this grep
   criteria", not "the pathnames the notes tree's implementation happens
   to use to store notes for them in the hierarchy".
