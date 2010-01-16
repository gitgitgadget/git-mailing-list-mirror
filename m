From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 23:30:43 +0800
Message-ID: <20100116233043.26a5636d.rctay89@gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100116203557.95340c00.rctay89@gmail.com>
	<20100116134656.GA4504@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 16:33:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWAeL-0006Zv-LK
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 16:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab0APPa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120Ab0APPa4
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 10:30:56 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49390 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab0APPaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 10:30:55 -0500
Received: by ywh6 with SMTP id 6so1330421ywh.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=47hUg6/UW7kNCz2APfxwGo9mTU6G+AXVaKnGriRzDoI=;
        b=ZBG9kCZU3tWcy+avpU7aNLU8/yvwYcBmTGMCr6RpVlsvX8TsYqBSOnBaojnWe45qG/
         2IuYbv2JsPnC+5b7XzASxtlzmJ4I09/AFjdmYNGFnfQaXqg2E1Tmxw4x9AaPL8vYi0mq
         uX4hHySq1FZWmVkj85Y2ikGqOLk889o5uGkdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=coNJC9G5l1cRA3p22VSU8gh8GKkegzh1Osn4GqhSWX/QHOGqI/j1aN0UHOrbvVFYSf
         yHTDxeW36gra8QMiU6nPysAskcFYe2TL9VDxoW06qJoHubEzHURA2A74IKqCZCHcyeaQ
         JKQQeh7iCstLrLdrTfTN1KTOS5qaRucOGpyQs=
Received: by 10.90.242.14 with SMTP id p14mr3578114agh.98.1263655854701;
        Sat, 16 Jan 2010 07:30:54 -0800 (PST)
Received: from your-cukc5e3z5n (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 13sm1626865gxk.13.2010.01.16.07.30.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 07:30:53 -0800 (PST)
In-Reply-To: <20100116134656.GA4504@Knoppix>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137231>

Hi,

On Sat, 16 Jan 2010 15:46:57 +0200
Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:

> > Regarding the checking of ref->status here:
> > 
> > Is it possible to delegate this to push_had_errors(remote_refs)
> > instead? We skip setting up upstream tracking when there are errors
> > from pushing, so we don't have to check ref->status anymore.
> 
> No. As documetnation says, the update or no update is done on per-branch
> basis.
> 
> <snip patch>

I see. If that's the case, could you also allow setting up upstream
tracking when ref->status is 'none' and not consider it errorneous?

After all, push_had_errors() does not consider 'none' errorneous.

I think a switch block might be neater too.

@@ -149,9 +149,15 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
		 * Check suitability for tracking. Must be successful /
		 * already up-to-date ref create/modify (not delete).
		 */
-		if (ref->status != REF_STATUS_OK &&
-			ref->status != REF_STATUS_UPTODATE)
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+		case REF_STATUS_OK:
+			; /* no-op */
+		default:
			continue;
+		}
		if (!ref->peer_ref)
			continue;
		if (!ref->new_sha1 || is_null_sha1(ref->new_sha1))


-- 
Cheers,
Ray Chuan
