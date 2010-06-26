From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 7/8] bundle: Keep names of basis refs after discovery
Date: Sat, 26 Jun 2010 01:29:18 -0500
Message-ID: <20100626062918.GH15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOtW-0000yK-E9
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0FZG3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:29:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63305 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZG3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:29:30 -0400
Received: by iwn41 with SMTP id 41so2715179iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xoB2KhT/ZLKFX0eYkk+LOm9VJq4bTm/JS5y9yE2RtFs=;
        b=D6mkefXCTCtmdVh4m7m/iGV2/Xy8SlEMwjhc2fN9RjrEo4pXku+zQcBdwEBEG+57Mp
         knOr0eh8YZEzhMSleENgi/YpHcT7mSqUr3IVUxkKyycFxP3RqCnGPf1wII1cAqndxwq1
         Uyo/K0c3L5QncYTG34X+rv5uLgNx6jOlKD9fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MUtfAgElBeVwjvvQ7kyZbgTTvpSdGVtIYI0AbZpW7hYhGMfcSSzvn8rb8G3Fb+eMiA
         yfmo5vLZ7FDWynJsck9Q0Ln0Y22EEdbb98W7Dnnf4o0T2y+HoNv5P9gqyog92xsShcqh
         lNNo8gBhx+hAJDrd6T207/PiogwyI/1zMcR0w=
Received: by 10.231.166.132 with SMTP id m4mr1839325iby.27.1277533770464;
        Fri, 25 Jun 2010 23:29:30 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id cw14sm4012170ibb.7.2010.06.25.23.29.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:29:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149735>

Without this change, attempts to examine revs->pending.objects[i].name
when debugging produce random giberish.  On the other hand, it
introduces a small per-basis-ref memory leak.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
For illustration.

 bundle.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 311c554..7aff369 100644
--- a/bundle.c
+++ b/bundle.c
@@ -226,8 +226,7 @@ static void list_prerequisite(int bundle_fd, struct object_array *pending,
 	write_or_die(bundle_fd, buf.buf, buf.len);
 
 	rev->object.flags |= UNINTERESTING;
-	add_object_array(&rev->object, buf.buf, pending);
-	strbuf_release(&buf);
+	add_object_array(&rev->object, strbuf_detach(&buf, NULL), pending);
 }
 
 static int list_prerequisites(int bundle_fd, struct rev_info *revs,
-- 
1.7.1.198.g8d802
