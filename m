From: Nico Williams <nico@cryptonector.com>
Subject: Use case (was Re: Should branches be objects?)
Date: Mon, 23 Jun 2014 22:20:14 -0500
Message-ID: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 05:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzHHY-0002vw-PU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 05:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaFXDUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 23:20:17 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:40011 "EHLO
	homiemail-a72.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101AbaFXDUQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 23:20:16 -0400
Received: from homiemail-a72.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a72.g.dreamhost.com (Postfix) with ESMTP id 6C6F56B0078
	for <git@vger.kernel.org>; Mon, 23 Jun 2014 20:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:date:message-id:subject:from:to:cc:content-type; s=
	cryptonector.com; bh=+YRMK03ExZ3y9u9ngKqsqC+LL9c=; b=EYkD0rmKC0s
	a+IfD8yFgaLftE+9ByuakOo+Dj8VRFSUDwwNZsz0Ih3o+w6o7FRWxNNW8p6BNhSk
	QTSXM+nApfiYURw1g4ap/sWej5bBdZdgsRSpPMV8VXxf0qaAXYooHOE/IXHjEnR0
	Y82QlI2gkfCt26sm6mdZpZ8c/rePlQck=
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a72.g.dreamhost.com (Postfix) with ESMTPSA id 2122C6B0070
	for <git@vger.kernel.org>; Mon, 23 Jun 2014 20:20:15 -0700 (PDT)
Received: by mail-wg0-f42.google.com with SMTP id z12so7164245wgg.13
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 20:20:15 -0700 (PDT)
X-Received: by 10.194.2.45 with SMTP id 13mr60071wjr.127.1403580015019; Mon,
 23 Jun 2014 20:20:15 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Mon, 23 Jun 2014 20:20:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252384>

(thinking more about this, digesting Jonathan's response...)

The Illumos repo, like OpenSolaris before it, and Solaris itself at
Sun (and now at Oracle) requires that fixes be broken down into small
commits, with related fixes, tests, and docs changes all typically in
separate commits, but all pushed together, so that a single push of N
commits is a logical set of changes (e.g., to be backed out together
if, say, any one of them breaks a build).  With git the only way to
record this grouping at push time is with a post-receive hook that
does the recording (which is what the Illumos repo does, sending email
to a list about all the commits pushed in one go).

Now, suppose that branches were objects.  Then at push time one might
push with a message about the set of commits being pushed, and this
message (and time of push, and pusher ID) would get recorded in the
branch object.  At fetch time the branch objects's histories would be
pulled (but usually never pushed), and would be available for browsing
with git log at remotes/<remote>/<branch>.  Each commit of the branch
object (as it were) would record each logical set of commits.

Side effects besides addressing the contiguous and related commit grouping need:

 - no more need to sign-off on cherry-picks: the branch will record
the ousher's ID, which can then be taken as the person signing off;

 - branch objects substantially replace/augment reflogs;

 - no need to ammend commits: just push an empty set of commits just
to update the branch object with a note!

The UI would mostly consist of an option to git push to include a push
message, and a way to review branch history (much like git log -g, but
with access to the push-time metadata).  Also along for the ride: a
way to get the new metadata in post-receive hooks.

Problem: if pushing via an intermediary the push metadat would get
lost.  This would argue for either a stronger still notion of related
commits, or none stronger than what exists now (because ETOOMUCH).
But this branch object concept could also be just right: if pushing
through a an intermediary (what at Sun was called a project gate) then
it becomes that intermedirary's (gatekeeper's) job to squash, rebase,
regroup, edit, drop, reword, ... commits.

Just a thought,

Nico
--
