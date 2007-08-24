From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 01:22:51 -0600
Message-ID: <1187940171.6357.59.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTUw-000501-1A
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXHXHWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbXHXHWK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:22:10 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3152 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbXHXHWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:22:07 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 01:21:55 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [134.253.112.50] (sacv8030ay.sandia.gov [134.253.112.50])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7O7LsNX003648;
 Fri, 24 Aug 2007 01:21:54 -0600
In-Reply-To: <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.23.235223
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_MEDIA_BODY 0,
 __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824072155; SEV=2.2.2; DFV=B2007082407;
 IFV=2.0.4,4.0-9; AIF=B2007082407; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364345383731332E303041443A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082407_5.02.0125_4.0-9
X-WSS-ID: 6AD058992E0208084-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56556>

On Thu, 2007-08-23 at 15:08 -0700, Junio C Hamano wrote: 
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > Looking at the index struct, it already has fields in it for file mode
> > uid and gid (woohoo!).
> 
> I can see that storing textual names in gitattributes and having
> the root user run git so that it can chown(), would work.
> 
> But this is only about checkout.  After you chown a file in the
> work tree and run update-index, next write-tree would not record
> it, as there is no place in tree objects to record uid/gid.
> You would need to arrange so that a matching change is made in
> the gitattributes file if you go that route.

That's ok.  Any place to store the data is fine by me.  I'm just
concerned about some comments I saw in attrs.c <line13>:
/*
The basic design decision here is that we are not going to have insanely
large number of attributes.
This is a randomly chosen prime.
*/
#define HASHSIZE 257

Using a brute force perm/ownership attribute set for every file,
assuming a modestly populated linux distribution image having upwards of
150,000 files/directories in it, thats sticking over 100,000 attributes
into some .gitattributes file somewhere.  Do you think the gitattributes
system can handle this kind of abuse?

> If you had:
> 
> 	etc/*		owner=root
>         etc/frotz	owner=nobody
> 
> in gitattributes, and you did a checkout.  You chown etc/nitfol
> with "chown printer etc/nitfol".  Somebody needs to add a line
> 
> 	etc/nitfol	owner=printer
> 
> to gitattributes before you make the commit.

Unless this 'somebody' is an automated process that will never fly. I
want git to do it for me when the right config/attr is set (maybe at
update_index time).  Thats where my concern about the gitattributes
system comes from.  What's going to happen when I stick 150,000 (est)
attributes in there?

> Maybe the chown
> was not about etc/nitfol but about making etc/frotz owned by
> root.  Then you would, instead of adding the etc/nitfol line,
> remove existing etc/frotz line so that earlier glob would
> capture and express the idea of making everything owned by
> root.  I suspect this would get rather tricky quickly.

Maybe doable though.  Starting from the root of the tree, traverse
downwards and only add new attributes when a file or dir's ownership
has changed from the parent, maybe.  This could optimize away many of
the attributes needed.  I think a good place might be right in
index_path() because the lstat data is fresh and accessible.  Writing
attrs out to file if necessary should hopefully not add too much overhead.

-JE
