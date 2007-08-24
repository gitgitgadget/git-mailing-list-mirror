From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 12:56:43 -0600
Message-ID: <1187981803.6357.173.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
 <86mywhfk17.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
 <1187979317.6357.155.camel@beauty>
 <alpine.LFD.0.999.0708241119140.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOeK5-0000JT-Qd
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759776AbXHXSzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759759AbXHXSzy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:55:54 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:1793 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831AbXHXSzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 14:55:53 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 12:55:44 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [134.253.112.134] (sacv8030ee.sandia.gov
 [134.253.112.134]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l7OIthCH009616; Fri, 24 Aug 2007 12:55:43 -0600
In-Reply-To: <alpine.LFD.0.999.0708241119140.25853@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.112423
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824185545; SEV=2.2.2; DFV=B2007082416;
 IFV=2.0.4,4.0-9; AIF=B2007082416; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364346323942302E303043313A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082416_5.02.0125_4.0-9
X-WSS-ID: 6AD1F63A3HO264419-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56591>

On Fri, 2007-08-24 at 11:23 -0700, Linus Torvalds wrote:
> 
> On Fri, 24 Aug 2007, Josh England wrote:
> > 
> > Do you think its OK to cache this stuff in the index, though?
> > write-tree could then just dump the perms/ownership out as gitattributes
> > somewhere.
> 
> I'd really prefer not.
> 
> The index state - very much by design - matches the filesystem "stat" 
> data, not the internal git data. So "ce_size" matches the checked-out 
> size, not the native git data size (ie with CRLF conversion, it matches 
> not the checked-in data, but the filesystem version). 

That's exactly what I'm after, too: having a snapshot of all lstat data
in the index, because I don't want to have to do an extra stat
somewhere.

> And the same really goes for ce_uid/ce_gid: they have to match what's on 
> the filesystem, because they are used not to track user information, but 
> to verify that the inode data is valid!

But the stat data (even uid/gid) is in there nonetheless, right?  If
everything is in there already I wouldn't need to add a thing.  I just
want to access the index cache rather than hitting the filesystem
directly.

> Yeah, we could just ignore them for checking "is the inode the same", but 
> that would actually end up *defeating* the point of what you want to do: 
> at that point, we'd also obviously ignore it when ownership changes!

If we view the index as being a snapshot of the filesystem, and if
perm/ownership data is stored as .gitattributes in the actual repo, 
then the perm/ownership engine just has to reconcile between the index
and the .gitattributes file for both the read and write case.
Differences in the write case would result in the .gitattributes being
updated.  Differences in the read case would result in chown/chmod being
run in the working tree.  Does this make sense?

-JE
