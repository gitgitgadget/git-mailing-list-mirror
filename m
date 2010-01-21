From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] Allow to override mergetool.prompt with
 $GIT_MERGETOOL*_PROMPT
Date: Wed, 20 Jan 2010 23:44:28 -0800
Message-ID: <20100121074427.GA26973@gmail.com>
References: <4B572192.2020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 08:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXrZX-00088J-Jf
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 08:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab0AUHfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 02:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670Ab0AUHfL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 02:35:11 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:41180 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0AUHfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 02:35:10 -0500
Received: by ywh36 with SMTP id 36so5207696ywh.15
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 23:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aA07wOA0JPMabZEAqHx2Df4VS0jrNFcOJTznmIpr+K4=;
        b=IhR0zeFsgO/ErwqWjcmw2PwfJ0YjP9qqxSqlK1o0kMT2XN98CwFJN5uxqCOtgrQBzQ
         999C95B4eofaY9FExfiYjX7CDuuDeyAdKb3eyuqLkU7wYXmqxoXRrCGWm1LSSzQzpkHu
         Xaod2Mn2rYjPA1kLOvRl3tf5qmBmcgy9R1eco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MqDaoEvSL5bIywMUwuuwUqDLS1L58sEOS1o+FeScNwSBD6HT2ARApEqg7LlwM68TNY
         GUazn7NjdBa123PsOH418TSgGzv1ear73ZP7YIfKh/PSxUVoyf2GsWJkPMskqt8kBb26
         xBAOuGWx1T6DwESBZ8fyXUO7g/UKZWsZ8NixM=
Received: by 10.101.5.12 with SMTP id h12mr1447767ani.52.1264059309128;
        Wed, 20 Jan 2010 23:35:09 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm320882ywd.7.2010.01.20.23.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 23:35:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B572192.2020606@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137634>

Hi,

On Wed, Jan 20, 2010 at 04:30:26PM +0100, Sebastian Schuberth wrote:
> This is for symmetry with git-difftool, and to make should_prompt_merge ()
> reusable from within git-difftool--helper.
> 
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  git-mergetool--lib.sh |    9 +++++++++
>  git-mergetool.sh      |    3 ++-
>  2 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 5b62785..16b0343 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -7,6 +7,15 @@ merge_mode() {
>  	test "$TOOL_MODE" = merge
>  }
>  
> +should_prompt_merge () {
> +	local prompt=$(git config --bool mergetool.prompt || echo true)
> +	if test "$prompt" = true; then
> +		test -z "$GIT_MERGETOOL_NO_PROMPT"
> +	else
> +		test -n "$GIT_MERGETOOL_PROMPT"
> +	fi
> +}

Someone already mentioned dropping "local" here.

The GIT_DIFFTOOL*_PROMPT variables are implementation details
about how git-difftool passes options to git-difftool--helper.
We don't advertise them in the documentation so we probably
shouldn't support them aside from what is needed for
git-difftool.  We can drop this part.

61ed71dc just recently removed git-difftool--helper's use of
GIT_MERGE_TOOL based on this rationale.


> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index b52a741..d453cb0 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -202,7 +202,8 @@ merge_file () {
>      return 0
>  }
>  
> -prompt=$(git config --bool mergetool.prompt || echo true)
> +should_prompt_merge
> +prompt=$?
>  
>  while test $# != 0
>  do

git-difftool falling back to mergetool.prompt when
difftool.prompt is not available is good, especially
since we advertise that feature.

Once you drop the local declarations and the env. variable
it should be good to go.  Patch v2, soon?

-- 

	David
