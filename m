From: Johan Herland <johan@herland.net>
Subject: Re: git equivalent to clearcase wink-in
Date: Thu, 21 Jan 2010 02:51:24 +0100
Message-ID: <201001210251.24948.johan@herland.net>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
 <20100120211251.GA26274@glandium.org>
 <fabb9a1e1001201434n1036253ds1120c2abc0d3728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Jamie Wellnitz <jwellnitz@gmail.com>,
	Richard Assal <richard_assal@yahoo.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXmDZ-0007C8-W7
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab0AUBv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 20:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577Ab0AUBv2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:51:28 -0500
Received: from smtp.getmail.no ([84.208.15.66]:33215 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751190Ab0AUBv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 20:51:28 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00GP6QHRMY80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 02:51:27 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00GJWQHP4C30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 02:51:27 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.13916
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <fabb9a1e1001201434n1036253ds1120c2abc0d3728e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137615>

On Wednesday 20 January 2010, Sverre Rabbelier wrote:
> On Wed, Jan 20, 2010 at 22:12, Mike Hommey <mh@glandium.org> wrote:
> > Surely the ccache directory could be shared on nfs or some other
> > network filesystem. Or object file could be checked in, which is imho
> > ugly, but should work (better to do that on a separate branch)
> 
> Ha! It could even be stored as a note on the tree object? The whole
> notes business seems to be nearing a usable stage. Or maybe notes are
> text-only, mhhh. Johan?

In principle you could (ab)use the notes structure for this purpose. There 
is nothing inherently text-only about notes. I would certainly suggest to 
create a custom notes ref for this purpose, so that these object caches are 
not mixed up with other notes (and are also not displayed by git log).

I'm also not sure the putting the note on the tree object is the right 
granularity. You could imagine putting a .o-file as a note on the 
corresponding .c-file _blob_, but that would only work if the .o-file 
depended solely on the .c file (i.e. it would only work for preprocessed 
source, or .c-files without any #includes), so that is probably not viable.

The problem with putting the object cache on the tree object, is that it 
would only be useful for those building the exact same tree as the one where 
the cache was made. Even though ccache can handle changed files just fine, 
you would not be able to leverage it, since the cache would be hidden under 
a different tree object.


Here's is an even more extreme idea: AFAIK, ccache works by hashing a 
preprocessed source file, and mapping the hash value to the resulting object 
file. A later lookup of the same preprocessed source file will yield the 
object file without having to go through that pesky compilation.

Now, what if that hash function happened to be SHA1, and the mapping 
happened to be the Git object database? In other words you could create a 
notes tree where the keys are SHA1s from preprocessed source files, and the 
note objects are the corresponding object files. As long as you don't call 
gc_notes() on this notes tree, it doesn't really matter that your SHA1 keys 
do not really exist as objects in the Git repo. The notes code can happily 
map any arbitrary SHA1 sum to a note object; it's only in gc_notes() that we 
actually care whether that SHA1 identifies an existing Git object.


Oh, and BTW, I consider the notes feature to be ready for prime time once 
the patch series currently in 'pu' is fully merged.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
