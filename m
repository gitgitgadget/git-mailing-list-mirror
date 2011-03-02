From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/3] Fix unnecessary (mtime) updates of files during
 merge
Date: Wed, 02 Mar 2011 15:22:00 -0800
Message-ID: <7vaahdaz1j.fsf@alter.siamese.dyndns.org>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 00:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuvN6-000493-As
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab1CBXWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 18:22:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab1CBXWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 18:22:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 650B63229;
	Wed,  2 Mar 2011 18:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1gIOYp1NRSl0rFOupY4Kp/BOiMk=; b=Frg8NrLJ0WTwNbouATty+37
	fsBvfCXlgZ8QqoJ1OSDJ1DcMbBIpqjf2WL91+kelVP6WoGoWMmRpYwc4aiMq/gZ3
	hfldvrL28/brvkEH1XrrTwQzH5gXuAfLzvQdU7qQr3oHuC/aVyq8Qxivv49tmVFB
	d7xif/NajcpJ63Vvm1Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QDHnsTrdrVKD39QrfV06Blrny4aqWOhMAyh/TrhQs1vo7uvZc
	aApEiQWPOMZxpnmeT9XRN6FKLSJozpopfzGO7JTGELEE+cbtC+CWbx1uQy2+Ot7t
	RjGHIX9NLmcxprt27lN/BWeGlkYBdCzla7HptGfI9sCNtOCR5UvsEqr8w4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24ECF3225;
	Wed,  2 Mar 2011 18:23:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BABBE3224; Wed,  2 Mar 2011
 18:23:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14CB17E0-4524-11E0-ABBB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168360>

Elijah Newren <newren@gmail.com> writes:

> We could fix this second testcase by recording stat information for
> files removed by make_room_for_directories_of_df_conflicts(), and
> then, if those files are reinstated at the end of conflict resolution
> (i.e. the directory of the D/F conflict went away during the merge),
> then call utime() to reset the modification times on those files back
> to what they originally were.

Which is a big Yuck.  I agree that we don't want to go there.

The real cause of the problem is that the code removes the files that
could potentially involved in conflict _way_ too early, and unfortunately
this is coming from the way merge-recursive tracks d/f conflicts, which is
to grab set of path that can potentially appear as directories by throwing
all directories into a single string list from both sides of the merge
(same for non directory paths using another single string list) upfront,
and after that point, it becomes very hard to tell if the potential
directory is on your (i.e. stage #2) side or on their side, and to make
things worse, it doesn't wait writing partial results out to the working
tree before it knows the result of the merge to say something intelligent
like "all these files under the directory will go away and we can safely
keep the file there".  Your earlier series, e.g. 2ff739f (merge-recursive:
New function to assist resolving renames in-core only, 2010-09-20), was a
step in the right direction, but we are not there yet while functions like
make_room_for_path() and make_room_for_directories_of_df_conflicts() are
used.

So I think it would need a lot major restructuring of the merge-recursive,
especially its d/f conflict logic, to fix the second one correctly.

Thanks.
