From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 14:19:11 +0200
Message-ID: <4AD31EBF.6090307@viscovery.net>
References: <loom.20091012T115746-719@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 14:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxJz3-0006Hg-1C
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbZJLMT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbZJLMT5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:19:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55014 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbZJLMT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 08:19:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MxJrr-0004fj-Gk; Mon, 12 Oct 2009 14:19:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2EBAF4E4; Mon, 12 Oct 2009 14:19:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20091012T115746-719@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130005>

Sergio schrieb:
> 1) Grafts and replace entries seem to operate on different aspects of the
> history graph. Grafts operate on arcs and replace on nodes. 

Correct, but see below about tree and blob objects.

> As such, replace entries seem less general to me. 

With grafts you can only change parenthood; with replace entries you can
change parenthood *and* all other aspects of a commit (message, author,
committer, dates).

Hence, replace entries are more general than grafts.

> Apparently, to simulate a graft with replace entries, you need to introduce
> extra commit objects. For instance, if object B has no parents, to pretend that
> it derives from some A, one needs to create an object B' equivalent to B but
> for the parents and then replace B by B', is this right?

Yes. Use git-cat-file + edit + git-hash-object as explained in this
message just the other day:
http://thread.gmane.org/gmane.comp.version-control.git/129727/focus=129907

> Conversely, I guess
> you can always simulate a replace entry with the graft mechanism, without the
> need to add any extra commit object. Am I overlooking something? 

You cannot; see above. You can even replace tree objects and blob objects
using replace entries, IIUC, but you cannot do that with grafts.

> 2) Is it currently possible to use a replace entry to replace a commit object
> with nothing? Namely if B has A as its sole parent, is it possible to have a
> replace entry such as A-sha1 becomes null, to pretend that B is a hierarchy
> root?  

Sure. Just make a commit object that does not have parents.

> 3) If I remember correctly, there was a reason why grafts were not considered
> suitable for transferring across repos. Can someone remind me about it? How
> does the replace mechanism address this issue?

The problem with grafts was that, for example, git-pack-objects obeyed the
graft, and could create a broken repository by removing grafted-away
objects. And since git-fsck also obeyed the graft, it did not notice the
breakage.

OTOH, history walkers (upload-pack, send-pack, pack-objects) and fsck
never obey replace entries in the history. But they do keep track of them
(and the history that they reference) because they are referenced from the
refs/replace namespace.

-- Hannes
