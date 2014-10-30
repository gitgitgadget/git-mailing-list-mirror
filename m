From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 2/3] gitk: write only changed configuration variables
Date: Thu, 30 Oct 2014 20:55:13 +1100
Message-ID: <20141030095513.GE16472@iris.ozlabs.ibm.com>
References: <1410726959-20353-1-git-send-email-max@max630.net>
 <1410726959-20353-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 10:55:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjmSA-0007Ij-AK
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 10:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758740AbaJ3JzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 05:55:24 -0400
Received: from ozlabs.org ([103.22.144.67]:37513 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758732AbaJ3JzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 05:55:21 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 75ACF140085; Thu, 30 Oct 2014 20:55:20 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1410726959-20353-3-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 14, 2014 at 11:35:58PM +0300, Max Kirillov wrote:
> When gitk contains some changed parameter, and there is existing
> instance of gitk where the parameter is still old, it is reverted to
> that old value when the instance exits.
> 
> Instead, store a parameter in config only it is has been modified in the
> exiting instance. Otherwise, preserve the value which currently is in
> file.  This allows editing the configuration when several instances are
> running, and don't get rollback of the modification if some other
> instance where the configuration was not edited is closed last.
> 
> Since trace(3tcl) can send bogus events, doublecheck if the value has
> really been changed, but once it is marked as changed, do not reset it
> back to unchanged ever, because if user has restored the original value,
> it's the decision which should be stored as well as modified value.
> 
> Treat view list especially: instead of rewriting the whole list, merge
> individual views. Place old and updated views at their older placed, add
> new ones to the end of list.
> 
> Do not merge geometry values. They are almost always changing because
> user moves and resises windows, and there is no way to find which one of
> the geometries is most desired. Just overwrite them unconditionally,
> like earlier.
> 
> Signed-off-by: Max Kirillov <max@max630.net>

I like the idea here but the implementation seems a bit more
complicated than it needs to be.  It seems to me that we need the
trace only for the non-array configuration variables; the array case
is only for the view definitions, and I think we could just set the
changed flag for a view explicitly in [newviewok].  That would
simplify things quite a bit.

I'm also not convinced we need all the uses of upvar.  Why do we need
to use upvar to rename viewname, viewfiles etc. to current_viewname,
etc.?  If you're concerned about what might possibly be in the .gitk
when you source it, perhaps doing the source inside a namespace would
be a cleaner approach?

Paul.
