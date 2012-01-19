From: Dieter Plaetinck <dieter@plaetinck.be>
Subject: Re: [PATCH] git-add: allow --ignore-missing always, not just in dry
 run
Date: Thu, 19 Jan 2012 11:52:16 +0100
Message-ID: <20120119115216.2773a02f@plaetinck.be>
References: <1326923544-8287-1-git-send-email-dieter@plaetinck.be>
	<7vobu0liwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 19 11:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnpcb-0006Lc-DM
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 11:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab2ASKx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 05:53:29 -0500
Received: from smtp01.priorweb.be ([62.182.61.111]:41300 "EHLO
	smtp.priorweb.be" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751072Ab2ASKx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 05:53:28 -0500
Received: from [178.79.146.162] (port=58255 helo=localhost.localdomain)
	by smtp.priorweb.be with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <dieter@plaetinck.be>)
	id 1RnpcR-0004U4-Co; Thu, 19 Jan 2012 11:53:23 +0100
In-Reply-To: <7vobu0liwj.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188808>

On Wed, 18 Jan 2012 14:56:12 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Dieter Plaetinck <dieter@plaetinck.be> writes:
> 
> > There is no need to restrict use of --ignore-missing to dry runs,
> > it can be useful to ignore missing files during normal operation as
> > well.
> >
> > Signed-off-by: Dieter Plaetinck <dieter@plaetinck.be>
> 
> Sorry, but for this kind of change, we would want to see a
> justification that is much better than that. The default around here
> is not to change an established behaviour without a good reason.

Hello Junio, thanks for your quick and elaborate response.
 
> Have you dug into the list archive to see _why_ we decided not to
> allow this option in the real run in the first place?

Actually I did, before submitting this patch.
From what I could find, the original patch [1] only cared about having this
feature available in dry run, and came with this "only in dry run" restriction,
merely because it was the only use case considered.
I couldn't find any evidence of this restriction actually being needed nor
any discussion of this matter. I added Jens to this mail, as he wrote
the original patch.

> You would need
> to find "By letting the command ignore missing paths, the user can
> get into X and Y situations and we would want to avoid it. We however
> need to give users a way to see if there is something missing, hence
> we add it when we are under dry-run option." and refute that previous
> justification, arguing why X and Y is something we should _not_ be
> worrying about, to make a good case for this change.

Yes, ignoring missing files can lead to files not actually being added, if they are missing.
But that's why this is an optional flag to needs to explicitly passed.
The flag is clear about what it does, so if users enable it, I don't see the problem?

> If somebody is writing a script using "git add" (which is not
> recommended to begin with), it is tempting to say 'git add
> $list_of_possible_files' in such a script when the script _knows_
> that the list it is giving to "git add" may contain a path that does
> not exist, and wants to ignore missing ones.
> 
> But then the script could easily filter what does not exist before
> compiling such a list, so that is not a very strong reason to advocate
> it.

The use case is as follows:
I'm working on a tool [2] which runs in the background, and automatically synchronizes file/directory trees,
by using inotify events, and synchronizing changes in the working tree to the
index automatically, committing automatically and push/pulling automatically.
Basically for when you want to version a tree with git, but without needing to manually
commit all the time. (useful for a directory with notes as text files, for example)
the problem is, you can have a constant stream of inotify events (if files are being
edited/deleted/(re)created all the time), and at the point where my tool decides to automatically commit the changes it just saw,
more changes (deletes, renames, readding a file that was just deleted, ..) can happen around the same time.
So basically, if this tool needs to check which files still/no-longer exist before calling git-add,
that's vulnerable to race conditions.
The only real solution against race conditions is to deal with (ignore) missing files right at the point where git
adds them to the index.

But if "git add" is not the right way, please let me know the alternative.
From what I can find "git add --all --ignore-missing <file>" (with my patch for allowing ignore-missing without dry run) would be the most appropriate,
this would never accidentially modify the working tree (as "git rm" for a deleted file could, if the file gets readded at the same point
where we call git), and it would gracefully handle changes we didn't see yet (such as new/modified files disappearing again)

thanks again for the feedback,
Dieter

[1] http://kerneltrap.org/mailarchive/git/2010/7/9/34077
[2] https://gitorious.org/search?q=dvcs-autosync
