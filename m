From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Tue, 28 Jun 2011 21:30:35 +0200
Message-ID: <20110628193034.GB3700@book.hvoigt.net>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <7v1uydvmh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 21:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbdzm-0007Mn-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 21:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1F1Tap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 15:30:45 -0400
Received: from darksea.de ([83.133.111.250]:52835 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123Ab1F1Tal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 15:30:41 -0400
Received: (qmail 10457 invoked from network); 28 Jun 2011 21:30:35 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 28 Jun 2011 21:30:35 +0200
Content-Disposition: inline
In-Reply-To: <7v1uydvmh0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176417>

Hi,

On Tue, Jun 28, 2011 at 11:29:15AM -0700, Junio C Hamano wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
> > +static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
> > +{
> > +	int is_pushed = 0;
> > +	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
> > +		struct child_process cp;
> > +		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		argv[1] = sha1_to_hex(sha1);
> > +		memset(&cp, 0, sizeof(cp));
> > +		cp.argv = argv;
> > +		cp.env = local_repo_env;
> > +		cp.git_cmd = 1;
> > +		cp.no_stdin = 1;
> > +		cp.out = -1;
> > +		cp.dir = path;
> > +		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
> > +			is_pushed = 1;
> > +		close(cp.out);
> > +		strbuf_release(&buf);
> > +	}
> 
> What if
> 
>  (1) you are binding somebody else's project as your own submodule, you do
>      not make any local changes (you won't be pushing them out anyway),
>      and you do not have remote tracking branches in that submodule
>      project?

In this scenario the superproject can not be cloned that way that it
would contain the submodule right? I would consider this a rather exotic
way to work since pushing means to share your work somehow. This way you
would share your work in the superproject but not from the submodule?
How about not doing the is-pushed check when the submodule has no
remotes? If we assume that only people having remote tracking branches
want to share them via push this would allow your usecase.

>  (2) you have a project you can push to that is bound as a submodule, you
>      have pushed the commit that is bound in the superproject's tree to
>      that submodule project, but you do not have remote tracking branches
>      in that submodule project?

This could also be solved with the above proposal.

>  (3) you have a project you can push to that is bound as a submodule, you
>      have multiple remotes defined (e.g. one for the public server you
>      intend for this check to be in effect, the other is just for your
>      private backup), and you have pushed the necessary commit to your
>      backup but not to the public one?
> 
> The above check would fail in cases (1) and (2) even though it does not
> have to. It would succeed in case (3), but people would not be able to use
> the superproject as the necessary commit is not there but only on your
> work and backup repositories.
> 
> What am I missing?
> 
> I am not sure if the check imposed on the client end is such a great
> idea.

This check is solely meant as a convenience security measure. It should
and can not enforce a tight check whether a superproject (including its
submodules) can be cloned/checked out at all times. But it ensures that
a developer has pushed his submodule commits "somewhere" which is enough
in practice.

One typical scenario is that people are working together using shared
remotes. In this scenario this patch provides a consistency check which
catches typical mistakes.

If you fork a project you might change or add a new url for a submodule
locally since you cannot directly push to upstream. This is situation 3
in your above description. All people working with you know which url
you are using for the submodule. In this situation the check helps you
and can not be enforced on the remote side since only the client knows
which remotes the submodule has.

Maybe we should provide a configuration option for this check so that
people who know what they are doing could switch it off?

> I suspect that it would depend on the superproject which submodule
> commit must exist "out there" for others to fetch. If you assume a closed
> environment where all the superprojects and necessary submodule projects
> are housed at a central location everybody pushes into and have tight
> control over how project participants clone and check out the
> superprojects and submodules, you do not have to worry about any of the
> above, but then the server-side can perform the check when it accepts a
> push (and you would already be doing other checks there in your hooks
> anyway in the industrial setup, I would guess).

As mentioned above a check on the remote end is only applicable if you
have a certain defined remote for the submodule in a superproject. This
also has to be in an environment which has control over all
projects/submodules. The presented solution does not just cover that but
also the case where you fork and use different remotes than upstream.

Cheers Heiko
