From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG/RFH] gitweb: Trouble with ref markers being hyperlinks because of illegally nested links
Date: Mon, 12 Jan 2009 02:15:11 +0100
Message-ID: <200901120215.13668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBQ5-0003cP-F4
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZALBPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZALBPV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:15:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:16170 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbZALBPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:15:20 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1307245nfc.21
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 17:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:cc:content-type
         :content-transfer-encoding:message-id;
        bh=3Eg5hHP8nHWbBrYQPBaevmgCzKZ0qeO9kwbyucrpuHg=;
        b=un2dvqNX2cRwrIWTySNamKburRjOZj9uiH/bW5EDkEtqD2yM0sMlR+n76vrmu4xO/z
         wug4+eXkst6hhaoXIPiGp0S+fDW3dCAlYV6MCWkVgdsCzYr82MzLYRmDlcrc3pc32O0s
         POJVuZKuTo+trkkqk81mK2+bSat7PPwxFzHiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition:cc
         :content-type:content-transfer-encoding:message-id;
        b=H3beBo6U8LyZNOXiLDGPvia+9tweVTEJHC17pDswkwXQX8HBgkf5216btkT5bzQmI8
         jzxXGQBVJHlw8OQgrt4T9qNO6pxlkH1ZSPKAeHvpDauWk4LBe/GoOA03ECgJNHRxYqN3
         JQb64D7bYhTSo7RFjiv4dKJEAbs1BYWOrif3c=
Received: by 10.210.82.7 with SMTP id f7mr1038140ebb.93.1231722918774;
        Sun, 11 Jan 2009 17:15:18 -0800 (PST)
Received: from ?192.168.1.11? (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id 34sm54041819nfu.2.2009.01.11.17.15.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 17:15:18 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105264>

Commit 4afbaef by Giuseppe Bilotta (gitweb: ref markers link to named 
shortlogs) turned ref markers for tags and heads into links to    
appropriate views for the ref name.

Unfortunately the code didn't take into account the fact that nesting 
links (A elements) is illegal in (X)HTML:

  12.2.2 Nested links are illegal

  Links and anchors defined by the A element must not be nested;
  an A element must not contain any other A elements.

(from http://www.w3.org/TR/html401/struct/links.html#h-12.2.2), and that 
some browsers (e.g. Mozilla 1.17.2 I still use) in the very strict 
conformance mode (application/xhtml+xml mimetype and XML + XHTML DTD) 
_enforce_ this requirement by moving inner link immediately outside the 
end of outer link, i.e. for the HTML source looking like the following
  <a ...> some text <a ...>v1.5.1</a></a>
rendered HTML (which you can see using "View Selection Source") is 
instead
  <a ...> some text </a><a ...>v1.5.1</a>
And of course SPAN elements which wraps inner link (inner A element) is 
_not_ moved.


This is quite easy to fix for hyperlinked ref markers in 'shortlog' and 
'history' views: just close the "title" hyperlink before printing 
$extra, i.e. ref markers. I have even made a patch doing that. Then 
instead of incorrect
  _Merge branch into maint_ [] _maint_
where _aaa_ means that 'aaa' is hyperlink, and [xxx] is a fer marker,
we will have correct:
  _Merge branch into maint_ [_maint_]
See that we have two separate and not nested links...


What is more complicated is the issue of ref marker from 
git_print_header_div e.g. in 'commit'/'commitdiff' view, and in 'log' 
view.  There link is made into block element using "display: block;"
CSS rule (div.title, a.title), so that you can click _anywhere_ on the 
header block.  This breaks layout even worse, making hyperlinked ref 
marker text appear *below* header div:

  -----------------------------------------------------------
  |_Merge branch into maint_ []                             |
  -----------------------------------------------------------
  _maint_

To preserve current layout and behavior it would be needed to do some 
deep HTML + CSS positioning hackery, perhaps with additional link block 
without any text... But I don't know exactly how to do this; all [few] 
experiments I did failed.

I see possible the following alternate solutions:
 * Ignore this issue (e.g. if it does not affect modern browsers)
 * Revert 4afbaef (we lose feature, but how often used is it?)
 * Always use quirks mode, or check browser and use quirks mode if it
   would break layout
 * Use extra divs and links and CSS positioning to make layout which
   looks like current one, and behaves as current one, but is more
   complicated.


P.S. From what I have checked neither kernel.org nor repo.or.cz
have this issue.
-- 
Jakub Narebski
Poland
