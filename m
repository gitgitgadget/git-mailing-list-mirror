From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Wed, 1 Jun 2005 08:51:23 +0200
Message-ID: <20050601065123.GA23358@cip.informatik.uni-erlangen.de>
References: <20050531190005.GE18723@atomide.com> <Pine.LNX.4.63.0505311914550.6500@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Lindgren <tony@atomide.com>, git@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdN6H-0005V1-9R
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 08:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFAGz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFAGz5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:55:57 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59566 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261303AbVFAGzv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 02:55:51 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j516pOS8001087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2005 06:51:24 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j516pNp0001086;
	Wed, 1 Jun 2005 08:51:23 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505311914550.6500@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Why do you need a lock at all?

> Just update your HEAD reference last when you push and get it first when 
> you pull.

consider the following scenario: Two people push at the same time. One
HEAD gets actually written, but both think that their changes got
upstream. Of course the 'upstream' tree is consitent, but incomplete.
That is why we need a lock. And the lock should be obtained before the
remote HEAD is retrieved, I think the following scenario is how to
handle it:

	1. acquire remote lock
	2. get remote HEAD
	3. if remote HEAD is ahead (not included in our history) abort
	   and free lock.
	4. push objects
	5. update remote HEAD with local
	6. free remote lock.

	Thomas
