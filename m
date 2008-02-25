From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 03:04:45 -0500
Message-ID: <20080225080445.GM8410@spearce.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at> <7vwsotmqq2.fsf@gitster.siamese.dyndns.org> <20080225075242.GD15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYLS-0002ZJ-OW
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYBYIFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbYBYIFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:05:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51118 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYBYIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:05:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTYKM-0006BW-PU; Mon, 25 Feb 2008 03:04:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4781D20FBAE; Mon, 25 Feb 2008 03:04:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080225075242.GD15761@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75006>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> 
> What about
> #define OBJ_BAD -2

All of the other OBJ_* constants are declared in the enum
object_type, not as #defines.

See below for why this should not be <0.
 
> > After all, if the walker callback was told with
> > OBJ_ANY that any type of object is Ok, it should still say
> > "oops" if the given object said it actually is of type OBJ_BAD.
> > E.g. in your [2/4] patch:
> > 
> >         +static int mark_object(struct object *obj, int type, void *data)
> >         +{
> >         + ...
> >         +	if (type != OBJ_ANY && obj->type != type) {
> >         +		objerror(parent, "wrong object type in link");
> >         +	}
> > 
> > if you use the above #define, a tagged object that has a bad
> > type will pass this check unnoticed, won't it?
> 
> No, it wouldn't, as object->type is never initialized to OBJ_BAD:
> $ grep "OBJ_BAD" *.c *.h
> cache.h:        OBJ_BAD = -1,

Today that may be true.  OBJ_BAD was created for cases where the
internal object header parsing code in say sha1_file.c finds a type
code it doesn't recognize and wants to return it back to the caller.
This grew out of some of the early pack v4 work.

It actually happens today when a function that returns an object
type enum returns failure.  sha1_object_info() is one such function.
It returns "int" but that int is also really an enum object_type.
When that function fails it returns -1, which has it happens
is OBJ_BAD.

Subtle, yes.  But OBJ_BAD has meaning and is in use today.  Please do
not use it for "we don't care what it is".

-- 
Shawn.
