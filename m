From: Mike Hommey <mh@glandium.org>
Subject: Re: Bug: version 2.4 seems to have broken `git clone --progress`
Date: Tue, 12 May 2015 11:54:47 +0900
Message-ID: <20150512025447.GA32735@glandium.org>
References: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
 <xmqq8ucu3jug.fsf@gitster.dls.corp.google.com>
 <20150512002242.GA8523@glandium.org>
 <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack O'Connor <oconnor663@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 04:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys0Le-0006pS-BH
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 04:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbbELCzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 22:55:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:36934 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbbELCzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 22:55:05 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Ys0LH-0000Ed-37; Tue, 12 May 2015 11:54:47 +0900
Content-Disposition: inline
In-Reply-To: <xmqqfv721rh7.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268840>

On Mon, May 11, 2015 at 07:04:20PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > So, the reason this is happening is that 2879bc3 moved sending the
> > progress helper option earlier, and for clone, it's early enough that
> > transport_set_verbosity happens afterwards. Since
> > transport_set_verbosity only sets the progress bit, and nothing re-emits
> > a helper option command when it changes, we're left with the default,
> > which is that no progress is shown if the output file descripto is not
> > a tty.
> >
> > I can see two ways to fix this:
> > - Make transport_set_verbosity call transport->set_option instead of
> >   defering to standard_options() in transport-helper.c.
> > - Declare that transport_set_verbosity must be used before any other
> >   transport_set_option, and change clone to invoke it first. Note that
> >   fetch and push already do that, so this is only currently a problem
> >   for clone.
> >
> > Junio, what do you think?
> 
> The latter sounds like more appropriate as a lower-impact short-term
> fix, so let's have that for now.
> 
> I however wonder if there are other settings that can be flipped
> after we started talking to the helper to cause a similar issue,
> and to prevent such breakages once and for all, we may have to
> take the former route in the longer term.  But I think that can be
> done later after the dust settles.

AFAICT, verbosity/progress is the only thing that is really treated
differently. transport_set_options always sends options to the remote
helper wire.

Mike
