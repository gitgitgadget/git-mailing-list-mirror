From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 08:48:05 -0700
Message-ID: <7vtyrgllje.fsf@alter.siamese.dyndns.org>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
 <4BC2D61B.7050902@drmicha.warpmail.net>
 <7vk4sdm5kw.fsf@alter.siamese.dyndns.org>
 <r2vfbd9d3991004120143td6f90410j60c7c002b15d5db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:48:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Ls6-0000iJ-7n
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab0DLPsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 11:48:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab0DLPsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 11:48:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 358D5AA9F6;
	Mon, 12 Apr 2010 11:48:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QhPdNFJhYeqva87Pt2feRgswpFE=; b=nGQ3Diz4aDa4SfRstUhGBrj
	XJ3KHKVW6n6mDhgFR9MNn4cuoh5/uoVwJzLEniISFei4uDZ+SoQWMF6/k9//MRq+
	m13cZ2pAtR+Ztu1F94/tjJQiK4cnLz7HvByeL4qcWdPwk6Rh4KzvI6ZEhXttH/81
	22MRdxWaD1ycTBfkfJ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TgnhNZDvRqc9J1rPf0kHljiXuGSCuMuUe3tl8LeYcqoObjECn
	5tJlKAFQcA792Z9/x5fnmDtyAFtRtu3xP8hHWOSbicygwvULTOKPj9Un+nrai7Pl
	GfyolSVqR69HWI2MHaV7qRr/iKYaxtVF/FVjrxSThjOdq7I6Inl/syjO3k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6563AA9E8;
	Mon, 12 Apr 2010 11:48:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4C2BAA9E6; Mon, 12 Apr
 2010 11:48:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CBF25200-464A-11DF-BEE5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144745>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> That would work but introduces a special case for smtpuser.  Do you
> think users may wish to unset override other options too?

I would indeed agree "users may _wish_ to", but that does not matter as
much as "users _need_ to, otherwise they cannot do X and Y and Z".

You seem to think from the beginning of this thread that "empty means I
don't want it" is a hacky special case that is limited to this smtpuser
variable, but I do not share that view.  Not at all.

In fact, "empty means I don't want it" is a very common convention even
outside the context of git.  Make's use of its variables is a good
example.  Many people's shell scripts tend to treat an empty variable and
an unset variable the same way.  The language itself does distinguish an
empty and an unset variable, but the colon form of ${var:-something} was
invented in addition to the more old fashioned ${var-something} exactly
because "empty means unset" is so common.  Perl (run without -w/strict) is
the same way and undef becomes empty string by default and you need to
actively check defined($var) if you care about the difference.  Etc. etc.

There are two rather big reasons we would want to stick to the current
format without introducing "unset".  At least we would want to try to
until we find real need that justifies such a change.

 - We could introduce a backward incompatible change to the configuration
   file format to say "This variable is not set at all", but once somebody
   starts using the syntax in his .git/config (or worse $HOME/.gitconfig),
   that repository cannot be used by older version of git anymore.

 - Also internally our variables are never "unset".  Behaviour of a
   plumbing or Porcelain command implemented in C is controlled by
   variables in C, and the contents of the configuration files overwrite
   these variables as they are parsed from the least specific (system) to
   the most specific.  The best you can do is "reset to default" (not
   "unset"), and even that involves fair amount of change.
