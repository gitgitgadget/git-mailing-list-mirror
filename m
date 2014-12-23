From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 18:41:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info> <xmqqmw6e499u.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
 <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:41:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TSz-0000L6-T3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaLWRlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:41:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:64223 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbaLWRln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:41:43 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MVJze-1YOyKb0h7W-00Yen9;
 Tue, 23 Dec 2014 18:41:39 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7keifEFcba45WxtKSQPmXSiRmxAjLyiZ9JcFB0VHBgfSuVwrH6J
 ZWCaBM3zDr+ZiZ0AEkpoRsOwrS8JokTz2AjtKMYnzeeCI1fuKUljzAdEekR0Z87e1ShlhZR
 p5M1L/HPrz0/cjBgsCa3xmF2Ch8HyJQ1Kg0NykBTSFrLCgASxJxUR5ehXpGlFKsiUhfu1vs
 awv0O+/0kr/V3WTBGzV8Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261747>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The parser I wrote actually accepts both versions, allowing me to skip
> > the tedious step to convert the camelCased config setting into a
> > lower-case-dashed version to pass to `index-pack` or `unpack-objects`,
> > only to be parsed by the same parser as `fsck` would use directly.
> >
> > So I am rather happy with the fact that the parser handles both
> > camelCased and lower-case-dashed versions.
> 
> That is myopic view of the world that ignores maintainability and
> teachability, doing disservice to our user base.

Okay, so just to clarify: you want me to

- split the parser into

	- a parser that accepts only camelCased variable names when they
	  come from the config (for use in fsck and receive-pack), and

	- another parser that rejects camelCased variable names and only
	  accepts lower-case-dashed, intended for command-line parsing
	  in fsck, index-pack and unpack-objects, and

- consequently have a converter from the camelCased variable names we
  receive from the config in receive-pack so we can pass lower-case-dashed
  settings to index-pack and unpack-objects.

If you want it this way, I will do it this way.

> What message does it send to an unsuspecting new user that
> fsck.random-error is silently accepted (because we will never document
> it) as an alias for fsck.randomError, while most of the configuration
> variables will not take such an alias?

I will not participate in a discussion about consistency again. There is
nothing that can be done about it; what matters is what you will accept
and what not. I will make the code stricter (and consequently more
complex) if that is what you want.

> >> I suspect that it would be much better if the configuration variables
> >> were organized the other way around, e.g.
> >> 
> >> 	$ git config fsck.warn missingTagger,someOtherKindOfError
> >
> > I had something similar in an earlier version of my patch series, but
> > it was shot down rightfully: if you want to allow inheriting defaults
> > from $HOME/.gitconfig, you have to configure the severity levels
> > individually.
> 
> Hmmm.  What's wrong with "fsck.warn -missingTagger" that overrides
> the earlier one, or even "fsck.info missingTagger" after having
> "fsck.warn other,missingTagger,yetanother", with the usual "last one
> wins" rule?

I will change the code (next year...).

> >> But the proposed organization to use one variable per questionable
> >> event type (as opposed to one variable per severity level) would lead
> >> to a one-shot override of this form, e.g.
> >> 
> >> 	$ git fsck --missing-tagger=warn --some-other-kind-of-error=warn
> >> 
> >> which I think is insane to require us to support unbound number of
> >> dashed options.
> >
> > The intended use case is actually *not* the command-line, but the config
> > file, in particular allowing /etc/gitconfig, $HOME/.gitconfig *and*
> > .git/config to customize the settings.
> 
> But we do need to worry about one-shot override from the command
> line.  A configuration that sticks without a way to override is a
> no-no.

And of course you can, by specifying the config setting via the -c
command-line option. The only inconsistency here is that all other
command-line options are lower-case-dashed, while the config settings are
camelCased.

> >> Or are you saying that we allow "git config core.file-mode true" from
> >> the command line to set core.fileMode configuration?
> >
> > I do not understand this reference.
> 
> I was puzzled by your "command line" and wondering if you meant
> "from the command line, aVariable can be spelled a-variable".

Well, of course, if you call `git -c aVariable command
--option=a-variable` you have a nice accumulation of styles right there
;-)

> > I did not suggest to change `git config`, did I? If I did, I
> > apologize; it was definitely *not* my intention to change
> > long-standing customs.
> 
> Then fsck.missing-tagger is definitely out.  Long standing customs
> is that a multi-word token at the first and the last level is not
> dashed-multi-word.

But I already changed all of the patches to fsck.missingTagger.

The only thing I did not do yet is to split the parser into two, one
accepting only camelCased, one accepting only lower-case-dashed options,
and a translator to convert from camelCase to lower-case-dashed versions
(because it is a lot of work and additional complexity, as well as
opportunity for bugs to hide because we'll have three code paths). I asked
you above whether you want that, and I will do it if you say that you do.

Ciao,
Dscho
