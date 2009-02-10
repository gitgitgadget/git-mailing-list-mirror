From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 12:16:31 -0800
Message-ID: <7vd4dqm4io.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <200902100807.40417.robin.rosenberg@dewire.com>
 <7viqninuzv.fsf@gitster.siamese.dyndns.org>
 <200902101758.00062.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWz3b-0000pO-7R
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbZBJUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZBJUQm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:16:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbZBJUQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:16:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B834398540;
	Tue, 10 Feb 2009 15:16:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ACDA09853C; Tue,
 10 Feb 2009 15:16:33 -0500 (EST)
In-Reply-To: <200902101758.00062.robin.rosenberg@dewire.com> (Robin
 Rosenberg's message of "Tue, 10 Feb 2009 17:57:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B9AAE11A-F7AF-11DD-832D-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109300>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> I was not talking about any loss.  The result would be a funny mixture of
>> permutations of {old-,}pack-*.{pack,idx} the user needs to match up after
>
> We don't leave old-files around unless we go very very wrong and only in
> that case would be leave "old"-files for one pack around and only if gc wants
> to replace a pack with the same name. That would not be fatal and the
> user can continue repacking to get rid of the redundant stuff once the cause
> of them problem is fixed. 

You can succeed for the first name and then fail for the second name, for
example, and can end up with old-pack-* and pack-* with the same name.  I
found that potentially confusing.  Since you are trying to improve the
area, it would be nicer to make it less prone to fail and easier to
recover.

Here is another attempt to rewrite it, which is closer to what you are
doing in your patch, but hopefully easier to understand what is going on
and more atomic.

This is not the "prepare objects/new-pack/ and if we manage to create it
into a good shape replace objects/pack/ with it" approach that I suggested
earlier, though.  That would be a lot more atomic.

 git-repack.sh |   78 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 458a497..1e38559 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -88,30 +88,68 @@ if [ -z "$names" ]; then
 		echo Nothing new to pack.
 	fi
 fi
-for name in $names ; do
-	fullbases="$fullbases pack-$name"
-	chmod a-w "$PACKTMP-$name.pack"
-	chmod a-w "$PACKTMP-$name.idx"
-	mkdir -p "$PACKDIR" || exit
 
+# Ok we have prepared all new packfiles.
+mkdir -p "$PACKDIR" || exit
+
+# First see if there are packs of the same name and if so
+# if we can move them out of the way (this can happen if we
+# repacked immediately after packing fully.
+rollback=
+failed=
+for name in $names
+do
 	for sfx in pack idx
 	do
-		if test -f "$PACKDIR/pack-$name.$sfx"
-		then
-			mv -f "$PACKDIR/pack-$name.$sfx" \
-				"$PACKDIR/old-pack-$name.$sfx"
-		fi
-	done &&
+		file=pack-$name.$sfx
+		test -f "$PACKDIR/$file" || continue
+		rm -f "$PACKDIR/old-$file" &&
+		mv "$PACKDIR/$file" "$PACKDIR/old-$file" || {
+			failed=t
+			break
+		}
+		rollback="$rollback $file"
+	done
+	test -z "$failed" || break
+done
+
+# If renaming failed for any of them, roll the ones we have
+# already renamed back to their original names.
+if test -n "$failed"
+then
+	rollback_failure=
+	for file in $rollback
+	do
+		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
+		rollback_failure="$rollback_failure $file"
+	done
+	if test -n "$rollback_failure"
+	then
+		echo >&2 "WARNING: Some packs in use have been renamed by"
+		echo >&2 "WARNING: prefixing old- to their name, in order to"
+		echo >&2 "WARNING: replace them with the new version of the"
+		echo >&2 "WARNING: file.  But the operation failed, and"
+		echo >&2 "WARNING: attempt to rename them back to their"
+		echo >&2 "WARNING: original names also failed."
+		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
+		for file in $rollback_failure
+		do
+			echo >&2 "WARNING:   old-$file -> $file"
+		done
+	fi
+	exit 1
+fi
+
+# Now the ones with the same name are out of the way...
+fullbases=
+for name in $names
+do
+	fullbases="$fullbases pack-$name"
+	chmod a-w "$PACKTMP-$name.pack"
+	chmod a-w "$PACKTMP-$name.idx"
 	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
-	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
-	test -f "$PACKDIR/pack-$name.pack" &&
-	test -f "$PACKDIR/pack-$name.idx" || {
-		echo >&2 "Couldn't replace the existing pack with updated one."
-		echo >&2 "The original set of packs have been saved as"
-		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
-		exit 1
-	}
-	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
+	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
+	exit
 done
 
 if test "$remove_redundant" = t
