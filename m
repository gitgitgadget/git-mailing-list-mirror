From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Thu, 25 Feb 2010 15:35:03 +0100
Organization: SUSE Labs
Message-ID: <201002251535.03334.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de> <201002251025.22881.agruen@suse.de> <4B866D60.6040306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 15:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkepM-0006Er-3K
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 15:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774Ab0BYOgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 09:36:08 -0500
Received: from cantor.suse.de ([195.135.220.2]:35348 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932732Ab0BYOgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 09:36:05 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 803869428F;
	Thu, 25 Feb 2010 15:36:03 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4B866D60.6040306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141051>

On Thursday 25 February 2010 13:30:24 Michael J Gruber wrote:
> Andreas Gruenbacher venit, vidit, dixit 25.02.2010 10:25:
> > On Thursday 25 February 2010 10:01:43 Michael J Gruber wrote:
> >> Andreas Gruenbacher venit, vidit, dixit 24.02.2010 16:57:
> >>> Add --view options in upload-pack and receive-pack so that a repository
> >>> on the server side can be made to look like several independent
> >>> repositories on the client side.
> >>>
> >>> This is implemented by transforming ref names: for example, with
> >>> --view=one/, refs/heads/one/master on the server will look like
> >>> refs/heads/master to the client, refs/tags/one/v1 will look like
> >>> refs/tags/v1, etc.
> >>>
> >>> This allows to transparently share repositories on the server which
> >>> have a lot of objects in common without complicating things for the
> >>> client, and without breaking garbage collection.
> >>
> >> Just from this description, I can't see why the same can't be done with
> >> appropriate refspecs. (A helper for doing that would be more welcome, of
> >> course.)
> >
> > You mean on the client side? The problem then is that a simple "git
> > clone" would not do the right thing anymore; you would still expose
> > server-side implementation details to clients. Clients shouldn't have to
> > bother with this added complexity. (They might not even have access to
> > some of the views.) When you do the mapping server-side, you can split or
> > merge repositories as needed without the clients even noticing.
> 
> But the client has to request a specific view, doesn't it?

No, it's a server side thing. The git commands affected are upload-pack and 
receice-pack, and those run on the remote end of a fetch. For example, the 
client would ask the server for repository /foo/one or /foo/two, and the 
server would map that to different views of /bar/shared: when the client asks 
the server to run "git-upload-pack /foo/one", the server runs "git-upload-pack 
--view=one/ /bar/shared" instead.

This is relatively easy to set up over ssh using a simple script; for direct 
git access, a small wrapper daemon would be needed. I'm not sure how this 
could be hacked into http access, but it doesn't seem all that hard, either.

> I just can't help the impression that this is a use case which does not
> need a new feature, at least not upload/receive-pack wise.

Still, even with the additional explanation above?

> It's more a matter of ensuring that all clients use a specific configuration
> (which you would have to with your patch as well, AFAICT), and this more
> general issue is creeping up again and again, with no agreeable solution
> so far.

Well that's another problem which we indeed also have for enabling things like 
local consistency checks and merge drivers. I don't have a good answer here :)

Thanks,
Andreas
