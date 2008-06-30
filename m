From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 23:47:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806292320300.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer> <alpine.LNX.1.00.0806291821520.19665@iabervon.org> <7vabh390sc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 05:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDANk-0006JU-QK
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 05:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYF3Drw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 23:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYF3Drw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 23:47:52 -0400
Received: from iabervon.org ([66.92.72.58]:46379 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbYF3Drv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 23:47:51 -0400
Received: (qmail 32656 invoked by uid 1000); 30 Jun 2008 03:47:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 03:47:50 -0000
In-Reply-To: <7vabh390sc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86869>

On Sun, 29 Jun 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > ... In any case, I don't think "git clone" is at 
> > all special with respect to GIT_CONFIG.
> 
> I think "git init" and "git clone" are very special with respect to
> GIT_CONFIG.
> 
>  * When "init" is run to create a new repository and initialize it, the
>    user would want the initial set of configuration populated in the
>    configuration file _for that repository_.  There however may be some
>    customization that affects the way how "init" operates, which might be
>    taken from $HOME/.gitconfig.  The meaning of GIT_CONFIG can get fuzzy
>    here.  Possibilities:
> 
>    (1) Instead of $HOME/.gitconfig (or /etc/gitconfig), the user might
>        want such customizations to be read from the file specified by
>        GIT_CONFIG.  But the user wants to make the resulting new
>        repository usable without any custom GIT_CONFIG set (i.e. its
>        $GIT_DIR/config will be the place the configuration is written).
> 
>    (2) The user may want to create a new repository that cannot be used
>        with GIT_CONFIG (for some strange reason), i.e. no $GIT_DIR/config
>        for the repository, and GIT_CONFIG is used to specify where that
>        separate configuration file for the new repository is.  The way
>        "init" operates does not come from that configuration file that is
>        to be created but from elsewhere.
> 
>  * When "clone" is run, the same confusion as initializing "init" applies.
>    In addition, custom GIT_CONFIG to read customizations for behaviour of
>    "init" and "fetch" that is done internally by "clone" would play larger
>    role.
> 
>  * When "init" is run to reinitialize an existing repository, it is not
>    special in any way with respect to GIT_CONFIG, compared to other
>    commands.  The GIT_CONFIG names the configuration for that existing
>    repository, so we read from it and write to it.
> 
> I personally think the case (2) is a very narrow special case that I do
> not think of any sane reason to even wanting to do so.  IOW, "you _could_
> interpret the presense of GIT_CONFIG that the user may want to do so, but
> why?"  (1) is also probably not very sensible but it makes more sense.
> 
> I think Dscho's original patch would support the semantics (1) and it is
> probably much saner than (2) which is your version does (if I am reading
> the two patches correctly).

A bit more information on this. There are 3 possible states for 
GIT_CONFIG:

 (1) Not set; things work normally

 (2) Set to ".git/config"; things work normally except that no global or 
     system config is used

 (3) Set to something else; anything expecting to read or write 
     configuration related to the repo will misbehave

Historically, clone worked entirely in state (2) regardless of what the 
user asked for. Everything else left it how the user had it. Dscho's patch 
changes it to initialize the repo in state (2) and fetch in state (1), 
still ignoring what the user set. My patch changes it to leave it how the 
user has it.

Now, clone writes to the config file before reading any configuration, so, 
if it's going to write to ".git/config" instead of $GIT_CONFIG, it can't 
read from $GIT_CONFIG either. So there's no way (outside of redesigning 
config.c) to make GIT_CONFIG useful for "clone" in particular. Other 
commands don't clear it, so they just misbehave if it's set. We can be 
pretty sure, therefore, that users will put it either in (1) or (if they 
want GIT_CONFIG_NO_GLOBAL and don't know about it and aren't worried about 
"clone") in (2). So the practical difference between my patch and Dscho's 
is that, with mine, ~/.gitconfig would affect the initialization step if 
it actually used any config settings.

If you want anything more clever to happen, that requires config.c 
changes of some sort to provide a state where it reads some additional 
file but writes the repo's usual one, and probably *also* *my* patch, so 
that clone doesn't blow away the user's setting before config.c gets it.

	-Daniel
*This .sig left intentionally blank*
