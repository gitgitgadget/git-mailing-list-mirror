From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Wed, 08 Aug 2007 15:59:56 -0700
Message-ID: <7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuVZ-0003je-IS
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934453AbXHHW77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934395AbXHHW76
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:59:58 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60884 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765534AbXHHW75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:59:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808225958.BSUI7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 18:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zazw1X00c1kojtg0000000; Wed, 08 Aug 2007 18:59:57 -0400
In-Reply-To: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	(David Kastrup's message of "Mon, 6 Aug 2007 12:22:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55391>

David Kastrup <dak@gnu.org> writes:

> @@ -139,6 +154,18 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
>  user-manual.html: user-manual.xml
>  	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
>  
> +git.info: user-manual.xml
> +	$(RM) $@ $*.texi
> +	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
> +	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\
> +"} elsif (/^\@direntry/) {print "\@dircategory Development\
> +\@direntry\
> +* Git: (git).           A fast distributed revision control system\
> +\@end direntry\
> +"} print unless (/^\@direntry/ .. /^\@end direntry/)' > $*.texi
> +	$(MAKEINFO) --no-split $*.texi
> +	$(RM) $*.texi
> +

This part worries me.

Historically (as you probably know, having suffered a lot more
than me with this issue), multi-line command script in Makefile
was hugely unportable.  Some "make" implementations stripped
backslash linefeed at the end, some other implementations
stripped only backslash, yet some other kept both backslash and
linefeed.  It was a mess.

Admittably we are already quite dependent on GNU make, so this
is probably not a huge deal, but I have a vague recollection
that even GNU make itself changed its behaviour over time with
respect to this exact area, and I had to adjust a few Makefiles
to accomodate both old and new GNU make.

The standard workaround is of course to have this perl script
part as a separate, "Documentation/fixup-texi.perl" script and
invoke it from the Makefile.
