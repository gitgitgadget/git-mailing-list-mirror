From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Wed, 1 Aug 2007 15:05:01 +0200
Message-ID: <200708011505.02078.jnareb@gmail.com>
References: <1185880790812-git-send-email-jnareb@gmail.com> <11858807944170-git-send-email-jnareb@gmail.com> <7vd4y8fcjw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMNZ-0007u8-Ro
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXHAWJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXHAWJO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:09:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:8639 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXHAWJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:09:13 -0400
Received: by mu-out-0910.google.com with SMTP id i10so422533mue
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:09:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=josv/1X4Mdh4Qr6USLUXvgNEv7AsI4UfyvzuLn0mw3CbeKq1DbasnefasCjarO7qlpXP0JF8Ima7IdsvbW9wYUrM15490aKOfkuW1UXMmRbXDGjqE1NJYB4xmkphIlDaDbyMpcpKUMhykZZfDWLqP13qiebjY435czGsY+ZOGWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=e5sYn4AXIZgVyAjbmI9FDwP/zCZe1PgiSKdEP3Ac4H4Yj7mBCKe3rP8yMq0pF4E3+dFug7md1chf27vxkH1u65K2eSVZXLta3gsUZ/jr2QWj4bmqYfdmu5laTUvnVQPqDMjFpaCoM0OY3EidnGtcBVpSXxClO4Us43tNy/2TaZg=
Received: by 10.86.1.1 with SMTP id 1mr897413fga.1186006151895;
        Wed, 01 Aug 2007 15:09:11 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 22sm2462279fkr.2007.08.01.15.09.10
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 15:09:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd4y8fcjw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54483>

On Wed, 1 Aug 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It allows to play with 'tree' view with blob size. Currently you
>> have to start browsing by adding ";opt=-l" to the gitweb URL by
>> hand.  There is not link which will change view from ordinary 'tree'
>> view to 'tree' view with blob sizes.
>>
>> The 'tree' with blob size view is slightly more costly than the
>> ordinary, old 'tree' view, but not much more (0.018s vs 0.012s
>> in the hot cache case), so I don't think we need to control it
>> as a enabled (or disabled) feature, overrideable or not.  It
>> probably should not be default.
> 
> I do not think there is any reason to forbid its use, as the
> "-l" to ls-tree was introduced for exactly this purpose,
> However, it might make sense to make the use of -l optional via
> the %feature mechanism.  50% increase even on hot cache case is
> not a price people who run busy sites would want to pay.

It's 0.014s vs 0.009s - 0.010s on root dir of repacked git.git 
repository. It is I think caused by the fact that "git ls-tree -l 
<tree-ish>" has to look up each blob in the tree, and read its
header. IIRC header is uncompressed, so it doesn't need deflating;
if it is compressed, then we have to add deflating to that. The
blob size (object size) is not present in the tree object structure.
Perhaps it is something to have in mind when designing and implementing
new packv4 with its creating tree objects on demand.

But I agree that this should be protected by the %feature mechanism.
Two questions:

 1. Should we make '-l' default when turned on? Or make 'showsizes'
    %feature tristate: off, on, by default on?

 2. If it is turned off, should we silently (or not so silently)
    ignore this option, or return "Permission denied" or perhaps
    "Invalid extra options parameter"?

And how we should name this feature (key in %feature hash)?


P.S. I have received no comments on
 [RFC/PATCH] gitweb: Enable transparent compression for HTTP output
(trade CPU load for lower bandwidth usage).

-- 
Jakub Narebski
Poland
