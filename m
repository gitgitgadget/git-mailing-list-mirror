From: Christian Stimming <stimming@tuhh.de>
Subject: Re: broken strings in localization (was: How to run git-gui always
	in English?)
Date: Tue, 30 Oct 2007 11:16:26 +0100
Message-ID: <20071030111626.0mbeh417tw4wos0s@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: prohaska@tib.de, spearce@spearce.org, johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 11:18:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImoB3-0000te-PC
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbXJ3KRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbXJ3KRm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:17:42 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45541 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbXJ3KRl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 06:17:41 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UAGR7W009551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 30 Oct 2007 11:16:28 +0100
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UAGR6V026170;
	Tue, 30 Oct 2007 11:16:27 +0100
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id ED32CE5034E; Tue, 30 Oct 2007 11:16:26 +0100 (CET)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 30 Oct 2007
	11:16:26 +0100
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska wrote:
> And it's even worse. An error in the localization can completely
> break git-gui. Apparently the German localization included in
> msysgit's Git-1.5.3-preview20071019.exe _is_ broken (see
> attached png).
>
> Shouldn't the localization code be a bit more fault tolerant?

Thanks for this error description. However, this isn't a fault of the  
localization per se; rather, it's a bad side-effects of git-gui using  
its own script po2msg.sh instead of gettext's msgfmt to prepare  
translations for inclusion in the program - and additionally the fact  
that this po2msg.sh script is used by the creator of the setup.exe,  
whereas the translators use msgfmt which will not exhibit this error.

Here's what happened: The program code changed from using the string  
"Prune from %s" to "Prune from" (just like program code changes  
often). Before, the translation had a translation like this:

msgid "Prune from %s"
msgstr "Abschneiden von %s"

or similar, in any case with the including "%s". After the string  
changed in the program, the next update of the translation file will  
record the fact that the original string changed by changing the  
translation like this:

#, fuzzy
msgid "Prune from"
msgstr "Abschneiden von %s"

Note that the msgstr-translation has not been changed yet - this can  
only be done by a human. For that reason, the update inserted the  
"fuzzy" marker. Here's where the error came in: All strings marked as  
"fuzzy" MUST NOT BE USED by msgfmt! And git-gui's script po2msg.sh  
doesn't adhere to this rule. Boo, that's why such erroneous  
translations made it into the msgcat catalog.

In other words: The tcl msgcat procedure is the wrong end to deal with  
that problem. Instead, those string argument checks should be done  
when "compiling" the foo.po files into the foo.msg files. And that's  
precisely what the msgfmt program is for: It correctly ignores all  
"fuzzy" strings and it additionally checks the %s et al string formats  
for correct translation (when used with the "-c" switch, as the  
"shift-V" command in emacs po-mode or any other po file editor will  
use).

@Dscho: That's why I'm rather unhappy with the addition of the  
po2msg.sh script. Not adhering to the "fuzzy" marker is clearly a bug  
and needs to be fixed there, but additionally you lose all format  
checking that msgfmt gives to you. Syntax errors in the translator's  
foo.po file should really be dealt with at msgfmt compile time, not  
later at runtime. That's the whole point of that compile step.

Regards,

Christian
