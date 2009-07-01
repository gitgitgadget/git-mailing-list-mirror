From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Wed, 1 Jul 2009 11:40:30 +0200
Message-ID: <20090701094029.GA22508@sepie.suse.cz>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz> <7vtz1x7f05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 11:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLwIy-0007n3-1Q
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 11:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZGAJk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 05:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZGAJk2
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 05:40:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41442 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbZGAJk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 05:40:27 -0400
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 928B68726A;
	Wed,  1 Jul 2009 11:40:30 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 241547664A; Wed,  1 Jul 2009 11:40:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtz1x7f05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122577>

On Tue, Jun 30, 2009 at 11:28:26AM -0700, Junio C Hamano wrote:
> Looking at ff06c74 (Improve request-pull to handle non-rebased branches,
> 2007-05-01), it introduced these specifically to address the issue you are
> bringing up, but it is ineffective.
> 
> I'd suggest to replace your patch with the attached instead.
> 
> ---
> 
>  git-request-pull.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index a2cf5b8..f86d8fd 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -42,8 +42,8 @@ if [ -z "$branch" ]; then
>  	status=1
>  fi
>  
> -PAGER=
> -export PAGER
> +GIT_PAGER=cat
> +export GIT_PAGER

Good idea, but for completeness, it should be set before this command:
    git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
(which should use tformat to get the newline right). So what about this
one?

---

diff --git a/git-request-pull.sh b/git-request-pull.sh
index ab2dd10..5917773 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -12,6 +12,9 @@ OPTIONS_SPEC=
 . git-sh-setup
 . git-parse-remote
 
+GIT_PAGER=
+export GIT_PAGER
+
 base=$1
 url=$2
 head=${3-HEAD}
@@ -34,7 +37,7 @@ branch=$(git ls-remote "$url" \
 	}")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
-	git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
+	git log --max-count=1 --pretty='tformat:warn:   %h: %s' $headrev >&2
 	echo "warn: Are you sure you pushed $head there?" >&2
 	echo >&2
 	echo >&2
@@ -42,8 +45,6 @@ if [ -z "$branch" ]; then
 	status=1
 fi
 
-GIT_PAGER=
-export GIT_PAGER
 echo "The following changes since commit $baserev:"
 git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
 
