From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 19:46:50 -0400
Message-ID: <9e4733910708241646x7b285574t94c3d7eb32bb60c9@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	 <9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
	 <fanmmk$f5q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOirw-0002Ft-M7
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 01:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbXHXXqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbXHXXqw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 19:46:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:15340 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948AbXHXXqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 19:46:51 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1102160wah
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 16:46:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWHi3YTscKILVRlrxmTtCHCtU2XpmlpFE5IS6IOtKChzzvtumPbn4ChqAA3yKxjVlTVQrwaB3ONM9iuk5EsbKA4XgBbGX7VunbqPfJ3U34/H/SWhBjP77TRYz1nw7iuKD+NK8lg8uLCRFa5MZf1THfEA1TWCc6PRy19PDtvxo9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VDfTqhF7DAO5J3TIGaevfrphSVUywziVevWgMmknTdT060PMVIdaig/1EUOYOgdKlia2gLVmIxUtuIBq9fhqkdnisblAd9NspUomMvacPXYWqRU2O+mFlg+hg087Y/VEdvB/jUn0iptjYWBZhQ190OK9kqGpCntHXc3UBJfB44E=
Received: by 10.114.201.1 with SMTP id y1mr1432734waf.1187999210797;
        Fri, 24 Aug 2007 16:46:50 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 24 Aug 2007 16:46:50 -0700 (PDT)
In-Reply-To: <fanmmk$f5q$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56614>

On 8/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
> There was idea to special case clone (just concatenate the packs, the
> receiving side as someone told there can detect pack boundaries; do not
> forget to pack loose objects, first), instead of using generic fetch --all
> for clone, bnut no code. Code speaks louder than words (although if someone
> would provide details of pack boundary detection...)

A related concept, initial clone of a repository does the equivalent
of repack -a on the repo before transmitting it. Why aren't we saving
those results by switching the repo onto the new pack file? Then the
next clone that comes along won't have to do anything but send the
file.

But this logic can be flipped around, if the remote needs any object
from the pack file, just send them the whole pack file and let the
remote sort it out. Using this logic you can still minimize the IO
statistically.

When a remote does a fetch you have to pack all of the loose objects.
When the loose object pile reaches 20MB or so, the fetch can trigger a
repack of the oldest half into a pack that is kept by the tree and
replaces those older loose objects. For future fetches simply apply
the rule of sending the whole pack if any object is needed.

The repack of the 10MB of older objects can be kicked out to another
process and copied into the tree when it is finished. At that point
the loose objects can be deleted. The git db can tolerate a process
copying in a new packfile and deleting the old objects while other
processes may be using the database, right?

This model shouldn't statistically change the amount of data very
much. If you haven't synced your tree in a month a few too many
objects may get sent to you. However, it should dramatically reduce
the IO load on the server cause by git protocol initial clones.

-- 
Jon Smirl
jonsmirl@gmail.com
