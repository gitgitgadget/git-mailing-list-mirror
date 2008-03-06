From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 05 Mar 2008 19:48:33 -0800
Message-ID: <7vejaoldgu.fsf@gitster.siamese.dyndns.org>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
 <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
 <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 04:49:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX76j-0002Dm-EC
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 04:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbYCFDsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 22:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648AbYCFDsr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 22:48:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbYCFDsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 22:48:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B53F6146A;
	Wed,  5 Mar 2008 22:48:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E03FD13D4; Wed,  5 Mar 2008 22:48:39 -0500 (EST)
In-Reply-To: <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
 (Ping Yin's message of "Thu, 6 Mar 2008 09:54:58 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76315>

"Ping Yin" <pkufranky@gmail.com> writes:

>>  I would agree that allowing the user to use a short-hand to name a group
>>  of modules the user is interested in would be a good idea, but I think
>>  .gitmodules is a wrong place to do so.  The grouping is a user preference,
>>  isn't it?
>>
>>  The place the owner of the repository (not the project) expresses which
>>  modules are of interest, what transports she wants to use to access it,
>>  etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
>>  be used when the user populates that information.
>>
> Not always the case. In my company environment, we have many
> submodules and have a unified hierachy of modules,...
> ..., it's better to put the
> common config in .gitmodules to pass to every one.

I think we are saying the same thing, and I do not understand why you
sound so upset about my comments.  I never said it is bad to copy the
"hints" supplied by .gitmodules verbatim to $GIT_DIR/config.

See how the current cmd_init() uses the information in .gitmodules.  It
could later become interactive to allow users to override what's in there,
but by default it simply uses the information from .gitmodules verbatim.

In the special case of everybody using exactly the same settings, you can
have "all" submodule group alias in .gitmodules, and the user can say "git
submodule init all", which would set up the set of the modules the user
would work with, using the "hints" in the .gitmodules distributed company
wide verbatim.

One of the goal of the overall design of submodules is _not forcing_ but
still allowing such uniformity, and I think using $GIT_DIR/config as
authoritative and treating in-tree .gitmodules as hint to prime
$GIT_DIR/config is quite fundamental to that design.  Let's make sure we
do not needlessly deviate from it.

Because names to name things are fundamental part of the communication, I
do not think we would want to allow users to call A what the project as a
whole calls B.  The use of .gitmodules by the current module_name() that
maps a specific name to a path is not just fine but is preferred for this
reason (i.e. if we copied them to $GIT_DIR/config it would only introduce
tower-of-babel confusion).

However, a short-hand to name groups of submodules is not just about
naming one thing with one name, but has user convenience aspect too.
There should be per-user customizability built into the design.  You could
probably fix this by making the code first consult $GIT_DIR/config and
then fall back on in-tree .gitmodules file.

By the way, in your patch, I notice that quoting of $name is often very
loosely done.  I do not think we have officially defined what the allowed
repertoire of module name characters are, but we probably should declare
the rules and make sure the code actively enforces it to prevent future
grief.  I'd say the same restriction as we have for refnames, except
that we do not allow slashes either, is good enough?
