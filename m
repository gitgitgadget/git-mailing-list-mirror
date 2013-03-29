From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 20:02:30 +0700
Message-ID: <20130329130230.GA25861@lanh>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <20130329120539.GA20711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avila.jn@gmail.com
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 14:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULYxM-00068C-9g
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 14:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab3C2NC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 09:02:27 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58213 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab3C2NC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 09:02:26 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so252511pdj.39
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nhgdkZTWn4NkuNnjVnCdQEKEhBTKWPy1WDuGNdeHz5g=;
        b=wlNY+wg2LI80+ybNYn0IrJIzTdataSVdjoqfFR5f+xAPeX+Ztrvf1Myb7fP03maXVz
         hV+g2cEcFdMnFqdSfFWfKqNKI3Yi7AIXdcP6bxmwUCfk5cnNdaNVDnhlaIurviSP7ogL
         naWqSCSHmC1dKUX/YlGSPKPcZPxqLDetVez5yRvkkCeQej3g14FPAkOfKclOwYiETRwS
         VjvPN8FeEy3VtN1mfmF5Qhh1pWMnveHwfxElxU46WLjg6JUGd2uRaRnNyx5E3IHW4NHy
         4/UejYWu32qHY7zNIuahOBXlf7KsJ+Xu7Y7E49YnCXYByyArNZaCtdARr8cQEHQFPTj6
         V9kQ==
X-Received: by 10.66.171.232 with SMTP id ax8mr4395453pac.67.1364562146254;
        Fri, 29 Mar 2013 06:02:26 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id kt5sm2782600pbc.30.2013.03.29.06.02.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 06:02:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 29 Mar 2013 20:02:30 +0700
Content-Disposition: inline
In-Reply-To: <20130329120539.GA20711@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219498>

On Fri, Mar 29, 2013 at 08:05:40AM -0400, Jeff King wrote:
> On Fri, Mar 29, 2013 at 03:45:35PM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> > On Fri, Mar 29, 2013 at 4:48 AM, Jeff King <peff@peff.net> wrote:
> > > -       return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
> > > +       return fnmatch_icase_mem(pattern, patternlen,
> > > +                                name, namelen,
> > > +                                FNM_PATHNAME) == 0;
> > >  }
> > 
> > I think you (or Junio) should rebase this on maint. Since c41244e
> > (included in maint), this call is turned to wildmatch(WM_PATHNAME) and
> > WM_PATHNAME is _not_ the same as FNM_PATHNAME for patterns like
> > "foo/**/bar". A diff between next and pu shows me that WM_PATHNAME is
> > incorrectly converted to FNM_PATHNAME. I hope that is the cause of all
> > breakages Junio found out on pu.
> 
> I don't think we want to rebase; the regression is in the v1.8.1 series,
> and I suspected that Junio was planning to ship a v1.8.1.6 with the fix.
> The wildmatch code comes in v1.8.2.
> 
> So we would want to do any adjustment to the fix when we merge up to
> maint.

OK. Then Junio, you may need to resolve the conflict with something
like this. Originally match_basename uses fnmatch, not wildmatch. But
using wildmatch there too should be fine, now that both
match_{base,path}name share fnmatch_icase_mem().

-- 8< --
diff --git a/dir.c b/dir.c
index 73a08af..84744df 100644
--- a/dir.c
+++ b/dir.c
@@ -81,7 +81,9 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,
 		use_str = str_buf.buf;
 	}
 
-	match_status = fnmatch_icase(use_pat, use_str, flags);
+	if (ignore_case)
+		flags |= WM_CASEFOLD;
+	match_status = wildmatch(use_pat, use_str, flags, NULL);
 
 	strbuf_release(&pat_buf);
 	strbuf_release(&str_buf);
@@ -564,7 +566,7 @@ int match_pathname(const char *pathname, int pathlen,
 
 	return fnmatch_icase_mem(pattern, patternlen,
 				 name, namelen,
-				 FNM_PATHNAME) == 0;
+				 WM_PATHNAME) == 0;
 }
 
 /*
-- 8< --
