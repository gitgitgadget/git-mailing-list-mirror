From: Avery Pennarun <apenwarr@gmail.com>
Subject: Configurable callbacks for missing objects (we Re: upload-pack:
	support subtree packing)
Date: Tue, 27 Jul 2010 14:51:27 -0400
Message-ID: <20100727185127.GD25124@worldvisions.ca>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com> <1280187370-23675-2-git-send-email-pclouds@gmail.com> <20100727144605.GA25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdpFE-0002hE-5u
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab0G0SvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 14:51:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61385 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0G0SvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:51:09 -0400
Received: by iwn7 with SMTP id 7so3932204iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qM1Nq9ax34ZcR9cu3zESMqjZ98Uc4zXSJy786PStYn0=;
        b=NMcXMv0zjE9Hb5c7DpmL6C8zongFiepQcY663Bn3s4FL9vDpeIO8X8V04eB9fEJ9gP
         EkhDCeWKF6Ad6WhG59rLjHTVnYbf6gvXuTVaj8HQ0gmLAXoTaEfQWAr03cv8IVnv9O7m
         uqu19aFdEH8XFKbbhk47BShr/3Lg3cTWimnw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BqJXYW0j6Gz7U9ljbqzh7SAH08kd9Nh55beNcjK2jJQTN9bW5yLAgTYjTc9iTnvAIP
         dj8e/oEaAyQzEbnYFTUVIhhsAoGyePaNI3TC8JoyTP6QMuh/OCcq3I+KIW4yeMo+R5vJ
         nu9VUGZFH5lyo0WmvXhsZtXJ2HZz6N2r1oKJo=
Received: by 10.231.149.3 with SMTP id r3mr10598806ibv.109.1280256668439;
        Tue, 27 Jul 2010 11:51:08 -0700 (PDT)
Received: from afterlife.apenwarr.local ([66.51.252.152])
        by mx.google.com with ESMTPS id r3sm5042746ibk.7.2010.07.27.11.51.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:51:07 -0700 (PDT)
Received: from apenwarr by afterlife.apenwarr.local with local (Exim 4.69)
	(envelope-from <apenwarr@afterlife.apenwarr.local>)
	id 1OdpFP-0006Xv-I1; Tue, 27 Jul 2010 14:51:27 -0400
Content-Disposition: inline
In-Reply-To: <20100727144605.GA25268@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151974>

On Tue, Jul 27, 2010 at 07:46:05AM -0700, Shawn O. Pearce wrote:

> But I disagree with the client rewriting the commits in order to
> work with them locally.  Doing so means you can't take a commit
> from your team's issue tracker and look it up.  And any commit
> you create can't be pushed back to the server without rewriting.
> Its messy for the end-user to work with.

Yeah, that doesn't sound ideal.  And I wrote git-subtree, which does exactly
that, so I should know :)

> I would prefer doing something more like what we do with shallow
> on the client side.  Record in a magic file the path(s) that we
> did actually obtain.  During fsck, rev-list, or read-tree the
> client skips over any paths that don't match that file's listing.
> Then we can keep the same commit SHA-1s, but we won't complain that
> there are objects missing.

Disclaimer: I've never looked at any of the fetch code.

But I've been thinking that a really elegant way to solve the problem could
be to have a user-configurable "get the missing objects" callback.  If any
part of git that *needs* an object can't find it, it calls this callback to
go try to retrieve it (either just that one object, or it can request to
download the object recursively, ie. everything it points to).

Then shallow clones could just auto-fill themselves if you really need a
prior version, for example.

It's also conceivable that we could limit this just to blobs: downloading
the complete set of commit objects, and probably even the complete set of
tree objects, is probably not that expensive.  And that would allow someone
to do virtually all operations (other than three-way merges to resolve blob
conflicts) without having the entire repo.

I say it could be user-configurable because that's where you could plugin a
gittorrent, or a tool that just tries fetching from a series of repositories in
turn, etc.

Have fun,

Avery
