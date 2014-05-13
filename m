From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 20/29] "guilt graph": Handle patch names containing
 quotes.
Date: Tue, 13 May 2014 17:49:17 -0400
Message-ID: <20140513214917.GK4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-21-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKZX-0007Kw-LW
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaEMVtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:49:12 -0400
Received: from josefsipek.net ([64.9.206.49]:1535 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaEMVtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:49:11 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 72C8E55654;
	Tue, 13 May 2014 17:49:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-21-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248868>

On Tue, May 13, 2014 at 10:30:56PM +0200, Per Cederqvist wrote:
> Quote quotes with a backslash in the "guilt graph" output.  Otherwise,
> the "dot" file could contain syntax errors.
> 
> Added a test case.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-graph          |  2 ++
>  regression/t-033.out | 22 ++++++++++++++++++++++
>  regression/t-033.sh  |  9 +++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/guilt-graph b/guilt-graph
> index 924a63e..0857e0d 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -57,6 +57,8 @@ while [ "$current" != "$base" ]; do
>  }"`
>  	[ -z "$pname" ] && pname="?"
>  
> +	pname="`printf \"%s\" \"$pname\" | sed 's/\"/\\\\\"/g'`"

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> +
>  	disp "# checking rev $current"
>  	disp "	\"$current\" [label=\"$pname\"]"
>  
> diff --git a/regression/t-033.out b/regression/t-033.out
> index 3d1c61f..c120d4f 100644
> --- a/regression/t-033.out
> +++ b/regression/t-033.out
> @@ -66,3 +66,25 @@ digraph G {
>  	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
>  	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
>  }
> +% guilt new a-"better&quicker'-patch.patch
> +% git add file.txt
> +% guilt refresh
> +Patch a-"better&quicker'-patch.patch refreshed
> +% guilt pop
> +Now at c.patch.
> +% guilt push
> +Applying patch..a-"better&quicker'-patch.patch
> +Patch applied.
> +% guilt graph
> +digraph G {
> +# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
> +	"bc7df666a646739eaf559af23cab72f2bfd01f0e" [label="a-\"better&quicker'-patch.patch"]
> +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
> +	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
> +	"bc7df666a646739eaf559af23cab72f2bfd01f0e" -> "891bc14b5603474c9743fd04f3da888644413dc5"; // ?
> +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> +	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
> +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> +	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
> +	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
> +}
> diff --git a/regression/t-033.sh b/regression/t-033.sh
> index fac081e..9fe1827 100755
> --- a/regression/t-033.sh
> +++ b/regression/t-033.sh
> @@ -50,3 +50,12 @@ cmd git add file.txt
>  cmd guilt refresh
>  fixup_time_info c.patch
>  cmd guilt graph
> +
> +# A patch name that contains funky characters, including unbalanced
> +# quotes.
> +cmd guilt new "a-\"better&quicker'-patch.patch"
> +cmd echo d >> file.txt
> +cmd git add file.txt
> +cmd guilt refresh
> +fixup_time_info "a-\"better&quicker'-patch.patch"
> +cmd guilt graph
> -- 
> 1.8.3.1
> 

-- 
C is quirky, flawed, and an enormous success.
		- Dennis M. Ritchie.
