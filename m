From: John Keeping <john@keeping.me.uk>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 19:45:21 +0000
Message-ID: <20130327194521.GQ2286@serenity.lan>
References: <51531059.8000407@atechmedia.com>
 <7vsj3gn55b.fsf@alter.siamese.dyndns.org>
 <515331F2.3060703@atechmedia.com>
 <874nfw4t0r.fsf@59A2.org>
 <51533E8D.5050206@atechmedia.com>
 <87zjxo3b7b.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charlie Smurthwaite <charlie@atechmedia.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwIK-0005gg-GM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3C0Tpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:45:32 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:40568 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3C0Tpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:45:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 44240CDA57C;
	Wed, 27 Mar 2013 19:45:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rafzedndoC7I; Wed, 27 Mar 2013 19:45:30 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A12BECDA5A5;
	Wed, 27 Mar 2013 19:45:23 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87zjxo3b7b.fsf@59A2.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219312>

On Wed, Mar 27, 2013 at 02:16:24PM -0500, Jed Brown wrote:
> Charlie Smurthwaite <charlie@atechmedia.com> writes:
> 
> > Yes, I would need to be able to do this on a bare repo for my use case. 
> 
> And if it's on the server, you don't want this to be observable, so
> you don't want HEAD to move around. I don't know a better way than:
> 
>   $ git clone --shared -b upstream-branch bare-repo.git /tmp/merge-repo
>   $ cd /tmp/merge-repo
>   $ git pull URL incoming-branch
> 
> Cloning with --shared just writes a path into .git/objects/info/alternatives
> and it doesn't need to be on the same file system (unlike --local).
> 
> Since 'git merge-tree' just works with trees, it has less information
> than 'git merge'.

You could use a temporary index and do something like:

	rm -f TMP_INDEX
	GIT_INDEX_FILE=TMP_INDEX
	export GIT_INDEX_FILE
	git read-tree -m $base $ours $theirs &&
	git merge-index git-merge-one-file -a

then inspect that with "git diff-index --cached $ours".

Note that this will fail if there are conflicts and I don't know what
git-merge-tree will do in that case.
