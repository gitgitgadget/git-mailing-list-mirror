From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ambiguous date handling
Date: Wed, 12 Sep 2012 09:58:20 -0700
Message-ID: <7vligfdvpv.fsf@alter.siamese.dyndns.org>
References: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
 <7v4nn3fu6s.fsf@alter.siamese.dyndns.org> <50505F61.8040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 18:59:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBqHM-0004QF-2E
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 18:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760571Ab2ILQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 12:58:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760558Ab2ILQ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 12:58:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A579BD0;
	Wed, 12 Sep 2012 12:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6VNHA9bbX6gVcn4I3udowS1kBk=; b=Xw7S18
	yNkyHR8P/kAZ3hyvlO/Ztv0oeK1u3blPvuTMAG1x74JN/mgZu16oB6rH+0MYwPJ+
	U+l/wfm+Tn+a4ueH+cso8bsnKyTBl/OxyhYVbAzRUNyvSktap4EZf0DgPikVIPy6
	7tzb5/gk/PtjiwbLQwPo1tzccArLg1mAJWyyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G5bUNoFqaKF3ctgzW/e8PJeHPhXT0FBt
	02IMnMUcqOFrjFZzwCQe2lCKNueVBCw62lZVbOBDn0qyjJJRqpESZ4FERg+Ty2KK
	pShrFqLwLTyxl/5vHQevU0NQdXWEUmVibbezKgZ/gL0Jf/tZIWnebxW+Uz/rm1tz
	Iv7w3gO3kLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 503F79BCF;
	Wed, 12 Sep 2012 12:58:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AA3E9BCE; Wed, 12 Sep 2012
 12:58:21 -0400 (EDT)
In-Reply-To: <50505F61.8040100@gmail.com> (Chris Packham's message of "Wed,
 12 Sep 2012 22:09:37 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EF51362-FCFB-11E1-A615-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205307>

Chris Packham <judge.packham@gmail.com> writes:

> Consistent as long as you save as the default .txt. Some people have
> trained themselves to use the save as .eml option which uses RFC822
> style output.

Yuck.

> Could this be done in a applypatch-msg
> hook?

Isn't the hook about fixing up the log message?  Also I do not think
the name of the original file is given to the hook, so there is no
sufficient information to allow it to switch between two behaviours
based on .txt or .eml.

But if you are massaging the _input_ to "git am", then you can
certainly do the massaging even _before_ you feed it to "git am", no?

We could think about adding a new hook to "git am", though.  It
cannot just be an option to "git am" (or "git mailinfo") that says
"if the input is .txt, assume European date order for \d+/\d+/\d+
dates, and otherwise assume US style", as that is too specific to
your particular set-up and will not match general needs.  If we were
to add such a hook, $GIT_DIR/hooks/am-input-filter might look
something like this (it is left as an exercise to enhance it to
avoid munging a payload outside the header that happens to begin
with "Date: "):

	#!/bin/sh
        case "$#" in
	0)
		cat
        	;;
	*)
        	for i
                do
                	case "$i" in
		        *.txt)
				sed -e 's/^\(Date: \)(\d+/)(\d+/)(\d+)/\1\3\2\4/' "$i"
				;;
			*)
                        	cat "$i"
				;;
			esac
		done
                ;;
	esac

and then teach "am" to use the hook, perhaps like the attached.

But at that point, wouldn't it be far simpler and cleaner if you did

	$ my-mbox-munge mail.txt | git am

in the first place?

 git-am.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git i/git-am.sh w/git-am.sh
index c682d34..42654a0 100755
--- i/git-am.sh
+++ w/git-am.sh
@@ -265,7 +265,16 @@ split_patches () {
 		else
 		    keep_cr=
 		fi
-		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
+
+		if test -x "$GIT_DIR"/hooks/am-input-filter
+		then
+			mif="$GIT_DIR"/hooks/am-input-filter
+		else
+			mif=cat
+		fi
+
+		"$mif" "$@" |
+		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr >"$dotest/last" ||
 		clean_abort
 		;;
 	stgit-series)
