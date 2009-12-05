From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH v2 4/8] Support remote helpers implementing smart
 transports
Date: Sat, 5 Dec 2009 15:16:30 +0200
Message-ID: <20091205131630.GA1684@Knoppix>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259942168-24869-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091204183713.GE1483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 14:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGuVF-0003S8-EO
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 14:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZLENQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 08:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZLENQ3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 08:16:29 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:56685 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZLENQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 08:16:29 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id DAB8218D17F;
	Sat,  5 Dec 2009 15:16:33 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00152AD07A; Sat, 05 Dec 2009 15:16:33 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 7EE2F403C;
	Sat,  5 Dec 2009 15:16:31 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091204183713.GE1483@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134597>

On Fri, Dec 04, 2009 at 10:37:13AM -0800, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> 
> Why not 'fallback' to remain consistent with this protocol and many
> others in git where we stick to lowercase ASCII?

Changed.
 
> Why is the initial advertisement special?  If the helper always
> flushes both sides, it shouldn't ever deadlock the protocol.  Also,
> note that a helper should be able to implement a tiny delay like
> Nagle's algorithm does in TCP.  It just can't sit on a byte forever.

That's just extremely badly worded. The point is that only place where
buffering has even seemed useful is initial adverts. Those can
really trigger large numbers of small transfers if unbuffered.

Granted, small delay should work quite well.

I'll reword it.

> This hunk appears to be unrelated.  And actually, if transport has
> no remote, shouldn't the arg here be NULL so the helper gets only
> 1 argument and not 2 arguments?

Actually, it can't be NULL (the code would have already die()'d in
that case). Fixed.

> I think exec winds up defaulting to name if --upload-pack was not
> used on the command line, and remote.$name.uploadpack was not set.
> See transport.c where you initialize the git options struct, these
> fields were defaulted in.

Actually, there was bug in initializing git options struct. It was
properly initialized if one used foo://, but not with foo::bar://.
Tripping it caused NULL exec to be passed if you didn't override.
I fixed that bug and now the servpath code has just strcmp.

> My point is, we shouldn't send option servpath to the helper if
> name is equal to servpath, because the helper might not support
> servpath and the option command will issue a warning above for no
> reason at all.

This is exactly what happens (and yes, I tested). No --receive-pack
doesn't trip warning, with --receive-pack it does.

-Ilari
