From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Documentation: reword --thin description
Date: Wed, 10 Feb 2010 11:07:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002101037300.1681@xanadu.home>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfF63-0002dR-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 17:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab0BJQHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 11:07:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20217 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab0BJQHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 11:07:14 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXM004U1VFXQ1Y0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Feb 2010 11:07:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139513>

On Tue, 9 Feb 2010, Stephen Boyd wrote:

>  --thin::
> -	Spend extra cycles to minimize the number of objects to be sent.
> -	Use it on slower connection.
> +	Spend extra cycles minimizing the number of sent objects.
> +	Use it with a slow connection.

Both the old and the new text are bollocks.

There is no extra cycles involved here.  And linking this to a slow 
connection is misleading.

The point of --thin is to create a pack containing delta objects while 
excluding the base objects they depend on when those objects are known 
to exist in the receiver's repository already.  Because base objects 
are usually significantly bigger than delta objects, this results in a 
large reduction in the amount of data to transfer.

However we don't allow a pack with delta objects referencing base 
objects to be stored in a Git repository if those base objects are not 
part of the same pack for robustness reasons.  Therefore, when a thin 
pack is transferred via the git protocol, the receiving end must 
"fatten" the pack by appending those missing base objects for that pack 
to be complete and valid.  This results in somewhat suboptimal object 
storage on the receiving end due to some object duplications.  Of course 
a simple gc will fix that.

These days --thin is always the default for a fetch.  We used to think 
that --thin might not be the best thing to do on a push given that the 
receiving end is typically a central server in that case and keeping 
storage low on a central server should be preferred.  But --thin turned 
out to be re-enabled by default for pushes by mistake on a few occasions 
when the affected code has been reworked.  No idea what state it is now, 
and I don't think that makes such a difference on the server in the end.


Nicolas
