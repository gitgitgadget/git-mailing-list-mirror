From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 14:03:05 -0400
Message-ID: <9e4733910608171103j545a7fd5x2b61b97376de04be@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <20060817040719.GC18500@spearce.org>
	 <Pine.LNX.4.64.0608171233370.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 20:03:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDmD5-00074V-IP
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 20:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWHQSDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 14:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWHQSDI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 14:03:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:18529 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932474AbWHQSDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 14:03:07 -0400
Received: by nz-out-0102.google.com with SMTP id n1so400228nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:03:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hNiG90W1EpepQ7qd4vVlr2gP/lBzzscysvzHPTiJNXN+uXC7IBy236x778RZMQc81RclJApbW7h8Y06ZOrogUq/nOGMbqPYy2haiguN83jVZnPyjdFlVvXfCDJnpX1TUAJMUxKTs0oB1dMneCTgCCXutj9L8dxb4bTAlTieHXYE=
Received: by 10.65.139.9 with SMTP id r9mr2560881qbn;
        Thu, 17 Aug 2006 11:03:05 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Thu, 17 Aug 2006 11:03:05 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608171233370.11359@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25599>

On 8/17/06, Nicolas Pitre <nico@cam.org> wrote:
> We're streaving for optimal data storage here so don't be afraid to use
> one of the available types for an "object stream" object.  Because when
> you think of it, the deflating of multiple objects into a single zlib
> stream can be applied to all object types not only deltas.  If ever
> deflating many blobs into one zlib stream is dimmed worth it then the
> encoding will already be ready for it.  Also you can leverage existing
> code to write headers, etc.

Here are two more case that need to be accounted for in the packs.

1) If you zip something and it gets bigger. We need an entry that just
stores the object without it being zipped. Zipping jpegs or mpegs will
likely make them significantly bigger. Or does zlib like already
detect this case and do a null compression?

2) If you delta something and the delta is bigger than the object
being deltaed. The delta code should detect this and store the full
object instead of the delta. Again jpegs and mpegs will trigger this.
You may even want to say that the delta has to be smaller than 80% of
the full object.

Shawn is planning on looking into true dictionary based compression.
That will generate even more types inside of a pack. If dictionary
compression works out full text search can be added with a little more
overhead. True dictionary based compression has the potential to go
even smaller than the current 280MB. The optimal way to do this is for
each pack to contain it's own dictionary.

-- 
Jon Smirl
jonsmirl@gmail.com
