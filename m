From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use clean.requireforce to protect untracked files.
Date: Fri, 03 Jun 2011 08:11:00 -0700
Message-ID: <7vipsnar23.fsf@alter.siamese.dyndns.org>
References: <4DE8C1AE.4000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSW26-0000mG-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 17:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab1FCPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 11:11:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1FCPLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 11:11:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5F645F22;
	Fri,  3 Jun 2011 11:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8rSBtIaB11vCHWTtTI2c+s0FKRA=; b=xJQJcs
	/NAiGit1OnIaW5pZZ7R7J6xB77jTLxxEk8vb47gndDvTUWHlROZpIKGPAlyOLIiW
	kgAXrKoYw3G3341q8FP9oZNbmvhuJ1kzyTsSpPVxKpd+nqFdiOwo7/2N22X4getS
	5+kiKPseOXm9MY/iZnm0cUG9iOuZu/6SEgDB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LDEuVcZswr1BJh6h4w6WmumuE4+Cu4lQ
	cseCzqErQH+jAcZe/sEqKnmLwOuGmo3YvckQ/ERRwVFrdJa74XpxTdvqOCCVySfP
	GZG0KceJ/hvwz6Iuu134TsRTa8n7a/bBRWePjCL0gk0JGawHTtQf3LazgrcHBJz0
	BHsYRSNcx/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C36A95F21;
	Fri,  3 Jun 2011 11:13:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C62855F1F; Fri,  3 Jun 2011
 11:13:10 -0400 (EDT)
In-Reply-To: <4DE8C1AE.4000007@gmail.com> (Jiang Xin's message of "Fri, 03
 Jun 2011 19:12:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00455BE6-8DF4-11E0-B01D-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175011>

Jiang Xin <worldhello.net@gmail.com> writes:

> Untracked files may be significant for certain repositories, but if run the
> command "git clean -fdx" by accident, all untracked files will be lost.

Don't add -x without thinking, then. It is the way to tell the command "I
want to remove all the untracked files and I REALLY MEAN IT".  It is often
used to say "I do not trust Makefile and I want to remove what 'make
clean' would leave behind".

A slightly related tangent is that we only have three classes of paths:

 - tracked ones
 - untracked ones, where there are two subclasses
   - unignored ones (e.g. new source file you haven't added)
   - ignored ones (e.g. build artifacts like *.o files)

and because of that, the general design is to consider "ignored" files
expendable during various operations. Sometimes people deliberately "ignore"
files that they consider not expendable, which is (by today's definition)
a wrong thing to do, but I think in the longer term we should add a way to
mark them as "ignored but precious".

  http://thread.gmane.org/gmane.comp.version-control.git/172818/focus=172846

Nobody has designed how this fourth class should behave (and how the
behaviour of the "ignored" should change, if any) yet, but a rough outline
would probably be:

 - precious files are the ones that are ignored (by today's definition,
   i.e. .gitignore mechanism consideres they are ignored) but marked as
   "precious" in some other way [*1*]. They will

   - not appear in "Untracked files:" section in "git status" output;
   - not be added by "git add" without "-f", just like other ignored files;
   - not be overwritten or removed to make room while switching branches;
   - not be removed with "clean -f -x" [*2*].

 - ignored files will stay to be "expendable".

I suspect there may be some codepaths that incorrectly treat them as not
expendable, and protect their lossage. We would want to fix them after we
introduce the "precious" class.

[Footnotes]

*1* We could invent a way to sneak such entries in .gitignore, but I am
inclined to think it would be cleaner to define "precious" attribute and
let the attributes mechanism handle this.

*2* This is just off the top of my head without thinking things
through. It might turn out that it makes more sense ot remove them.
