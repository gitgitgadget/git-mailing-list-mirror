From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
	that are corrupted in a pack file
Date: Wed, 7 Jan 2009 18:43:25 -0800
Message-ID: <20090108024325.GE10790@spearce.org>
References: <alpine.LFD.2.00.0901062005290.26118@xanadu.home> <1231292360.8870.61.camel@starfruit> <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain> <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>, kb@slide.com,
	Linus Torvalds <torvalds@linux-foundation.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKkt9-0002Xj-3R
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZAHCn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbZAHCn1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:43:27 -0500
Received: from george.spearce.org ([209.20.77.23]:33307 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZAHCn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:43:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E3D7838210; Thu,  8 Jan 2009 02:43:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104877>

James Pickens <jepicken@gmail.com> wrote:
> On Wed, Jan 7, 2009, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Can you cnfirm that your "reproducible" case starts working with that
> > addition to your ~/.gitconfig? If so, the solution is pretty simple: we
> > should just lower the default pack windowsize.
> 
> Umm... isn't that more of a workaround than a solution?  I.e., if you lower
> the default pack windowsize, couldn't the corruption still happen under the
> right conditions?

Uhm, yea.  So I managed to reproduce it on a Linux system here.
Different object ids than R. Tyler's case, but I'm going to try
to debug it and see why we are getting these.

For those following along at home, Linus' 2.6 tree:

$ ulimit -v `echo '150 * 1024'|bc -l`
$ git co 56d18e9932ebf4e8eca42d2ce509450e6c9c1666
HEAD is now at 56d18e9... Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
$ git merge 9e42d0cf5020aaf217433cad1a224745241d212a
Updating 56d18e9..9e42d0c
error: failed to read delta base object ef135b90084f3c54fccea4e273aeff029db2d873 at offset 48342508 from .git/objects/pack/pack-edb47354be787909e05c15bd1d9eb8b4684d2e4d.pack
error: failed to read delta base object c4e828b71d96622bb258938d69aab9cec53d5cae at offset 128427683 from .git/objects/pack/pack-edb47354be787909e05c15bd1d9eb8b4684d2e4d.pack
error: failed to read object 3cd5a6463cfd9306095bf6312a9b7ab09d4f2f5d at offset 128427777 from .git/objects/pack/pack-edb47354be787909e05c15bd1d9eb8b4684d2e4d.pack
fatal: object 3cd5a6463cfd9306095bf6312a9b7ab09d4f2f5d is corrupted

No, the repository is not corrupt.  We f'd up our memory management
somewhere.

-- 
Shawn.
