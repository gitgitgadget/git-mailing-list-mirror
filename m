From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [msysGit] git rev-parse broken on Git for Windows
Date: Fri, 30 Jul 2010 16:43:50 +0200
Message-ID: <201007301643.50730.trast@student.ethz.ch>
References: <4C526260.6000104@workspacewhiz.com> <201007301102.15274.trast@student.ethz.ch> <4C52E125.1020004@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	<msysgit@googlegroups.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 16:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oeqot-00052E-Of
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 16:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab0G3OoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 10:44:15 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:15166 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0G3OoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 10:44:14 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 16:44:12 +0200
Received: from thomas.site (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 16:43:50 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4C52E125.1020004@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152244>

Joshua Jensen wrote:
> Thomas Rast wrote:
> > Johannes Schindelin wrote:
> >>> eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)
> > Can you elaborate on "break"?
> >
> > Because as you can see in git-sh-setup.sh, the "official" user of
> > parseopt does
> >
> > 	eval "$(
> > 		echo "$OPTIONS_SPEC" |
> > 			git rev-parse --parseopt $parseopt_extra -- "$@" ||
> > 		echo exit $?
> > 	)"
> >
> > So AFAICS they only differ in the quoting.  And the latter works.
> Here is the output from Git Bash:
> 
> $ git subtree
> C:\Program Files (x86)\Git/libexec/git-core/git-subtree: eval: line 31: 
> syntax error near unexpected token `<'
[...]
> The example from the git rev-parse documentation fails in the same way:
> 
> eval `echo "$OPTS_SPEC" | git rev-parse --parseopt $parseopt_extra -- 
> "$@" || echo exit $?`

Oh, sorry that I was so dense in the first reply.  Of course the
quoting is the problem.  When unquoted, the shell first splits along
whitespace and then eval reassembles with *one space* between each
pair of words.  The change just exacerbated the issue; there are other
ways to trigger bad behaviour if the eval uses an unquoted --parseopt:

  # what you saw
  $ echo eval $( (echo 'description'; echo --; echo "s,long= foo") | git rev-parse --parseopt -- --help || echo exit $?)
  eval cat <<\EOF usage: description -s, --long ... foo EOF exit 129

  # newlines are clobbered
  $ echo eval $( (echo 'description'; echo --; echo "s,long= foo") | git rev-parse --parseopt -- --long="$(printf 'argument\nwith\nnewlines')" || echo exit $?)
  eval set -- -s 'argument with newlines' --

  # consecutive spaces are also clobbered
  echo eval $( (echo 'description'; echo --; echo "s,long= foo") | git rev-parse --parseopt -- --long="three   spaces" || echo exit $?)
  eval set -- -s 'three spaces' --

So I'm afraid Avery will have to fix this in git-subtree.  I'll also
follow up with a doc patch for git-rev-parse.  Luckily there are no
users in git outside of tests and git-sh-setup, so there are no bugs.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
