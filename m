From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Storing Maintainers info around the kernel tree
Date: Thu, 16 Aug 2007 17:13:41 +0200
Message-ID: <46C469A5.8020003@gmail.com>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com> <20070814232430.GA9325@redhat.com> <2ABEF126-D860-46D2-8E15-673C3ADB51A0@mac.com> <200708151321.05959.rjw@sisk.pl> <D31EF534-ACD1-426D-AF88-F152C23CB542@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@lists.linux-foundation.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Salikh Zakirov <salikh@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763677AbXHPPS3@vger.kernel.org Thu Aug 16 17:18:51 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763677AbXHPPS3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILh7a-0003ab-Rs
	for glk-linux-kernel-3@gmane.org; Thu, 16 Aug 2007 17:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763677AbXHPPS3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Aug 2007 11:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787AbXHPPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Aug 2007 11:18:17 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:48195 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbXHPPSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Aug 2007 11:18:15 -0400
Received: from [213.51.146.189] (port=40147 helo=smtp2.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILh6b-0005A6-4L; Thu, 16 Aug 2007 17:17:49 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:57268 helo=[192.168.0.3])
	by smtp2.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1ILh6Y-0005ja-FA; Thu, 16 Aug 2007 17:17:46 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <D31EF534-ACD1-426D-AF88-F152C23CB542@mac.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56017>

On 08/16/2007 03:04 PM, Kyle Moffett wrote:

> On Aug 16, 2007, at 07:57:23, Rene Herman wrote:

>> category as .gitignore, which would _be_ a property.
>>
>> If you do this stuff in files scattered around the tree, updating and 
>> moving stuff becomes a pain -- the tool would need to go edit files.
> 
> From a practical standpoint we don't want to duplicate someone's 
> maintainer information in the attributes of every file they maintain.  

In a tree structure, you don't have to. As described earlier, the tool 
(git-prop) looks for the requested property being set first on the file 
itself, then on the directory in which it resides, then its parent, and so 
on. If I read things right, this is also how properties work in subversion 
in fact.

So after

$ git prop --set --name maintainer --value \
	"Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>" drivers/ide/
and

$ git prop --set --name maintainer --value \
	"Alan Cox <alan@lxorguk.ukuu.org.uk>" drivers/ide/ide-cd.*

we get:

$ git prop --get --name maintainer drivers/ide/ide-cd.c
Alan Cox <alan@lxorguk.ukuu.org.uk>

$ git prop --get --name maintainer drivers/ide/ide-generic.c
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Now, this override behaviour needs a tree structure ofcourse, but notice I 
set the "maintainer" property only to the name/address. The other 
information from the MAINTAINERS file would be using their own properties:

$ git prop --set --name tree --value \
     "quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/" drivers/ide/

and nothing under drivers/ide/ would override this value nor would it be 
repeated anywhere. Alan takes care of more than ide-cd but only the actual 
"maintainer" value string would be set on the others as well and repeating 
that much for different "maintenance units" is no different from the current 
MAINTAINERS file where it also is (well, would be, Alan is in fact only 
listed for ide-cd it seems...) repeated in different entries.

(as a slight difference -- in the above example, Alan's information _is_ 
repeated over ide-cd.c and ide-cd.h where the current MAINTAINERS file just 
says "IDE/ATAPI CDROM DRIVER", but that's a bit of an oddbal situation since 
you normally have either single files or a tree that make up a "maintenance 
unit" -- and is in fact just a human versus tool difference).

> It would be much easier to put in the "kernel/somesubsys" directory a 
> Maintainers file which has:

It's ofcourse possible, but note that if we want this stuff to be minimally 
manual, moving files around (and deleting them) then requires editing these 
actual in-tree files via a tool.

With the properties deleting files just requires deleting any file-specific 
properties alongside which is trivial since those are linked from the file.

Moving stuff works by building a list of all properties that are set on the 
source starting at the source and destination's highest shared parent 
directory and then reconstructing this list at the destination, striking 
properties off the list that are already set at the destination.

Adding properties, alongside added files or after the fact, could be done 
via standard patch submissals via the kind of "meta-diff" that already 
exists for "git move".

I really believe this stuff should be meta-data -- and these properties as 
outlined work well it seems.

$ git prop --set --name git.ignore -V ./.gitignore .
$ rm .gitignore

This is something I saw subversion also uses properties for. Takes the value 
from a file instead of the command line. .gitattributes are also easily 
incorporated into the property-system directly.

$ git prop --set --name git.executable scripts/Lindent

Must say I'm not particularly sure if this one has much value over the 
current executable bit storage,but also from svn and example of a boolean 
property.

$ git prop --set --name license --value "GPL v2" .
$ git prop --set --name license --value "GPL" sound/alsa/

and so on. The GPL v2 on the source root only works if you set the property 
on everything that's not, so you may not want to but as a "wouldn't it be 
nice if" kinda thing. Makes for easy license analysis at least...

$ git prop --set --name FIXME drivers/block/floppy.c

Okay, that's probably overdoing it a bit, but as long as I'm having fun here...

Note -- the properties would be versioned themselves ofcourse so that you'd 
always have a tree where data and meta-data matched. Basically, I believe 
you'd view the properties as just more data files, one per property, with 
the exception that they'd not actually live in the working tree and are 
linked from data (files/directories) that do.

Long "letters of intent" this, but I'm by now in love with these things. 
More comments (or implementations obviously :-) welcome. Any significant 
misses in this?

Rene.
