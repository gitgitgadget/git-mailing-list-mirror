From: <4jxDQ6FQee2H@dyweni.com>
Subject: Bug in Git-Gui - Creates corrupt patch
Date: Wed, 25 Feb 2009 09:03:22 -0600
Message-ID: <20090225090322.301cdb77@family.dyweni.com>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 25 16:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcLS8-0001m0-GS
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 16:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761502AbZBYPLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 10:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761489AbZBYPLq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 10:11:46 -0500
Received: from pl1.haspere.com ([208.111.35.220]:56154 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760466AbZBYPLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 10:11:45 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Feb 2009 10:11:45 EST
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id D2BEBC9FB7;
	Wed, 25 Feb 2009 09:03:24 -0600 (CST)
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111462>

Hi Shawn,

I have stumbled upon a bug in Git-GUi and am providing reproduction
steps:



1.  Commit this file into a new git repository:

-----------------------------
<?php

class myclass {
	public function funcAbc() {
		echo "line 1";
		echo "line 2";
		echo "line 3";
		echo "line 4";
		echo "line 5";
	}
	
	public function funcBCD() {
		echo "line 1-1";
		echo "line 2-1";
		echo "line 3-1";
		echo "line 4-1";
		echo "line 5-1";
	}
}

?>
--------------

Here is the base64 encoded version:

PD9waHAKCmNsYXNzIG15Y2xhc3MgewoJcHVibGljIGZ1bmN0aW9uIGZ1bmNBYmMoKSB7CgkJZWNo
byAibGluZSAxIjsKCQllY2hvICJsaW5lIDIiOwoJCWVjaG8gImxpbmUgMyI7CgkJZWNobyAibGlu
ZSA0IjsKCQllY2hvICJsaW5lIDUiOwoJfQoJCglwdWJsaWMgZnVuY3Rpb24gZnVuY0JDRCgpIHsK
CQllY2hvICJsaW5lIDEtMSI7CgkJZWNobyAibGluZSAyLTEiOwoJCWVjaG8gImxpbmUgMy0xIjsK
CQllY2hvICJsaW5lIDQtMSI7CgkJZWNobyAibGluZSA1LTEiOwoJfQp9Cgo/Pg==




2.  Now delete the last function in the class.  Here's the resulting
file, it is not staged or commited yet.

----------------------------
<?php

class myclass {
	public function funcAbc() {
		echo "line 1";
		echo "line 2";
		echo "line 3";
		echo "line 4";
		echo "line 5";
	}
}

?>
----------------------------


Here is the base64 encoded version:

PD9waHAKCmNsYXNzIG15Y2xhc3MgewoJcHVibGljIGZ1bmN0aW9uIGZ1bmNBYmMoKSB7CgkJZWNo
byAibGluZSAxIjsKCQllY2hvICJsaW5lIDIiOwoJCWVjaG8gImxpbmUgMyI7CgkJZWNobyAibGlu
ZSA0IjsKCQllY2hvICJsaW5lIDUiOwoJfQp9Cgo/Pg==




3. Using git-gui, try to stage *only* the last line marked for removal
(should be '-	}').

I get 'fatal: corrupt patch at line 22'.




4. Now try the same task using git-add -p.   Start 'git-add -p'.  Enter
edit mode (e).  Remove all the '-' lines except the last one (make
them ' ') so that only the last '-' will be removed. Save and exit.

On my system the patch is committed.





I'm running git version 1.6.0.6, 32bit linux, Gentoo OS
