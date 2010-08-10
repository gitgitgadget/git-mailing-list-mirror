From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 1/3] core: Stop leaking ondisk_cache_entrys
Date: Mon, 9 Aug 2010 22:28:07 -0500
Message-ID: <20100810032807.GB2386@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 05:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OifX7-0008Qp-9g
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 05:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab0HJD3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 23:29:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44009 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0HJD3k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 23:29:40 -0400
Received: by gwb20 with SMTP id 20so3592555gwb.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/ihwdN7WDZ7J1ryG2G7VKzF+U4TtUapVTecAdq6hMHc=;
        b=lyVNnS8cB1kagDgWdHv9Ktn5CYKxciIyKC3nh3ZNENtholQdSwgavR1ate5vTdCuv2
         t1zG4T4k8TC1UTi4QoTiDiUmx+DlEsT2fkDoLuPJFwu5uIbIn7oGdqQViNQGDWHN1v0M
         AwvMr6QhxMPsE3VadzMcl5dHakp+aMB0taq7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d/NpxeoVzMkFSq47RXhWfBzl7vCSeUkj0/ViV+nLpUWcBh/RqC7lK/tvAK+NLqL3Qb
         Ahf1l5DUPCuAxfmjO7kQGBEOYxoicgHPJJh/F6GUPn/Rw5YOM/tku+RYfFJe4COq0Hx3
         eVf1Ou4btrVwJmiqGyRvdMZ3EvJQzJJNJ4Pj4=
Received: by 10.150.236.18 with SMTP id j18mr18699956ybh.295.1281410974912;
        Mon, 09 Aug 2010 20:29:34 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id u19sm1692904ybf.19.2010.08.09.20.29.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 20:29:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810032647.GA2386@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153073>

Noticed with valgrind.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 read-cache.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1f789b..1f42473 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1516,6 +1516,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 	int size = ondisk_ce_size(ce);
 	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
 	char *name;
+	int result;
 
 	ondisk->ctime.sec = htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec = htonl(ce->ce_mtime.sec);
@@ -1539,7 +1540,9 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 		name = ondisk->name;
 	memcpy(name, ce->name, ce_namelen(ce));
 
-	return ce_write(c, fd, ondisk, size);
+	result = ce_write(c, fd, ondisk, size);
+	free(ondisk);
+	return result;
 }
 
 int write_index(struct index_state *istate, int newfd)
-- 
1.7.2.1.544
