From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Fri, 5 Oct 2012 20:21:32 +0700
Message-ID: <20121005132132.GA13591@do>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
 <7vbogj5sji.fsf@alter.siamese.dyndns.org>
 <506D5837.6020708@alum.mit.edu>
 <7vobki19ax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 15:28:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK7xK-0002qz-PO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 15:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab2JEN2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 09:28:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63067 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab2JEN2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 09:28:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1820167pbb.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sD7rzTSiL+CGnZSFJPsl/Tl9ofmWpdTcQ5VVcKCsKUM=;
        b=tF4JY+/2iL5MXan98gWTa19AwkuAAmgpvTZF9ouefDgixyATN+PitdURN/IdubrQ2e
         md9eT66jN8nsbHKVsEX9G74DnJFj0MoEjp2tFEF8XpcVjxjnegpsVi8ZETx/Mff9GEbO
         E84VevL/3GMnQTUNNuLsNMpiw23KN2FlMyJQN7911/0lMfoINnWkOnlrF5+ojhe5xJMj
         xdZbOY2GvoKiTcUWNW1q/FleOZaY2jGTHBYrC8B0/ewlbzc870I2yLBp6j/r7UxFpmPR
         Ox1tqX0EhhBgbejBzeNQXSC/1zzGhDLPhLukA4DaMfXfRyzCWYPc7xet0tF5tRE7ZK/s
         xGCg==
Received: by 10.66.78.195 with SMTP id d3mr21696421pax.17.1349443709657;
        Fri, 05 Oct 2012 06:28:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id pi1sm6079369pbb.7.2012.10.05.06.28.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:28:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 05 Oct 2012 20:21:32 +0700
Content-Disposition: inline
In-Reply-To: <7vobki19ax.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207103>

On Thu, Oct 04, 2012 at 09:39:02AM -0700, Junio C Hamano wrote:
> Assuming that we do want to match "x/y" with "x/**/y", I suspect
> that "'**' matches anything including a slash" would not give us
> that semantics. Is it something we can easily fix in the wildmatch
> code?

Something like this may suffice. Lightly tested with "git add -n".
Reading the code, I think we can even distinguish "match zero or more
directories" and "match one or more directories" with "/**/" and maybe
"/***/". Right now **, ***, ****... are the same. So are /**/, /***/,
/****/...

-- 8< --
diff --git a/wildmatch.c b/wildmatch.c
index f153f8a..81eadc8 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -98,8 +98,12 @@ static int dowild(const uchar *p, const uchar *text,
 	    continue;
 	  case '*':
 	    if (*++p == '*') {
+		int slashstarstar = p[-2] == '/';
 		while (*++p == '*') {}
 		special = TRUE;
+		if (slashstarstar && *p == '/' &&
+		    dowild(p + 1, text, a, force_lower_case) == TRUE)
+		    return TRUE;
 	    } else
 		special = FALSE;
 	    if (*p == '\0') {
-- 8< --
-- 
Duy
