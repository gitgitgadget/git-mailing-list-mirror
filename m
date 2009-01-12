From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [BUG/RFH] gitweb: Trouble with ref markers being hyperlinks because of illegally nested links
Date: Sun, 11 Jan 2009 21:59:58 -0500
Message-ID: <cb7bb73a0901111859q3a166d92k5176b27af2c4d256@mail.gmail.com>
References: <200901120215.13668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 04:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMD6e-0006jK-Cu
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 04:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZALDAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 22:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZALDAD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 22:00:03 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:34271 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbZALDAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 22:00:00 -0500
Received: by ewy10 with SMTP id 10so11284727ewy.13
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e2cz0KXSsCyfuNFPMU338EKCPXPIOhMXTFtf6b/+ksY=;
        b=RWAN58LVUVE/w7p04zO7TbASKkvABq2QSaFXxAj043luzunljvo60Qh7X1Eu7hTlTk
         f+o5EmgXvkQInsYiUf0uJrDEndILpd7tyRWHiIgwKsRCSau982eglI8CoLOX6vvgmNNV
         pWeCkpgRGGosoCX8PWleKz9J0XmLj1sLHzfGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xOsVODHLcd51z3cPsJCm26llGiihPFNphIO5g2NvUsMEh/PxaM7BW6zZ59KIZ4hKaY
         OtwGgOK+ojmfa9ic6oqEmQnfZt1TvTbng80FlWE14FMIFdlPjkckvYappbXXN5MlNVzz
         eG7qpJ08D55lRmk6bCvgq0zLBRp3QFYyQK0G0=
Received: by 10.210.42.13 with SMTP id p13mr10047378ebp.183.1231729198454;
        Sun, 11 Jan 2009 18:59:58 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Sun, 11 Jan 2009 18:59:58 -0800 (PST)
In-Reply-To: <200901120215.13668.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105282>

On Sun, Jan 11, 2009 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Commit 4afbaef by Giuseppe Bilotta (gitweb: ref markers link to named
> shortlogs) turned ref markers for tags and heads into links to
> appropriate views for the ref name.
>
> Unfortunately the code didn't take into account the fact that nesting
> links (A elements) is illegal in (X)HTML:
>
>  12.2.2 Nested links are illegal
>
>  Links and anchors defined by the A element must not be nested;
>  an A element must not contain any other A elements.
>
> (from http://www.w3.org/TR/html401/struct/links.html#h-12.2.2), and that
> some browsers (e.g. Mozilla 1.17.2 I still use) in the very strict
> conformance mode (application/xhtml+xml mimetype and XML + XHTML DTD)
> _enforce_ this requirement by moving inner link immediately outside the
> end of outer link, i.e. for the HTML source looking like the following
>  <a ...> some text <a ...>v1.5.1</a></a>
> rendered HTML (which you can see using "View Selection Source") is
> instead
>  <a ...> some text </a><a ...>v1.5.1</a>
> And of course SPAN elements which wraps inner link (inner A element) is
> _not_ moved.
>
>
> This is quite easy to fix for hyperlinked ref markers in 'shortlog' and
> 'history' views: just close the "title" hyperlink before printing
> $extra, i.e. ref markers. I have even made a patch doing that. Then
> instead of incorrect
>  _Merge branch into maint_ [] _maint_
> where _aaa_ means that 'aaa' is hyperlink, and [xxx] is a fer marker,
> we will have correct:
>  _Merge branch into maint_ [_maint_]
> See that we have two separate and not nested links...

I've seen from the list that you already have patches ready to fix at
least this problem. I think we might start from having these patches
in while we think of the best way to fix the biggest issue:

> What is more complicated is the issue of ref marker from
> git_print_header_div e.g. in 'commit'/'commitdiff' view, and in 'log'
> view.  There link is made into block element using "display: block;"
> CSS rule (div.title, a.title), so that you can click _anywhere_ on the
> header block.  This breaks layout even worse, making hyperlinked ref
> marker text appear *below* header div:
>
>  -----------------------------------------------------------
>  |_Merge branch into maint_ []                             |
>  -----------------------------------------------------------
>  _maint_
>
> To preserve current layout and behavior it would be needed to do some
> deep HTML + CSS positioning hackery, perhaps with additional link block
> without any text... But I don't know exactly how to do this; all [few]
> experiments I did failed.
>
> I see possible the following alternate solutions:
>  * Ignore this issue (e.g. if it does not affect modern browsers)

That would be my current choice until we find a better solution.

>  * Revert 4afbaef (we lose feature, but how often used is it?)
>  * Always use quirks mode, or check browser and use quirks mode if it
>   would break layout
>  * Use extra divs and links and CSS positioning to make layout which
>   looks like current one, and behaves as current one, but is more
>   complicated.

I'm asking on #html, hopefully I'll get some interesting idea to try for this.

-- 
Giuseppe "Oblomov" Bilotta
