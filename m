From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix displaying unchopped argument in chop_and_escape_str
Date: Sat, 16 Feb 2008 23:07:46 +0100
Message-ID: <200802162307.47323.jnareb@gmail.com>
References: <20080216130037.GA14571@auto.tuwien.ac.at> <m3lk5kbry3.fsf@localhost.localdomain> <7vve4o7jhz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 23:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQVD4-0006sV-9W
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 23:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYBPWID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbYBPWIC
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 17:08:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:9388 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYBPWIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 17:08:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so87863ugc.16
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=hcjxRkLLFQkOTyOSuu03qklGGgaln9WYrQ6X0sRU9fI=;
        b=oZsX8cDfut86Na/z1LMszmml9v5XSCVdOYF7JSgcRiOZbMsGvBl9s/QHfgUtoayt5FV8mI88b5A6BcjWY3jfwcEbN0hSq3UJY7gTPdketSW9bQmOTIA/8gEnDAsh8oRhX+VPNL0buvvrU2ZzeQZCGvINPmc12RK8IVGiJFK9KsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RKnEPmMf2WjUNLhVOl6otMOxjJ9cm6TOnPuzy0h/cmARDF3JauL7pixWrfrDIfcUf/gIUiaOu6+Q3RBGEyvdGIesjBOP2aSxZli7RIYna+aJtCfR2ocLQLPhwxTzBFmR2firvML1cN7E0pZCWEoKKmALfv/tqlOq3kXA0bCB2j4=
Received: by 10.66.251.3 with SMTP id y3mr1097850ugh.88.1203199678559;
        Sat, 16 Feb 2008 14:07:58 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.197.33])
        by mx.google.com with ESMTPS id a1sm1795065ugf.78.2008.02.16.14.07.56
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 14:07:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vve4o7jhz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74081>

Do not use esc_html to escape [title] _attribute_ of a HTML element,
and quote unprintable characters.  Replace unprintable characters by
'?' and use CGI method to generate HTML element and do the escaping.

This caused bug noticed by Martin Koegler,
  Message-ID: <20080216130037.GA14571@auto.tuwien.ac.at>
that for bad commit encoding in author name, the title attribute (here
to show full, not shortened name) had embedded HTML code in it, result
of quoting unprintable characters the gitweb/HTML way. This of course
broke the HTML, causing page being not displayed in XML validating web
browsers.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>>
>>> http://repo.or.cz/w/alt-git.git?a=shortlog
>>> 
>>> fails to load in my Seamonkey browser (Debian stable):
>>> 
>>> XML Parsing Error: not well-formed
>>> Location: http://repo.or.cz/w/alt-git.git?a=shortlog
>>> Line Number 561, Column 33:<td><i><span title="Uwe Kleine-K<span class="cntrl">\e</span>,Av<span class="cntrl">\e</span>(Bnig">Uwe Kleine ...</span></i></td>
>>> --------------------------------^
>>
>> It looks like gitweb uses esc_html instead of esc_param (or leaving it
>> to CGI module) title attribute of span (?) element in a shortlog.
>>
>> I'd try to fix this bug.
> 
> Thanks.

And here it is. It fixes this bug; I hope there aren't any similar bugs,
but I have not checked this. 

Robert Schiele wrote:
> On Sat, Feb 16, 2008 at 11:52:42AM -0800, Jakub Narebski wrote:
>> 
>> It looks like gitweb uses esc_html instead of esc_param (or leaving it
> 
> Huh?  Isn't that the wrong escaping?  esc_param is for URLs not for XML
> attributes in general, isn't it?

True, esc_param is for escaping values of CGI parameters, not for
escaping (and quoting) attributes of HTML element.


P.S. I am sorely dissapointed by the fact that CGI version 3.10 doesn't
do escaping / quoting of unprintable (control) characters in attributes
(characters outside specified character set).

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a89b478..acf155c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -866,8 +866,8 @@ sub chop_and_escape_str {
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
-		return qq{<span title="} . esc_html($str) . qq{">} .
-			esc_html($chopped) . qq{</span>};
+		$str =~ s/([[:cntrl:]])/?/g;
+		return $cgi->span({-title=>$str}, esc_html($chopped));
 	}
 }
 
-- 
1.5.4
