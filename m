From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v5 5/5] setup: Don't dereference in-tree symlinks for
 absolute paths
Date: Mon, 3 Feb 2014 14:17:00 +0100
Message-ID: <20140203131700.GA15607@mule>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-6-git-send-email-martinerikwerner@gmail.com>
 <CACsJy8DX8bh2cAx+a_cJafAOYB7Ly=y28jAGo1L8NEmkWaZv=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 14:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAJOo-0003FO-FI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 14:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbaBCNRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 08:17:08 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39991 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaBCNRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 08:17:07 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so5314720lbd.37
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H55NVRRBCq4xyHO2x6Nv+XRlf9xU6HZWVRkbRXOXF/o=;
        b=JSlvS2d9s1X+vQj6KOeBFarYd357FIGnsdAHSXbuk7CBqATB3Jw5eUUKU0SluQ1Gd+
         DQH9QyriYC4pXwAEVWOPJyx1RVEPa9gMKlO3HSnD9ZlfLr6bJ7PVUr7rak4k6bv3j9QM
         dnJJFKf7u303t8jIjXzVt+LtJtMkGmShlBERsT1LiqIFiI1p8adeEb50zwfmsKmpk6yr
         7jPKNFDfb449MF2uGYGa38r6Ow/eUw0aE4YvzD7vg7SXMBRylDN/PTR/CXV+BGmC5/J/
         YKR/Oa+brS2U6dRxPOuPmukv4Fp8oKTKVtu7XCNgljIwMo0QuwpO/2S1+TG224mdlUZ7
         Bckg==
X-Received: by 10.112.135.9 with SMTP id po9mr23936395lbb.8.1391433424275;
        Mon, 03 Feb 2014 05:17:04 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id mo3sm21389898lbb.17.2014.02.03.05.17.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:17:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8DX8bh2cAx+a_cJafAOYB7Ly=y28jAGo1L8NEmkWaZv=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241435>

On Mon, Feb 03, 2014 at 11:15:57AM +0700, Duy Nguyen wrote:
> On Sun, Feb 2, 2014 at 11:35 PM, Martin Erik Werner
> <martinerikwerner@gmail.com> wrote:
> > diff --git a/setup.c b/setup.c
> > index a2e60ab..230505c 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -86,11 +86,23 @@ char *prefix_path_gently(const char *prefix, int len,
> >         const char *orig = path;
> >         char *sanitized;
> >         if (is_absolute_path(orig)) {
> > -               const char *temp = real_path(path);
> > -               sanitized = xmalloc(len + strlen(temp) + 1);
> > -               strcpy(sanitized, temp);
> > +               char *npath;
> > +
> > +               npath = xmalloc(strlen(path) + 1);
> >                 if (remaining_prefix)
> >                         *remaining_prefix = 0;
> > +               if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> > +                       free(npath);
> > +                       return NULL;
> > +               }
> > +               if (abspath_part_inside_repo(npath)) {
> > +                       free(npath);
> > +                       return NULL;
> > +               }
> > +
> > +               sanitized = xmalloc(strlen(npath) + 1);
> > +               strcpy(sanitized, npath);
> > +               free(npath);
> 
> We could replace these three lines with "sanitized = npath;". But it's
> not a big deal imo. The rest of the series looks good.
> 
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> 
> >         } else {
> >                 sanitized = xmalloc(len + strlen(path) + 1);
> >                 if (len)
> -- 
> Duy

Thank you for reviewing! And thanks Torsten and Junio Likewise. (And
thanks Richard for initial triggering and brief discussion of the bug :)

Hmm, yeah I don't really know what to prefer out of a. Two mallocs with
only a minimal one returned or 2. Single, potentially non-minimal, malloc
returned, if it makes little difference, for simplicity the latter seems nicer.

Then it seems like one could get rid of npath completely:

diff --git a/setup.c b/setup.c
index 230505c..dd120cd 100644
--- a/setup.c
+++ b/setup.c
@@ -88,21 +88,17 @@ char *prefix_path_gently(const char *prefix, int len,
 	if (is_absolute_path(orig)) {
 		char *npath;
 
-		npath = xmalloc(strlen(path) + 1);
+		sanitized = xmalloc(strlen(path) + 1);
 		if (remaining_prefix)
 			*remaining_prefix = 0;
-		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
-			free(npath);
+		if (normalize_path_copy_len(sanitized, path, remaining_prefix)) {
+			free(sanitized);
 			return NULL;
 		}
-		if (abspath_part_inside_repo(npath)) {
-			free(npath);
+		if (abspath_part_inside_repo(sanitized)) {
+			free(sanitized);
 			return NULL;
 		}
-
-		sanitized = xmalloc(strlen(npath) + 1);
-		strcpy(sanitized, npath);
-		free(npath);
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)

at the cost of 'sanitized' always being the length of path, regardless
if it's shorter, or even a NUL string.

--
Martin Erik Werner <martinerikwerner@gmail.com>
