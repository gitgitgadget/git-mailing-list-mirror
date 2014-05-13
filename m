From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 19/29] Check that "guilt graph" works when working on
 a branch with a comma.
Date: Tue, 13 May 2014 17:36:59 -0400
Message-ID: <20140513213659.GH4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-20-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:36:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKNe-0003wI-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbaEMVgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:36:55 -0400
Received: from josefsipek.net ([64.9.206.49]:1747 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbaEMVgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:36:53 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 580C655654;
	Tue, 13 May 2014 17:36:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-20-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248864>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


On Tue, May 13, 2014 at 10:30:55PM +0200, Per Cederqvist wrote:
> git branch names can contain commas.  Check that "guilt graph" works
> even in that case.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-033.out | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  regression/t-033.sh  | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/regression/t-033.out b/regression/t-033.out
> index 76613f9..3d1c61f 100644
> --- a/regression/t-033.out
> +++ b/regression/t-033.out
> @@ -1,3 +1,68 @@
>  % setup_repo
>  % guilt graph
>  No patch applied.
> +%% Testing branch a,graph
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
> +%% Adding an unrelated file in a new patch. No deps.
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
> +%% Changing a file already changed in the first patch adds a dependency.
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
> index a3a8981..fac081e 100755
> --- a/regression/t-033.sh
> +++ b/regression/t-033.sh
> @@ -3,6 +3,13 @@
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
> @@ -11,3 +18,35 @@ cmd setup_repo
>  # message when no patches are applied.  (An older version of guilt
>  # used to enter an endless loop in this situation.)
>  shouldfail guilt graph
> +
> +echo "%% Testing branch a,graph"
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
> +echo "%% Adding an unrelated file in a new patch. No deps."
> +cmd guilt new b.patch
> +cmd echo b >> file2.txt
> +cmd git add file2.txt
> +cmd guilt refresh
> +fixup_time_info b.patch
> +cmd guilt graph
> +
> +echo "%% Changing a file already changed in the first patch adds a dependency."
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
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
