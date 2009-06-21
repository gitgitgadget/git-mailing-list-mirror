From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sat, 20 Jun 2009 23:41:35 -0700
Message-ID: <7vprcyt7fk.fsf@alter.siamese.dyndns.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 08:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIGlg-0003mm-0a
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 08:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZFUGle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 02:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZFUGld
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 02:41:33 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63409 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZFUGld (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 02:41:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621064136.RALQ20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jun 2009 02:41:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Whb1c0074aMwMQ04WhboR; Sun, 21 Jun 2009 02:41:35 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=wW3WdqC5rP8A:10 a=dIu3SnmMAAAA:8
 a=4Z2u5vCXdYxIbA2_FQwA:9 a=GKEOpBIi50oDwy0ER4UA:7
 a=uFmw6r5n_dVmlIjaxRpgBTy1_MsA:4 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <20090621050846.3554.31660.chriscool@tuxfamily.org> (Christian Couder's message of "Sun\, 21 Jun 2009 07\:08\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121967>

Christian Couder <chriscool@tuxfamily.org> writes:

> This is better than saving in a shell script, because it will make
> it much easier to port "rebase -i" to C.

Hmph.

We used to parse a commit object in one go into variables, and I would
have imagined that a rewrite in C will read a commit object to get the
author information in variables in-core, without having to write any
temporary file.

But with your patch, it starts to use a temporary file, and forces the C
rewrite to do the same.  It closes the door for a more efficient rewrite.

Why is this a good change?

> This also removes some sed regexps and some "eval"s.

That is a correct description of what the patch does.

But the use of sed and eval is an implementation detail.  As long as they
are used correctly, I do not think it is a grave offense to use them, and
removal is not an improvement.

A possible argument (or excuse) you _could_ make to justify this change, I
think, is that such a temporary file with known name will allow a hook
script that is run during a rebase to learn the authorship information of
the commit being rebased.  This has been hidden inside variables without
getting exported, and this patch defines a way for the scripts to get at
it if they wanted to.

I didn't check if there is such a codepath that involves hooks, if there
are plausible scenarios that they would want to learn that information,
nor if the information is hard to get otherwise, though.
