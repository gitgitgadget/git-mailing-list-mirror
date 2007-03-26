From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 19:10:05 +0200
Message-ID: <e5bfff550703261010u67aa1207j1c6f0200bb7744a@mail.gmail.com>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
	 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
	 <20070325083530.GA25523@bohr.gbar.dtu.dk>
	 <20070325091806.GH25863@spearce.org>
	 <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com>
	 <alpine.LFD.0.83.0703261015110.3041@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Peter Eriksen" <s022018@student.dtu.dk>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:10:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVshw-0003Ha-WE
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbXCZRKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbXCZRKI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:10:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:9616 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbXCZRKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:10:07 -0400
Received: by nz-out-0506.google.com with SMTP id s1so2095197nze
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:10:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=exiSdeuNx3Bqq+HbaV3jHUG8r0z+0Y/DLio5A0+KXaW5ouv9SWFvq4sk5Ne4eADRXGltwByWgNLK1GlVuHqQXJMr6v/EW0yzKmdJpauoQzv+nk/8Iueazz7XSHc/cW0NRiQO2sgxPvmTlNIOvywCQiszFKxWqkAQqgiXkHK+lQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D1EqsQvNoGW10EzP3zrzHnihS55I2XOAwlPT25QAr8N9AA3ZC1O5I7MO1JJZevCw2V8gCpyUVnhofdYKkEtxKUVgiyQO6tDDqwuqp8NT4hxrT6fyiWNQnX36lRpPTecgtdGzMctw1/ifqJPYdRV46XpPjolW7gVbaniVBde44ks=
Received: by 10.114.195.19 with SMTP id s19mr2712795waf.1174929005734;
        Mon, 26 Mar 2007 10:10:05 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Mon, 26 Mar 2007 10:10:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.83.0703261015110.3041@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43160>

On 3/26/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Mar 2007, Marco Costalba wrote:
>
> > Experimenting with file names cache in qgit I have found a big saving
> > splitting the paths in base name and file name and indexing both:
> >
> > drivers\usb\host\ehci.h
> > drivers\usb\host\ehci-pci.c
> > drivers\usb\host\ohci-pci.c
> > kernel\sched.c
> >
> > became:
> >
> > dir names table
> >
> > 0 drivers\usb\host
> > 1 kernel
> >
> >
> > file name table
> >
> > 0 ehci.h
> > 1 ehci-pci.c
> > 2 ohci-pci.c
> >
> > In this way a big saving is achieved in case of directories deep in
> > the tree (long paths) and a lot of files.
>
> Sure, but if you also consider drivers/usb/Makefile and drivers/Kconfig
> for example then you start losing on space saving.

In your example you'd have:

drivers/usb/Makefile
drivers/Kconfig

became

dir names table
0 drivers
1 drivers/usb

file name table
0 Makefile
1 Kconfig

I fail to see wher's the losing on space saving. More, you probably
have many paths both under 'drivers' and 'drivers/usb' and for each
added path it would be possible to avoid to store the prefix ('driver'
or 'driver/usb').

To better clarify, OBJ_DICT_TREE data *currently* looks like:

+------------+-------+-------+-------+-------+----
| NR_ENTRIES | name1 | hash1 | name2 | hash2 | ...
+------------+-------+-------+-------+-------+----
  vint        2 bytes 4 bytes 2 bytes 4 bytes

where name1 is an index into the packfile's sole EXTOBJ_FILENAME_TABLE.

The possible improve is to define OBJ_DICT_TREE like

+------------+-------+-------+-------+-------+----
| NR_ENTRIES | dir1   | fiile1 | hash1| dir 2| fiile2|...
+------------+-------+-------+-------+-------+----
  vint        2 bytes 2 bytes 2 bytes 4 bytes

where dir1 is an index into a new EXTOBJ_DIRNAME_TABLE and file1 is an
index in a new  EXTOBJ_FILENAME_TABLE.


EXTOBJ_FILENAME_TABLE is defined as the currently (but much smaller in
size!!) and keeps only the file names, not the full paths, while
EXTOBJ_DIRNAME_TABLE is defined as EXTOBJ_FILENAME_TABLE but without
MODE field (associated to files only) and is used to store the dir
names.

Decopuling dir names from file names could improve saving space
because the length of proposed EXTOBJ_FILENAME_TABLE +
EXTOBJ_DIRNAME_TABLE < current EXTOBJ_FILENAME_TABLE.

  Marco

P.S: Of course now you'd save 2+2 bytes in OBJ_DICT_TREE instead of 2
for 'name' index.
To avoid this and keep the idea of decopuling dir and file names an
still use 2 bytes in OBJ_DICT_TREE a possible layout of
EXTOBJ_FILENAME_TABLE could be:


 +------------+------+-------+-----------------+---
-+----------------+-------+------+----------+
 | NR_ENTRIES | dirA  |  file name1 | ofs1| file name2 | ofs 2|dirB
|file name3 | ofs3 | ....
 +------------+------+-------+-----------------+----
+---------------+--------+------+----------+

Where ofs1 and ofs2 are 2-bytes values pointing to dirA, ofs3 points
to dirB and so on.

Where the tree layout of the above example is:

dirA \ file name1
dirA \ file name2
dirB \ file name3

With this approach you have both the saving in case of directories
with many files and still 2 bytes per 'name' index in OBJ_DICT_TREE
(that points to 'file name' field). This approach saves space as soon
as directory names are longer then 2 chars.
