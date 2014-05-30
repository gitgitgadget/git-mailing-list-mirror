From: Jeff King <peff@peff.net>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but
 processed BEFORE .gitconfig
Date: Fri, 30 May 2014 16:09:45 -0400
Message-ID: <20140530200945.GB5513@sigill.intra.peff.net>
References: <5388CBA5.9030403@neulinger.org>
 <20140530182746.GK12314@google.com>
 <5388D175.3060500@neulinger.org>
 <xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
 <5388E2F7.606@neulinger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nathan Neulinger <nneul@neulinger.org>
X-From: git-owner@vger.kernel.org Fri May 30 22:10:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqT81-0002SZ-1e
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934510AbaE3UKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:10:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:34403 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934432AbaE3UJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:09:47 -0400
Received: (qmail 29386 invoked by uid 102); 30 May 2014 20:09:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 15:09:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 16:09:45 -0400
Content-Disposition: inline
In-Reply-To: <5388E2F7.606@neulinger.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250474>

On Fri, May 30, 2014 at 02:58:47PM -0500, Nathan Neulinger wrote:

> Yes, the behavior currently is:
> 
> 	If I can figure out "who", I'll set the EMAIL/attributes based on that.
> 	If not, it'll default to the "don't know" behavior that throws up the list
> 
> Ideally, I'd prefer the second option be:
> 
> 	Force user to specify --author if a good default can't be determined
> 
> But there doesn't appear to be a way to do that.

Yeah, I don't think there is a blessed way to tell git "I am explicitly
_not_ giving you an identity". You can set user.email to "bogus.(none)"
which git will think "oh, I tried to get the FQDN, but failed". However,
that is not a documented interface, and I would not be surprised if it
changes in the future.

The instructions you get:

	*** Please tell me who you are.
	
	Run
	
	  git config --global user.email "you@example.com"
	  git config --global user.name "Your Name"
	
	to set your account's default identity.
	Omit --global to set the identity only in this repository.
	

are probably not helpful either (you do not want the user to run "git
config", as that would interfere with the other shared users).

> >If so, wouldn't it be a better option to use that mechanism to set
> >separate $HOME (or XDG_CONFIG_HOME if you prefer) to these real
> >users who share the account, so that separate $HOME/.gitconfig files
> >can be used by them?
> 
> Not really, since there are lots of servers, and lots of application/service
> accounts. Where filesystem acl'ing can be used reasonably, it is, making
> this moot, but it still boils down to example case of "I have a team of X
> people maintaining Y different applications, each on their own dedicated
> account". I'd just like a good mechanism to set defaults based on
> information other than what is in the home dir on the occasions that users
> log in directly to the app account, as opposed to doing updates offline on
> their own systems/to central repo/etc.

But I think anything you could set up in the environment could be set up
in an on-the-fly $HOME. For example, instead of:

  GIT_WEAK_AUTHOR_NAME=$name
  GIT_WEAK_AUTHOR_EMAIL=$email

do:

  HOME=$(mktemp -d gitenv.XXXXXX")
  trap 'rm -rf "$HOME"' 0
  git config --global user.name "$name"
  git config --global user.email "$email"

You'd want to link in anything else you actually _want_ in $HOME, but
that also gives an opportunity to set up application-specific options
based on the user (e.g., if you could pull their .vimrc from some shared
storage or something).

-Peff
