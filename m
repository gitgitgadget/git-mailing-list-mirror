From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 15:41:17 -0700
Message-ID: <7vfxptpr76.fsf@gitster.siamese.dyndns.org>
References: <20080728162003.GA4584@artemis.madism.org>
 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
 <20080728205545.GB10409@artemis.madism.org>
 <20080728205923.GC10409@artemis.madism.org>
 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
 <20080728220308.GF10409@artemis.madism.org>
 <m3r69dtzm9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbQC-0006mm-5u
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbYG1Wl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYG1Wl1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:41:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYG1Wl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:41:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C532440ADA;
	Mon, 28 Jul 2008 18:41:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43A4340AD9; Mon, 28 Jul 2008 18:41:19 -0400 (EDT)
In-Reply-To: <m3r69dtzm9.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 28 Jul 2008 15:26:33 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F96D30A-5CF6-11DD-BA70-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90517>

Jakub Narebski <jnareb@gmail.com> writes:

> Pierre Habouzit <madcoder@debian.org> writes:
>> On Mon, Jul 28, 2008 at 09:40:22PM +0000, Avery Pennarun wrote:
>
>> > Further, if you don't have a separate .git directory for each
>> > submodule, you can't *switch* branches on the submodule independently
>> > of the supermodule in any obvious way.
>> 
>> Yes you can, in what I propose you have a dummy .git in each submodule,
>> with probably an index, a HEAD and a config file (maybe some other
>> things along) to allow that especially.
>
> What you are (re)inventing here is something called gitlink (.git which
> is a file, or .gitlink file); not to be confused with 'sumbodule'/'commit'
> entry in a tree which is sometimes called gitlink....
> ...
> There was even some preliminary implementation IIRC, but AFAIR it
> was abandoned because of no "real usage".

I am afraid you are confused.  I think you are talking about "gitfile",
not "gitlink".

It is not abandoned; see e.g. read_gitfile_gently() in setup.c.

I suspect the use of it may help the use case Pierre proposes, but its
main attractiveness as I understood it back when we discussed the facility
was that you could switch branches between 'maint' that did not have a
submodule at "path" back then, and 'master' that does have one now,
without losing the submodule repository.  When checking out 'master' (and
that would probably mean you would update 'git-submodule init' and
'git-submodule update' implementation), you would instanciate subdirectory
"path", create "path/.git" that is such a regular file that that points at
somewhere inside the $GIT_DIR of superproject (say ".git/submodules/foo").
By storing refs and object store are all safely away in the superproject
$GIT_DIR, you can now safely switch back to 'maint', which would involve
making sure there is no local change that will be lost and then removing
the "path" and everything underneath it.
