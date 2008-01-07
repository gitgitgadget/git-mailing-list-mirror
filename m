From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 07 Jan 2008 11:46:21 -0800
Message-ID: <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
References: <20080107102327.GA12427@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 20:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBxw7-0005Op-Bz
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 20:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbYAGTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 14:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYAGTqg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 14:46:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYAGTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 14:46:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A07B6A7;
	Mon,  7 Jan 2008 14:46:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 936BBB6A2;
	Mon,  7 Jan 2008 14:46:30 -0500 (EST)
In-Reply-To: <20080107102327.GA12427@pvv.org> (Finn Arne Gangstad's message of
	"Mon, 7 Jan 2008 11:23:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69801>

Finn Arne Gangstad <finnag@pvv.org> writes:

> We're trying to get git to work well with our vision of submodules,
> and have to figure out how to make submodule fetching and pushing work
> in a smooth way.
>
> This is our situation (simplified):
>
>           [product1]          [product2]  ...         (supermodules)
>            /      \             /     \
>     ... [foo]  [os-abstraction-lib] [log-merger] ...  (submodules)
>
>
> A developer does a modification to the os-abstraction-lib, and a
> modification to the log-merger that depends on the change in the
> os-abstraction-lib. He wants this into product2, and doesn't know or
> care about product1.  He doesn't know whether his modification is
> acceptable or not, or whether his modification will go in before some
> other modification.
>
> He needs some way of pushing his modifications to a branch in the
> supermodule (e.g. "change-131345"), without interfering with anyone
> else.  The problem is where to push the sub-modules, they need to be
> available for anyone who wants to get the "change-131345" branch of
> the product2, but the modifications shouldn't show up anywhere else
> (yet).  Here are solutions we have thought of so far:

The phrase "without interfering with anyone else" feels somewhat
wrong and I sense there is something missing in the description
of the workflow.  When a developer pushes a change to somewhere
else, it must be because the change needs to be shared with
_somebody else_ (but not necessarily with _everybody_).

Without knowing exactly what the desired workflow is, I'd hazard
a guess and would recommend something else, which is  hopefully
a more useful way.

When the developer makes that 131345 change in os-lib submodule,
he is acting as a developer of that library and advancing its
state.  He wants to add an enhancement so that a particular way
to use it elsewhere (his use in log-merger program perhaps being
the first one of them) can be supported, but the change is not
accepted as the project wide one from os-lib project's point of
view.  The change needs to be shared with people in product2
group that want to further work on top of the change he makes in
log-merger project, but not necessarily with everybody in
product2 group, let alone people in product1 group.

That's exactly what a topic branch is about, isn't it?

He has a topic to enhance something in os-lib project, so
whatever the mysterious 131345 can be made into one branch in
os-lib project and given a more meaningful topic name.  He can
push that out to os-lib project, and bind its tip in his tree of
product2 superproject at os-lib directory, and push it to
produc2 repository (maybe to its 'master', or maybe also to its
one of the topic branches that houses his work-in-progress).

That way, when somebody from product2 group needs to work on top
of the change he made and pushed out thusly updates, his copy of
os-lib will get the updates to (or perhaps creation of) the
topic branch that contains 131345 change, and he can start
working from where the original developer left off.  He can even
fix bugs in the change in that 131345 topic in os-lib project
the original developer made, push that back, and the original
developer can build on top of that change.
