From: John McKown <john.mckown@healthmarkets.com>
Subject: Re: What about SHA-1 collisions?
Date: Tue, 6 Nov 2012 21:41:29 +0000 (UTC)
Message-ID: <loom.20121106T223000-502@post.gmane.org>
References: <20121106202643.GF28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVqxM-0008B5-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 22:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab2KFVo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 16:44:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:35765 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab2KFVo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 16:44:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVqxD-00088I-By
	for git@vger.kernel.org; Tue, 06 Nov 2012 22:45:03 +0100
Received: from 75.31.122.3 ([75.31.122.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:45:03 +0100
Received: from john.mckown by 75.31.122.3 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.31.122.3 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209124>

Josef Wolf <jw <at> raven.inka.de> writes:

> 
> Hello,
> 
> we all know, the probability for SHA-1 collisions is very, very low, almost
> non-existant. But we also know that they are not impossible.
> 
> Just for curiosity: what would happen if such a collision would occur within
> one repository?
> 

In a sense, this cannot happen. Suppose you have a new working directory.
You do a "git init" to initialize it for use by git. You then copy in a
bunch of data from elsewhere. By chance, files "a" and "b" have different
content, but the same sha1 (they collide). The "git add ." command is
basically a short cut for doing something like:
for i in *;do git add $i;done
That is, it seems to add each file, one at a time in some order. Suppose
it creates the sha1 for "a" first. It then creates the appropriate
"stuff" for file "a" in the .git subdirectory, based on the sha1 value. Now,
it gets around to processing "b". It gets the sha1 value of b and finds
that it already has an entry for that value. At that point, the "git add" thinks
"Oh, I've already processed this file. No need to do anything!" So the contents
of file "b" are not saved anywhere in git and, bottom line, that version of "b" 
will not be in the git repository. Ever. Because "a" already has that SHA1 "tied 
up" and it is (theoretically) never released.

I think of the SHA1 value being a unique key into a "write once" database. Once 
you've added some content (a file) into the database, then the SHA1 value of
that content (file) is unmodifiable. Attempts to write another record into the 
database is rejected (in a read DB, you'd get some sort of DUPLICATE KEY 
response). Git considers the "duplicate key" to be just fine because it ASSUMES 
that the SHA1 is unique to the first file (content) which generates it.

Hope I made sense.

John
