From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Fri, 4 Jan 2008 12:54:58 +1300
Message-ID: <46a038f90801031554j6218f08cl6c9608b24e1675f8@mail.gmail.com>
References: <477822C3.9060002@gbarbier.org>
	 <alpine.LNX.1.00.0712302145500.13593@iabervon.org>
	 <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src>
	 <477A26FD.7020408@gbarbier.org> <m3myrpo1p0.fsf@roke.D-201>
	 <20080101202352.GA4295@efreet.light.src>
	 <477D3401.2010005@gbarbier.org>
	 <20080103211521.GA4225@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Gr=E9goire_Barbier?=" <gb@gbarbier.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jan 04 00:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAZuN-0003q2-28
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 00:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbYACXzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYACXzE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 18:55:04 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:39551 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbYACXzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 18:55:03 -0500
Received: by an-out-0708.google.com with SMTP id d31so1103637and.103
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TYKxNUWwPqXR1FWHr7I133rbpPmlJKQr6aCMFfUmn/8=;
        b=H6coFlZ9wEYutEbQ1xg+leOpDF/JF6E1r9puEGT7cpglcQu0i0/6UMINqv7OvLbdQYYC8tVdfQmbf8yWbiwJIysdzSXI8+SzSe7Rra10HyE8ppbGRqDkGqtfUquXqqp31mkYlsDxuwzh46R8U5xJKnapDRfHTW0y4FL5yL4GsT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KV/QtFI6cRrc41WDISOk8mVggE/UNFkzrGNN/0dRx36Pfz79+Iu0BB5ZhDyNzVq7J26cK4VQeOoaDB4XFt6EvHJvCAxnMHkKzHoqSZOTtqVkivpEzjixGbCYzwnlRyy+MSPmGCPClUZJb2h5tVotHFX4bCJP4CSEqBFsE27Ques=
Received: by 10.100.227.20 with SMTP id z20mr26591413ang.106.1199404498602;
        Thu, 03 Jan 2008 15:54:58 -0800 (PST)
Received: by 10.100.172.20 with HTTP; Thu, 3 Jan 2008 15:54:58 -0800 (PST)
In-Reply-To: <20080103211521.GA4225@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69544>

On Jan 4, 2008 10:15 AM, Jan Hudec <bulb@ucw.cz> wrote:
> Now to keep it stateless, I thought that:
...
> This would guarantee, that when you want n revisions, you make at most
> log2(n) requests and get at most 2*n revisions (well, the requests are for

That is still a lot! How about, for each ref

 - Client sends a POST listing the ref and the latest related commit
it has that the server is likely to have (from origin/heads/<ref>).
Optionally, it can provide a blacklist of <treeish> (where every
object refered is known) and blob sha1s.
 - Server sends the new sha1 of the ref, and a thin pack that covers the changes
 - The client can disconnect to stop the transaction. For example --
if it sees the sha1 of a huge object that it already has. It can
re-request, with a blacklist.

A good number of objects will be sent unnecesarily - with no option to
the client to say "I have this" - but by using the hint of letting the
server know we have origin/heads/<ref> I suspect that it will be
minimal.

Also:
 - It will probably be useful to list all the refs the client knows
from that server in the request.
 - If the ref has changed with a non-fast-forward, the server needs to
say so, and provide a listing of the commits. As soon as the client
spots a common commit, it can close the connection -- it now knows
what ref to tell the server about in a subsequent command.

This way, you ideally have 1 request per ref, 2 if it has been
rebased/rewound. This can probably get reorganised to do several refs
in one request.

cheers,


m
