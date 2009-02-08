From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyCurrentBranch
Date: Sat, 07 Feb 2009 22:43:16 -0800
Message-ID: <7vwsc11la3.fsf@gitster.siamese.dyndns.org>
References: <20090208042910.19079.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 07:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW3QP-00061y-BB
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 07:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbZBHGnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 01:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZBHGnY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 01:43:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZBHGnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 01:43:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8487F97CA8;
	Sun,  8 Feb 2009 01:43:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 562B497CA7; Sun,
  8 Feb 2009 01:43:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6D718E6-F5AB-11DD-A0D2-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108923>

"George Spelvin" <linux@horizon.com> writes:

> (Prompted by the 1.6.2-rc0 announcement.)
>
> Myself, I always thought the obvious way to handle this problem was to
> detach the HEAD.  Is there a reson there's no "detach" option for this?

Let's first think about why pushing into the current branch with the
traditional behaviour is bad.

If you are in control of the remote whose current branch was checked out
when push was made, there are two cases:

 (1) You do not know what you are doing.  The first time you do "git diff
     HEAD", or perhaps "git status", you suddenly see a lot of reverts,
     sctach your head and cry for help;

     If you set 'detach' option, this clueless user is not helped; he will
     happily keep working and would make tons of commits on detached HEAD,
     and next time he switches to another branch, will lose all of them.

     In a sense, this is a lot worse than the current behaviour, because
     you will do a lot more damage than just a single commit that has many
     uninteniontal reverts as what currently happens---which can be sorted
     out.

 (2) You know what you are doing.  You'd say:

	: detach HEAD at the commit before the push updated the branch
	$ git checkout @{1}  
	$ work work work
        $ git commit

     to detach the HEAD, finish the work you were doing in the pushed-into
     repository and then:

	: check out the previous branch (i.e. go back)
	$ git checkout @{-1}
	: merge the last commit, i.e. the work you done on detached HEAD
        $ git merge @{1}

    If you allow 'detach' option, then you saved him from typing "git
    checkout @{1}".  Not a big gain, especially if you compare this with
    increased pain you are causing to people in category (1).

The case where the pushed-into repository is not yours was discussed
previously by Jeff King in the second thread below.

Previous discussions.

    http://thread.gmane.org/gmane.comp.version-control.git/35770/focus=36291
    http://thread.gmane.org/gmane.comp.version-control.git/100339/focus=100731
