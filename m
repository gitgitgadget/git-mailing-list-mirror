From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 08:53:48 +0200
Organization: glandium.org
Message-ID: <20080721065348.GB24608@glandium.org>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org> <20080721001422.GB12454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 08:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpIf-0004ww-79
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 08:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbYGUGyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 02:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbYGUGyN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 02:54:13 -0400
Received: from vuizook.err.no ([194.24.252.247]:44273 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168AbYGUGyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 02:54:12 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KKpHD-0007mh-KJ; Mon, 21 Jul 2008 08:53:49 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KKpHI-0006Vs-7L; Mon, 21 Jul 2008 08:53:48 +0200
Content-Disposition: inline
In-Reply-To: <20080721001422.GB12454@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89310>

On Sun, Jul 20, 2008 at 08:14:22PM -0400, Jeff King wrote:
> On Sun, Jul 20, 2008 at 11:23:13AM -0700, Junio C Hamano wrote:
> 
> > I think that is a very sensible approach, but just like we have a few
> > "built-in" function-header regexps with customization possibilities for
> > the user, we might want to:
> > 
> >  * Have that "-x", "-T" in the command line we generate for OpenSSH;
> 
> I am slightly negative on this, because we are setting OpenSSH
> preferences behind the user's back that they would not normally expect
> git to be tampering with.
> 
> I think the expectation for this is that it impacts only the ssh session
> used by git.  But because OpenSSH supports the concept of "master" and
> "slave" sessions (i.e., it can multiplex many sessions over a single ssh
> session, avoiding authentication and thus reducing latency until the
> start of the session), what you do in one session can impact other
> sessions. In particular, if the 'master' does not have x11 forwarding
> (because it happens to be started by git), then slave connections do not
> get it. So a user with X11Forwarding and ControlMaster set in his config
> would usually have everything work, but bad timing with the
> git-initiated session as the master would unexpectedly break his
> X11Forwarding for other sessions.
> 
> I don't know how commonly the ControlMaster option for openssh is used.
> I also don't know if this should simply be considered a bug in openssh,
> since it silently ignores the request for X forwarding.  Personally, I
> will not be affected because I don't do X forwarding by default, anyway.
> But I thought I would raise the point.

I'm not sure the ControlMaster option is still followed when using -T. 
Also, IIRC, ControlMaster doesn't exit until slave connections are
done, so git ssh sessions granted the master control would stall until
then if they happen to have slaves launched. i.e. It can *already* have
bad side effects.

Adding '-S none' would ensure ControlMaster would not take effect; on
the other hand, it would not allow git's ssh connection to be a slave
either. '-o ControlMaster no' could be a solution.

All these need to be tested, obviously.

Mike
