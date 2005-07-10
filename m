From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Design for http-pull on repo with packs
Date: Sun, 10 Jul 2005 14:42:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 10 20:44:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrgnH-0001TG-TV
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 20:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGJSon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGJSon
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 14:44:43 -0400
Received: from iabervon.org ([66.92.72.58]:65287 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261155AbVGJSom (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 14:44:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DrglJ-0004Hr-00
	for git@vger.kernel.org; Sun, 10 Jul 2005 14:42:45 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have a design for using http-pull on a packed repository, and it only
requires one extra file in the repository: an append-only list of the pack
files (because getting the directory listing is very painful and
failure-prone).

The first thing to note is that fetch() is allowed to get more than just
the requested object. This means that we can get the pack file with the
requested object, and this will fulfill the contract of fetch(), and,
hopefully, be extra-helpful (since we expect the repository owner to have
packed stuff together usefully). So I do this:

 Try to get individual files. So long as this works, everything is as
  before.

 If an individual file is not available, figure out what packs are
  available:

   Get the list of pack files the repository has
    (currently, I just use "e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135")
   For any packs we don't have, get the index files.
   Keep a list of the struct packed_gits for the packs the server has
    (these are not used as places to look for objects)

 Each time we need an object, check the list for it. If it is in there,
  download the corresponding pack and report success.

I've nearly got an implementation ready, except for not having a way of
getting a list of available packs. It seems to work for getting
e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135 when necessary, although I'm
still debugging the last few things.

	-Daniel
*This .sig left intentionally blank*
