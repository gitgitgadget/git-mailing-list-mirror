From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 0/5] make open/unlink failures user friendly on windows
	using retry/abort
Date: Mon, 7 Feb 2011 21:48:18 +0100
Message-ID: <20110207204818.GA63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY0Y-0001eq-VD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1BGUsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:48:21 -0500
Received: from darksea.de ([83.133.111.250]:37590 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751798Ab1BGUsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:48:20 -0500
Received: (qmail 11683 invoked from network); 7 Feb 2011 21:48:18 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 21:48:18 +0100
Content-Disposition: inline
In-Reply-To: <7vmxo6pxyi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166281>

This is the fourth iteration of my patch series with hopefully all the
mentioned issues addressed.

On Wed, Dec 15, 2010 at 12:45:09PM -0800, Junio C Hamano wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > Perhaps instead we would be better of with something like an xunlink
> > (etc) in wrapper.c that deals with this on all platforms (and make
> > sure that unlink sets errno to EBUSY correctly if it doesn't already)?
> 
> That is superficially similar to the way we let xread() silently handle
> short read to give us an easier to use API.  Especially, the part to
> silently retry for a few times is similar to xread() recovering by
> repeating short reads.
> 
> I do not think "ask the user one last time" part belongs to such a
> wrapper, though.

I think we should currently keep this Windows specific because this is the
only system where such problems occur in practise. If we find later on
that other systems are affected with the same problem we can still move
the functions to another more public place. But without proper testing
whether it helps on other setups as well putting this into a more
prominent place does not make sense, IMO.

Cheers Heiko

Heiko Voigt (4):
  mingw: move unlink wrapper to mingw.c
  mingw: work around irregular failures of unlink on windows
  mingw: make failures to unlink or move raise a question
  mingw: add fallback for rmdir in case directory is in use

Johannes Schindelin (1):
  mingw_rmdir: set errno=ENOTEMPTY when appropriate

 compat/mingw.c |  168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   14 ++---
 2 files changed, 173 insertions(+), 9 deletions(-)

-- 
1.7.4.34.gd2cb1
