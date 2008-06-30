From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 22:21:21 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806292157540.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer> <alpine.LNX.1.00.0806291821520.19665@iabervon.org> <7vabh390sc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 04:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD925-00022N-2u
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 04:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYF3CVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 22:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYF3CVX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 22:21:23 -0400
Received: from iabervon.org ([66.92.72.58]:42100 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYF3CVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 22:21:22 -0400
Received: (qmail 27913 invoked by uid 1000); 30 Jun 2008 02:21:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 02:21:21 -0000
In-Reply-To: <7vabh390sc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86862>

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

Actually, (1) has never worked for either clone or init. Init always 
obeyed GIT_CONFIG as for where it put the output (in fact git-clone.sh 
used GIT_CONFIG to cause git-init to write to the created repo, IIRC). 
Clone always replaced GIT_CONFIG with the destination location before it 
read any configuration, so it wouldn't see configuration that was in the 
user's GIT_CONFIG (or in any pre-existing config file at all). 
Historically, these commands don't support (1) and aren't consistant with 
each other.

I think it would make sense if there were some way to provide custom 
configuration to a particular invocation of "git clone", but GIT_CONFIG as 
currently handled by config.c can't do it.

> I think Dscho's original patch would support the semantics (1) and it is
> probably much saner than (2) which is your version does (if I am reading
> the two patches correctly).

My patch makes "git clone" do what "git init; git remote; git fetch" do 
with respect to GIT_CONFIG. I don't think this behavior is really useful 
for any of those programs or for the combination, but at least having them 
match would be consistant. I think the sensible thing would be for 
config.c to always write to git_path("config") (or a variable used by 
"git config"), and read: git_path("config"), $GIT_CONFIG, ~/.gitconfig, 
/etc/gitconfig (in order of decreasing precedence); and further have 
builtin-config.c set the "file to write to" variable based on $GIT_CONFIG 
or "--file", "--global", or "--system".

But I don't really understand what the purpose of the feature was in the 
first place, aside from the narrow case of being able to read and write 
files that use the config file format with "git config".

	-Daniel
*This .sig left intentionally blank*
