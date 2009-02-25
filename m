From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug?] "git am --abort" loses previous "git add"
Date: Wed, 25 Feb 2009 10:23:12 -0800
Message-ID: <7v8wnu2x67.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 19:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcOR4-0006Wu-FI
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbZBYSXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 13:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbZBYSXT
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:23:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbZBYSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 13:23:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DC8F9DD30;
	Wed, 25 Feb 2009 13:23:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 519499DD2C; Wed,
 25 Feb 2009 13:23:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E9510C8-0369-11DE-BC6D-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111475>

Consider this sequence:

    pwd/master$ git add file
    pwd/master$ git am 0001-patch.txt
    Dirty index: cannot apply patches (dirty: file)
    pwd/master|AM$ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       new file:   file
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       0001-patch.txt
    pwd/master|AM$ git am --abort
    pwd/master$ git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       0001-patch.txt
    #       file

"git am" itself correctly detected that the index is dirty, and refrained
from doing anything (other than creating and leaving .git/rebase-apply).
It carefully kept what you added so far to the index.

But "git am --abort" is broken and loses the added changes from the index.

There probably are two possible fixes (I am not familiar with the --abort
that was bolted on recently, and haven't checked the code).

 - Perhaps when "git am" fails with a dirty index (i.e. not even starting
   to look at the patches and stopping with unapplicable patches), we
   should discard .git/rebase-apply directory so that we do not even have
   to tell users to run "git am --abort";

 - Perhaps "git am --abort" can be told to tell this case from the usual
   "patch in progress" case, and act differently.

My preference obviously would be the latter, as .git/rebase-apply/ could
be the only place that has the patches fed to "git am" from its standard
input.
