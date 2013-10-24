From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 22:31:35 +0100
Message-ID: <20131024213134.GD10779@serenity.lan>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
 <20131024205434.GC10779@serenity.lan>
 <xmqqa9hymkma.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSVT-00048F-Px
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab3JXVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:31:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34342 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3JXVbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:31:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 81024CDA5B3;
	Thu, 24 Oct 2013 22:31:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LHEEGt-cyON5; Thu, 24 Oct 2013 22:31:44 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 76619CDA566;
	Thu, 24 Oct 2013 22:31:44 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6A79E161E3B6;
	Thu, 24 Oct 2013 22:31:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XZc4oSxQFmM; Thu, 24 Oct 2013 22:31:43 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5F4D3161E30C;
	Thu, 24 Oct 2013 22:31:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqa9hymkma.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236627>

On Thu, Oct 24, 2013 at 02:20:29PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Thu, Oct 24, 2013 at 12:11:22PM -0700, Junio C Hamano wrote:
> >> The first one is a clean-up of the code to parse command line
> >> options to "git merge-base".  Options such as "--independent",
> >> "--is-ancestor" and "--octopus" are mutually exclusive and it is
> >> better expressed in terms of the recently introduced OPT_CMDMODE.
> >> 
> >> The second one implements the entire logic of the for loop we see in
> >> "git pull --rebase" directly using get_merge_bases_many() and
> >> postprocessing the result.
> >
> > Nice!  I tried this in the case where the target commit happens to be
> > the 63rd reflog entry:
> >
> > $ time sh -c 'for rev in $(git rev-list -g origin/master 2>/dev/null)
> > do
> >     git merge-base --is-ancestor $rev b2edae0 && break
> > done
> > '
> >
> > real    0m3.772s
> > user    0m3.338s
> > sys     0m0.440s
> >
> > $ time git merge-base --reflog origin/master b2edae0
> >
> > real    0m0.156s
> > user    0m0.138s
> > sys     0m0.018s
> 
> The real question is if the C code computes the same as the shell
> loop.

And in fact it doesn't - if you replace the "break" with "echo $rev" the
shell version prints b2edae0... but the C version prints nothing (and
exists with status 1).
