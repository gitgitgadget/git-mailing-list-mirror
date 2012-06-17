From: David Kilzer <ddkilzer@kilzer.net>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sat, 16 Jun 2012 20:58:55 -0700
Message-ID: <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org> <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> <7vd34z96lv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 06:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg6jy-00071b-8l
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 06:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913Ab2FQEEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 00:04:41 -0400
Received: from nm38-vm5.bullet.mail.ne1.yahoo.com ([98.138.229.149]:25926 "HELO
	nm38-vm5.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750739Ab2FQEEk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 00:04:40 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2012 00:04:40 EDT
Received: from [98.138.90.52] by nm38.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jun 2012 03:58:54 -0000
Received: from [98.138.226.63] by tm5.bullet.mail.ne1.yahoo.com with NNFMP; 17 Jun 2012 03:58:54 -0000
Received: from [127.0.0.1] by smtp214.mail.ne1.yahoo.com with NNFMP; 17 Jun 2012 03:58:54 -0000
X-Yahoo-Newman-Id: 508970.54535.bm@smtp214.mail.ne1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: Khu2vIEVM1kZQMCg3XRozfA2no65Mcmo64lNTzV3Rnzsa8U
 bPvohyKpdJo335MxRONJsDr7goOXkYpaNhTfaZsjJr7TGIkjgN_WGsqjhqiS
 hiFUXmnTeQGi5GzDeHovD2VcAuM91usjwGgbG7DyHc..kPnwcOkZu.WPiKOt
 ozre3Hq2cqZDWx5JvlP1Fu0Rx3qvapOrtGnzl2rHq.j.mpd828QAOQ6pj5wI
 T34uxUQsgBH7JAnigQFGJi8mUb9UNhpCkpkkjDtm7kanpn0vtGzVApPPXBmy
 O.4t_jKxWo_hz.c5VTg.4G3X_ozXWFCx1.qdFRbdvFbV8ZCNFXosSAiuWIwN
 olmzzESUQ1OR1pL0jrmrUzES6MrHguEdDhNh7szZ7BF0F_ygPFxrqG6WRxyK
 BoRaUpTxcqrwQUTOwDrZLKmLfnIwrpyLcn.PiTL7tQ5gEkkOMsS9ne33e.yZ
 EQMAaYsy9SbKfFcWN4esBCID7W4WMovPJYcxSIrltwCg6QBnRBiE_TuYwbj6
 eejpXl4v6la8PxT_eAoADLRAK7elVM64-
X-Yahoo-SMTP: 1KOiJh.swBAFCIHbgY4jfyoPcdmG
Received: from kilze0-204.kilzer.net (ddkilzer@98.207.50.178 with plain)
        by smtp214.mail.ne1.yahoo.com with SMTP; 16 Jun 2012 20:58:54 -0700 PDT
In-Reply-To: <7vd34z96lv.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200116>

On Jun 15, 2012, at 10:19 PM, Junio C Hamano wrote:

> David Kilzer <ddkilzer@kilzer.net> writes:
> 
>> Thanks!  I'll repost the patch based on rerere.autoupdate for further discussion.
> 
> I do not use the configuration variable myself, and I didn't check
> the code, but if you had rerere.autoupdate set, doesn't "git merge"
> in the codepath you are touching (or anywhere for that matter)
> already blindly take the replayed resolution and commit the result?

No, it does not.  That is what I originally expected to happen when I used "git rebase -i -p" through a merge with conflicts, but it currently does not behave this way.

> In other words, do you need to do anything special to make the
> command honour rerere.autoupdate?

Yes, there are two changes required to make it behave this way, both in git-rebase--interactive.sh in the same locality:

1. Pass --rerere-autoupdate to git-merge if rerere.autoupdate is true.
2. Run git-update-index (before dying) to determine if all conflicts were successfully resolved and commit the result if so, else die as before.

There is one big caveat to #2, though.  If the original (pre-rebase) merge commit contained changes to a non-conflicted file, those changes will be lost if all of the conflicted files are auto-updated using rerere.

This is actually a real concern in a particular git repository that I maintain where I'm merging individual commits from two different git-svn repositories into a third pure-git tree.  (One svn tree is essentially a branch of the other.)  I merge individual commits from both git-svn trees to provide the highest fidelity for (potential future) git-bisect operations.  When I hit a build failure after ~100 commits, I determine how best to fix it, then run "git rebase -i -p" to inject the fix in the proper merge commit.  Occasionally I catch a build failure when resolving a conflict, which may also cause me to change a non-conflicted file.

I now have a patch series for #1 and #2 (including a failing test that provides an example of a change to a non-conflicted file getting lost during "rebase -i -p").  Would it be helpful to post this patch series?

> Assuming that your patch does not need to do anything special based
> on the rerere.autoupdate configuration (because the underlying
> "merge" may automatically take care of it), I think what you need
> may be a mechanism to give --[no-]rerere-autoupdate option to "git
> rebase -m/-i/-p" and pass that option to the invocation of
> underlying "git merge", so that the user who does not usually want
> to blindly trust the replayed resolution (hence rerere.autoupdate
> configured to false) can choose to tell the "git rebase -m/-i/-p"
> command that "for this single invocation it is OK to trust the
> replayed resolution".  Or the other way around, i.e. "Even though I
> have rerere.autoupdate configured to true, for this single
> invocation of 'rebase', I am giving the '--no-rerere-autoupdate'
> option to tell you that you should _not_ blindly replay the
> resolution."


Yes, that sounds reasonable.  What would be the best way to store this rebase-only switch?

Does git-config have a per-rebase-operation mode where config options can be read/written for the duration of a specific rebase operation such that these config settings override all the other config files?  That has the potential to provide a better separation of concerns rather than creating yet another one-off file in .git/rebase-*/.  (May want to add an extra flag to git-config like --check-rebase or --rebase to make it check for .git/rebase-*/config before .git/config since that probably shouldn't be the default behavior when the user invokes git-config.)

Or would it be best just to touch an empty file in .git/rebase-*/ for this purpose?

Dave
