From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui-i18n: Make "Revert changes in these $n files"
	translatable.
Date: Thu, 26 Jul 2007 10:47:23 +0200
Message-ID: <20070726104723.ugsfnbj1ogw8gg4k@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDz0X-0006w6-2G
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179AbXGZIrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 04:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757863AbXGZIrh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 04:47:37 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:49424 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbXGZIrf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 04:47:35 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6Q8lNWA000521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Jul 2007 10:47:23 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6Q8lN2d019335;
	Thu, 26 Jul 2007 10:47:23 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 57C75E50349; Thu, 26 Jul 2007 10:47:23 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Thu, 26 Jul 2007
	10:47:23 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53808>

Dear Harri, (responding to the commit in the mob branch)

thanks for discovering this message that was missed from translation.  
I'd like to use the opportunity to explain shortly the situation with  
plural form translations. You wrote:

+	# Split question between singular and plural cases, because
+	# such distinction is needed in some languages.

The issue with plural forms is even more complicated than that. In  
fact, the gettext library in C has the separate function ngettext()  
solely for the purpose of dealing with plural forms correctly; see  
http://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html#Plural-forms for the (lengthy but interesting) explanation. All one has to know is this: There are many languages out there that have not only one singular and one plural form, but much more of them, depending on the actual number of items being talked about. (Example: Three forms, with special cases for 1 and 2, 3, 4, in Slovak and  
Czech)

Unfortunately the msgcat package of Tcl is missing all support for a  
meaningful implementation of plural forms. (IMHO that's quite a  
shortcoming of msgcat and quite a big advantage of gettext, but there  
isn't an easy solution in sight. Whatever.) For that reason we have to  
refrain from using any plural-form-depending messages at all.

Enough of this discussion.

In this *particular* commit, the plural-form discussion misses the  
point with the message in question. In this particular message, if  
$n==1 (one single file to be reverted), the *file name* should be  
printed in the message. If $n > 1, the *number of files* should be  
printed in the message. The i18n error that had to be fixed is that  
the English message used to be built up from several parts, which is a  
no-no for translatable strings, and you have fixed that correctly.

Nevertheless the last [mc...] message in your commit doesn't end up  
that nicely for the translator. As you have the first sentence already  
in another language and translated separately, I would suggest to have  
the second sentence translated separately as well, and then appending  
these together in the actual message being shown. Like the patch below.

Thanks again for spotting this error.

Christian


diff --git a/lib/index.tcl b/lib/index.tcl
index 9080ac6..e1bda52 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -350,17 +350,15 @@ proc revert_helper {txt paths} {
                 unlock_index
                 return
         } elseif {$n == 1} {
-               set s "[short_path [lindex $pathList]]"
+               set query [mc "Revert changes in file %s?" [short_path  
[lindex $pathList]]]
         } else {
-               set s "these $n files"
+               set query [mc "Revert changes in these %i files?" $n]
         }

         set reply [tk_dialog \
                 .confirm_revert \
                 "[appname] ([reponame])" \
-               [mc "Revert changes in %s?
-
-Any unadded changes will be permanently lost by the revert." $s] \
+               "$query\n\n[mc "Any unadded changes will be  
permanently lost by the revert."]" \
                 question \
                 1 \
                 [mc "Do Nothing"] \
--
1.5.3.rc2.12.gbc280
