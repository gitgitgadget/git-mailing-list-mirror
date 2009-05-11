From: Cedric Staniewski <cedric@gmx.ca>
Subject: Re: [PATCH] Add NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile
Date: Mon, 11 May 2009 18:29:52 +0200
Message-ID: <4A085280.3090501@gmx.ca>
References: <loom.20090511T101424-212@post.gmane.org> <alpine.DEB.1.00.0905111256580.4973@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 11 18:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Yjc-0008Mz-FT
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbZEKQwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbZEKQwD
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 12:52:03 -0400
Received: from wp165.webpack.hosteurope.de ([80.237.132.172]:42490 "EHLO
	wp165.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251AbZEKQwA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 12:52:00 -0400
X-Greylist: delayed 1327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 12:52:00 EDT
Received: from f053229164.adsl.alicedsl.de ([78.53.229.164]); authenticated
	by wp165.webpack.hosteurope.de running ExIM  using esmtpsa (TLSv1:RC4-MD5:128)
	id 1M3YO1-0000CV-JI; Mon, 11 May 2009 18:29:53 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090319)
In-Reply-To: <alpine.DEB.1.00.0905111256580.4973@intel-tinevez-2-302>
X-bounce-key: webpack.hosteurope.de;cedric@gmx.ca;1242060722;9c12cf0c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118811>

Johannes Schindelin wrote:
> 	I do not understand how this commit could be responsible, but here 
> 	is an attempt to fix things.

The important difference is that before this commit, git-add was
hardlinked to a file outside of DESTDIR. Thus, when the build directory
was removed or you tar'ed DESTDIR, git-add was just a regular file and
all the other builtins were hardlinked to it.

Behavior before commit:
$ touch git git-add && mkdir bin libexec && cp git bin &&
ln git-add libexec/ &&                      ###  the relevant line
tar caf git.tar.gz bin libexec && tar tfv git.tar.gz

bin/
bin/git
libexec/
libexec/git-add


Behavior after commit:
$ touch git git-add && mkdir bin libexec && cp git bin &&
ln bin/git libexec/git-add &&               ### the relevant line
tar caf git.tar.gz bin libexec && tar tfv git.tar.gz

bin/
bin/git
libexec/
libexec/git-add link to bin/git
