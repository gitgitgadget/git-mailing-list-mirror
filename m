From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 13 Oct 2010 17:50:12 -0500
Message-ID: <20101013225012.GB9509@burratino>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
 <20100929214107.GA4485@capella.cs.uchicago.edu>
 <7v4ocpncli.fsf@alter.siamese.dyndns.org>
 <7vvd55lwjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@ksplice.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:53:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ACc-0006kw-CK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0JMWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:53:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48009 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab0JMWxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:53:36 -0400
Received: by qyk2 with SMTP id 2so1421852qyk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SXlzEXYvXJC0eYHHLIjeA6NFOqieD1bMpWXxrVTVll4=;
        b=M+YSXiUAImaAjv2JtagEMt/3osSfalwIF9oAo04q37bX4xPgkUOadWRbd2OMAGcjEa
         JUzlEFBm3nUq56DlkXDNV61ij4UBEuVPtJ+ekWAzCmKvz41cmYvpO2UrFZqkldNWP2aw
         opdHfETWgzypSHJwAiuuEULTFp0D+Jtm5JwFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tvKxWDYI8Ak2p6/YPmyfqq1ryzAo6vue/Jn40t+EC1I//Kg49FSfiR4oUxECYCLJ6y
         Ija4C8Ww9TT3SpWWGccMqoZQ5j2xFe8LvmgV07GKOlqruhMjVu1H1X/gkgs1ZEwJoaw9
         o7FnZWORnmHPy7Poo6Due+MJnkkABvooQO3r4=
Received: by 10.224.182.194 with SMTP id cd2mr7401308qab.48.1287010415505;
        Wed, 13 Oct 2010 15:53:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t17sm7042892qcp.14.2010.10.13.15.53.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:53:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvd55lwjl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159000>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Neither the patch nor your suggestion makes much sense to me.  With the
>> patch, the regexp is now
>>
>>     ^(1969-12-31|1970-01-01) <time>(\.0+)? ([-+][0-2][0-9]):?([0-5][0-9])
[...]
> Well, I was missing that without ':' strtol() goes through to parse $3$4
> as a single integer

So maybe something like the following would make this easier to follow.

diff --git a/builtin/apply.c b/builtin/apply.c
index 0fa9a8d..000d3e5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -733,8 +733,8 @@ static int has_epoch_timestamp(const char *nameline)
 		" "
 		"[0-2][0-9]:[0-5][0-9]:00(\\.0+)?"
 		" "
-		"([-+][0-2][0-9]):?([0-5][0-9])\n";
+		"([-+][0-2][0-9]:?[0-5][0-9])\n";
-	const char *timestamp = NULL, *cp;
+	const char *timestamp = NULL, *cp, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
 	int zoneoffset;
@@ -764,10 +764,11 @@ static int has_epoch_timestamp(const char *nameline)
 		return 0;
 	}
 
-	zoneoffset = strtol(timestamp + m[3].rm_so + 1, NULL, 10);
+	zoneoffset = strtol(timestamp + m[3].rm_so + 1, (char **) &colon, 10);
-	if (m[4].rm_so == m[3].rm_so + 3)
-		zoneoffset /= 100;
-	zoneoffset = zoneoffset * 60 + strtol(timestamp + m[4].rm_so, NULL, 10);
+	if (*colon == ':')
+		zoneoffset = zoneoffset * 60 + strtol(colon + 1, NULL, 10);
+	else
+		zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
 	if (timestamp[m[3].rm_so] == '-')
 		zoneoffset = -zoneoffset;
 
