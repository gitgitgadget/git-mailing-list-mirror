From: Jonathan Nieder <jrnieder@gmail.com>
Subject: unable to resolve reference refs/tags/v3.1-rc8: Success (Re: git
 problem)
Date: Sun, 2 Oct 2011 22:59:07 -0500
Message-ID: <20111003035907.GA17134@elie>
References: <4E892483.7070605@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 03 05:59:40 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RAZgo-0004HR-KL
	for glk-linux-kernel-3@lo.gmane.org; Mon, 03 Oct 2011 05:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1JCD73 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 2 Oct 2011 23:59:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab1JCD7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2011 23:59:21 -0400
Received: by iaqq3 with SMTP id q3so4549918iaq.19
        for <multiple recipients>; Sun, 02 Oct 2011 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XQuOhPWAHwPch8mFDih03sldBP1oCZdLGdFwfOD//UA=;
        b=aJyqt5jHJaoHJGXn/nuEwfzhK1j/Z5HynzXQaIJKzDPni/dI2UFDIyADqJhuzh4fdY
         gyDhHRD6OwkJ7IaSbfGp8b+0Uuz9Zyvrsqzf5TNzEbi8PeuGOvOdaaOSjdYzDhL0v7Vh
         RZVVebJhM8yb4xXh13N9lsglFOsUtltM4WFy8=
Received: by 10.42.174.9 with SMTP id t9mr3592997icz.100.1317614360419;
        Sun, 02 Oct 2011 20:59:20 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id by18sm26471256ibb.1.2011.10.02.20.59.19
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 20:59:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E892483.7070605@lwfinger.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182618>

Hi,

Larry Finger wrote:

> I had my system freeze when doing a pull from Linus's repo. Since then,
> every pull results in the following errors:
>
> ~> git pull
> error: unable to resolve reference refs/tags/v3.1-rc8: Success
> From git://github.com/torvalds/linux
>  ! [new tag]         v3.1-rc8   -> v3.1-rc8  (unable to update local ref)

Could you try pulling again with
"/path/to/git/sources/bin-wrappers/git pull" after applying this
patch?

Thanks,

diff --git i/refs.c w/refs.c
index a615043b..b15f78a4 100644
--- i/refs.c
+++ w/refs.c
@@ -493,12 +493,15 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		char *buf;
 		int fd;
 
-		if (--depth < 0)
+		if (--depth < 0) {
+			errno = ELOOP;
 			return NULL;
+		}
 
 		git_snpath(path, sizeof(path), "%s", ref);
 		/* Special case: non-existing file. */
 		if (lstat(path, &st) < 0) {
+			int saved_errno = errno;
 			struct ref_list *list = get_packed_refs(NULL);
 			while (list) {
 				if (!strcmp(ref, list->name)) {
@@ -509,6 +512,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 				}
 				list = list->next;
 			}
+			errno = saved_errno;
 			if (reading || errno != ENOENT)
 				return NULL;
 			hashclr(sha1);
@@ -562,7 +566,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			*flag |= REF_ISSYMREF;
 	}
 	if (len < 40 || get_sha1_hex(buffer, sha1))
-		return NULL;
+		die("ref %s is corrupt: length=%d, content=%.*s", ref,
+		    (int) len, (int) len, buffer);
 	return ref;
 }
 
