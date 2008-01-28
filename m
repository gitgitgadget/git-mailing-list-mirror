From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Mon, 28 Jan 2008 02:51:25 -0500
Message-ID: <20080128075125.GC24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org> <20080128004722.GZ24004@spearce.org> <7vabmqwgvt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOmh-0007wc-6o
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYA1Hvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYA1Hvb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:51:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42750 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYA1Hvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:51:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJOm6-0004yd-Te; Mon, 28 Jan 2008 02:51:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31A9320FBAE; Mon, 28 Jan 2008 02:51:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vabmqwgvt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71859>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Hmm.  core.sharedrepository is sometimes a bad solution.
> >
> > core.sharedrepository means I need to give write access to both the
> > refs database and the object database to all members of the project.
> > Some of whom may not be able to be trusted with tools like "rm",
> > but who need real shell access to that system anyway.  And sometimes
> > management won't allow users to have two accounts on the same system
> > (one that is fixed to git-shell, and one that has a real shell)
> > because the world would implode if a user was given two different
> > accounts for two different access purposes.
> 
> Ok, that was the motiviation I did not get from your original
> message.  It begins to make sense somewhat.
> 
> Another approach to do the same I can think of, without having
> to add 50 new accounts for 50 users, would be to collect a ssh
> key from each of these 50 users, and have 1 line per user in the
> authorized_keys file of gitadmin.gitadmin user (who owns the
> repository with the paranoia hook that decides the authorization
> aspect of the repository).  The authentication would come from
> the environment="Name=value" option in the authorized_keys file.
> Each of your aunt tillies can push or fetch over ssh using the
> key she has in the gitadmin.gitadmin's authorized_keys file.

Yea.  The downside to this is we have to maintain that
authorized_keys file.  Today each user can generate their
own SSH key and upload to their own authorized_keys file.

I've had enough cases of users losing their SSH key and
needing to recreate it that I'd rather not have to manage
a 50 user long authorized_keys file.

I'm also not sure of what the performance implication is to SSH for
authentication with 50 public keys in a single file.  Does it slow
down as its running a check against each key, or is there something
smarter to filter the keys?  From the description of the format in
the OpenSSH manpage it doesn't look like its possible other than
to probe every key in turn for every authentication attempt.

In other words, the authorized_keys is a nice feature, but it seems
like its more useful for a remote backup job logging in as root, or a
"vacation mode" where a coworker is permitted to execute a specific
command while you are away.  But maybe I'm missing something.
 
> I suspect the "hackiness" factor from the aesthetics viewpoint
> is probably about the same, but this would work with the current
> code without patches, no?

Yes, it would, obviously.  But it has the downside of needing to
manage a single common authorized_keys file.  Which is something
I think I'd like to avoid.

It also doesn't do anything about upload-pack, as that has no hook
to perform authorization.  Of course just adding some sort of ref
filtering hook to upload-pack is still a smaller patch than adding
all this UNIX socket redirection and an upload-pack hook.  :)

-- 
Shawn.
