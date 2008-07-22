From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem using jgit
Date: Tue, 22 Jul 2008 11:58:31 -0500
Message-ID: <20080722165831.GA11173@spearce.org>
References: <p06240809c4a9d887fda4@[192.168.1.106]> <488467E3.7000107@gmail.com> <488482A2.4000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Bannasch <stephen.bannasch@deanbrook.org>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLD1-0006C6-RZ
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYGVQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYGVQ6c
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:58:32 -0400
Received: from george.spearce.org ([209.20.77.23]:57134 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYGVQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:58:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 442B6383A5; Tue, 22 Jul 2008 16:58:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <488482A2.4000601@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89500>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Marek Zawirski wrote:
>> Stephen Bannasch wrote:
>>> I've setup a simple test class that integrates jgit to clone a git  
>>> repository. However I'm getting a NullPointerError when  
>>> RevWalk.parseAny ends up producing a null object id.
...
> It's caused by 14a630c3: Cached modification times for symbolic refs too
> Changes introduced by this patch made Repository#getAllRefs() including  
> Ref objects with null ObjectId in case of unresolvable (invalid?) HEAD  
> symbolic ref, and null Ref for HEAD  when it doesn't exist. Previous  
> behavior was just not including such refs in result.

My intention here was that if a ref cannot be resolved, it should
not be reported.  So Ref.getObjectId should never return null, and
it should also never return an ObjectId for which the object does
not exist in the Repository's object database(s).  (Though that can
happen in the face of repository corruption, but lets not go there
just yet).

So IMHO the RefDatabase code is _wrong_ for returning HEAD with a
null objectId.

Now this case can happen if HEAD points at a stillborn branch.  This
is easily reproduced in any repository, e.g. just do:

	git symbolic-ref HEAD refs/heads/`date`

You'll wind up on a branch which doesn't exist.  In this case HEAD
shouldn't be reported back from RefDatabase, it doesn't exist, as
branch `date` does not exist either.

-- 
Shawn.
