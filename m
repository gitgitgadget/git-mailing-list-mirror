From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use git merge -s subtree?
Date: Mon, 07 Jan 2008 22:57:53 -0800
Message-ID: <7vir24x0r2.fsf@gitster.siamese.dyndns.org>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
	<BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
	<47803CB6.4050102@gmx.net> <7vir277jz6.fsf@gitster.siamese.dyndns.org>
	<BAYC1-PASMTP1079A31936B4563801537DAE4E0@CEZ.ICE>
	<7vlk71z6sd.fsf@gitster.siamese.dyndns.org>
	<BAYC1-PASMTP152065390CFAF8C09F0B60AE480@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC8QE-0002AJ-DI
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 07:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147AbYAHG6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 01:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbYAHG6M
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 01:58:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbYAHG6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 01:58:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C11F96A5;
	Tue,  8 Jan 2008 01:58:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 042A09499;
	Tue,  8 Jan 2008 01:57:55 -0500 (EST)
In-Reply-To: <BAYC1-PASMTP152065390CFAF8C09F0B60AE480@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 8 Jan 2008 00:34:55 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69844>

Sean <seanlkml@sympatico.ca> writes:

> In the case of the "--follow" option though, the user might be forgiven
> for thinking in terms of files rather than paths.  Even the git-log
> documentation says for "--follow", "Continue listing the history of a
> file beyond renames".   Which at least implies that Git knows about
> file history, rather than just paths.

But you know git does not know nor care about "file" history.

And the thing is, I just tried this:

  $ git log --follow --pretty=short --stat gitk-git/gitk | head -n 20
  commit 62ba5143ec2ab9d4083669b1b1679355e7639cd5
  Author: Junio C Hamano <gitster@pobox.com>

      Move gitk to its own subdirectory

   gitk => gitk-git/gitk |    0 
   1 files changed, 0 insertions(+), 0 deletions(-)

  commit 7388bcbc5431552718dde5c3259d861d2fa75a12
  Author: Paul Mackerras <paulus@samba.org>

      gitk: Use the UI font for the diff/old version/new version radio buttons

   gitk |    6 +++---
   1 files changed, 3 insertions(+), 3 deletions(-)

  commit cca5d946d692fde7ea5408a694cb4b1c97a5a838
  Author: Paul Mackerras <paulus@samba.org>

      gitk: Simplify the code for finding commits

So there is something else going on, if David actually tried to
follow "B/foo" that was subtree-merged from a parent that had it
at toplevel "foo" and "log --follow" did not work for him.

Two things that come to mind offhand are that (1) --follow looks
for a path that has similar contents elsewhere only when the
path it is following in the child disappears in the parent.  So
if you start from B/foo that was subtree-merged (i.e. the other
parent has foo at the top) into a parent that already had B/foo,
it will not follow the other parent that does not have B/foo;
(2) I do not know if the original example by David tried to use
"-n $count" offhand, but it seems that currently --follow does
not play well with -n (try the above gitk-git/gitk without
piping the result into "head -n 20" but instead by limiting with
"git log -3 --follow ..."); if that is the case that definitely
is a bug.
