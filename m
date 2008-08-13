From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Add Git-aware CGI for Git-aware smart HTTP transport
Date: Wed, 13 Aug 2008 07:53:41 -0700
Message-ID: <20080813145341.GA3782@spearce.org>
References: <200808130326.m7D3Pr2V000918@terminus.zytor.com> <20080813032812.GD5855@spearce.org> <48A262B9.8020608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:54:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHkM-0004L1-S2
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYHMOxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYHMOxm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:53:42 -0400
Received: from george.spearce.org ([209.20.77.23]:33064 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYHMOxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:53:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ADD7938375; Wed, 13 Aug 2008 14:53:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48A262B9.8020608@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92222>

[...added git ML back to thread...]

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>> The plan I've proposed requires wedging the CGI in between the HTTP
>> server and the repository files.  Which means older dumb clients
>> get data by forking off the CGI, rather than letting the HTTP server
>> stream the file itself.
>
> Yeah, that's quite a bit unfortunate, because it means some potentially  
> very expensive buffering in Apache.  That's one reason to do some kind  
> of redirection.

Hmm.  So what if the "smart" protocol used a redirect to the CGI
and the dumb protocol didn't use any redirects at all?  I say this
because I think the dumb protocol won't handle redirects well.
It will do them, but it would incur a redirect on every request
it makes.

So if we have the "smart" protocol perform detection by trying:

	C: HEAD /path/to/repository.git/git-http-backend HTTP/1.0

	S: HTTP/1.0 302 Found
	S: Location: /git-http/path/to/repository.git

Under Apache this server configuration can be easily handled by a
mod_rewrite regex:

	RewriteRule ^(/pub/scm/.*)/git-http-backend$ /git/$1 [R,L]
	ScriptAlias /git/ /path/to/git-http-backend/

Individual users could also install the git-http-backend CGI
right into their repository, in which case the CGI if invoked with
no PATH_INFO can do a redirect back to itself to indicate where
GIT_DIR is:

	C: HEAD /path/to/repository.git/git-http-backend HTTP/1.0

	S: HTTP/1.0 302 Found
	S: Location: /path/to/repository.git/git-http-backend/.

Individual operations can be selected by appending on the operation
name, so <Location ~ > style rules can be used to apply access
controls, such as:

	# Disallow push to any smart repository via ScriptAlias
	#
	<Location ~ ^/git/.*/receive-pack$>
		Order Deny,Allow
		Deny from all
	</Location>

	# Disallow push to any smart repository with CGI in tree.
	#
	<Location ~ .*/git-http-backend/./receive-pack$>
		Order Deny,Allow
		Deny from all
	</Location>

Setting this up on a server which doesn't have the power of mod_regex
available would be tricky, as you need to link the CGI into every
single repository you are serving.  I don't know (or use) many other
HTTP servers beyond Apache so I'm not sure if they can do this.

-- 
Shawn.
