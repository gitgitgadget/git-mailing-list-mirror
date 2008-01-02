From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to structure a project distributed with varyingly interdependent feature branches?
Date: Wed, 02 Jan 2008 14:12:44 -0800
Message-ID: <7vwsqrvpur.fsf@gitster.siamese.dyndns.org>
References: <1199139613.2360.83.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:13:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABqB-0005cN-Ml
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYABWNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYABWNA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:13:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYABWM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 17:12:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CABFB2CF8;
	Wed,  2 Jan 2008 17:12:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D5FCD2CED;
	Wed,  2 Jan 2008 17:12:53 -0500 (EST)
In-Reply-To: <1199139613.2360.83.camel@localhost> (Matt McCutchen's message of
	"Mon, 31 Dec 2007 17:20:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69496>

Matt McCutchen <matt@mattmccutchen.net> writes:

> Rsync presents a unique challenge because it has a number of long-term
> feature patches that are maintained and distributed with the main source
> code.  Furthermore, some of the patches depend on other patches.
> ...
> 1. How to properly represent the history of an individual branch and
> update it when the trunk (or the branch on which it depends) changes.
> Right now, Wayne updates the branch by rebasing; unfortunately, if the
> trunk changes in such a way that one of the intermediate commits no
> longer makes sense, it is impossible to update the branch while
> preserving a record that the intermediate commit once existed.

I take this to mean a situation like this:

 * There is a series of patch X Y Z that implements some nicety
   not present in the mainline yet.  This set applies to older
   codebase at point A.

 * Newer codebase B does things differently from codebase A and
   patch X is no longer needed --- IOW, what X achieves on top
   of A has already been incorporated somewhere between A and B.
   Applying Y and Z suffices to obtain that nice feature on top
   of B.

               .---X---Y---Z       .---Y'--Z' 
              /                   /
      ---o---A---o---.....---o---B

This is natively expressed with git, if your history were like
this:

               .----------X------Y-------Z
              /            \
      ---o---A---o---....---M---....---B

and you publish Z.  People who would want to apply the series to
their codebase simply merge Z.  The patch dependency of X is
captured in the mainline history because the effect of X is
incorporated to the mainline as a merge at M.  If the point they
want to apply the series is older than point M (where patch X
becomes unnecessary because of the mainline change), X, Y and Z
will be brought in, while people basing on commits newer than M
will pull in only Y and Z (because they already have X).

But that works only in theory and with a developer with perfect
vision.  Nobody would be able to forsee that X would become such
a crucial change when it is developed.  Often you would just
create a regular commit M somewhere between A and B that has the
effect of X, and later regret that you had made a separate X
forked from an earlier A and recorded M as a merge.

People use quilt (or guilt) to manage patch stacks for things
like this.

Having said that, I think you can maintain a single patch series
(say the above X-Y-Z) and publish it as a few variants for
downloaders as a prefabricated set of branches.

Say if you have this (the first picture), you do not create Y'-Z'
history (again, M is the point patch X becomes unnecessary, but
we live in the real world and it was not recorded as a merge of
X into the mainline):

                 .---X---Y---Z
                /
               /
              /
      ---o---A---o---.....---M---...---o---B

and X-Y-Z _is_ what you would maintain and keep tweaking.  You
can publish Z and people who would want to "apply" the series
can cleanly apply X-Y-Z (or merge Z if they are git users).

But people who would want to "apply" the series to codebase
newer than point M would individually need to resolve conflicts
or know X is unneeded for them.  To alleviate this, you would
publish _another_ commit:

                 .---X---Y---Z
                /             \
               /               Z'
              /               /
      ---o---A---o---.....---M---...---o---B

That is, you merge Z to newer mainline for them to create Z',
and:

 * publish Z' for git users --- they can merge this to their
   codebase that is newer than M and they do not have to resolve
   conflicts you needed to resolve, arising from the overlap
   between X and M, when you created Z'.

 * publish diff between M-Z', for non git users who would want
   to apply it with "patch".

You suggested that you would keep rebasing X--Y--Z while
improving the long living patch series.  You would recreate Z'
whenever the series is updated (and rerere will hopefully help
you re-resolve the conflicts between X and M automatically).
