From: Christian Stimming <stimming@tuhh.de>
Subject: Re: broken strings in localization (was: How to run git-gui always
	in English?)
Date: Tue, 30 Oct 2007 13:59:13 +0100
Message-ID: <20071030135913.h0c6jdn2xw8w0ccs@webmail.tu-harburg.de>
References: <20071030111626.0mbeh417tw4wos0s@webmail.tu-harburg.de>
	<Pine.LNX.4.64.0710301040490.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, prohaska@zib.de, spearce@spearce.org,
	nanako3@bluebottle.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 13:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imqh6-0006Nj-2b
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 13:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbXJ3M7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 08:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbXJ3M7a
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 08:59:30 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:58367 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXJ3M73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 08:59:29 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UCxFWf008547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 30 Oct 2007 13:59:15 +0100
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UCxF88023761;
	Tue, 30 Oct 2007 13:59:15 +0100
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id C60B3E5034E; Tue, 30 Oct 2007 13:59:13 +0100 (CET)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 30 Oct 2007
	13:59:13 +0100
In-Reply-To: <Pine.LNX.4.64.0710301040490.4362@racer.site>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Note that the msgstr-translation has not been changed yet - this can
>> only be done by a human. For that reason, the update inserted the
>> "fuzzy" marker. Here's where the error came in: All strings marked as
>> "fuzzy" MUST NOT BE USED by msgfmt! And git-gui's script po2msg.sh
>> doesn't adhere to this rule. Boo, that's why such erroneous translations
>> made it into the msgcat catalog.
>
> My bad.  I thought I handled that, but obviously I did not.  Will fix.

Patch looks good.

Note that "msgfmt" with the "-c" option still does more checking and  
should probably be enabled by default. Currently I can use the "-c"  
option by running make MSGFMT="msgfmt -c". We can just call msgfmt  
always with the option -c (it was added in gettext-0.10.35 in 1998) so  
that Shawn or everyone else gets immediate notice if there is a format  
string problem in the file.

@nanako3: In particular, with the current git-gui.git master msgfmt  
will complain about an error in ja.po, which is a rather tricky one.  
(All the rest is fine.) The fix looks as follows (ignoring the  
non-european characters):

diff --git a/po/ja.po b/po/ja.po
index f65e460..2713c9e 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -1781,3 +1781,3 @@ msgstr "??????????:"
  msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%1$s ... %3$*i %4$s ?? %$2*i (%5$3i%%)"
+msgstr "%1$s ... %4$*i %6$s ?? %2$*i (%7$3i%%)"

Two errors: The easy one #1 is the confused '$' and '2' - the format  
string in the middle should start with '%2$'. The difficult one #2 is  
that one has to know that a format specification with a '*' (asterisk)  
suddenly refers to *two* arguments instead of one, hence the suceeding  
argument number is two higher instead of one. This way, the argument  
numbers count up to 7.

Regards,

Christian
