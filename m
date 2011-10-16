From: Junio C Hamano <gitster@pobox.com>
Subject: What should "git fetch origin +next" should do?
Date: Sun, 16 Oct 2011 00:20:02 -0700
Message-ID: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 09:25:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFL6Y-00059i-VT
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 09:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1JPHUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 03:20:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab1JPHUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 03:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC0C4240;
	Sun, 16 Oct 2011 03:20:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	bWvUSZaPQD7tTS/ahNhXaP6fns=; b=ZSN7l6OrF35bJm+Z5AG28fmqxk0JK3sXn
	eU6mYcaGBu741u8JhxC3nkn1El8iuKn6DIEiIDBFMxD7sxzmauGBp2ab90xl6Zva
	Ly5XzAE40PQhvjR+0Kgmz8OWr/fYdN+wtIrCGi49sRemJa6GF5J5FS1VD/XtWqYr
	kr+j0eDEzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=lpa
	tJdbJpADQEDszZ2IguEME48JzD5yryqLKdwm11NmWDzrx0KFUzObaITwYm5v2OoO
	QOeFOnvA3yis+R89wUnruPGyo7J1iukR6C3WWC27h0HAVyDTdzaixfgrf2h51nkX
	UxMJo6XtlDNPuJNxbmetnMgEPSR6Fhyr9ISdD1xU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 032AC423F;
	Sun, 16 Oct 2011 03:20:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E71BA423D; Sun, 16 Oct 2011
 03:20:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 446B8A2E-F7C7-11E0-99C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183693>

As some might know, I use the traditional non-separate-remotes layout in
many of my working trees. I am old fashioned.

I just tried to update one of them with "git pull --ff-only", and after
seeing that the fetch phase failed with non-ff on 'next', ran

	$ git fetch origin +next

which happily copied the tip of updated next to FETCH_HEAD and nowhere
else. Of course, a colon-less refspec means do not store it anywhere,
i.e. "<colon-less-refspec>" === "<colon-less refspec>:", so prefixing it
with '+' to force would logically be a no-op.  But it nevertheless was
somewhat surprising and irritating.

This is one of the many things that is so minor that it probably is not
worth risking backward compatibility issues to change, but something that
we would design differently if we were starting from scratch. Maybe in Git
2.0.

The question however is what should it do. I can see three possibilities:

 (1) Forcing to fetch into FETCH_HEAD does not make any sense, so instead
     of silently ignoring the '+' prefix, error it out and do not fetch
     anything. This is easy to explain and logically makes more sense than
     the current behaviour.

 (2) Do notice '+' and understand that it is a request to force fetch into
     some ref locally, and from the lack of colon and RHS, assume that the
     user wants Git to infer the RHS using the configured refspec (in my
     case, "refs/heads/next:refs/heads/next" is one of the configured
     fetch refspec; "refs/heads/*:refs/remotes/origin/*" would be the one
     that would match in the separate-remotes layout). In other words,
     treat it as if the user typed "+refs/heads/next:refs/heads/next" (or
     "+refs/heads/next:refs/remotes/origin/next" in the separate-remote
     layout) from the command line.

 (3) Do notice '+' is applied to 'next' but otherwise ignore the fact that
     it is a command line pathspec, which would cause us to ignore
     configured refspecs. In other words, fetch normally as if there were
     no refspec on the command line, but when updating refs/heads/next (or
     refs/remotes/origin/next in the separate-remotes layout), allow non
     fast-forward updates.

The latter two are hard to explain and more error prone. I tend to think
both would be a mistake. If "+next" from the command line is modified to
update our remote tracking branch using the configured refspec, "next"
without '+' prefix also should. Otherwise the behaviour becomes too
inconsistent, but it is often convenient to fetch one-off even from a
configured remote using "git fetch origin next" into FETCH_HEAD without
updating our remote tracking branches, and change along the lines of
either (2) or (3) will forbid such a workflow.

Additionally (3) has very little advantage over "git fetch --force".  If
'next' and 'master' both do not fast-forward, and the configured fetch
refspecs require both to fast-forward, "git fetch --force" would update
both, and "git fetch +next" with interpretation (3) would error out by
noticing that 'master' does not fast-forward. But anybody who is doing
"git fetch +next" already knows that 'next' does not fast-forward, and
that is because he has tried regular "git fetch" and saw both 'next' and
'master' fail back then, so he either wants to update only 'next', in
which case interpretation in (3) would not be helpful, or wants to update
both, in which case --force would be a better choice and exists already.

Perhaps we can/want to implement (1)?
