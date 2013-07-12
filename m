From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 13:28:57 -0700
Message-ID: <7vfvvjjzee.fsf@alter.siamese.dyndns.org>
References: <51E029B9.20108@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxjxi-0006Qo-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365Ab3GLU3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:29:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965283Ab3GLU3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:29:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD04302B1;
	Fri, 12 Jul 2013 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfvvMvb7z7Zkn4a6Cj6yNJHx004=; b=uml+BA
	o8MH7QAr3tm3005+j9XZC/x2+a44aUq53CwN3dG5UTdvbk7NATu8l1aB9YKhCu70
	iOhYF0Z10COIiT6+ehWyaNI+NVkVHyI56d1jHe4qBnuCRF2CaDeJjkJ1jZvj1iJz
	1ULvG6BtpVx6e+JQj6qeEgTxqRJTr8TzR5MJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EbMUyCeGgVHEuKoYh1cBj77ZIyW0qrjS
	hcBdkbLVPXyZBUs4HEakL+wCCfXOr5oinVp5wnRFbOaKpx1LO6QxZDy2Zn4EI5Ls
	GFuv9uRuIZO80g+oxy9TQIuki2pQmpQ8K1J9hFWt3dQjiEwG/uoxcudM4Qu6gq8R
	app3nn/ltHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D54FE302B0;
	Fri, 12 Jul 2013 20:28:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AC7E302AF;
	Fri, 12 Jul 2013 20:28:59 +0000 (UTC)
In-Reply-To: <51E029B9.20108@googlemail.com> (Stefan Beller's message of "Fri,
	12 Jul 2013 18:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEC32E5E-EB31-11E2-995C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230249>

Stefan Beller <stefanbeller@googlemail.com> writes:

> 	# Adding the line to the mailmap should make life easy, so we know
> 	# it's the same person
> 	echo "A <A@example.org> <changed_email@example.org>" > .mailmap

While I was looking at this, I noticed this piece of code:

diff --git a/mailmap.c b/mailmap.c
index 2a7b366..418081e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -122,7 +122,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 	while (nend > nstart && isspace(*nend))
 		--nend;
 
-	*name = (nstart < nend ? nstart : NULL);
+	*name = (nstart <= nend ? nstart : NULL);
 	*email = left+1;
 	*(nend+1) = '\0';
 	*right++ = '\0';

The function is given a buffer "A <A@example.org>...", nstart scans
from the beginning of the buffer, skipping whitespaces (there isn't
any, so nstart points at the buffer), while nend starts from one
byte before the first '<' and skips whitespaces backwards and ends
at the first non-whitespace (i.e. it hits "A" at the beginning of
the buffer).  nstart == nend in this case for a single-letter name,
and an off-by-one error makes it fail to pick up the name, which
makes the entry equivalent to

	<A@example.org> <changed_email@example.org>

without the name.  I do not think this bug affected anything you
observed, though.

> 	git shortlog -sne
> 		 1  A <A@example.org>
> 		 1  A <a@example.org>

This is coming from mailmap.c::add_mapping() that downcases the
e-mail address.

changed_email@example.org is mapped to a@example.org because of this
downcasing, while "A <A@example.org>" does not have any entry for it
in the .mailmap file, so it is given back as-is.  Hence we see two
distinct entries.
