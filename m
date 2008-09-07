From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A git problem with timestamps
Date: Sun, 07 Sep 2008 13:03:26 -0700
Message-ID: <7vvdx7lo4x.fsf@gitster.siamese.dyndns.org>
References: <200809070954.03394.armyofthepenguin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rod <armyofthepenguin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQVv-0007aI-J4
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYIGUDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755569AbYIGUDe
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:03:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbYIGUDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:03:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 685A2774D5;
	Sun,  7 Sep 2008 16:03:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E4E93774D4; Sun,  7 Sep 2008 16:03:28 -0400 (EDT)
In-Reply-To: <200809070954.03394.armyofthepenguin@gmail.com>
 (armyofthepenguin@gmail.com's message of "Sun, 7 Sep 2008 09:54:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BF3742C-7D18-11DD-8496-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95169>

Rod <armyofthepenguin@gmail.com> writes:

> Here are the git commands Fred is attempting to use:
> # Branch the *base* of master
> git checkout -b updated_original_source_code 345678
>
> cp ../updated_source_code.tar.gz .
> tar zxvf updated_source_code.tar.gz
>
> # Commit all changes from original_source_code
> # to updated_source_code
> git -a -m "Updated original source code"
>
> # Now apply the history of master onto this branch:
> # This is where they get hosed because the timestamps
> # from Barney's commits are wrong, and hence the 
> # generated patches are out of order.
> git format-patch 345678..master | git am -k -3

First of all, the branch name "updated_original_source_code" does not make
much sense.  When you get another round of source tarball update, what
would you do?  Create "updated_original_source_code_2"?  The one after
that is "updated_original_source_code_3"?

That misses the whole point of revision control, doesn't it?

You instead keep an "upstream" branch, whose tip might be at 345678 before
accepting the tarball update, and you advance its tip only with the
upstream updates:

      Barney               o---o---o       o---o
                          /         \     /     \
      Fred   o---o---o---o---o---o---o---o---o---o
            /
        ---o---------------------------------------o
           ^                                       ^
           upstream ===== (tarball update) ======> upstream

You can tag its tip after every time you accept the tarball update from
your upstream.

A natural thing to do from there is to _merge_ upstream changes to your
shared development, that results in:


      Barney               o---o---o       o---o
                          /         \     /     \
      Fred   o---o---o---o---o---o---o---o---o---o---*
            /                                       /
        ---o---------------------------------------o
           ^                                       ^
           upstream ===== (tarball update) ======> upstream

Of course you could rebase all history on top of updated upstream (buy why
bother? -- you are not keeping a linear history by cross merging between
two developers already, so there is no point doing a "format-patch | am"
sequence to linearlize your history at this point), and --topo-order given
to format-patch may help with broken timestamps one of you recorded.
