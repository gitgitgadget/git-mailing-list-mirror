From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 22:45:49 +0100
Message-ID: <1628833.9HksdDrMW8@al>
References: <6997784.RuzRO1AFsK@al> <xmqqsiherirj.fsf@gitster.dls.corp.google.com> <12667112.uUCmIHHWmi@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1SL-0003D1-9P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbaKXVp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:45:57 -0500
Received: from lekensteyn.nl ([178.21.112.251]:54872 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbaKXVp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=epcfzmFHVP6ftnxst+hoDMrzs8/j2CW97kCVYXykLFU=;
	b=qQ4ibc0cAMYO9GP0iAj7zoIjJd63VkxIUAD8gKJSXJG8TrHotYilck3EZ41CK9i2/dm3bDjBbU5IXbLe86RepzXlIZ+Q1CLCV2L9N+W6Q+mmCMnK6f9N8TJlfbG4b1CCAvmG82QrLlyIzJT9AMr3WqJMjnhxoLghKa6BrFO+ClciI2vjHxyY4JQWjnwBBS/ulIW3YVNCHGnxqxuCDuFnaFEpUSODV9FqrCfOW2PiI7GcklMA0jvXpRQrPOFbPFVy/H7miPnw/GmErdwlQRTvAW8wYeIg3neLkoyzXMFFfdtDPTlPa2JCTT3sl5cBY+U2eIqSeIlQWCB44+W3Bg3XCg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Xt1SA-00064P-IS; Mon, 24 Nov 2014 22:45:51 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <12667112.uUCmIHHWmi@al>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260154>

ping?

I asked around and the people who know of `git remote` fell in these two
categories:

 - those who know of this "bug" and then first set the fetch URL and
   then the push URL.
 - those who did not expect the current behavior.

The command 'git remote set-url NAME URL' reads as "set the URL(s) for
remote NAME to URL". Currently it means "set the fetch (and push) URL of
remote NAME to URL" (depending on whether pushurl is set).

I propose to add the option --fetch next to --push with the meaning "set
the fetch/push URL of remote NAME to URL". Then --fetch --push means
"set the fetch and push URL of remote NAME to URL". In a future git
version, this could be made the default option to avoid surprises (which
would be backwards incompatible though).

As for the changelog entry,

    The "git remote set-url" command now allows you to change just the
    fetch URL without modifying the push URL using the new --fetch
    option. For symmetry with the --push option.

("symmetry" in the eyes of the user, not how it is implemented in the
git config.)

Opinions?

On Wednesday 19 November 2014 22:28:35 Peter Wu wrote:
> On Wednesday 19 November 2014 13:18:56 Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > > Jeff King <peff@peff.net> writes:
> > > If you are fetching from somebody else and then pushing into your
> > > own publishing repository (i.e. fork of that upstream), why isn't
> > > the sequence of event like this, instead?
> > >
> > >     $ git clone $upstream
> > >     $ browser github.com
> > >     ... fork upstream to your own publishing repository ...
> > >     $ git remote set-url --push mine <url for your publish repo>
> > >
> > > Isn't this one of those bad workflows encouraged by GitHub, for
> > > which you guys have to be punished ;-)?
> 
> For "forks", it usually goes like this:
> 
>     git clone $upstream
>     ... realizes that is has a bug which I want to fix ...
>     ... creates a new repo ...
>     git remote rename origin upstream
>     git remote add origin git@$personal_repo
>     # "--fetch" is what I need
>     git remote add --fetch https://$personal_repo
> 
> I often start by entering/copying the ssh URL which is what I need for
> pushing. Later ssh-agent forget about my key and I realize that push
> works fine over https, so would like to set that... only to observe that
> is not possible in an straightforward way through 'git remote'.
> 
> > Coming back to the topic, how common would this "oops, I cloned via
> > a wrong transport" be?  I am not opposed to giving a recovery method
> > for gotcha that does not happen very often, but if such an addition
> > adds undue confusion factor for people who use "set-url" for more
> > common cases, that would be a bad trade-off.
> 
> Well, people rarely need to use 'git remote' except when, well, they
> need to modify the remotes. Where does the confusion come from? I might
> be biased now that I know the internals. Maybe the https/ssh case above
> needs to be mentioned in the documentation? What do you think of the
> updated documentation by the way?
