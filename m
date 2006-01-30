From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 12:39:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 12:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3XNr-000168-1f
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 12:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWA3Lji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWA3Lji
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 06:39:38 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41616 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932224AbWA3Ljh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 06:39:37 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 758C9146689; Mon, 30 Jan 2006 12:39:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6563FAAA;
	Mon, 30 Jan 2006 12:39:34 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1ED68146689; Mon, 30 Jan 2006 12:39:34 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15267>

Hi,

On Sun, 29 Jan 2006, Junio C Hamano wrote:

> Strategy
> --------
> 
> We have `info/grafts` mechanism to fake parent information for
> commit objects.  Using this facility, we could roughly do:
> 
> . Download the full tree for v2.6.14 commit and store its
>   objects locally.

On first read, I mistook "tree" for "commit"...

> . Set up `info/grafts` to lie to the local git that Linux kernel
>   history began at v2.6.14 version.

Maybe also record this in .git/config, so that you can

- disallow fetching from this repo, and
- easily extend the shallow copy to a larger shallow one, or a full one.

> . Run `git fetch git://.../linux-2.6 master`, with a local ref
>   pointing at v2.6.14 commit, to pretend that we have everything
>   up to v2.6.14 to `upload-pack` running on the other end.

How about refs/tags/start_shallow?

> . Update the `origin` branch with the master commit object name
>   we just fetched from Linus.
> 
> Design
> ------
>
> [...]
>
> Another functionality we would need is to tell `upload-pack` to
> use `info/grafts` of downloader's choice.  With this, after
> fetching the objects for v2.6.14 commit, the downloader can set
> up its own grafts file to cauterize the development history at
> v2.6.14, and tell the `upload-pack` to pretend the kernel
> history starts at that commit, while sending the tip of Linus'
> development track to us.

Why not just start another fetch? Then, "have <refs/tags/start_shallow>" 
would be sent, and upload-pack does the right thing?

If you absolutely want to get only one pack, which then is stored as-is, 
upload-pack could start two rev-list processes: one for the tree and one 
for all the rest.

> [...]
> 
> [NOTE]
> Most likely this is not directly run by the user but is run as
> the first command invoked by the shallow clone script.

Better make it an option to git-clone

> 4. `upload-pack` notices this is a single commit request, and
>    sends an ACK if it can satisfy the request (or a NAK if it
>    can't, e.g. it does not have the asked commit).  Instead of
>    doing the usual `get_common_commits` followed by
>    `create_pack_file`, it does:
> 
> 	$ git rev-list -n1 --objects $commit | git pack-object

Here it could say

(git rev-list -n1 --objects $commit_since; git rev-list --objects 
	^$commit_since $commit) | git pack-object

If the former is still needed (e.g. for git-tar-remote-tree), we could 
distinguish "single <ref>" and "shallow <ref>" commands.

> [...]
> 
> The second phase of the shallow clone is to fetch the history
> since v2.6.14 to the tip.

As I outlined above, I don't see the need for this.

Ciao,
Dscho
