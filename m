From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 02 Jan 2013 10:08:12 -0800
Message-ID: <7vr4m331bn.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org> <20130102003344.GA9651@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Jan 02 19:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqSjz-0002Q2-EP
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 19:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3ABSIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 13:08:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab3ABSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 13:08:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3EBCB330;
	Wed,  2 Jan 2013 13:08:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOTjiKCHDON9sNPMDo2MNgBRIw4=; b=UELRAI
	yornixo4wHixrr9VQkPjnsKiLmBL2VaRc27ZnuCNITkVx4k78BILqDc21pZRcPC1
	U4ZvqVrm5ibDBUGEoxtBFHlxfNvv7RVbo+aoLIFGYNTBL7DzGRY5HVEOQ9CWHlRI
	NTJmrzT3IIxNCGCHD2AzRz0izoJqr1hdW1m4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yi4pJWdfYrRH+n1SUW5Jg4vyLh5HiVa6
	mYRKhp33N4AHcDFjyKNdLkri2lw02pPUfNVP4Z+E0zphYgqb22xlQknUZAgAi60J
	W2hxBODyfjD+dgofqlHFcbKRLwk2nimMBBfiDS6gToL7/IDQHMaGFC/2e3VGbH5P
	Ny74nO16mzE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5A3CB32F;
	Wed,  2 Jan 2013 13:08:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4341EB32E; Wed,  2 Jan 2013
 13:08:14 -0500 (EST)
In-Reply-To: <20130102003344.GA9651@thyrsus.com> (Eric S. Raymond's message
 of "Tue, 1 Jan 2013 19:33:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60455D12-5507-11E2-876A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212530>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> If you try to use new git-cvsimport with old cvsps, old cvsps will complain
> of an invalid argument and git-cvsimport will quit.

I see an opening for smoother transition here.

Like it or not, you cannot force distros to ship with cvsps 3.0 when
we ship our 1.8.2 (or 2.0 or whatever) that includes a cvsimport
that requires cvsps 3.0.  The best we can do is to make it capable
of working with cvsps 3.0 for a better result (when available), and
working with cvsps 2.0 in a limited way as ever (linear history
only, etc. etc.) when cvsps 3.0 is not available.

As your version already knows how to detect the case where cvsps is
too old to operate with it, I imagine it to be straight-forward to
ship the old cvsimport under obscure name, "git cvsimport--old" or
something, and spawn it from your version when necessary, perhaps
after issuing a warning "cvsps 3.0 not found; switching to an old
and unmaintained version of cvsimport..."

That way, people who have been happily working with linear CVS
histories with the old limited tool can keep using the same set-up
until their distro update their cvsps, without harming people who
need to work with more complex CVS histories, who can choose to
update their cvsps early themselves as $HOME/bin/cvsps earlier on
their $PATH.

By "cvsimport" (the current version), we are talking about a piece
of software that has been used in the field for more than 5 years,
still with a handful of patches to enhance it in the past two years.
A flag-day "this hot-off-the-press version is infinitely better"
replacement is not an option, especially when we can expect that
existing users are not asking for an "inifinitely better" version
(they rather prefer "stable" in the "works just as before" sense),
even when the hot-off-the-press version *is* infinitely better in
some use cases such as dealing with branchy histories.
