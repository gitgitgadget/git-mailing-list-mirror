From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Configuring (future) committags support in gitweb
Date: Sat, 8 Nov 2008 20:07:53 +0100
Message-ID: <200811082007.55045.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Francis Galiegue <fg@one2team.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 20:09:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KytBR-0007xK-Pr
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 20:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYKHTIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 14:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYKHTIA
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 14:08:00 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:13409 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYKHTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 14:07:59 -0500
Received: by ey-out-2122.google.com with SMTP id 6so736253eyi.37
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EFzYHdei+iNneR4TtSeVzIvlfOGzMItyAKTSAqnTF28=;
        b=kDmeFf11egkYneHIPy+976KlTfu0HWn/vhBAyEI1UDyJSQVD5alENyvAd0nQZfKJ5L
         kL76VrVAtZM1yvpE6n4Z/naxLoUl6sTRtuefqo4nep3Hb6s7OapkeYA3jL7EdX5CiNQr
         g9lHjmKfR10X+hVQKj4u43O/GXm2G4JSra6Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=nQPsUhlLLR69rgQKbUE7gTMHhYJs65Sebem14rFhbsrMXiV/g+TXLouNPUoZsVhNmy
         Gcac4D01iHmtYcLaEcQPUUs7YxhjB9wVunxp17X3eQwPVnPk9hXPVod26QNDeN1Bf7I9
         MEmnMSlA2NIxmwvLv6dsm6BXyuEbGVmsHN16U=
Received: by 10.210.71.11 with SMTP id t11mr5598047eba.57.1226171277725;
        Sat, 08 Nov 2008 11:07:57 -0800 (PST)
Received: from ?192.168.1.11? (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id 5sm6281131eyh.2.2008.11.08.11.07.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 11:07:56 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100415>

Francis Galiegue <fg@one2team.net> writes
in "Need help for migration from CVS to git in one go..." 

> * third: also Bonsai-related; Bonsai can link to Bugzilla by
> matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
> http://your.bugzilla.fqdn.here/show_bug.cgi?id=$1. Does gitweb have
> this built-in? (haven't looked yet) Is this planned, or has it been
> discussed and been considered not worth the hassle?

Here below there is proposal how the committags support could look like
for gitweb _user_, which means how to configure gitweb to use (or do not
use) committags, how to configure committags, and how to define new
committags.


Committags are "tags" in commit messages, expanded when rendering commit
message, like gitweb now does for (shortened) SHA-1, converting them to
'object' view link.  It should be done in a way to make it easy
configurable, preferably having to configure only variable part, and not
having to write whole replacement rule.

Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protecting
of email addresses, "rich text formatting" like *bold* and _underline_,
syntax highlighting of signoff lines.


I think it would be good idea to use repository config file for
setting-up repository-specific committags, and use whatever Perl
structure for global configuration. The config language can be
borrowed from "drivers" in gitattributes (`diff' and `merge' drivers).

So the example configuration could look like this:

  [gitweb]
  	committags = sha1 signoff bugzilla

  [committag "bugzilla"]
  	match = "\\b(?:#?)(\\d+)\\b"
  	link  = "http://your.bugzilla.fqdn.here/show_bug.cgi?id=$1"

where 'sha1' and 'signoff' are built-in committags, committags are
applied in the order they are put in gitweb.committags; possible actions
for committag driver include:
 * link: replace $match by '_<a href="$link">_$match_</a>_'
 * html: replace $match by '_$html_'
 * text: replace $match by '$text'
where '_a_' means that 'a' is treated as HTML, and is not expanded
further, and 'b' means that it can be further expanded by later
committags, and finally is HTML-escaped (esc_html).


What do you think about this?
-- 
Jakub Narebski
Poland
