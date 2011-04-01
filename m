From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Sat, 02 Apr 2011 01:37:28 +0200
Message-ID: <201104020137.28951.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
 <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 02 01:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5nuV-0006Ip-Cy
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 01:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1DAXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 19:37:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54409 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1DAXhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 19:37:31 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIZ000ETYYIWO80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 02 Apr 2011 01:37:30 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E3D171EA597B_D9661B9B	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 23:37:29 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D00651EA3FB9_D9661B9F	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 23:37:29 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIZ00HH3YYHKT00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 02 Apr 2011 01:37:29 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170636>

On Friday 01 April 2011, Shawn Pearce wrote:
> The only problem is a cpio based clone, which may link the objects
> directory before the refs, and miss linking the new pack but wind up
> linking the new ref, making the clone corrupt. But that is a bug in
> the cpio clone implementation. Using file:// to use the classical pipe
> is safe here, because the refs are scanned before the objects are.
> IMHO, if you think clone during push is unsafe because of this, we
> should fix the cpio clone path to do a `git ls-remote` on the source,
> cache the refs in memory, copy the objects, then write out a
> packed-refs file containing the refs we snapshotted *before* linking
> the objects directory into the new clone.

Looking at clone_local() in builtin/clone.c (which I guess is the
culprit here), wouldn't we fix this simply by swapping the two parts
of the function, so that the refs part is done before the objects
part? Like this:


static const struct ref *clone_local(const char *src_repo,
				     const char *dest_repo)
{
	const struct ref *ret;
	struct strbuf src = STRBUF_INIT;
	struct strbuf dest = STRBUF_INIT;
	struct remote *remote;
	struct transport *transport;

	remote = remote_get(src_repo);
	transport = transport_get(remote, src_repo);
	ret = transport_get_remote_refs(transport);
	transport_disconnect(transport);

	if (option_shared)
		add_to_alternates_file(src_repo);
	else {
		strbuf_addf(&src, "%s/objects", src_repo);
		strbuf_addf(&dest, "%s/objects", dest_repo);
		copy_or_link_directory(&src, &dest);
		strbuf_release(&src);
		strbuf_release(&dest);
	}

	if (0 <= option_verbosity)
		printf("done.\n");
	return ret;
}


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
