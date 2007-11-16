From: Junio C Hamano <gitster@pobox.com>
Subject: Re: preserving mtime
Date: Fri, 16 Nov 2007 02:21:36 -0800
Message-ID: <7v1waqze1b.fsf@gitster.siamese.dyndns.org>
References: <473D63F9.4010201@inrim.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabrizio Pollastri <f.pollastri@inrim.it>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsyKk-0000fa-V0
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 11:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbXKPKVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 05:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbXKPKVn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 05:21:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47693 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130AbXKPKVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 05:21:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E98BF2EF;
	Fri, 16 Nov 2007 05:22:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 77AF694104;
	Fri, 16 Nov 2007 05:22:00 -0500 (EST)
In-Reply-To: <473D63F9.4010201@inrim.it> (Fabrizio Pollastri's message of
	"Fri, 16 Nov 2007 10:33:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65213>

Fabrizio Pollastri <f.pollastri@inrim.it> writes:

> is it possible to tell git to preserve the file modification time in a
> checked out copy? It is useful when managing web files, where mtime is
> tested by spiders for download decisions.

"git checkout branchA" after "git checkout branchB" would not
touch "file" if "file" are identical between two branches, so
the modification time is already preserved.

If the contents of "file" from the version you would want to
check out is different from the version you previously checked
out, and you still want to keep the old timestamp, then you are
trying to do something that a normal SCM user would actively not
want (e.g. doing so would screw up the build systems such as
"make").  Such a specialized need usually is addressed by the
build and install procedure of the application (in your case, a
website management).  Maybe your current build procedure may
blindly copy when installing:

	install: web.html
        	$(install) web.html $(dest)/var/www/web.html

but you may want to ignore certain classes of changes and avoid
re-installing to help crawlers.  You would do:

	install = ./myinstall.sh
	install: web.html
        	$(install) web.html $(dest)/var/www/web.html

and then ./myinstall.sh might look like:

	#!/bin/sh
	test -f "$2" &&
        compare-ignoring-minor-changes "$1" "$2" && exit 0
	install "$1" "$2"
