From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 07 Jan 2008 13:51:05 -0800
Message-ID: <7v4pdpz4mu.fsf@gitster.siamese.dyndns.org>
References: <20080107102327.GA12427@pvv.org>
	<7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
	<20080107204922.GA19728@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzsw-0007EB-DX
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYAGVv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYAGVv0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:51:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYAGVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:51:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A8DB6B5;
	Mon,  7 Jan 2008 16:51:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB49B6A4;
	Mon,  7 Jan 2008 16:51:17 -0500 (EST)
In-Reply-To: <20080107204922.GA19728@pvv.org> (Finn Arne Gangstad's message of
	"Mon, 7 Jan 2008 21:49:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69817>

Finn Arne Gangstad <finnag@pvv.org> writes:

> I'll try to explain a bit better, in different ways:
>
> Way 1: Think of product2 as a big repository
>
> I want to use git as if product2 was a single repository containing
> all its submodules as directories.
>
> I want to be able to send email patches agains product2 that affect
> any number of the submodules. I want to apply these in any order, and
> to let them live as topic branches in product2.
>
> Way 2: Changes to several submodules must be "globally atomic"
>
> If I change submodule 1 and submodule 2, I want to be able to commit
> both those changes as one atomic change in the supermodule - in a
> topic branch. When merging that topic branch in the supermodule, both
> changes in the submodules are merged. But NOT BEFORE. The submodules
> cannot be pre-merged (hence the need to push them "somewhere")
>
> Way 3: The submodules are not released on their own
>
> Only the products are released, each product has different release
> criteria, code freezes, whatever. Syncing of submodules between
> products happens rarely (a few times a year maybe). Modifications to
> submodules must fit each product's release criteria.
>
> There is usually no one who is responsible for each submodule, they
> live their life as part of the supermodule. Anyone can modify a
> submodule, but each product has a maintainer who decides what
> modifications to the submodules are allowed in that product.
>
> Does this make things clearer in any way?

Yes, I think my guess was not too far off the mark.

To achieve #1, when you create a topic for product2, you can
create a corresponding topic in its submodules.  Because os-lib
is shared between product1 and product2 groups, you may want to
have a namespace rule agreed upon between the groups involved.
It could be something as simple as "in os-lib, topics from
product2 group are named with product2/ prefix".

Then a topic to add a fancy coloring to log-merger program in
product2 can be called "fancy-color".  When you create that
topic branch, you also create product2/fancy-color in os-lib
submodule and switch both to it (currently there is no
single-step Porcelain for this, so you would do something like
"git checkout -b fancy-color; cd os-lib; git checkout -b
product2/fancy-color; cd ..".  There is a beginning of
discussion regarding recursive git-submodule behaviour, which
would be a good place to polich the idea further).  The topic
branch product2/fancy-color in os-lib project would be the one
I discussed in my previous message.  That can be pushed out
first if it needs further futzing by people other than the
original developer.

I am not sure if you are stating what you really want correctly
about #2.  git submodule is designed to be usable as a
standalone project.  A commit in a submodule is an atomic event
in that submodule.  Another commit that updates the containing
project to point at that commit in the submodule will be the
atomic event that updates both the containing project and the
contained submodule at the same time from the containing
project's point of view, in the sense that before that commit
the containing project does not see that change in the
submodule, and after that commit it does.

So a possible workflow would be:

 - The original developer creates fancy-color topic in product2
   and product2/fancy-color topic in os-lib and log-merge;

 - He hacks away, creates commits to advance the topic branches
   in the submodules involved and at the toplevel project as he
   sees fit;

 - He pushes out product2/fancy-color topic of os-lib project.
   This can be done even before pushing out the toplevel or
   log-merge project if your process requires for managers of
   product2 group to approve and update the change to os-lib
   project made by the group (that is, topic branches under
   product2/ namespace).

 - If the manager updated product2/fancy-color topic in os-lib,
   the original developer can pull to update his copy of os-lib,
   update his copy of the toplevel product2 project and commit
   the integration results.  In his repository, that commit in
   the toplevel is the single atomic event that finishes the
   fancy-color topic (eh, the initial round of it, anyway). 

 - That toplevel commit to fancy-color topic is pushed out.  The
   appearance of that commit could be the single atomic event
   that makes the fancy-color topic global.  Alternatively,
   merging that whole topic (both "fancy-color" in the toplevel
   and "product2/fancy-color" in submodules) to the mainline
   branch of the product2 group (perhaps that branch is called
   'master' in the product2 project and 'product2/master' in
   os-lib project) could be the single atomic event that makes
   the changes "official", from product2 group's point of view.

I do not think #3 matters in the discussion at all.  If os-lib
does not get released, that's your code and that's your choice.
It does not change the project and history management aspect of
anything.

Although it is unclear how you plan to avoid reinventing
potentially conflicting wheels across groups without _any_
coordination, once your product groups start to have diverging
needs, but if your product groups never talk with each other and
never share their improvements and enhancements to the shared
part of the codebase, that's also your choice.  It does not
change the history management aspect of anything.
