From: Nick Bowler <nbowler@elliptictech.com>
Subject: Reverting a swath of commits consumes all memory and dies.
Date: Tue, 24 Apr 2012 12:14:03 -0400
Organization: Elliptic Technologies Inc.
Message-ID: <20120424161403.GA24738@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 18:14:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMiNZ-0004Et-O7
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 18:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab2DXQOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 12:14:08 -0400
Received: from mx.scalarmail.ca ([98.158.95.75]:36969 "EHLO
	ironport-01.sms.scalar.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756075Ab2DXQOG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 12:14:06 -0400
Received: from unknown (HELO sms-zimbra-mta-02.sms.scalar.ca) ([192.168.32.56])
  by ironport-01.sms.scalar.ca with ESMTP; 24 Apr 2012 12:14:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sms-zimbra-mta-02.sms.scalar.ca (Postfix) with ESMTP id CBB6B4C06E
	for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:14:04 -0400 (EDT)
Received: from sms-zimbra-mta-02.sms.scalar.ca ([127.0.0.1])
	by localhost (sms-zimbra-mta-02.sms.scalar.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEjpNJBHmBAE for <git@vger.kernel.org>;
	Tue, 24 Apr 2012 12:14:04 -0400 (EDT)
Received: from mail.ellipticsemi.com (dsl-67-204-24-19.acanac.net [67.204.24.19])
	(Authenticated sender: nbowler@elliptictech.com)
	by sms-zimbra-mta-02.sms.scalar.ca (Postfix) with ESMTPSA id CDB2287BFE
	for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:14:03 -0400 (EDT)
Received: by mail.ellipticsemi.com (nbSMTP-1.00) for uid 550
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	nbowler@mail.ellipticsemi.com; Tue, 24 Apr 2012 12:14:03 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196225>

Hi folks,

I just noticed that git-revert when given a large batch of commits will
consume more and more memory as commits are reverted.  Eventually, git's
usage exceeds about half of the available memory and dies because fork
fails with -ENOMEM.  This appears to be gratuitous, because after git
dies you can simply run

  git reset --hard
  git revert --continue

and the revert will pick up right where it left off.  Reverting commits
one at a time also works.  I can reproduce it (for example) with the
following example, using current master git:

  % git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  % cd linux
  % git revert --no-merges --no-edit HEAD~50..

watch git's memory usage increase indefinitely with "top", until...

  error: cannot fork() for commit: Cannot allocate memory
  fatal: revert failed

  % git reset --hard
  % git revert --no-edit --continue

repeat as needed until eventually there's few enough commits left that
the revert completes without running out of memory (or git-revert fails
for some other reason).

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
