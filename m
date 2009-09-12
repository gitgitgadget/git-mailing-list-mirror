From: Junio C Hamano <gitster@pobox.com>
Subject: Re: previously committed file untracked prevent checking out an old 
 tag/branch
Date: Fri, 11 Sep 2009 17:06:37 -0700
Message-ID: <7vvdjpowky.fsf@alter.siamese.dyndns.org>
References: <9accb4400909110426v2a42086ema318167e94b2cbc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 02:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmG8m-0000ho-P2
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbZILAGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 20:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbZILAGp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 20:06:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZILAGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 20:06:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FB644D193;
	Fri, 11 Sep 2009 20:06:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=28b2qTVxUQE8E0lmqzkiyzerf/4=; b=PIbwI9
	wxxTy6SWnhrs4V1IMKXR44fd7cIGuHZfwpRaK66N2ezJMToXsicYvmFm0bjZpO9Q
	POU2DVKilYYqTD6WljDBSF1ichvle0llSmKWYRKmFF+VSYLc3zIkgHQNVf8ZOuSA
	JMFkV+zTMKr+23sYyw1crsQskNnU/s2+k9wEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xvuK92FJxyfPnFCDL3f2HXyxttCFoAjf
	nqxgvfPVr7IDJZwIiXIvVhu6c2ljQapXz3lM5rIr1HjzirJoPscwfbJGo47JYb0z
	o41yNB+n7OWx2eoc/lb95liBY4D+0mlYi9cjTx4+D0KvSomOePRHoikf5ftBnQQs
	vHoh1CQdnT0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E41824D192;
	Fri, 11 Sep 2009 20:06:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6AF14D190; Fri, 11 Sep 2009
 20:06:39 -0400 (EDT)
In-Reply-To: <9accb4400909110426v2a42086ema318167e94b2cbc1@mail.gmail.com>
 (Daniele Segato's message of "Fri\, 11 Sep 2009 13\:26\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28C3FB18-9F30-11DE-845F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128231>

Daniele Segato <daniele.bilug@gmail.com> writes:

> I only can think of doing a backup of my build.properties, delete it
> and check out the tag or I just delete it and rebuild
> it from the template later.

That is the right approach, but you could automate it further.

The project I help at work has a similar set-up.  The Makefile defines a
plain vanilla set of configuration via the Make variables, and they can be
overriden by including ./config.mk.  The master branch does not have the
file tracked, but ./config.mk-sample file is tracked and the developers
can use it as a template.

The developers can have an untracked (from the project's point of view)
subdirectory, local/. with local/myconfig.mk file.  "local" is in fact a
full fledged git repository with local/.git and changes to myconfig.mk can
be tracked there.  It is not (and should not be) a subproject.

Because what appear in the sample config.mk-sample are a bunch of Make
variable definitions, and in Make, later definition trumps the earlier
ones,  So the developers can do:

	$ cat config.mk-sample local/myconfig.mk >config.mk
        $ make

The first step can be in the Makefile; the above command line is for
illustration.

For branches that are used for specific customer release, we track their
config.mk file.  That means the developer would lose config.mk file if he
does this:

	$ git checkout master
	$ cat config.mk-sample local/myconfig.mk >config.mk
        $ make
	... do the usual work of developing and testing ...
        $ git checkout customer ;# may fail due to config.mk
        $ rm -f config.mk	;# so get rid of it
        $ git checkout customer ;# now it is ok
        $ make			;# for real release
        ... or perhaps to diagnose the issue at customer site  ...
        $ edit config.mk	;# minimally adjust for testing
        $ make
        $ test
	... done, and go back to the regular programming ...
        $ git checkout config.mk ;# get rid of local changes
        $ git checkout master

But because the real configuration is tracked in local/.git, there is no
information lossage.

The generic config.mk _could_ be written to include local/myconfig.mk if
exists, in order to help debugging or testing the customer branch (then
there is no need for "edit config.mk for testing and then revert" steps),
but we chose not to do so, as it risks the release/build engineer to
forget that he has funny customization in his local/myconfig.mk file and
screwing up the release by inadvertently including the customization.

HTH ;-)
