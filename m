From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh
	portability
Date: Thu, 28 Apr 2011 18:01:15 +0200
Message-ID: <20110428160115.GA19003@goldbirke>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTee-0006xN-HK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760449Ab1D1QBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:01:19 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:21715 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab1D1QBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:01:19 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:01:12 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:01:15 +0200
Content-Disposition: inline
In-Reply-To: <20110427064033.GB4226@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172369>

Hi,


On Wed, Apr 27, 2011 at 01:40:34AM -0500, Jonathan Nieder wrote:
> The "_get_comp_words_by_ref -n :=3D words" command from the
> bash_completion library reassembles a modified version of COMP_WORDS
> with ':' and '=3D' no longer treated as word separators and stores it=
 in
> the ${words[@]} array.  Git's programmable tab completion script uses
> this to abstract away the difference between bash v3's and bash v4's
> definitions of COMP_WORDS (bash v3 used shell words, while bash v4
> breaks at separator characters); see v1.7.4-rc0~11^2~2 (bash: get
> --pretty=3Dm<tab> completion to work with bash v4, 2010-12-02).
>=20
> zsh has (or rather its completion functions have) another idea about
> what ${words[@]} should contain: the array is prepopulated with the
> words from the command it is completing.  For reasons that are not
> well understood, when git-completion.bash reserves its own "words"
> variable with "local words", the variable becomes empty and cannot be
> changed from then on.  So the completion script neglects the argument=
s
> it has seen, and words complete like git subcommand names.  For
> example, typing "git log origi<TAB>" gives no completions because
> there are no "git origi..." commands.
>=20
> Work around this by using a different variable (comp_words) that is
> not special to zsh.  So now commands that completed correctly before
> v1.7.4-rc0~11^2~2 on zsh should be able to complete correctly again.

Thanks for this explanation.  I tried to fix this some time ago, but
got only as far as to indentify that something is amiss with returning
$words from _get_comp_words_by_ref(), and during tracing I saw so much
weird and (for me) unexplicable zsh behavior that I simply gave up.

But this patch heavily conflicted with one of my long-forgotten
cleanup patch series, and that series together with the above
explanation gave me alternative ideas for fixing this issue with zsh.

So, here it is.  The first two patches are independent cleanups, but
they make the actual fix in the third patch so short.

It works well as far as I tested it with both bash and zsh, but I
would really appreciate a few extra sets of eyeballs for the cleanups
and sanity-checking and testing of the bugfix.


SZEDER G=E1bor (3):
  bash: don't modify the $cur variable in completion functions
  bash: remove unnecessary _get_comp_words_by_ref() invocations
  bash: don't declare 'local words' to make zsh happy

 contrib/completion/git-completion.bash |  225 +++++++++---------------=
--------
 1 files changed, 64 insertions(+), 161 deletions(-)
