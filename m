From: Mike Hommey <mh@glandium.org>
Subject: Re: Bug: version 2.4 seems to have broken `git clone --progress`
Date: Tue, 12 May 2015 09:22:42 +0900
Message-ID: <20150512002242.GA8523@glandium.org>
References: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
 <xmqq8ucu3jug.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack O'Connor <oconnor663@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 03:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YryYC-00021H-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 03:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbELA7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 20:59:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34493 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbbELA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 20:59:52 -0400
X-Greylist: delayed 2214 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2015 20:59:51 EDT
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Yrxy6-0002Qq-LR; Tue, 12 May 2015 09:22:42 +0900
Content-Disposition: inline
In-Reply-To: <xmqq8ucu3jug.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268835>

On Mon, May 11, 2015 at 02:06:15PM -0700, Junio C Hamano wrote:
> "Jack O'Connor" <oconnor663@gmail.com> writes:
> 
> > In git 2.3.7 I could run the following command and see progress in the
> > terminal, despite the redirection of stdout and stderr:
> >
> >     git clone https://github.com/oconnor663/dotfiles --progress 2>&1 | cat
> >
> > As of 2.4, that command no longer shows progress. When I bisect, the
> > responsible commit is 2879bc3b0c3acc89f0415ac0d0e3946599d9fc88
> > ("transport-helper: ask the helper to set progress and verbosity
> > options after asking for its capabilities"). Can anyone suggest a
> > workaround?
> >
> > -- Jack O'Connor
> 
> That commit is by Mike Hommey <mh@glandium.org> so I'd imagine that
> CC'ing the author of the patch would be the first thing to do ;-)
> 
> I am kind of surprised that the commit changes behaviour, though.
> If I didn't hear that you had trouble in 2.4, I would have suspected
> 85cb8906 (progress: no progress in background, 2015-04-13) instead.

So, the reason this is happening is that 2879bc3 moved sending the
progress helper option earlier, and for clone, it's early enough that
transport_set_verbosity happens afterwards. Since
transport_set_verbosity only sets the progress bit, and nothing re-emits
a helper option command when it changes, we're left with the default,
which is that no progress is shown if the output file descripto is not
a tty.

I can see two ways to fix this:
- Make transport_set_verbosity call transport->set_option instead of
  defering to standard_options() in transport-helper.c.
- Declare that transport_set_verbosity must be used before any other
  transport_set_option, and change clone to invoke it first. Note that
  fetch and push already do that, so this is only currently a problem
  for clone.

Junio, what do you think?

Mike
