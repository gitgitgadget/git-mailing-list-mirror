From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Mon, 14 Apr 2008 18:13:50 -0700
Message-ID: <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
 <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo>
 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
 <1208202740.25663.69.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 03:14:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlZl8-0003sq-19
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 03:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbYDOBOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 21:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbYDOBOH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 21:14:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbYDOBOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 21:14:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D483F35BA;
	Mon, 14 Apr 2008 21:14:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C621235B7; Mon, 14 Apr 2008 21:13:53 -0400 (EDT)
In-Reply-To: <1208202740.25663.69.camel@work.sfbay.sun.com> (Roman
 Shaposhnik's message of "Mon, 14 Apr 2008 12:52:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79551>

Roman Shaposhnik <rvs@sun.com> writes:

>> Don't get me wrong.  I am not saying that everybody should start rolling
>> their own "sane environment setup script" and ship their project with it.
>> I am only suggesting it as a possible way to do your "policy enforcement"
>> without having to introduce in-tree .gitconfig, which I unfortunately see
>> no fundamental upsides but definite downsides (security included).
>
> And here comes my question: could you, please, elaborate on *technical*
> drawbacks of in-tree .gitconfig (such as security that you've
> mentioned).

Just to name a few, as I do not see a point in spending time elaborating
in detail when there is an alternative without such security downsides.

One of your examples was about a forced use of custom merge tool.
Consider in-tree .gitconfig that is always read for everybody that
describes such a tool.  A malicious script named there is a security risk
for people who clone such a project.  A smudge filter is even worse, as it
kicks in the minute you try to check out the project.

These executable (not just merge tool or attribute filters) are designed
to be named by .git/config exactly because .git/config is designed to be
personal (i.e. "that _particular repository only_") and you can afford to
be environment and platform specific there.  If you start describing them
in in-tree .gitconfig, they must be cross platform and (worse yet)
you have to make sure they are installed everywhere.

There are states recorded by git-submodule whether the particular
repository has seen and is interested in which submodule (i.e. "submodule
init" has been run).

I'm too lazy to make a laundary list of what you can have in .git/config
with the current system (see Documentation/config.txt), but that part of
the system is built around the design that the configuration is specific
to the repository (and sharing what the user records in ~/.gitconfig
across repositories is in line with it).

Unless you are willing to sift through all of them, mark which ones can be
overriden by in-tree .gitconfig and which ones cannot, and implement an
easy to use (by both the developers and the users) mechanism to enforce
the distinction, just changing the git_config() function to read from one
new place (i.e. in-tree .gitconfig) would not be a sufficient solution for
what you seem to want to do.
