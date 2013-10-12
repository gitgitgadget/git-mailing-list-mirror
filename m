From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 20:50:35 -0400
Message-ID: <20131012005035.GA27939@sigill.intra.peff.net>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
 <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
 <522E3C6A.3070409@bbn.com>
 <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
 <20130910022152.GA17154@sigill.intra.peff.net>
 <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
 <vpqmwnljdmn.fsf@anie.imag.fr>
 <52589027a4851_5dc4c2be742754f@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUnQ3-0007hV-5P
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab3JLAum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:50:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:47813 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751828Ab3JLAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 20:50:40 -0400
Received: (qmail 2731 invoked by uid 102); 12 Oct 2013 00:50:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Oct 2013 19:50:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Oct 2013 20:50:35 -0400
Content-Disposition: inline
In-Reply-To: <52589027a4851_5dc4c2be742754f@nysa.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235934>

On Fri, Oct 11, 2013 at 06:56:23PM -0500, Felipe Contreras wrote:

> > >>> > These deprecation warning messages should be written to stderr, and
> > >>> > should probably be prefixed with "WARNING: ".
> > >>>
> > >>> Is there any deprecation warning that works this way?
> > >>
> > >> The ones in C code typically use warning(), which will prefix with
> > >> "warning:" and write to stderr. They do not use all-caps, though.
> > >>
> > >> Try "git log --grep=deprecate -Swarning" for some examples.
> > >
> > > I'm asking about the ones in shell, because this is a shell script.
> > 
> > No user cares whether "git pull" is written in shell. shell Vs C is an
> > implementation detail, stdout Vs stderr is user-visible.
> 
> You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
> meantime no shell script does that, and that's no reason to reject this patch
> series.

You are completely missing Matthieu's point that we attempt to be
consistent in the format of messages, as well as where they are output,
and from a user's perspective it does not matter what language the tool
is implemented in.

Also, you are wrong that there are no other shell scripts that behave as
Richard said:

  $ git grep '>&2' | grep -i deprecate
  contrib/completion/git-completion.bash: echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
  contrib/examples/git-resolve.sh:echo 'WARNING: This command is DEPRECATED and will be removed very soon.' >&2
  git-lost-found.sh:echo "WARNING: '$0' is deprecated in favor of 'git fsck --lost-found'" >&2

Please, can we just squash in the patch below and stop talking about
this?

diff --git a/git-pull.sh b/git-pull.sh
index a9cf7ac..9c4091c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -58,8 +58,8 @@ then
 	if test "$rebase" = 'true'
 	then
 		mode="rebase"
-		echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
-		echo "Please use pull.mode and branch.<name>.pullmode instead."
+		echo >&2 "warning: The configurations pull.rebase and branch.<name>.rebase are deprecated."
+		echo >&2 "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
 fi
 test -z "$mode" && mode=merge
