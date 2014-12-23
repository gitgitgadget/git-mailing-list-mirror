From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 17:47:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info> <xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Sc9-0007Dx-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 17:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbaLWQrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 11:47:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:62324 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336AbaLWQrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 11:47:13 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MJmcS-1Y4YXf2dd6-001EVc;
 Tue, 23 Dec 2014 17:47:07 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:rJoeybJbGESy2wBKm5+eO/Ugu/ZbJXzTtxmVd8Jyv3rmr11fevE
 CIyAj6yUe0cvjmYWycqPpiZu6J30eLJf+WgXuaJiqI7dPPhCIv5NcaDekebE1K5Zyt0CBpX
 LSTBI6UOdz/oaybvwqtT7JPDJEm5oA02xT3BntQy2XuhitfHDEFlX2qyHJMKYbcCtXWypRE
 eFqgUbBrp/EqbnsxuopCQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261740>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >> > Of course you can say that! ;-) The problem these ugly messages
> >> >> > try to solve is to give the user a hint which setting to change
> >> >> > if they want to override the default behavior, though...
> >> >> 
> >> >> Ahh, OK, then dashed form would not work as a configuration
> >> >> variable names, so missingTaggerEntry would be the only usable
> >> >> option.
> >> >
> >> > Except that cunning me has made it so that both
> >> > missing-tagger-entry *and* missingTaggerEntry work...
> >> 
> >> Then the missing-tagger-entry side needs to be dropped.  The naming
> >> does not conform to the way how we name our officially supported
> >> configuration variables.
> >
> > But it does conform with the way we do our command-line parameters,
> 
> Hmmm....  What is the expected user interaction?  The way I read the
> series was ($MISSING_TAGGER stands for the "token" we choose to show):
> 
>     (1) The user runs fsck without customization, and may see a
> 	warning (or error):
> 
>         $ git fsck
>         error in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: $MISSING_TAGGER
> 
>     (2) The user demotes it to warning and runs fsck again:
> 
> 	$ git config fsck.$MISSING_TAGGER warn
>         $ git fsck
>         warning: tag d6602ec5194c87b0fc87103ca4d67251c76f233a: $MISSING_TAGGER

The intended use case is actually when receive.fsckObjects = true and you
call `git push`, seeing 'remote: error: $MULTIPLE_AUTHORS: ...'.

Now, the $MULTIPLE_AUTHORS *config* setting is parsed by `git
receive-pack`, but that is not the command that needs to customize the
fsck call: it is either `git index-pack` or `git unpack-objects`. So what
`git receive-pack` does is to pass the config options as command-line
options to the called command. For consistency with the rest of Git, the
command-line options were *not* camel-cased, but lower-case,
dash-separated.

The parser I wrote actually accepts both versions, allowing me to skip the
tedious step to convert the camelCased config setting into a
lower-case-dashed version to pass to `index-pack` or `unpack-objects`,
only to be parsed by the same parser as `fsck` would use directly.

So I am rather happy with the fact that the parser handles both camelCased
and lower-case-dashed versions.

> I suspect that it would be much better if the configuration variables
> were organized the other way around, e.g.
> 
> 	$ git config fsck.warn missingTagger,someOtherKindOfError

I had something similar in an earlier version of my patch series, but it
was shot down rightfully: if you want to allow inheriting defaults from
$HOME/.gitconfig, you have to configure the severity levels individually.

(The current solution also sidesteps the problematic situation when both
fsck.warn *and* fsck.error contain, say, missingTagger.)

> Then a one-shot override would make sense and easier to give as
> command line option, e.g.
> 
> 	$ git fsck --warn=missingTagger,someOtherKindOfError

Yep, my first implementation actually used
`--strict=missing-tagger,-some-demoted-error`. But as I mentioned above,
that approach is not as flexible as the current one.

> But the proposed organization to use one variable per questionable
> event type (as opposed to one variable per severity level) would
> lead to a one-shot override of this form, e.g.
> 
> 	$ git fsck --missing-tagger=warn --some-other-kind-of-error=warn
> 
> which I think is insane to require us to support unbound number of
> dashed options.

The intended use case is actually *not* the command-line, but the config
file, in particular allowing /etc/gitconfig, $HOME/.gitconfig *and*
.git/config to customize the settings.

> Or are you saying that we allow "git config core.file-mode true"
> from the command line to set core.fileMode configuration?

I do not understand this reference. I did not suggest to change `git
config`, did I? If I did, I apologize; it was definitely *not* my
intention to change long-standing customs.

Ciao,
Dscho
