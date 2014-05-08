From: Junio C Hamano <gitster@pobox.com>
Subject: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 13:52:38 -0700
Message-ID: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 22:53:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVJK-0002Uy-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbaEHUwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:52:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57622 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbaEHUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:52:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B06B11627E;
	Thu,  8 May 2014 16:52:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	FC8NU9UhHeIDNu1q5DKrohQJ7w=; b=tZ9GcgP0Z3vE6c3kae9zeq5QDtW4n3cgP
	KNI4ZGQyJC2ueFSXdFE8SxaN7V/KPOYOH6paX6oFWRfaGnSW2Jvpaw7PVO0O+eve
	28lZc7MoBv4WUHYUuINv33Pxx2/kLxqn82cjDb4UYTV+X2LEREs/sRzTPntZhtze
	y1u0DMaBNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fpt
	hHmR9qvahVG6M9+ftwCjSjPp7CviSmEhbDSRhPP59i/YMdVSUFaF+M/h0ruUT2rk
	WqUjucjFGwTDkWYw0jKjoNziW9m7g3O1rsnH7GVmkQ5JwNWB1PV2naFH/rt6QtcQ
	2BR8o9MVPITqOwFgdWlRbW7OPyUPnVuvsP/9+QvU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5FA51627D;
	Thu,  8 May 2014 16:52:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77BB01626F;
	Thu,  8 May 2014 16:52:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1D1FCEE-D6F2-11E3-BDCF-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248446>

If you run

    $ git blame -L103,107 v2.0.0-rc0..v2.0.0-rc2 t/t9117-git-svn-init-clone.sh

you will see something like this:

    ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 103) 
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
    ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 105)         test...
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
    ^cc29195 (Junio C Hamano 2014-04-18 11:21:43 -0700 107)         test...

It is correct to attribute these lines that have not changed since
the bottom of the range (i.e. v2.0.0-rc0) to that commit, and it may
be technically correct to show my name because I recorded the tree
that contains these lines as v2.0.0-rc0 with that commit.

But I find it really misleading, as this is the true picture if we
dug to the bottom of the history:

    $ git blame -L103,107 v2.0.0-rc2 t/t9117-git-svn-init-clone.sh
    f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 103) 
    7bbc458b (Kyle J. McKay 2014-04-22 04:16:22 -0700 104) test_expect_...
    f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 105)  test ! -d p...
    7bbc458b (Kyle J. McKay 2014-04-22 04:16:22 -0700 106)  git svn ini...
    f849bb6b (Johan Herland 2013-10-11 14:57:06 +0200 107)  test_must_f...

I do not expect Johan's name to appear in the output for the first
one, because that would require us to dig deeper than the commit we
were told to stop at, but I am wondering if we can do better than
the existing "-b" option to reduce the confusion from the output.

The "-b" option blanks the commit object name, but still shows the
name and timestamp for the bottom commit:

             (Junio C Hamano 2014-04-18 11:21:43 -0700 103) 
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
             (Junio C Hamano 2014-04-18 11:21:43 -0700 105)         test...
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
             (Junio C Hamano 2014-04-18 11:21:43 -0700 107)         test...

I am tempted to say "blame that is run without the --porcelain
option is a end-user facing Porcelain, and people should not be
reading its output in their scripts" and change the behaviour of the
"-b" option to instead show something like this instead:
    
    ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 103) 
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
    ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 105)         test...
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
    ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 107)         test...

which shows the commit object name, its bottom-ness and the
timestamp, or even

             (                                         103) 
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
             (                                         105)         test...
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
             (                                         107)         test...

which does away with the misleading information altogether.

I myself is leaning towards the latter between the two, and not
overriding "-b" but introducing another "cleanse the output of
useless bottom information even more" option.

Opinions?
