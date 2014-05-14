From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 08/29] Added more test cases for "guilt new": empty
 patches.
Date: Wed, 14 May 2014 13:10:41 -0400
Message-ID: <20140514171040.GF1582@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-9-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 14 19:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkchT-0000i5-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 19:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbaENRKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 13:10:36 -0400
Received: from josefsipek.net ([64.9.206.49]:1765 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756262AbaENRKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 13:10:35 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 00AEF55654;
	Wed, 14 May 2014 13:10:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-9-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248926>

On Tue, May 13, 2014 at 10:30:44PM +0200, Per Cederqvist wrote:
> Test that empty patches are handled correctly, both with and without
> the guilt.diffstat configuration option.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-020.out | 250 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-020.sh  |  60 +++++++++++++
>  2 files changed, 310 insertions(+)
> 
> diff --git a/regression/t-020.out b/regression/t-020.out
> index af45734..7e07efa 100644
> --- a/regression/t-020.out
> +++ b/regression/t-020.out
> @@ -1128,3 +1128,253 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
...
> +% git log -p
> +commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
> +Author: Author Name <author@email>
> +Date:   Mon Jan 1 00:00:00 2007 +0000
> +
> +    patch empty.patch
> +
> +commit d4850419ccc1146c7169f500725ce504b9774ed0
> +Author: Author Name <author@email>
> +Date:   Mon Jan 1 00:00:00 2007 +0000
> +
> +    initial
> +    
> +    Signed-off-by: Commiter Name <commiter@email>
> +
> +diff --git a/def b/def
> +new file mode 100644
> +index 0000000..8baef1b
> +--- /dev/null
> ++++ b/def
> +@@ -0,0 +1 @@
> ++abc
> +% git config guilt.diffstat false
> +---
> +

I'm a bit confused about the above.  It looks like contents of an empty
patch with an empty diffstat.  But the only time I see a cat in the .sh file
is when you rewrite... oh I got it.  I'll comment about it by the 'cat'.

...
> diff --git a/regression/t-020.sh b/regression/t-020.sh
> index cdd08ba..906aec6 100755
> --- a/regression/t-020.sh
> +++ b/regression/t-020.sh
> @@ -5,6 +5,13 @@
>  
>  source "$REG_DIR/scaffold"
>  
> +function fixup_time_info
> +{
> +	cmd guilt pop
> +	touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
> +	cmd guilt push
> +}
> +
>  cmd setup_repo
>  
>  #
> @@ -69,6 +76,59 @@ done
>  
>  cmd list_files
>  
> +# push an empty patch with no commit message
> +cmd guilt new empty.patch
> +fixup_time_info empty.patch
> +cmd list_files
> +cmd git log -p
> +
> +# Ensure we can push the empty patch even when guilt.diffstat is true.
> +cmd git config guilt.diffstat true
> +cmd guilt refresh
> +fixup_time_info empty.patch
> +cmd list_files
> +cmd git log -p
> +cmd git config guilt.diffstat false
> +
> +# Let the patch have a commit message, but no data.
> +cat .git/patches/master/empty.patch <<EOF

cat > .git/.../empty.patch <<EOF
...
EOF

Otherwise, you'll just cat the existing patch and that's it.

> +Fix a bug.
> +
> +From: Per Cederqvist <ceder@lysator.liu.se>
> +
> +This commit fixes a serious bug.
> +
> +FIXME:
> +    - add a test case
> +    - track down the bug
> +    - actually fix it
> +EOF
> +
> +fixup_time_info empty.patch
> +cmd list_files
> +cmd git log -p
> +
> +# And once more, with an empty diffstat.
> +
> +cmd git config guilt.diffstat true
> +cmd guilt refresh
> +fixup_time_info empty.patch
> +cmd list_files
> +cmd git log -p
> +
> +# Restore the diffstat setting and remove the empty patch.
> +cmd git config guilt.diffstat false
> +cmd guilt refresh
> +fixup_time_info empty.patch
> +cmd list_files
> +cmd git log -p
> +# (Cannot delete an applied patch)
> +shouldfail guilt delete empty.patch
> +cmd guilt pop -a
> +cmd guilt delete -f empty.patch
> +cmd list_files
> +cmd git log -p
> +
>  # FIXME:
>  #   --all
>  #   -a
> -- 
> 1.8.3.1
> 

-- 
Fact: 23.6% of all statistics are generated randomly.
