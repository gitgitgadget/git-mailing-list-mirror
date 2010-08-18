From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace commits at parsing time
Date: Wed, 18 Aug 2010 06:07:54 +0200
Message-ID: <201008180607.54675.chriscool@tuxfamily.org>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org> <7vbp91aqfk.fsf@alter.siamese.dyndns.org> <AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 06:08:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlZwh-0002Hm-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 06:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754Ab0HREIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 00:08:06 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51832 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab0HREIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 00:08:05 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D72E7818034;
	Wed, 18 Aug 2010 06:07:56 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153809>

On Wednesday 18 August 2010 05:17:52 Nguyen Thai Ngoc Duy wrote:
> On Wed, Aug 18, 2010 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >> The function parse_commit() is not safe regarding replaced commits
> >> because it uses the buffer of the replacement commit but the object
> >> part of the commit struct stay the same. Especially the sha1 is not
> >> changed so it doesn't match the content of the commit.
> > 
> > This all sounds backwards to me, if I am reading the discussion
> > correctly.
> > 
> > If a replace record says commit 0123 is replaced by commit 4567 (iow,
> > 0123 was a mistake, and pretend that its content is what is recorded in
> > 4567), and when we are honoring the replace records (iow, we are not
> > fsck), shouldn't read_sha1("0123") give us a piece of memory that stores
> > what is recorded in 4567, parse_object("0123") return a struct commit
> > whose buffer points at a block of memory that has what is recorded in
> > 4567 _while_ its object.sha1[] say "0 123"?
> 
> 1. parse_object() as it is now would return object.sha1[] = "4567".
> 2. lookup_commit(), then parse_commit() would return object.sha1[] =
> "0123".
> 
> > What problem are you trying to solve?
> 
> Inconsistency in replacing objects. I have no comments whether #1 or
> #2 is expected behavior. But at least it should stick to one behavior
> only.

We discussed this inconsistency in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/152321/ 

So we can resolve the inconsistency with Duy's patch to make parse_object() 
return object.sha1[] = "0123".

It's simpler and probably safer. The downside is that the sha1 will not be 
consistent with the content anymore and that it will be more difficult to 
realize that an object has been replaced as there will be no sha1 change to be 
seen.

Best regards,
Christian.
