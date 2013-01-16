From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 14:32:03 +0100
Message-ID: <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvT6b-0004tV-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab3APNcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 08:32:16 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:57634 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753869Ab3APNcP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 08:32:15 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TvT63-0003w5-HO; Wed, 16 Jan 2013 14:32:03 +0100
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358343135;cb65bfeb;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213754>

Hi there,

I was just working on improving git-remote-helper.txt by documenting how remote helper can signal error conditions to git. This lead me to notice a (to me) surprising change in behavior between master and next that I traced back to this patch series.

Specifically:

On 30.11.2012, at 02:41, Chris Rorvick wrote:

> This patch series originated in response to the following thread:
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/208354
> 
> I made some adjustments based on Junio's last round of feedback
> including a new patch reworking the "push rules" comment in remote.c.
> Also refined some of the log messages--nothing major.  Finally, took a
> stab at putting something together for the release notes, see below.

>From the discussion in that gmane thread and from the commits in this series, I had the impression that it should mostly affect pushing tags. However, this is not the case: It also changes messages upon regular push "conflicts. Consider this test script:


#!/bin/sh -ex
git init repo_orig
cd repo_orig
echo a > a
git add a
git commit -m a
cd ..

git clone repo_orig repo_clone

cd repo_orig
echo b > b
git add b
git commit -m b
cd ..

cd repo_clone
echo B > b
git add b
git commit -m B
git push


With git 1.8.1, I get this message:

 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to '/Users/mhorn/Projekte/foreign/gitifyhg/bugs/git-push-conflict/repo_orig'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.



But with next, I get this:


 ! [rejected]        master -> master (already exists)
error: failed to push some refs to '/Users/mhorn/Projekte/foreign/gitifyhg/bugs/git-push-conflict/repo_orig'
hint: Updates were rejected because the destination reference already exists
hint: in the remote.


This looks like a regression to me. No tags were involve, and the new message is very confusing if not outright wrong -- at least in my mind, but perhaps I am missing a way to interpret it "correctly" ? What am I missing?


Cheers,
Max
