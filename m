From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Documentation: Replace @@GIT_VERSION@@ in documentation
Date: Sun, 25 Mar 2007 22:33:42 -0700
Message-ID: <7v7it41scp.fsf@assigned-by-dhcp.cox.net>
References: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
	<11748238102228-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 07:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVhpz-0000EU-0w
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 07:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933590AbXCZFdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 01:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933593AbXCZFdo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 01:33:44 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64056 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933590AbXCZFdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 01:33:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326053344.CLJJ1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 01:33:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fHZi1W00B1kojtg0000000; Mon, 26 Mar 2007 01:33:43 -0400
In-Reply-To: <11748238102228-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sun, 25 Mar 2007 13:56:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43112>

Frank Lichtenheld <frank@lichtenheld.de> writes:

>  %.html : %.txt
>  	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
> +	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
> +	mv $@+ $@
>  
>  %.1 %.7 : %.xml
>  	xmlto -m callouts.xsl man $<
>  
>  %.xml : %.txt
>  	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
> +	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $@ >$@+
> +	mv $@+ $@
>  
>  user-manual.xml: user-manual.txt user-manual.conf
>  	$(ASCIIDOC) -b docbook -d book $<

Sorry, but these compositions are wrong, as the build procedure
can die after asciidoc finishes but before it manages to finish
sed/mv.  The next make invocation would not know that the
previous one did not complete and would assume that the build
product %.html or %.xml are up to date.

Ideally if we can persuade asciidoc to output to its stdout, we
could do this:

	rm -f $@+ $@
        $(ASCIIDOC) --to-stdout ... | sed -e $(script) >$@+
        mv $@+ $@
