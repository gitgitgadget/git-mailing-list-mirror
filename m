From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] git-log --follow incompatibile with --max-count
Date: Fri, 7 Nov 2008 19:38:09 +0100
Message-ID: <200811071938.11170.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 19:39:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyWFR-0000Hn-R6
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 19:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbYKGSiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 13:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbYKGSiU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 13:38:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:47585 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYKGSiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 13:38:19 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1284637ugf.37
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 10:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=oj6Kjdz2HBU58wRvhyniLJvEZYukHNw3iYl5mr22oBA=;
        b=RR+6jM0+SMeh4LjNSLY3kq/lldgmpWUvGyRa6lEqe73eY/Ssw1TZEoxJZJ6lB6y934
         FLtVA25DINejSgz8Fi6nLegaoBGS+1I2UrWUYlh9w4U3GwE1lXUvNrWU3MB+03juRb/o
         AlK+dlsql+1jrbajzMKKQKHY1gz0jVySO8OV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=YpFsnldho5X/ABjXt19nAFUloQrntaVAFeqwJTDBvoRumSqJDUwO9rWvhsCt72Hy9z
         AovIb10GCcHPZfaCIu1pqvw0AzCMuvVS3k3KRllszvWotbhwAcSxQP2nhOn22uskO4xD
         UyZDz8oBpKq4NE/RH2i2mYZ4BapFtwRm7JRLQ=
Received: by 10.67.116.9 with SMTP id t9mr1560973ugm.61.1226083094579;
        Fri, 07 Nov 2008 10:38:14 -0800 (PST)
Received: from ?192.168.1.11? (abvq140.neoplus.adsl.tpnet.pl [83.8.214.140])
        by mx.google.com with ESMTPS id u7sm5213857uge.15.2008.11.07.10.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Nov 2008 10:38:13 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100322>

First, it is a bit strange that while "git log" understand '--follow'
option, "git rev-parse" (the plumbing equivalent to be used in scripts)
does not.


Second, somehow "git log --follow <filename>" is incompatible with
'-n' / '--max-count':

 $ git log --max-count=10 --follow --pretty=oneline --abbrev-commit gitweb/gitweb.perl 
 f24dce1... gitweb: Separate features with no project specific override
 61b4606... gitweb: Better processing format string in custom links in navbar

 $ git log --max-count=10 --pretty=oneline --abbrev-commit gitweb/gitweb.perl 
 f24dce1... gitweb: Separate features with no project specific override
 61b4606... gitweb: Better processing format string in custom links in navbar
 8db49a7... gitweb: generate parent..current URLs
 b0be383... gitweb: parse parent..current syntax from PATH_INFO
 3550ea7... gitweb: use_pathinfo filenames start with /
 b02bd7a... gitweb: generate project/action/hash URLs
 d8c2882... gitweb: parse project/action/hash_base:filename PATH_INFO
 1b2d297... gitweb: refactor input parameters parse/validation
 3e3d4ee... Merge branch 'pb/gitweb-tagcloud' into pb/gitweb
 0d1d154... gitweb: Support for simple project search form

 $ git log --max-count=10 --pretty=oneline --abbrev-commit gitweb/gitweb.perl | wc -l
 10

Without '--nax-count' it works correctly:

 $ git log --pretty=oneline --abbrev-commit gitweb/gitweb.perl | wc -l
 446

 $ git log --follow --pretty=oneline --abbrev-commit gitweb/gitweb.perl | wc -l
 485


Both bugs were noticed by Guy Blucher when writing 'historyfollow'
patch for gitweb:
  "[RFC] gitweb: add 'historyfollow' view that follows renames"
  Msg-ID: <054F21930D24A0428E5B4588462C7AED0149B4B8@ednex512.dsto.defence.gov.au>
  http://permalink.gmane.org/gmane.comp.version-control.git/99199
-- 
Jakub Narebski
Poland
