From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] remote-curl: sanity check ref advertisement from
 server
Date: Sun, 17 Feb 2013 17:41:13 -0800
Message-ID: <20130218014113.GC3221@elie.Belkin>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 02:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Fjj-0000gu-IL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 02:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab3BRBlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 20:41:19 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:54343 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030Ab3BRBlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 20:41:19 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so2259804dak.34
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WzcmzNd/p8oTCDxbSU+dC766htKIyxQr+n4AGnHtI9s=;
        b=IDfXAoKlXmQmMROTEC6YnvcxgTADH7EOTIsPW7/RfTEYG9gLzzeAGbQedu8WVHyz1S
         jUI9WE4jEK4+0PBw1hk+V9uxH9u5VK1z2SGP9hLPl54iogsRKrJSmF9+UL0zShyyWN97
         l2awbfpmpsJKMjgHCD492YNF3XKnxTqoaks57RN5GTgS2kW5fyCbzYM8H+OMxHdEu365
         cPjI9LGO3EtKYwjzNeAv0Q+T4VHBDIPwANKDBavVTHmpEKToCtGjJfLjEuwqMZClWX1Z
         oWlDH3LPeoW/L9Bnkv1BRrYdhvS2+HVgSIyfqtMDnce9ouhknWZrko2u/coEZSDJrIK/
         Ke9Q==
X-Received: by 10.68.244.1 with SMTP id xc1mr25213905pbc.165.1361151678621;
        Sun, 17 Feb 2013 17:41:18 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hs8sm12627624pbc.27.2013.02.17.17.41.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 17:41:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130217192830.GB25096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216426>

Jeff King wrote:
> On Sun, Feb 17, 2013 at 03:05:34AM -0800, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> +		if (verify_ref_advertisement(last->buf, last->len) < 0)
>>> +			die("ref advertisement is invalid at %s", refs_url);
>>
>> Won't this error out with
>>
>> 	protocol error: bad line length character: ERR
>>
>> instead of the current more helpful behavior for ERR lines?
>
> I don't think so. Don't ERR lines appear inside their own packets?

Yes, I misread get_remote_heads for some reason.  Thanks for checking.

[...]
> The one thing we do also check, though, is that we end with a flush
> packet. So depending on what servers produce, it may mean we trigger
> this complaint instead of passing the ERR along to fetch-pack.
>
> Rather than doing this fake syntactic verification, I wonder if we
> should simply call get_remote_heads, which does a more thorough check

I'm not sure whether servers are expected to send a flush after an
ERR packet.  The only codepath I know of in git itself that sends
such packets is git-daemon, which does not flush after the error (but
is not used in the stateless-rpc case).  http-backend uses HTTP error
codes for its errors.

If I am reading get_remote_heads correctly, calling it with the
following tweak should work ok.  The extra thread is just to feed a
string into a fd-based interface and could be avoided for "list", too,
if it costs too much.

diff --git i/connect.c w/connect.c
index 49e56ba3..55ee7de7 100644
--- i/connect.c
+++ w/connect.c
@@ -68,7 +68,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 {
 	int got_at_least_one_head = 0;
 
-	*list = NULL;
+	if (list)
+		*list = NULL;
 	for (;;) {
 		struct ref *ref;
 		unsigned char old_sha1[20];
@@ -92,6 +93,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name = buffer + 41;
 
+		if (!list)
+			continue;
+
 		name_len = strlen(name);
 		if (len != name_len + 41) {
 			free(server_capabilities);
