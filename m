From: Max Horn <max@quendi.de>
Subject: Re: Updating shared ref from remote helper, or fetch hook
Date: Tue, 29 Jan 2013 16:00:14 +0100
Message-ID: <EAAA778A-EEAE-42C6-95C1-21F47F8DBC64@quendi.de>
References: <87ehh5lw9j.fsf@59A2.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Cfz-0006uI-J1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 16:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757014Ab3A2PAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 10:00:22 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:36321 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756934Ab3A2PAU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 10:00:20 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1U0CfW-00064c-SM; Tue, 29 Jan 2013 16:00:14 +0100
In-Reply-To: <87ehh5lw9j.fsf@59A2.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1359471620;bf3b7a97;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214939>

Hi Jed, all,


On 28.01.2013, at 06:19, Jed Brown wrote:

> I'm working on an hg remote helper that uses git notes for the sha1
> revision, so that git users can more easily refer to specific commits
> when communicating with hg users.

For the record, I am also working on that very same thing; it is yet another git-remote-hg alternative, based on Felipe's code but with many improvements. You can find it here: <https://github.com/buchuki/gitifyhg>.

Anyway, back to Jed's (and also my) question:

>  Since there may be multiple
> concurrent fast-import streams, I write the notes to a private ref
> (refs/notes/hg-REMOTE), to be merged eventually using
> 
>  git notes --ref hg merge hg-REMOTE*
> 
> There will never be conflicts because each hg commit translates to a
> unique git commit, thus even if multiple concurrent remotes process the
> same commit, the corresponding note will match.
> 
> Unfortunately, I couldn't find a safe way to get this run after a fetch
> or clone.  Of course I can ask the user to arrange to have this command
> run, but it would be a better interface to have it run automatically
> since it is a natural responsibility of the remote helper.  Am I missing
> a way to do this or a viable alternative approach?

One idea we (well, Jed :-) had when brain storming about this was that perhaps one could (or even should?) (ab)use the "checkpoint" feature for that.

Basically, when the remote-helper is almost done with everything, issue a "checkpoint" command, to flush out everything we just imported to the HD. 

Then once this completed, we can perform the notes merge. The main remaining problem with that is: How would we know when the "checkpoint" actually completed? Any ideas?

Perhaps a way to do that would be to make use of the new "bidi-import" remote helper capability -- if I understand it right, then this effectively connects the fast-import stdout to the stdin of the remote helper. Thus, if one were to follow the "checkpoint" by a "progress" command, then by waiting for that progress command's output to appear back on stdin, the remote helper could determine whether the import succeeded, and perform finalization actions (like merging notes, as in our case).


Does that sound viable? Crazy? Anybody got better a idea?


Cheers,
Max