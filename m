From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Fri, 12 Jan 2007 18:48:39 +0300
Message-ID: <20070112184839.9431ddff.vsu@altlinux.ru>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__12_Jan_2007_18_48_39_+0300_saC9HTXimoV7PO+h"
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 12 17:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5P6R-0007xn-1Q
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 17:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbXALQR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 11:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXALQR6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 11:17:58 -0500
Received: from mivlgu.ru ([81.18.140.87]:55527 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbXALQR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 11:17:57 -0500
X-Greylist: delayed 1752 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 11:17:57 EST
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id DF80A804B; Fri, 12 Jan 2007 18:48:41 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36681>

--Signature=_Fri__12_Jan_2007_18_48_39_+0300_saC9HTXimoV7PO+h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2007 11:28:14 -0800 Junio C Hamano wrote:

> From: Junio C Hamano <junkio@cox.net>
> Date: Wed, 10 Jan 2007 11:20:58 -0800
> Subject: [PATCH] merge-recursive: do not use on-file index when not needed.
>
> This revamps the merge-recursive implementation following the
> outline in:
>
> 	Message-ID: <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
>
> There is no need to write out the index until the very end just
> once from merge-recursive.  Also there is no need to write out
> the resulting tree object for the simple case of merging with a
> single merge base.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

This commit broke t3401-rebase-partial.sh:

...
*   ok 3: rebase topic branch against new master and check git-am did not get halted

* expecting success: git-checkout -f my-topic-branch-merge &&
         git-rebase --merge master-merge &&
         test ! -d .git/.dotest-merge
First, rewinding head to replay your work on top of it...
HEAD is now at 5f97179... Add C.
Merging master-merge with my-topic-branch-merge~1
Merging:
5f97179 Add C.
1be2c8e Add B.
found 1 common ancestor(s):
0e8cba9 Add A.
.../git-rebase: line 82: 11517 Segmentation fault      git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
Unknown exit code (139) from command: git-merge-recursive 1be2c8e0eba8a7a383d0403facb1c72c622c0939^ -- HEAD 1be2c8e0eba8a7a383d0403facb1c72c622c0939
* FAIL 4: rebase --merge topic branch that was partially merged upstream
        git-checkout -f my-topic-branch-merge &&
                 git-rebase --merge master-merge &&
                 test ! -d .git/.dotest-merge

* failed 1 among 4 test(s)

> @@ -1105,9 +1040,7 @@ static int merge_trees(struct tree *head,
>  		    sha1_to_hex(head->object.sha1),
>  		    sha1_to_hex(merge->object.sha1));
>
> -	*result = git_write_tree();

Previously *result was set here...

> -
> -	if (!*result) {
> +	if (unmerged_index()) {
>  		struct path_list *entries, *re_head, *re_merge;
>  		int i;
>  		path_list_clear(&current_file_set, 1);
> @@ -1128,17 +1061,11 @@ static int merge_trees(struct tree *head,
>  			if (!process_entry(path, e, branch1, branch2))
>  				clean = 0;
>  		}
> -		if (cache_dirty)
> -			flush_cache();
>
>  		path_list_clear(re_merge, 0);
>  		path_list_clear(re_head, 0);
>  		path_list_clear(entries, 1);
>
> -		if (clean || index_only)
> -			*result = git_write_tree();
> -		else
> -			*result = NULL;
>  	} else {
>  		clean = 1;
>  		printf("merging of trees %s and %s resulted in %s\n",
> @@ -1146,6 +1073,8 @@ static int merge_trees(struct tree *head,
>  		       sha1_to_hex(merge->object.sha1),
>  		       sha1_to_hex((*result)->object.sha1));

...and it is still used here - however, after the patch *result is
uninitialized at this point.

>  	}
> +	if (index_only)
> +		*result = git_write_tree();

Too late...

>
>  	return clean;
>  }



--Signature=_Fri__12_Jan_2007_18_48_39_+0300_saC9HTXimoV7PO+h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFp63ZW82GfkQfsqIRAvMeAJoCmdgCxTCEGaYEMjv7s2VRHxCBFwCgkDJi
yNntcSfh3gXbBeRx8X8J1iI=
=lpka
-----END PGP SIGNATURE-----

--Signature=_Fri__12_Jan_2007_18_48_39_+0300_saC9HTXimoV7PO+h--
