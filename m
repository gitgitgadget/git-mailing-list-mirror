From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 12:07:45 +0100
Message-ID: <20130907110745.GH2582@serenity.lan>
References: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
 <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
 <20130905080606.GE2582@serenity.lan>
 <xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
 <20130905192646.GG2582@serenity.lan>
 <20130906214138.GA7470@google.com>
 <xmqq1u51wqbi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 13:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIGNG-0004zV-JG
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 13:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab3IGLIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 07:08:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:46635 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3IGLH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 07:07:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 743CFCDA5BA;
	Sat,  7 Sep 2013 12:07:57 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pS3njAPScbbY; Sat,  7 Sep 2013 12:07:56 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9E20ACDA5B3;
	Sat,  7 Sep 2013 12:07:47 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq1u51wqbi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234131>

On Fri, Sep 06, 2013 at 03:14:25PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > John Keeping wrote:
> >> On Thu, Sep 05, 2013 at 12:18:45PM -0700, Junio C Hamano wrote:
> >
> >>> I somehow thought that rebase by default looked in the reflog to do
> >>> exactly that. Perhaps I am not remembering correctly.
> >>
> >> It just does @{upstream} by default, which tends to get messy if the
> >> upstream has been rewritten.
> >
> > Maybe Junio is thinking of 'git pull --rebase', which walks the reflog
> > until it finds an ancestor of the current branch and uses that as the
> > <upstream> parameter to rebase.
> 
> You're right.
> 
> It makes me wonder why we did that one inside pull and not in
> rebase, though.

I'd never realised "pull --rebase" does that - it's exactly what I want
sometimes and I normally do fetch followed by rebase to get more control
over the process.

Perhaps we should do something like this (with added tests and
documentation)?

-- >8 --
Subject: [PATCH] rebase: use reflog to find common base with upstream

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8d7659a..5e3013d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -428,6 +428,14 @@ then
 			error_on_missing_default_upstream "rebase" "rebase" \
 				"against" "git rebase <branch>"
 		fi
+		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
+		do
+			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
+			then
+				upstream_name=$reflog
+				break
+			fi
+		done
 		;;
 	*)	upstream_name="$1"
 		shift
-- 
1.8.4.239.g2332621
