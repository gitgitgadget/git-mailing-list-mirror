From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range	completion
Date: Tue, 15 Jul 2008 10:05:01 +0200
Message-ID: <487C5A2D.3000707@op5.se>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org> <20080715042553.GD2432@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIfYt-0001fM-QE
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbYGOIGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 04:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYGOIGB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 04:06:01 -0400
Received: from mail.op5.se ([193.201.96.20]:51905 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYGOIF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 04:05:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1741224B0009;
	Tue, 15 Jul 2008 10:06:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.347
X-Spam-Level: 
X-Spam-Status: No, score=-4.347 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.052, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hl8UF20u5QzL; Tue, 15 Jul 2008 10:05:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.154])
	by mail.op5.se (Postfix) with ESMTP id B15A524B0014;
	Tue, 15 Jul 2008 10:05:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080715042553.GD2432@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88537>

Shawn O. Pearce wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
>>> What is $COMP_WORDBREAKS set to in your shell?  In mine it
>>> appears to be:
>>>
>>> 	" \"'@><=3D;|&(:"
>> Ahhah. Indeed. I don't have the ':'.
> ...
>> Umm, if so, git should just set it in the completion script, no?
>=20
> OK, so it turns out not having : in COMP_WORDBREAKS is a very common
> case that we should somehow deal with, to aid our users.
>=20
> I'm concerned about just setting COMP_WORDBREAKS back to the default
> in the git completion script because then we get into an ordering
> game with the profile scripts, don't we?  If git completion sources
> before the gvfs script we don't get our COMP_WORDBREAKS setting.
>=20
> I think we may need to do two things.
>=20
> If COMP_WORDBREAKS doesn't contain a :, try to reset it to include
> one when the script is sourced.  This may "fix" git completion but
> make gvfs completion act differently, resulting in a thread on the
> gvfs lists.  ;-)
>=20
> If COMP_WORDBREAKS doesn't contain : during a completion event than
> we need to do what your original patch asked, which is to include
> "$ref:" in the prefix, so the ref isn't lost.
>=20
> At least we understand the problem now, finally.  I'll try to write
> up a patch for it tomorrow.  Unfortunately packing to move has been
> really sucking up my time lately.
> =20

I beat you to it ;-) This works just fine for me regardless of whether
or not I have a colon in COMP_WORDBREAKS.

--%<--%<--%<--
=46rom: Andreas Ericsson <ae@op5.se>
Subject: git-completion.bash: Handle "rev:path" completion properly

The gvfs package on at least Fedora9 installs its own bash
completion script which removes the colon from COMP_WORDBREAKS,
which acts as a list of characters where bash should consider
as word boundaries. Doing so breaks the git bash completion
script when handling any rev:path style argument.

This patch fixes it by prepending the "rev" part and the colon
(which otherwise gets lost) before adding the "path" part if
COMP_WORDBREAKS doesn't contain the colon we would otherwise
need.

Also fixes a nearby indented-with-spaces issue.

Spotted-by: Linus Torvalds <torvalds@linux-foundation.org>
Investigated-by: Bj=F6rn Steinbrink <b.steinbrink@gmx.de>
Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 contrib/completion/git-completion.bash |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d268e6f..e138022 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -293,7 +293,11 @@ __git_complete_file ()
 		*)
 			ls=3D"$ref"
 			;;
-	    esac
+		esac
+		# When completing something like 'rev:path', bash behaves
+		# differently whether or not COMP_WORDBREAKS contains a
+		# colon or not. This lets it handle both cases
+		test "${COMP_WORDBREAKS//:}" =3D "$COMP_WORDBREAKS" && pfx=3D"$ref:$=
pfx"
 		COMPREPLY=3D($(compgen -P "$pfx" \
 			-W "$(git --git-dir=3D"$(__gitdir)" ls-tree "$ls" \
 				| sed '/^100... blob /s,^.*	,,
--=20
1.5.6.3.315.g10ce0

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
