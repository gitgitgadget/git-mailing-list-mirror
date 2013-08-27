From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 12/23] pack v4: creation code
Date: Tue, 27 Aug 2013 12:59:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271252570.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-13-git-send-email-nico@fluxnic.net>
 <xmqqppszdtiv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMbw-0001yU-2H
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab3H0Q7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:59:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60342 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3H0Q7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:59:15 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS7002HG8IRFLN0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 12:59:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 2114E2DA052D; Tue, 27 Aug 2013 12:59:15 -0400 (EDT)
In-reply-to: <xmqqppszdtiv.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233117>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Let's actually open the destination pack file and write the header and
> > the tables.
> >
> > The header isn't much different from pack v3, except for the pack version
> > number of course.
> >
> > The first table is the sorted SHA1 table normally found in the pack index
> > file.  With pack v4 we write this table in the main pack file instead as
> > it is index referenced by subsequent objects in the pack.  Doing so has
> > many advantages:
> >
> > - The SHA1 references used to be duplicated on disk: once in the pack
> >   index file, and then at least once or more within commit and tree
> >   objects referencing them.  The only SHA1 which is not being listed more
> >   than once this way is the one for a branch tip commit object and those
> >   are normally very few.  Now all that SHA1 data is represented only once.
> >
> 
> This tickles my curiosity. Why isn't this SHA-1 table sorted by
> reference count the same way as the tree path and the people name
> tables to keep the average length of varint references short?

Doing so allows for the SHA1 index used in objects to be used directly 
for lookups into the pack index in order to know immediately the 
location of the referenced object bypassing the binary search.  
Furthermore, SHA1 references are rather evenly spread across the whole 
table.  Only tree objects may share the same SHA1 references repeatedly 
across multiple objects, and those are likely to end up being deltas 
against each other.


Nicolas
