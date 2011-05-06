From: Jeff King <peff@peff.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 13:23:34 -0400
Message-ID: <20110506172334.GB16576@sigill.intra.peff.net>
References: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOki-0003RH-Cy
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab1EFRXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 13:23:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab1EFRXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:23:38 -0400
Received: (qmail 12054 invoked by uid 107); 6 May 2011 17:25:32 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 13:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 13:23:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172991>

On Sat, May 07, 2011 at 12:07:14AM +1000, Jon Seymour wrote:

> I think the problem we are trying to solve is this: how to make it as
> easy as possible to install, and get operational, an extension to git.
> 
> If git supported the concept of a standard place to put extensions,
> then it could be as simple as:
> 
>     unzip -d $(git --plugins-dir) plugin.zip
> 
> with no need to configure or choose a prefix and no need to edit the
> an .profile or .bashrc to permanently add a directory to the PATH.

This seems slightly backwards to me. You are asking git "where should
plugins go?" and then putting them there. But that leaves no room for
plugins going in _multiple_ places. IOW, the usual hierarchy of:

  1. distribution-packaged extensions (in /usr/share/git/plugins)

  2. local system-wide extensions (in /usr/local/share/git/plugins)

  3. per-user extensions (in $HOME/.gitplugins)

It seems like we should not be asking git, but _telling_ git about where
our plugins are. I understand that you don't want the user to have to do
any additional steps, and I think that is a reasonable goal. But can't
that be easily accomplished by:

  1. The git wrapper learns to look in a set of plugin paths, something
     like:

       foreach path in (list of plugin paths)
         foreach plugin in "path/*"
           add plugin/bin to PATH
           add plugin/man to MANPATH

  2. At compile time, we give some stock system directories like
     /usr/share/git/plugins and /usr/local/share/git/plugins.
     Distribution packages of git override as appropriate for the target
     system.

  3. We always check $HOME/.gitplugins by default.

  4. Users can set GIT_PLUGIN_PATH in the environment if they want to do
     something fancy (they can also always just set PATH and MANPATH
     manually if they want, too).

This is how many systems already work. For example, look at how vim
handles plugins.

Distro-packaged extensions obviously know where to go (the packager
knows their distro's rules). People with personal extensions don't have
to know anything special; their packages go in $HOME/.gitplugins.

In general I would expect /usr/local/share/git/plugins to be pretty
standard, and not needing of being repeated for admins who want to
install something system-wide. But if you want to be really thorough,
then your "git --plugins-dir" should probably report the "system-wide
but not distro" directory for that (but I would call it something like
"git --system-plugins-dir" or something to make it more clear).

-Peff
