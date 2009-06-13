From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix show_entry() in tree-diff.c for TREE_IN_RECURSIVE
Date: Sat, 13 Jun 2009 16:42:23 -0700
Message-ID: <7v63ezvgyo.fsf@alter.siamese.dyndns.org>
References: <op.uvhcoii8tdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 01:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFczL-00013i-Mv
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 01:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbZFMXm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 19:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbZFMXm1
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 19:42:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59040 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZFMXm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 19:42:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613234222.WGDF20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 13 Jun 2009 19:42:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3biP1c00B4aMwMQ03biPWC; Sat, 13 Jun 2009 19:42:23 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=J_NeQprUbJUA:10 a=lrbLnaca2U4A:10
 a=pGLkceISAAAA:8 a=HKzFpXsutjY_zaJtbSAA:9 a=4hgAmI2LBiHBXmH3FTP0Hoz9zS4A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <op.uvhcoii8tdk399@sirnot.private> (Nick Edelen's message of "Sat\, 13 Jun 2009 22\:32\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121527>

"Nick Edelen" <sirnot@gmail.com> writes:

> fix show_entry() in tree_diff.c to display tree entries on TREE_IN_RECURSIVE

s/fix/Fix/; s/$/./;

> Signed-off-by: Nick Edelen <sirnot@gmail.com>

> this seems like how it should act: trees are shown under this option for
> changes,...

Please show a sample input, the output you expect and the output from the
current code, to illustrate the alleged breakage better.

For example. if you used to have files dc/1, dr/2, dt/3, fc, fr and ft and
then removed dr/2, dt/3, fr, ft and added da/5, fa, dt and ft/4, you
expect this output.

$ git diff -t -r --raw HEAD^ HEAD
:000000 040000 0000000... a13e5ad... A	da
:000000 100644 0000000... ce01362... A	da/5
:040000 040000 8dc877a... 40b5137... M	dc
:100644 100644 e69de29... ce01362... M	dc/1
:040000 000000 f84fc27... 0000000... D	dr
:100644 000000 e69de29... 0000000... D	dr/2
:000000 100644 0000000... ce01362... A	dt
:040000 000000 6e36c7d... 0000000... D	dt
:100644 000000 e69de29... 0000000... D	dt/3
:000000 100644 0000000... ce01362... A	fa
:100644 100644 e69de29... ce01362... M	fc
:100644 000000 e69de29... 0000000... D	fr
:100644 000000 e69de29... 0000000... D	ft
:000000 040000 0000000... 9a1efba... A	ft
:000000 100644 0000000... ce01362... A	ft/4

But because we show 040000 entries only for changed and typechange cases, 
we currently get this.

$ git diff -t -r --raw HEAD^ HEAD
:000000 100644 0000000... ce01362... A	da/5
:040000 040000 8dc877a... 40b5137... M	dc
:100644 100644 e69de29... ce01362... M	dc/1
:100644 000000 e69de29... 0000000... D	dr/2
:000000 100644 0000000... ce01362... A	dt
:100644 000000 e69de29... 0000000... D	dt/3
:000000 100644 0000000... ce01362... A	fa
:100644 100644 e69de29... ce01362... M	fc
:100644 000000 e69de29... 0000000... D	fr
:100644 000000 e69de29... 0000000... D	ft
:000000 100644 0000000... ce01362... A	ft/4

I think the output from the code after your change is more consistent, but
I somehow suspect that this might break people's script, like gitweb,
rather badly, if they depended on the existing behaviour.
