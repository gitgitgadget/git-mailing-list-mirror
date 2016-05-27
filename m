From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Fri, 27 May 2016 16:01:02 +0200
Message-ID: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Cc: e@80x24.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	gitster@pobox.com, aaron@schrab.com,
	"Samuel GROOT # This line is ignored ." 
	<samuel.groot@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6IKE-0005FU-Dd
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcE0OBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:01:12 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:47660 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcE0OBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:01:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C3A082570;
	Fri, 27 May 2016 16:01:07 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrtN3nhcC3G9; Fri, 27 May 2016 16:01:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B222C256E;
	Fri, 27 May 2016 16:01:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id ABBCC2077;
	Fri, 27 May 2016 16:01:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRZ78-maYQCL; Fri, 27 May 2016 16:01:07 +0200 (CEST)
Received: from wificampus-031045.grenet.fr (wificampus-031045.grenet.fr [130.190.31.45])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 830BB2055;
	Fri, 27 May 2016 16:01:07 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.537.gb153d2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295753>

While working on the new option `quote-email`, we needed to parse an
email file. Since the work is already done, but the parsing and data
processing are in the same loop, we wanted to refactor the parser, to
make the code more maintainable.

This is still WIP, and one of the main issue (and we need your
advice on that), is that around 30 tests will fail, and most of them
are false-negatives: to pass, they rely on the format of what is
displayed by `git send-email`, not only data.


For example, several tests will fail because they do a strict compare
between `git send-email`'s output and:

   (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
   (mbox) Adding cc: One<one@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'

Though `git send-email` now outputs something like:

   (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>'
   (mbox) Adding cc: One<one@example.com>  from line 'Cc: One<one@example.com>'

The new behavior is explained because parsing and processing are not
done in the same function, and processing cannot know the exact line
the data came from.

We can think of several solutions:

   1. Modify the parser, to give the script the knowledge of the exact
      line the data came from.

   2. Hack the tests: modify the script using the parser to artificially
      recreate the supposedly parsed line.
      (e.g. with a list.join(', ')-like function)

   3. Modify the tests to replace exact cmp by greps.


IMHO, we should consider option 3, since the tests should rely on data
rather than exact outputs. It also makes the tests more maintainable,
in the sense that they will be more resilient to future output
modifications.

What do you think?


   [WIP-PATCH 1/2] send-email: create email parser subroutine
   [WIP-PATCH 2/2] send-email: use refactored subroutine to parse patches

git-send-email.perl | 284 ++++++++++++++++++++++++++++++++++++++++++++--------------------------------
  1 file changed, 164 insertions(+), 120 deletions(-)
