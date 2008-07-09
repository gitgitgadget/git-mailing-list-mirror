From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
	subroutines
Date: Wed, 9 Jul 2008 18:03:03 +0200
Message-ID: <20080709160303.GL10151@machine.or.cz>
References: <200807031824.55958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGc9I-0005nn-Ut
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 18:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbYGIQDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 12:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754959AbYGIQDJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 12:03:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38240 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842AbYGIQDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 12:03:08 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2A46D2C4C023; Wed,  9 Jul 2008 18:03:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807031824.55958.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87890>

  Hi!

On Thu, Jul 03, 2008 at 06:24:53PM +0200, Jakub Narebski wrote:
> There are also a few things which I'd like some comments about:
> 
>  * Do config_val_to_bool and config_val_to_int should be exported
>    by default?

  Yes with the current API, not with object API (see below). But if
exported by default, there should be definitely a git_ prefix.

>  * Should config_val_to_bool and config_val_to_int throw error or
>    just return 'undef' on invalid values?  One can check if variable
>    is defined using "exists($config_hash{'varname'})".

  I think that it's more reasonable to throw an error here (as long as
you don't throw an error on undef argument). This particular case is
clearly a misconfiguration by the user and you rarely need to handle
this more gracefully, I believe.

>  * How config_val_to_bool etc. should be named? Perhaps just
>    config_to_bool, like in gitweb?

  What about Git::Config::bool()? ;-) (See below.)

>  * Is "return wantarray ? %config : \%config;" DWIM-mery good style?
>    I am _not_ a Perl hacker...

  I maybe wouldn't be as liberal myself, but I can't tell if it's a bad
style either.

>  * Should ->get_config() use ->command_output_pipe, or simpler
>    ->command() method, reading whole config into array?

  You have the code written already, I'd stick with it.

>  * What should ->get_config() have as an optional parameter:
>    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?

  Do we even _need_ a parameter like that? I don't understand what is
this interface trying to address.

>  * Should we perltie hash?

  I agree with Lea that we should actually bless it. :-) Returning a
Git::Config object provides a more flexible interface, and you can also
do $repo->get_config()->bool('key') which is quite more elegant way than
the val_ functions, I think. Also, having accessors for special types
lets you return undef when the type really isn't defined, instead of
e.g. true with current config_val_bool, which is clearly bogus and
requires complicated code on the user side.

> As this is an RFC I have not checked if manpage (generated from
> embedded POD documentation) renders correctly.

  By the way, unless you know already, you can do that trivially by
issuing:

	perldoc perl/Git.pm

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
