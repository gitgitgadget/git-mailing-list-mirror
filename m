From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc considered dangerous
Date: Sun, 08 Feb 2009 12:09:17 -0800
Message-ID: <7vab8wy9le.fsf@gitster.siamese.dyndns.org>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:11:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFzc-0000L8-Of
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZBHUJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZBHUJY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:09:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZBHUJY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:09:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A50B92AB68;
	Sun,  8 Feb 2009 15:09:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 87B272A579; Sun, 
 8 Feb 2009 15:09:19 -0500 (EST)
In-Reply-To: <200902080347.25970.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sun, 8 Feb 2009 03:47:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60EC3AD6-F61C-11DD-A217-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109008>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> I've seen this. Running git gc on Windows, while having Elipse open can kill your
> object database. 
>
> Eclipse keeps the pack files open most of the time. Then you 
> launch git gui which recommends the user to do a git gc. I never
> do (it *always* wants to do this), so I haven't encountered the 
> issue, but if gc doesn't find a new optimal pack it tries to rewrite a 
> new pack with the same id. So it rm's the idx file (fine) and the the
> pack file (not ok) and gives up, which means it has a .pack file with 
> no index, so it cannot use it. Trying git gc again after eclipse exits 
> will execute the final stab on your objects. 
>
> The underlying bug is ofcource that Windows locks files when
> they are open. A *nix* user does not suffer from this problem.
>
> I'll investigate more at some other time. This is a preliminary
> analysis.

That sounds like you are hitting this codepath in git-repack.sh:

	fullbases="$fullbases pack-$name"
	chmod a-w "$PACKTMP-$name.pack"
	chmod a-w "$PACKTMP-$name.idx"
	mkdir -p "$PACKDIR" || exit

	for sfx in pack idx
	do
		if test -f "$PACKDIR/pack-$name.$sfx"
		then
			mv -f "$PACKDIR/pack-$name.$sfx" \
				"$PACKDIR/old-pack-$name.$sfx"
		fi
	done &&
	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
	test -f "$PACKDIR/pack-$name.pack" &&
	test -f "$PACKDIR/pack-$name.idx" || {
		echo >&2 "Couldn't replace the existing pack with updated one."
		echo >&2 "The original set of packs have been saved as"
		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
		exit 1
	}
	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"

We created a pack and an idx successfully in a pair of temporary files, we
notice that pack-$name.idx and/or pack-$name.pack exists and try to move
them out of the way, then we install the new ones in their final
destination, and we try to see if that move succeeded.  If any one of
these steps fails, the entire process fails, but along the way we
shouldn't have lost anything.

I see if .pack can be renamed but .idx can't, then it is possible to get
into a state where you have to mix and match pack-$name.pack and
old-pack-$name.idx.
