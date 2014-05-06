From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 19/28] Check that "guilt graph" works when working on a
 branch with a comma.
Date: Tue, 6 May 2014 16:15:48 -0400
Message-ID: <20140506201547.GP1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-20-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlmH-0004Hn-W7
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbaEFUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:15:45 -0400
Received: from josefsipek.net ([64.9.206.49]:1583 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbaEFUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:15:44 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 90F4B55659;
	Tue,  6 May 2014 16:15:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-20-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248244>

On Fri, Mar 21, 2014 at 08:31:57AM +0100, Per Cederqvist wrote:
> git branch names can contain commas.  Check that "guilt graph" works
> even in that case.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-033.out | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-033.sh  | 37 +++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/regression/t-033.out b/regression/t-033.out
> index 76613f9..e638d7b 100644
> --- a/regression/t-033.out
> +++ b/regression/t-033.out
> @@ -1,3 +1,65 @@
>  % setup_repo
>  % guilt graph
>  No patch applied.
> +% git checkout -b a,graph master
> +Switched to a new branch 'a,graph'
> +% guilt init
> +% guilt new a.patch
> +% guilt pop
> +All patches popped.
> +% guilt push
> +Applying patch..a.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev 95275d7c05c6a6176d3941374115b91272877f6c
> +	"95275d7c05c6a6176d3941374115b91272877f6c" [label="a.patch"]
> +}
> +% git add file.txt
> +% guilt refresh
> +Patch a.patch refreshed
> +% guilt pop
> +All patches popped.
> +% guilt push
> +Applying patch..a.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +}
> +% guilt new b.patch
> +% git add file2.txt
> +% guilt refresh
> +Patch b.patch refreshed
> +% guilt pop
> +Now at a.patch.
> +% guilt push
> +Applying patch..b.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> +	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +}
> +% guilt new c.patch
> +% git add file.txt
> +% guilt refresh
> +Patch c.patch refreshed
> +% guilt pop
> +Now at b.patch.
> +% guilt push
> +Applying patch..c.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
> +	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
> +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> +	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
> +}
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> index ae40577..57dce78 100755
> --- a/regression/t-033.sh
> +++ b/regression/t-033.sh
> @@ -3,9 +3,46 @@
>  # Test the graph code
>  #
>  
> +function fixup_time_info
> +{
> +	cmd guilt pop
> +	touch -a -m -t "$TOUCH_DATE" ".git/patches/a,graph/$1"
> +	cmd guilt push
> +}
> +
>  source "$REG_DIR/scaffold"
>  
>  cmd setup_repo
>  

A comment here to justify this seemingly useless guilt-graph call?  Maybe
adding one of the '%%' lines between each section.  Otherwise, this looks
good.

>  shouldfail guilt graph
>  
> +cmd git checkout -b a,graph master
> +
> +cmd guilt init
> +
> +cmd guilt new a.patch
> +
> +fixup_time_info a.patch
> +cmd guilt graph
> +
> +cmd echo a >> file.txt
> +cmd git add file.txt
> +cmd guilt refresh
> +fixup_time_info a.patch
> +cmd guilt graph
> +
> +# An unrelated file. No deps.
> +cmd guilt new b.patch
> +cmd echo b >> file2.txt
> +cmd git add file2.txt
> +cmd guilt refresh
> +fixup_time_info b.patch
> +cmd guilt graph
> +
> +# An change to an old file. Should add a dependency.
> +cmd guilt new c.patch
> +cmd echo c >> file.txt
> +cmd git add file.txt
> +cmd guilt refresh
> +fixup_time_info c.patch
> +cmd guilt graph
> -- 
> 1.8.3.1
> 

-- 
It used to be said [...] that AIX looks like one space alien discovered
Unix, and described it to another different space alien who then implemented
AIX. But their universal translators were broken and they'd had to gesture a
lot.
		- Paul Tomblin 
