From: Nicolas Pitre <nico@cam.org>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 14:43:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703261417520.3041@xanadu.home>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
 <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org>
 <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com>
 <alpine.LFD.0.83.0703261015110.3041@xanadu.home>
 <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVu9v-0006p9-AI
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbXCZSnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbXCZSnH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:43:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49815 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbXCZSnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:43:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFI003ZVXBREQ00@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Mar 2007 14:43:04 -0400 (EDT)
In-reply-to: <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43173>

On Mon, 26 Mar 2007, Marco Costalba wrote:

> I fail to see wher's the losing on space saving. More, you probably
> have many paths both under 'drivers' and 'drivers/usb' and for each
> added path it would be possible to avoid to store the prefix ('driver'
> or 'driver/usb').

I'm under the impression you don't understand how tree objects work.

> To better clarify, OBJ_DICT_TREE data *currently* looks like:
> 
> +------------+-------+-------+-------+-------+----
> | NR_ENTRIES | name1 | hash1 | name2 | hash2 | ...
> +------------+-------+-------+-------+-------+----
>  vint        2 bytes 4 bytes 2 bytes 4 bytes
> 
> where name1 is an index into the packfile's sole EXTOBJ_FILENAME_TABLE.

Exact.

> The possible improve is to define OBJ_DICT_TREE like
> 
> +------------+-------+-------+-------+-------+----
> | NR_ENTRIES | dir1   | fiile1 | hash1| dir 2| fiile2|...
> +------------+-------+-------+-------+-------+----
>  vint        2 bytes 2 bytes 2 bytes 4 bytes
> 
> where dir1 is an index into a new EXTOBJ_DIRNAME_TABLE and file1 is an
> index in a new  EXTOBJ_FILENAME_TABLE.

You definitely don't understand how tree objects are used.

Tree objects have no notion of full path at all.  They only contain 
directory component from a single path level only.

If you have the following files:

	drivers/Kconfig
	drivers/usb/Makefile
	drivers/usb/host/ehci.h
	drivers/usb/host/ehci-pci.c
	drivers/usb/host/ohci-pci.c
	kernel/sched.c

then you'll start with one tree objects for the root directory that 
contains:

	drivers (tree)
	kernel (tree)

Then a second tree object for the "drivers" directory that contains:

	Kconfig (blob)
	usb (tree)

Then a third tree object for the "usb" directory with:

	Makefile (blob)
	host (tree)

Then the fourth tree object with:

	ehci.h (blob)
	ehci-pci.c (blob)
	ohci-pci.c (blob)

And finally a fifth tree object for the "kernel" directory with:

	sched.c (blob)

Hence, the path component table would contain:

	drivers
	usb
	host
	Kconfig
	Makefile
	ehci.h
	ehci-pci.c
	ohci-pci.c
	sched.c

along with the mode bits for each of those path components, and this is 
what the new tree object would index into for each tree record.

> EXTOBJ_FILENAME_TABLE is defined as the currently (but much smaller in
> size!!) and keeps only the file names, not the full paths, while
> EXTOBJ_DIRNAME_TABLE is defined as EXTOBJ_FILENAME_TABLE but without
> MODE field (associated to files only) and is used to store the dir
> names.
> 
> Decopuling dir names from file names could improve saving space
> because the length of proposed EXTOBJ_FILENAME_TABLE +
> EXTOBJ_DIRNAME_TABLE < current EXTOBJ_FILENAME_TABLE.

I hope the explanation above made it clear that what you're proposing 
cannot ever be smaller than current EXTOBJ_FILENAME_TABLE.


Nicolas
