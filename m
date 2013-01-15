From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git grep performance regression
Date: Tue, 15 Jan 2013 11:38:32 +0700
Message-ID: <CACsJy8AnABCisgSVL7Qh_-uejAJA3x1kzy=4i+uXm3+90m5tuA@mail.gmail.com>
References: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk> <CACsJy8A7FLYqdY2Mt5pUq0nH3N8mbZ4crkYJYFfepp19c0aWhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 05:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuyJ4-0001mP-5O
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 05:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab3AOEjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 23:39:05 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52204 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3AOEjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 23:39:04 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so4839730oag.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 20:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6Rpj1SMb75tX0YpzIA95GC2rMcM6NRUrraHxdgjnSHU=;
        b=hUOS2seybuMloF0b8HcTGxAaFDwX/lKXjwn3kRW3srXrhtBK1tSK6l/nx8ia+y1uiC
         nbyHsjyKHEGh2vOX0QEgbk+CNkQYRa03LhG4NHBUseW3zTxu9vO6aSF3xWBM9G3FA9Dz
         KZRchsaUOPU6D1ICgN9Cv2K/86lrfvUGy66afTh4pHd7x1vjEp8VYzeFg9RXjFadAqkL
         BWAPYTDu6E5Iv9J7Mei/p0LW07AISIuusLKtLC9z7SUbwo3IIPSCqjF/jbZP/tYE8feH
         XcKNrYv6XASqbPRT7Biv9GnzsxbYD0rE14VB98rFKKOEkBJsgqOilT6U0/1pKfiG2aVw
         PqRg==
Received: by 10.60.22.164 with SMTP id e4mr53715755oef.87.1358224743141; Mon,
 14 Jan 2013 20:39:03 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 14 Jan 2013 20:38:32 -0800 (PST)
In-Reply-To: <CACsJy8A7FLYqdY2Mt5pUq0nH3N8mbZ4crkYJYFfepp19c0aWhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213573>

On Tue, Jan 15, 2013 at 9:46 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I don't have time to look into details now, but by enabling
> DEBUG_ATTR, it looks like this commit makes it push and pop patterns a
> lot more than without the commit.

I think the culprit is at this chunk:

 static void prepare_attr_stack(const char *path)
 {
        struct attr_stack *elem, *info;
        int dirlen, len;
        const char *cp;

-       cp = strrchr(path, '/');
-       if (!cp)
-               dirlen = 0;
-       else
-               dirlen = cp - path;
+       dirlen = find_basename(path) - path;

dirlen is not expected to include the trailing slash, but
find_basename() does that. It messes up with the path filters for
push/pop in the next code. This brings grep performance closely back
to before for me. Ross, can you check (patch could be whitespace
damaged by gmail)?

-- 8< --
diff --git a/attr.c b/attr.c
index b05110d..1e96e26 100644
--- a/attr.c
+++ b/attr.c
@@ -583,6 +583,9 @@ static void prepare_attr_stack(const char *path)

        dirlen = find_basename(path) - path;

+       if (dirlen)
+               dirlen--;
+
        /*
         * At the bottom of the attribute stack is the built-in
         * set of attribute definitions, followed by the contents
-- 8< --
