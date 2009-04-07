From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 07 Apr 2009 13:48:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
References: <20090405T001239Z@curie.orbis-terrarum.net>
 <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
 <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
 <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
 <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_f5jWnSkaiQQ26Vn9J+/mew)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFQr-0007Sv-P9
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758913AbZDGRsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758325AbZDGRsM
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:48:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29581 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932AbZDGRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:48:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHQ000WHS42PVL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 07 Apr 2009 13:48:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090407142147.GA4413@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115969>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_f5jWnSkaiQQ26Vn9J+/mew)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 7 Apr 2009, Björn Steinbrink wrote:

> On 2009.04.07 09:13:45 -0400, Nicolas Pitre wrote:
> > Having git-rev-list consume about 2G RSS for the enumeration of 4M 
> > objects is simply inacceptable, period.  This is the equivalent of 500 
> > bytes per object pinned in memory on average, just for listing object, 
> > which is completely silly. We ought to do better than that.
> 
> Ah, crap, I might have been fooled by "ps aux", top actually shows about
> 1.3G being shared, likely the mmapped pack files. And that will be
> reused, assuming the box has enough memory to keep all that stuff.

Right.  And since the pack is mapped read-only, it can be paged out 
easily by the OS.  And if that doesn't help, we already have 
core.packedGitWindowSize and core.packedGitLimit config options to play 
with.

> But that's still 700MB or about 150 bytes per object on average.
> 
> A "struct tree" is 40 bytes here, adding the average path length (19 in
> this repo) that's 59 byte, leaving about 90 bytes of "overhead" per
> object, as end the end we seem to care only about the sha1 and the path
> name.

I'm starting to think more seriously about pack v4 again, where each 
path components are indexed in a table.  Because most tree objects are 
different revisions of the same path, this could represent a significant 
saving in memory as well.

> And in the upload-pack case, there's also pack-objects running
> concurrently, already going up to 950M RSS/100M shared _while_ the
> rev-list is still running. So that's 3G of memory usage (2G if you
> ignore the shared stuff) before the "Compressing objects" part even
> starts. And of course, pack-objects will apparently start to mmap the
> pack files only after the rev-list finished, so a "smart" OS might have
> removed a lot of the mmapped stuff from memory again, causing it to be
> re-read. :-/

The first low hanging fruit to help this case is to make upload-pack use 
the --revs argument with pack-object to let it do the object enumeration 
itself directly, instead of relying on the rev-list output through a 
pipe.  This is what 'git repack' does already.  pack-objects has to 
access the pack anyway, so this would eliminate an extra access from a 
different process.


Nicolas

--Boundary_(ID_f5jWnSkaiQQ26Vn9J+/mew)--
