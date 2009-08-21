From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Rebase with filters
Date: Fri, 21 Aug 2009 10:41:55 +0100
Message-ID: <320075ff0908210241g64fe224dkba1c5d499663c84e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 11:42:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeQdJ-0006It-24
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 11:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbZHUJl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 05:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbZHUJl4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 05:41:56 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42075 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbZHUJlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 05:41:55 -0400
Received: by bwz19 with SMTP id 19so365027bwz.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3+RS4D/zIXSIpwI1aL/Jye14c8xAeSaBwC3D6kfGIcM=;
        b=B/CiIn+RsHAVAYey5Bx4OcpAmZqn6JdAj1p3OV6lFw36gNOsgQOYn7ZIhzAxYKmbxK
         JJ5xqycEpPDB3qYAba5FbeFO30u9PGPRP5GARjvJixOdO9AFen134DF0l2H4bUcqbUX0
         fsgg+5PnpQeMSBcI5//2n/u6Usr2af1iWmWLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rVtis+M8dmmac17ka6MYUZ/Qw8JVdWKSp6YsrpuprBbLqvuD0gGDfaHpjxKp5kJvcz
         170ExdHFI/6npEA1K7eqBc124su9iOmxitdUDdQlBvClNvQAtmchpsO+uc/BhDysxo62
         o57qgA5YlcntwhEczTZMT3+bF4KcOzybYLHT8=
Received: by 10.103.126.33 with SMTP id d33mr371546mun.109.1250847715314; Fri, 
	21 Aug 2009 02:41:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126702>

Hello. I seem to be doing something wrong - that has previously caused
me to loose data (well, not really, the commit was still there, but it
took me a while to notice - gotta love the non-destructive nature of
git)

I have a project that contains a file that, irritatingly, an IDE will
always re-format on save, even if there are no changes. So, I use a
clean and smudge filter to re-order it into a sane format that's
easier to detect if there have actually been changes.

So far, so good. But, not everyone always uses this filter, and I get
some unexpected behavior when doing a 'git rebase'. For example - the
repository starts with a commit that has been sanely-ordered. I make a
change of several files, and commit locally - but when I come to push,
I find that origin/master has moved.

No worries, I do
git fetch
git rebase origin/master

Now I see the usual text going past, and including:

....
error: realtime/modules/realtime-flex-components/.flexLibProperties:
does not match index
Using index info to reconstruct a base tree...
<stdin>:59: trailing whitespace.

<stdin>:81: trailing whitespace.
			
<stdin>:83: trailing whitespace.
				parameters:[					
<stdin>:98: space before tab in indent.
   				if (item.value == null )
<stdin>:99: space before tab in indent.
   				{
warning: squelched 214 whitespace errors
warning: 219 lines add whitespace errors.
Falling back to patching base and 3-way merge...
error: Entry 'realtime/modules/realtime-flex-components/.flexLibProperties'
not uptodate. Cannot merge.
fatal: merging of trees 85b26f7c165c2a9d362340187b79527428b650e8 and
3ab3078b55e17dcb1f3f4c8e6a65eff517eedb92 failed
Failed to merge in the changes.
Patch failed at 0001 More KPI/Report work

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".


OK - looking a bit closer, someone committed .flexLibProperties
without the filter. I guess that's the "does not match index". Let's
merge..

 (|REBASE) $ git mergetool
No files need merging


Interesting - I guess there were no conflicts when the filtering was
all done. Let's just look at the status..

 (|REBASE) $ git status
# Not currently on any branch.
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   realtime/modules/realtime-flex-components/.flexLibProperties


Eek... Where's the rest of my files?!

My guess is that the "error" reported further up ought to terminate
the rebase without giving me the "When you have resolved this problem
run "git rebase --continue" because otherwise I end up loosing the
majority of the changes in my rebased commit.. ?
