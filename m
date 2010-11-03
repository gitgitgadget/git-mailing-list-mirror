From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Wed, 3 Nov 2010 12:41:48 -0500
Message-ID: <20101103174148.GB13377@burratino>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-2-git-send-email-spearce@spearce.org>
 <7v8w1axrnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDhLi-0007T8-7d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab0KCRmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:42:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37225 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0KCRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:42:07 -0400
Received: by pvb32 with SMTP id 32so366007pvb.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Rk9k3NQIEBfxvYcDgUwZP6UBZhsDxzEJtmRKLb/R4I=;
        b=X3SX+cSYrRGP9KtWNSXMfewH5D4Itmyeh6UG2ntEL/1ctr7hlc/tXOPQwKr5JiPUE1
         PyQQXJoQq8Y0mseMxTJ7Da4L4M8Q/b5dSfoG7n4zbTwvnZH889w9J+GLExwCl1cPb5+Y
         YbRuFxFH7RNM5EElw+2ZCjj9b0te8b/eE7/NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jNfObxvQDj44SREHAOACrG124CC2MXrYcR0Ein6GpJYBxeFQr3Ckpfc+rYf9UJGHsi
         hn2C4J/f7Tnlk+8GV/M5BFFUUpSShJUUeWI/w4iqmwZtvbkb62ZlWqI+cT2H3FM6g9rM
         wUXE/bV5uniVF1ZLflOzjakJXThJsyRyZv2+w=
Received: by 10.142.170.2 with SMTP id s2mr4210900wfe.153.1288806127569;
        Wed, 03 Nov 2010 10:42:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e16sm3646602vcm.8.2010.11.03.10.42.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 10:42:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w1axrnp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160632>

Junio C Hamano wrote:

>  (1) introduce "int git_open_ro(const char *)" to replace the current
>      git_open_noatime().  The point is that the function no longer is
>      about avoiding from smudging the inode metadata.  Instead, it becomes
>      the preferred way for us to get a read-only fd.
[...]
> We can of course do without s/git_open_noatime/git_open_ro/; and it will
> make the patch much smaller.  The rename is purely a clarification of the
> API and is optional.  It may make it easier to explain the name of the new
> function, though.

Probably a silly question, but should all readonly open()s actually use
noatime?  Some uses for atime:

 - tmpwatch.  That one's a bit insane, anyway, but I think it might
   work because loose objects and packs are read-only.

 - mail clients.  For this case, noatime is the right thing to do ---
   git's access does mean the mail was read.

 - listing important files, as in popularity-contest.  For this,
   noatime is also the right thing to do.

Judging from these three use cases, readonly open()s to the worktree
should indeed use noatime, but open()s of .git/config, say, should
not.  Hmm.
