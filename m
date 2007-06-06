From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 06 Jun 2007 10:06:32 +0200
Message-ID: <200706061006.33139.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040951.06620.johan@herland.net>
 <7vtztl7dqi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqXd-0005i5-VY
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXFFIGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbXFFIGu
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:06:50 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34164 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXFFIGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:06:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ700A0LFV6QZ00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 06 Jun 2007 10:06:43 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ700NNNFUX3Z30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 06 Jun 2007 10:06:33 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ70039BFUXEV20@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 06 Jun 2007 10:06:33 +0200 (CEST)
In-reply-to: <7vtztl7dqi.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49259>

Teach git-fsck to do the same kind of verification on tag objects that is
already done by git-mktag.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 06 June 2007, Junio C Hamano wrote:
> The tagger field was introduced mid July 2005; any repository
> with a tag object older than that would now get non-zero exit
> from fsck.
> 
> This won't practically be problem in newer repositories, but it
> is somewhat annoying.  Perhaps do this only under the new -v
> option to git-fsck, say "warning" not "error", and not exit with
> non-zero because of this?

Like this?

Or would you rather switch around the "verbose" and the
"parse_and_verify_tag_buffer()" (i.e. not even attempt the thorough
verification unless in verbose mode)?


Have fun!

...Johan

 builtin-fsck.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index bacae5d..fb9a8bb 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -359,11 +359,24 @@ static int fsck_commit(struct commit *commit)
 static int fsck_tag(struct tag *tag)
 {
 	struct object *tagged = tag->tagged;
+	enum object_type type;
+	unsigned long size;
+	char *data = (char *) read_sha1_file(tag->object.sha1, &type, &size);
 
 	if (verbose)
 		fprintf(stderr, "Checking tag %s\n",
 			sha1_to_hex(tag->object.sha1));
 
+	if (!data)
+		return objerror(&tag->object, "could not read tag");
+	if (type != OBJ_TAG) {
+		free(data);
+		return objerror(&tag->object, "not a tag (internal error)");
+	}
+	if (parse_and_verify_tag_buffer(0, data, size, 1) && verbose)
+		objwarning(&tag->object, "failed thorough tag object verification");
+	free(data);
+
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
 	}
-- 
1.5.2



-- 
Johan Herland, <johan@herland.net>
www.herland.net
