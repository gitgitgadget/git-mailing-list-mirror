From: Johan Herland <johan@herland.net>
Subject: [PATCH] Move check for already parsed tag object to parse_tag_buffer()
 wrapper function
Date: Sun, 10 Jun 2007 02:45:22 +0200
Message-ID: <200706100245.22292.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090214.39337.johan@herland.net>
 <7vlketf1m6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBYe-0007eH-Rl
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXFJAp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXFJAp0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:45:26 -0400
Received: from smtp.getmail.no ([84.208.20.33]:60604 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbXFJApZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:45:25 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00305A3OFM00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:45:24 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00JTFA3MII60@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:45:22 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE009ZHA3MPEB0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:45:22 +0200 (CEST)
In-reply-to: <7vlketf1m6.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49647>

This effectively disables the check when creating and fscking tag objects,
which is desirable because we don't want the fact that the object is
already parsed to stop us from verifying thoroughly.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Saturday 09 June 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > diff --git a/tag.c b/tag.c
> > index 19c66cd..b134967 100644
> > --- a/tag.c
> > +++ b/tag.c
> > @@ -46,9 +46,11 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
> >  	const char *type_line, *tag_line, *tagger_line;
> >  	unsigned long type_len, tag_len;
> >  
> > -	if (item->object.parsed)
> > -		return 0;
> > -	item->object.parsed = 1;
> > +	if (item) {
> > +		if (item->object.parsed)
> > +			return 0;
> > +		item->object.parsed = 1;
> > +	}
>
> Passing both item and data does not feel right.  If you are
> trying to make the factored out function to do the verification
> of data, then perhaps the caller should do the "don't handle the
> same data twice" optimization using item?

You mean, like this?


...Johan

 tag.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tag.c b/tag.c
index 2b92465..4e79943 100644
--- a/tag.c
+++ b/tag.c
@@ -75,12 +75,6 @@ int parse_and_verify_tag_buffer(struct tag *item,
 	unsigned long type_len,   tag_len,   keywords_len,   tagger_len;
 	const char *header_end;
 
-	if (item) {
-		if (item->object.parsed)
-			return 0;
-		item->object.parsed = 1;
-	}
-
 	if (size < 65)
 		return FAIL("Tag object failed preliminary size check");
 
@@ -264,6 +258,10 @@ int parse_and_verify_tag_buffer(struct tag *item,
 
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
+
 	return parse_and_verify_tag_buffer(item, (const char *) data, size, 0);
 }
 
-- 
1.5.2.1.144.gabc40
