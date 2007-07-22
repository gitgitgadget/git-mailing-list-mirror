From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Sun, 22 Jul 2007 11:05:51 -0400
Message-ID: <3bbc18d20707220805hd95c4ccsc48f140888403391@mail.gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
	 <1184699486.9831.7.camel@mattlaptop2>
	 <200707220130.28516.jnareb@gmail.com>
	 <7vd4ylt3eh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Luben Tuikov" <ltuikov@yahoo.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 17:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICd0Q-0000H7-Pp
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 17:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbXGVPFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXGVPFx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 11:05:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:59490 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbXGVPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 11:05:52 -0400
Received: by nz-out-0506.google.com with SMTP id s18so985005nze
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 08:05:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o2Q36g6VpE2KNDVJLqYjH9wDJ6d/WFx0k5qIQltcDQB6AKWmSqjEhzMZpecM3PMBo7UxA9vpcd7ZTHLsvLpTUDjAlFGRvdTT3YWk/lpumju4G8T65yP75p5CoAqzhuUxOu+4fVHz08dToeySotF7i/Bwd7URHLzwUdUiJOmMw48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MfFE4cC7OJsRz5Nb4hD9wmospGEXTDOPk88Lyi/TUoPruZVG7dA1F5tAZc/ZFocUR/aWGUXqDja29BXXj1x+wYwRjddeVmFvPMh7VUvOlAehHlaojvUk3azfem1H4uyyp+XmaTEDhKrPTkTRGZG4XURPJpy2INmKuLRKx9/L918=
Received: by 10.142.50.15 with SMTP id x15mr166243wfx.1185116751110;
        Sun, 22 Jul 2007 08:05:51 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Sun, 22 Jul 2007 08:05:51 -0700 (PDT)
In-Reply-To: <7vd4ylt3eh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53273>

On 7/22/07, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  Will apply.

Jakub, thanks for picking this up.  I was running out of energy to
push what began as an offer of a possibly useful local customization
any further toward adoption.

That said: the backward compatibility code for gitweb _site_
configuration is broken because it is inside an if statement that only
runs for gitweb _repository_ configuration.  I tested it with a
gitweb_config.perl with

$feature{'snapshot'}{'default'} = ['x-gzip', 'gz', 'gzip'];
$feature{'snapshot'}{'override'} = 0;

and gitweb generated "snapshot ( )" (no visible link).  Inspection of
the source revealed links to "sf=x-gzip", "sf=gz", and "sf=gzip" with
empty strings for the link text.  The expected behavior is
"_snapshot_", linking to "sf=tgz", with a tooltip indicating "tar.gz"
format.

Moving the code out of the `if' wouldn't solve the problem by itself
because feature_snapshot is only reached if override is enabled, but
the site configuration compatibility needs to work whether or not
override is enabled.  That's why Junio was considering adding a
separate function gitweb_bc_feature_snapshot.  I think a nicer
alternative would be to change gitweb_check_feature to call the sub
(if any) whether or not override is enabled and let the sub check
$feature{'foo'}{'override'} itself to decide whether to look for an
override.  Then each feature_* sub is the central point for both
override processing and backward compatibility for that feature.

Matt
