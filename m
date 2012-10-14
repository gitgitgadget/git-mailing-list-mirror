From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/2] Re: [PATCH] config: warn on inaccessible files
Date: Sun, 14 Oct 2012 02:26:50 -0400
Message-ID: <20121014062650.GC13477@sigill.intra.peff.net>
References: <20121014000210.GA19094@elie.Belkin>
 <7vhapx1wlh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:27:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHfE-0007UF-E1
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab2JNG0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:26:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51968 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab2JNG0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 02:26:52 -0400
Received: (qmail 18521 invoked by uid 107); 14 Oct 2012 06:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Oct 2012 02:27:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2012 02:26:50 -0400
Content-Disposition: inline
In-Reply-To: <7vhapx1wlh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207641>

On Sat, Oct 13, 2012 at 09:55:22PM -0700, Junio C Hamano wrote:

> > When ~/.gitconfig is unreadable (EPERM), the messages are a symptom of
> > an older issue: the config file is being ignored.  Shouldn't git error
> > out instead so the permissions can be fixed?  E.g., if the sysadmin
> > has set "[branch] autoSetupRebase" to true in /etc/gitconfig and I
> > have set it to false in my own ~/.gitconfig, I'd rather see git error
> > out because ~/.gitconfig has become unreadable in a chmod gone wrong
> > than have a branch set up with the wrong settings and have to learn to
> > fix it up myself.
> >
> > In other words, how about something like this?
> 
> I think that is a reasonable issue to address, but I wonder if we
> should be sharing more code between these.  If the config side can
> be switched to unconditionally attempt to fopen and then deal with
> an error when it happens, we can get rid of access_or_{warn,die}
> and replace them with fopen_or_{warn,die} and use them from the two
> places (attr.c:read_attr_from_file() and the configuration stuff).
> 
> I haven't looked to see if that a too intrusive refactoring to be
> worth it, though.

Handling the error at the fopen level would eliminate a minor race
condition (e.g., access() reports OK, then the file has its permissions
changed, then we fopen and get EPERM, but ignore it). So it would not
just be a refactoring, but would actually improve the code quality.

-Peff
