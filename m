From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 08 Jun 2011 11:29:48 -0500
Message-ID: <mHQrb8DBZuqQY8Hc3UzxeMQ_IVnTRI-lDtGLq4eawjiPycP6aZDRrQ@cipher.nrlssc.navy.mil>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>	 <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com> <1307548930.19438.30.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, geoffrey.russell@gmail.com,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:30:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULe2-0007bw-CA
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1FHQaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 12:30:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43091 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1FHQaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:30:08 -0400
Received: by mail.nrlssc.navy.mil id p58GTmmS017899; Wed, 8 Jun 2011 11:29:48 -0500
In-Reply-To: <1307548930.19438.30.camel@drew-northup.unet.maine.edu>
X-OriginalArrivalTime: 08 Jun 2011 16:29:48.0646 (UTC) FILETIME=[48DD7860:01CC25F9]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175395>

On 06/08/2011 11:02 AM, Drew Northup wrote:
> 
> On Tue, 2011-06-07 at 21:48 -0400, Peter Harris wrote:
>> On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
>>>
>>> As of today, almost every time I do a git command, gc is getting
>>> invoked.
> <re-added>
>>>   I have packSizeLimit set to 30M 
> </re-added>
>>>   There are 96 pack files.
>>
>> That's why. See gc.autopacklimit in "git help config" -- by default,
>> git will gc if there are more than 50 pack files.
> 
> Do we want to consider ignoring (or automatically doubling, or something
> like that) gc.autopacklimit if that number of packs meet or exceed
> gc.packSizeLimit? I have no idea what the patch for this might look
> like, but it seems to make more sense than this situation.
> 
> Just a random brain fart...
> 

Or just ignore the packs that exceed pack.packSizeLimit...

diff --git a/builtin/gc.c b/builtin/gc.c
index ff5f73b..7be14ab 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -26,6 +26,7 @@ static int pack_refs = 1;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
+static off_t pack_size_limit;
 static const char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
@@ -64,6 +65,10 @@ static int gc_config(const char *var, const char *value, void *cb)
 		}
 		return git_config_string(&prune_expire, var, value);
 	}
+	if (!strcmp(var, "pack.packsizelimit")) {
+		pack_size_limit = git_config_ulong(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -135,10 +140,8 @@ static int too_many_packs(void)
 			continue;
 		if (p->pack_keep)
 			continue;
-		/*
-		 * Perhaps check the size of the pack and count only
-		 * very small ones here?
-		 */
+		if (pack_size_limit && p->pack_size >= pack_size_limit)
+			continue;
 		cnt++;
 	}
 	return gc_auto_pack_limit <= cnt;
