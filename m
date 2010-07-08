From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 3/6] merge-recursive: Fix D/F conflicts
Date: Wed, 7 Jul 2010 22:34:50 -0600
Message-ID: <AANLkTim1thwRF5boWeuhRsKpnY3DHAHq1ixIB-5GBIYA@mail.gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
	<1278480034-22939-4-git-send-email-newren@gmail.com>
	<7v630rt1h3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 06:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWipA-0004eT-HJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 06:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0GHEex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 00:34:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45457 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0GHEew convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 00:34:52 -0400
Received: by vws5 with SMTP id 5so582347vws.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 21:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j50KYDpIu3uGXnryOScPsI9lBma9sLTPVmT1W7FvW4c=;
        b=cUB7SXmnHgJX/V5CeLEhas7C2a8hvr+FZrOuQOBtkL9hC+H7dcssDA2OsiWbuqac39
         7R3m6sij5/UDvQvaZdfHfWFso/FkvT8S56+BIzhDebUtXGj4MKxriLjgS4lubYVyjgFm
         2aSHdYi86JetyVLySd7EyqfmYRb3dzPHnfjYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cipP4zZNmLbA3OuzU/KzI4/CggNhHX8a6AM7Vpi5wAQO0c68Gh46ZasVT1MNQfqKFI
         LCIBP2wxgnv2T+yrAX3KktGes40lkJpEJ3hkEACrdg027LBPd9iGxe2d/CXJ6L90BeDv
         0VxrxwkVLTVGsOYdr/RmIj0vVB1zxQ35ysMRU=
Received: by 10.220.59.202 with SMTP id m10mr3881599vch.188.1278563690395; 
	Wed, 07 Jul 2010 21:34:50 -0700 (PDT)
Received: by 10.220.92.199 with HTTP; Wed, 7 Jul 2010 21:34:50 -0700 (PDT)
In-Reply-To: <7v630rt1h3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150533>

On Wed, Jul 7, 2010 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Style aside, what happens when we cannot cleanly resolve D/F conflict=
s,
> i.e. when some untracked/modified paths still remain after the earlie=
r
> removal? =C2=A0We would signal conflict but at that point what happen=
s to the
> files in the working tree that are involved in this new codepath? =C2=
=A0They
> are already gone, I presume, and they at least match the original ind=
ex
> entries, so not much is lost, but what would the recovery procedure o=
ut of
> the resulting mess? =C2=A0"reset --hard"?

That's a really good point, and yes all those files are already gone.
However, isn't this already a problem with current git?  git does not
abort when it detects the D/F conflict, it simply creates the file
with an alternate name such as directory/file~branch, and then
continues processing all the other entries -- resulting in all those
same files under the directory being deleted.  So I don't think this
patch creates any new problem.

If you want to resolve such a merge by keeping the directory and the
files under it, it is possible, though not at all obvious or
straightforward:
$ git rm --cached file-that-used-to-be-dir
$ git status file-that-used-to-be-dir | grep deleted | sed -e
s/.*deleted:// | xargs git checkout $(git merge-base HEAD $(cat
=2Egit/MERGE_HEAD)) --

I think we could fix this up, now that we have the D/F conflict
resolution being handled last: When process_df_entry() detects that
there's a directory in the way of the file that needs to be created
(and instead warns and creates it with an alternate name), it could
also restore those deleted entries at that time.  It seems like a bit
of unnecessary work to delete and then restore files, but I'm not sure
how to get around it given the basic strategy of having unpack_trees
do what it can and then trying to fix it up separately.


Elijah
