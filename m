From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 7 Jan 2009 18:52:15 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>  <1231368935.8870.584.camel@starfruit>  <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKl2N-0004bM-Cj
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbZAHCw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZAHCw6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:52:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34317 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813AbZAHCw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 21:52:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n082qGKM026011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 18:52:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n082qFIK016547;
	Wed, 7 Jan 2009 18:52:16 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231374514.8870.621.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104879>



On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
>
>         tyler@grapefruit:~/source/git/linux-2.6> git pull
>         error: failed to read object be1b87c70af69acfadb8a27a7a76dfb61de92643 at offset 1850923
>         from .git/objects/pack/pack-dbe154052997a05499eb6b4fd90b924da68e799a.pack
>         fatal: object be1b87c70af69acfadb8a27a7a76dfb61de92643 is corrupted

Btw, this is an interesting error message, mostly because of what is 
_not_ there.

In particular, it doesn't report any reason _why_ it failed to read the 
object, which as far as I can tell can happen for only one reason: 
unpack_compressed_entry() returns NULL, and that path is the only thing 
that can do so without a message.

And it only does it if zlib fails.

Now, zlib can fail because the unpacking fails, but it can fail for other 
cases too.

And the thing is, we don't check/report those kinds of failure cases very 
well. Which really bit us here, because if we had checked the return value 
of inflateInit(), we'd almost certainly would have gotten a nice big "you 
ran out of memory" thing, and we wouldn't have been chasing this down as a 
corruption issue.

We probably should wrap all the "inflateInit()" calls, and do something 
like

	static void xinflateInit(z_streamp strm)
	{
		const char *err;

		switch (inflateInit(strm)) {
		case Z_OK:
			return;
		case Z_MEM_ERROR:
			err = "out of memory";
			break;
		case Z_VERSION_ERROR:
			err = "wrong version";
			break;
		default:
			err = "error";
		}
		die("inflateInit: %s (%s)", err,
			strm->msg ? strm->msg : "no message");
	}

or similar. That way we'd get good error reports when we run out of 
memory, rather than consider it to be a corruption issue.

We could also try to make a few of these wrappers actually release some of 
the memory (the way xmmap() does), but there are likely diminishing 
returns. And the much more important issue is the proper error reporting: 
if we had reported "out of memory", we'd not have spent so much time 
chasing disk corruption etc.

			Linus
