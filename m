From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Q: does index-pack work in place on windows?
Date: Thu, 03 Feb 2011 00:32:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102030026430.12104@xanadu.home>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
 <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_h4zK9apKAKaHbhRdv9AUfg)"
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 06:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkrne-0003Qv-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab1BCFcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:32:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44441 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab1BCFcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:32:03 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG1002320ORRZ80@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 00:31:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165955>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_h4zK9apKAKaHbhRdv9AUfg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 2 Feb 2011, Erik Faye-Lund wrote:

> On Wed, Feb 2, 2011 at 9:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > ... or any other (operating / file) system where you cannot unlink a file
> > that is open?
> >
> > When you run
> >
> >    $ git clone git://some.where/repo/sitory.git local
> >    $ cd local
> >    $ git index-pack .git/objects/pack/pack-*.pack
> >
> > there is a call to write_idx_file() in builtin/index-pack.c, that feeds
> > the correct (and existing) name of the corresponding pack idx file.
> >
> > The callee in pack-write.c, after sorting the list of objects contained in
> > the pack, does this:
> >
> >        if (!index_name) {
> >                static char tmpfile[PATH_MAX];
> >                fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
> >                index_name = xstrdup(tmpfile);
> >        } else {
> >                unlink(index_name);
> >                fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> >        }
> >
> > and then writes out the pack index to the file descriptor.  But index-pack
> > uses the usual has_sha1_file() and read_sha1_file() interface to validate
> > the "existing" objects, and is likely to have mmapped the .idx file when
> > it called use_pack_window().  Which makes me suspect that this unlink (or
> > the open that immediately follows) may fail on systems that do not allow
> > unlink on inode that has still users.
> 
> ...and you're right:
> 
> $ git index-pack
> .git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.pack
> Unlink of file '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx'
> failed. Should I try again? (y/n)? n
> fatal: unable to create
> '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx':
> File exists

Why would you do such thing in the first place?

If the pack exists along with its index on disk, there is no point 
recreating it.  Maybe index-pack should just bail out early in that 
case.


Nicolas

--Boundary_(ID_h4zK9apKAKaHbhRdv9AUfg)--
