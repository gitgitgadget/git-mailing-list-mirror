From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 17/29] "guilt graph" no longer loops when no patches
 are applied.
Date: Tue, 13 May 2014 17:53:53 -0400
Message-ID: <20140513215353.GL4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-18-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:53:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKdy-0006Wv-MV
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbaEMVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:53:48 -0400
Received: from josefsipek.net ([64.9.206.49]:1548 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaEMVxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:53:46 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id F008F55654;
	Tue, 13 May 2014 17:53:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-18-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248869>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Tue, May 13, 2014 at 10:30:53PM +0200, Per Cederqvist wrote:
> Give an error message if no patches are applied.  Added a test case
> that never terminates unless this fix is applied.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-graph          |  9 +++++++--
>  regression/t-033.out |  3 +++
>  regression/t-033.sh  | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>  create mode 100644 regression/t-033.out
>  create mode 100755 regression/t-033.sh
> 
> diff --git a/guilt-graph b/guilt-graph
> index b3469dc..56d0e77 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -17,8 +17,13 @@ fi
>  
>  patchname="$1"
>  
> -bottom=`git rev-parse refs/patches/$branch/$(head_n 1 < "$applied")`
> -base=`git rev-parse $bottom^`
> +bottompatch=$(head_n 1 < "$applied")
> +if [ -z "$bottompatch" ]; then
> +	echo "No patch applied." >&2
> +	exit 1
> +fi
> +
> +base=`git rev-parse "refs/patches/${branch}/${bottompatch}^"`
>  
>  if [ -z "$patchname" ]; then
>  	top=`git rev-parse HEAD`
> diff --git a/regression/t-033.out b/regression/t-033.out
> new file mode 100644
> index 0000000..76613f9
> --- /dev/null
> +++ b/regression/t-033.out
> @@ -0,0 +1,3 @@
> +% setup_repo
> +% guilt graph
> +No patch applied.
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> new file mode 100755
> index 0000000..a3a8981
> --- /dev/null
> +++ b/regression/t-033.sh
> @@ -0,0 +1,13 @@
> +#!/bin/bash
> +#
> +# Test the graph code
> +#
> +
> +source "$REG_DIR/scaffold"
> +
> +cmd setup_repo
> +
> +# Check that "guilt graph" gives a proper "No patch applied" error
> +# message when no patches are applied.  (An older version of guilt
> +# used to enter an endless loop in this situation.)
> +shouldfail guilt graph
> -- 
> 1.8.3.1
> 

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
