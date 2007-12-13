From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git config --get-regexp exit status
Date: Thu, 13 Dec 2007 10:06:33 -0800
Message-ID: <7vfxy631w6.fsf@gitster.siamese.dyndns.org>
References: <20071213133653.13925.89254.stgit@krank>
	<871w9qsoc8.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2sTS-0006AH-KK
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 19:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbXLMSG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbXLMSG7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 13:06:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbXLMSG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 13:06:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CF7069E2;
	Thu, 13 Dec 2007 13:06:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CC095EB9;
	Thu, 13 Dec 2007 13:06:36 -0500 (EST)
In-Reply-To: <871w9qsoc8.fsf@lysator.liu.se> (David =?utf-8?Q?K=C3=A5gedal?=
 =?utf-8?Q?'s?= message of "Thu,
	13 Dec 2007 14:42:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68180>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
> ...
> One thing that annoyed me what that "git config --get-regexp" will
> return zero, one, or more matches, which are all valid reponses. But
> it treats the zero-match special and return an exit status of 1.
>
> Is that a conscious choice, or just an effect of how "git config
> --get" works?
>
> Since zero matches isn't really an error, I would like the exit statu=
s
> to be 0. At least for this use case :-)

I would imagine "matching variant" may want to signal "I did not match
anything" as a special event, just like grep does.  As long as the
caller can distinguish "no match" from real failure cases (say, not in =
a
git repository and hence no configuration file), that is one valid use
of status code.

I haven't been annoyed by that myself, but I see what you mean.  "give
me all the matching ones" callers would want to consider zero match and
seven matches both the same way as non errors.  And similarity to "grep=
"
does not extend very far because there is no "--get-regexp" variant tha=
t
is quiet (i.e. "no output, just checking if there is a match").

So I do not mind if --get-regexp considered zero matches as non-error
myself.  If an existing script did something like:

	if list=3D$(git config --get-regexp '$pattern')
        then
        	# use list, without verifying if it is empty
                ...
	fi

such a change would break it, though.  But the script should have been
doing:

	LF=3D'
	'
	if list=3D$(git config --get-regexp '$pattern')
        then
		IFS=3D"$LF"
		for $list
                do
                	...
		done
	fi

anyway, so...
