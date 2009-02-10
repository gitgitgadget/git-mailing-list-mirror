From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Wed, 11 Feb 2009 00:51:20 +0100
Message-ID: <200902110051.20975.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902101758.00062.robin.rosenberg@dewire.com> <7vd4dqm4io.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2PR-0005ee-GM
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbZBJXvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbZBJXvb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:51:31 -0500
Received: from mail.dewire.com ([83.140.172.130]:13218 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbZBJXv3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 18:51:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 441D3147E8BD;
	Wed, 11 Feb 2009 00:51:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IuSu1WLNiB-G; Wed, 11 Feb 2009 00:51:22 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0739C803219;
	Wed, 11 Feb 2009 00:51:21 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vd4dqm4io.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109351>

tisdag 10 februari 2009 21:16:31 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> >> I was not talking about any loss.  The result would be a funny mixture of
> >> permutations of {old-,}pack-*.{pack,idx} the user needs to match up after
> >
> > We don't leave old-files around unless we go very very wrong and only in
> > that case would be leave "old"-files for one pack around and only if gc wants
> > to replace a pack with the same name. That would not be fatal and the
> > user can continue repacking to get rid of the redundant stuff once the cause
> > of them problem is fixed. 
> 
> You can succeed for the first name and then fail for the second name, for
> example, and can end up with old-pack-* and pack-* with the same name.  I
> found that potentially confusing.  Since you are trying to improve the
> area, it would be nicer to make it less prone to fail and easier to
> recover.
> 
> Here is another attempt to rewrite it, which is closer to what you are
> doing in your patch, but hopefully easier to understand what is going on
> and more atomic.

Almost perfect.

> +# If renaming failed for any of them, roll the ones we have
> +# already renamed back to their original names.
> +if test -n "$failed"
> +then
> +	rollback_failure=
> +	for file in $rollback
> +	do
> +		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
> +		rollback_failure="$rollback_failure $file"
> +	done
> +	if test -n "$rollback_failure"
> +	then
> +		echo >&2 "WARNING: Some packs in use have been renamed by"
> +		echo >&2 "WARNING: prefixing old- to their name, in order to"
> +		echo >&2 "WARNING: replace them with the new version of the"
> +		echo >&2 "WARNING: file.  But the operation failed, and"
> +		echo >&2 "WARNING: attempt to rename them back to their"
> +		echo >&2 "WARNING: original names also failed."
> +		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
> +		for file in $rollback_failure
> +		do
> +			echo >&2 "WARNING:   old-$file -> $file"
> +		done

Exit 1 here.  We did not succeed in rolling back

> +	fi
> +	exit 1

But here we should exit 0 because we succeeded in rolling back the changes,
so we do not need to scare the user.

> +fi
> +
> +# Now the ones with the same name are out of the way...
> +fullbases=
> +for name in $names
> +do
> +	fullbases="$fullbases pack-$name"
> +	chmod a-w "$PACKTMP-$name.pack"
> +	chmod a-w "$PACKTMP-$name.idx"
>  	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
> -	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
> -	test -f "$PACKDIR/pack-$name.pack" &&
> -	test -f "$PACKDIR/pack-$name.idx" || {
> -		echo >&2 "Couldn't replace the existing pack with updated one."
> -		echo >&2 "The original set of packs have been saved as"
> -		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> -		exit 1
> -	}
> -	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
> +	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
> +	exit
>  done

Here is a safe place to remove the old-packs.

>  if test "$remove_redundant" = t
> 

-- robin

Tested on msysgit with different sizes pack.packSizeLimit so we have different
number of packs. After a few rounds of repacking,  the pack names tend to
stabilize and no damage occurred despite files were locked. After unlocking
repacking succeeds normally and redundant files are cleaned up.

Patch-patch:

>From baf79b5f8b03002611115e858cd43ede7d8e7f64 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 11 Feb 2009 00:32:13 +0100
Subject: [PATCH] Try to remove the old packs if we succeed. Exit success if rollback fails after
 failing to rename old packs.

---
 git-repack.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 0f13043..80673be 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -136,8 +136,9 @@ then
 		do
 			echo >&2 "WARNING:   old-$file -> $file"
 		done
+		exit 1
 	fi
-	exit 1
+	exit
 fi
 
 # Now the ones with the same name are out of the way...
@@ -152,6 +153,15 @@ do
 	exit
 done
 
+# Remove the "old-" files
+for name in $names
+do
+	rm -f "$PACKDIR/old-pack-$name.idx"
+	rm -f "$PACKDIR/old-pack-$name.pack"
+done
+
+# End of pack replacement.
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
-- 
1.6.1.285.g35d8b
