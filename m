From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] Convert ce_path_match() use to match_pathspec()
Date: Mon, 25 May 2009 15:14:19 -0700
Message-ID: <7voctgvnic.fsf@alter.siamese.dyndns.org>
References: <1243240924-5981-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 00:14:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iR9-0005m7-6B
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbZEYWOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 18:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZEYWOT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:14:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55974 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbZEYWOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:14:19 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525221420.UAJA20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Mon, 25 May 2009 18:14:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vyEK1b00H4aMwMQ04yEK28; Mon, 25 May 2009 18:14:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=sCSPhZ2M2JsA:10 a=NbnU99Y12dgA:10
 a=pGLkceISAAAA:8 a=chqRMn5cMs8nJAz6vUEA:9 a=abudRNIsyjGDZ6dLTHoE38Q7VyAA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1243240924-5981-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 25
 May 2009 18\:42\:04 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119971>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> For some reasons diff code did not get converted to use
> match_pathspec(). So diff commands do not understand wildcards.

ce_path_match() is not just about diffs; there may be places that do no=
t
expect pathspecs to match cruft with globs.  Have you checked all the
callsites and they are Ok with globbing?

I think using glob in diff-files should be Ok, but that would make it
inconsistent with diff-tree (and possibly diff-index but I didn't check=
).
The correct operation of diff-tree (and path pruning in "git log" famil=
y)
heavily relies on an early-exit optimization not to recurse into a
directory when we can detect that none of the paths in that directory w=
ill
ever match any of the given pathspecs, and this is done based on the
non-globbing (iow "leading path") semantics; you need to be extra caref=
ul
about this.
