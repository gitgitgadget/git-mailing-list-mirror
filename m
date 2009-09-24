From: Li Hong <lihong.hi@gmail.com>
Subject: [RFC] 'git cat-file' needs a better design on its option interface
Date: Thu, 24 Sep 2009 23:04:31 +0800
Message-ID: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 17:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqpt1-0003qW-5t
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 17:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZIXPEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 11:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbZIXPEa
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 11:04:30 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:43514 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbZIXPE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 11:04:29 -0400
Received: by vws41 with SMTP id 41so1124786vws.4
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=kpPwoEqY8vvSWW608ZIdeLEr+F4Pei+kk58TRFz0ZeY=;
        b=QsSZ1ePb1gjVSIFzLtSlAGU+C8/qhg51hZ9z0YiijPC+EDnMbAjQWtZfLL7mTh/Rf6
         PMLyTHrjoq99dYvxXR+m+s6CDpUVG49deqXaVWJVCKh+ae9uHIiWyazFUX2e5QfK36QI
         d9PvTWKYBDwnApHDWTJozyXR0EpJmjPSz7++o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=W9si8QBNw1TG3mmEIUk2Ozybvs87kP8S9NWPmKDbZrnrHr8KFDldK/TQmD9usc9jdR
         qJU8uK6KO1Asjo9hgteKz0EF/agkA/sQahDjgLAp60wjVDAGtxwuGQc2+ZM/JffVE1UZ
         7psBvr14I2bEamtSrDFkSL4HnlLpFSoLhW42k=
Received: by 10.142.152.6 with SMTP id z6mr290089wfd.138.1253804672082; Thu, 
	24 Sep 2009 08:04:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129046>

Hi All,

When using 'git cat-file' recently, I find its option interface is somewhat
inconvenient or mistakenly-designed.

	1. There is no default action. You have to use -p or <type> option,
	even for a simple look at the content of an object. It is better if
	we can provide a default action just like 'cat' does.
	
	2. Can't control the output. Several output options can't be used at
	the same time. Can't control what to output and how to output. I
	suggest here we use a simple format string to let the human being
	and other batch scripts happy.

	3. Batch mode is handled seperately and differently.

	4. <type> option has a mix meaning (raw print and object dereference)
	and is also inconsistent with -x style option.

	  * for raw print, an format char such as 'r' should be a good choice.
	  * for dereference, should use the uniform rev-naming. (e.g.
	    v0.99.8^{commit})


So I propose to amend the interface as follow:

	git cat-file [-b] [-f <fmt>] [-e] <args> ...

	-b	read more objects from stdin
	-f	provide a output format string
	-e	silent, exit with zero when there's no error

	the default action is to pretty-print the content when there is no
	other options except -b.

A format string example can be formed as follow (this needs more discuss):

	"blabla %t\s%s\t%h\n%p\n%r\n\n"

	%t: type
	%s: size
	%h: sha1
	%p: pretty-print
	%r: raw-print

However, this change will give a heavy impact on many documents and scripts
depending on this command. There are 233 references in source code according
to a trivial count 'grep -r "cat-file" * | wc -l', not to mention many
private usage of this command.

So this is just a RFC. If I can get a very positive feedback from the
community, I may start to do the real code change.

Any ideas?

- Li Hong
