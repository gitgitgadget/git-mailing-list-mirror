From: "David S. Miller" <davem@davemloft.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 00:16:51 -0800 (PST)
Message-ID: <20060108.001651.02992220.davem@davemloft.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: torvalds@osdl.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 09:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvVjg-0005M5-ND
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 09:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWAHIQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Jan 2006 03:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWAHIQ5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 03:16:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43753
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030525AbWAHIQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 03:16:55 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1EvVjP-0002l5-M8; Sun, 08 Jan 2006 00:16:51 -0800
To: len.brown@intel.com
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14309>

=46rom: "Brown, Len" <len.brown@intel.com>
Date: Sun, 8 Jan 2006 02:47:30 -0500

> I'm probably a na=EFve git user -- but I expect I have a lot of compa=
ny.
> If there is a better way of using the tool to get the job done,
> I'm certainly a willing customer with open ears.

What I do is simply build a new fresh tree if I feel the urge
to sync with the top of Linus's tree.  I use the script below
which I call "git suck".  It just sucks the patches out of
one tree and sticks them into another tree.  You go:

bash$ cd new-2.6
bash$ git suck ../foo-2.6

It preserves everything except the dates, and it's so incredibly
cheap and fast with GIT.

I know a lot of people react to this kind of usage with "what's the
point of the source control system if you're just messing with patches
in and out of the tree all the time" But as a subsystem maintainer,
you deal with a lot of changes and it's important to get a pristine
clean history when you push things to Linus.

In fact, I do this so much that Linus's tree HEAD often equals my
origin when he pulls.

Merges really suck and I also hate it when the tree gets cluttered
up with them, and Linus is right, ACPI is the worst offender here.

Yes, we can grep the merges out of the shortlog or whatever, but that
merging crap is still physically in the tree.

Just don't do it.  Merge into a private branch for testing if you
don't want to rebuild trees like I do, but push the clean tree to
Linus.

#!/bin/sh
#
# Usage: git suck path-to-tree
#
# Pull all patches relative to 'origin' from the tree specified
# and apply them to the current directory tree, keeping all changelog
# and authorship information identical.  It will update the dates
# of the changes of course.
(cd $1; git format-patch --mbox origin) || exit 1
for i in $1/*.txt
do
   sed 's/\[PATCH\] //' <$i >tmp.patch
   git-applymbox -k tmp.patch || exit 1
done
