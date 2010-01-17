From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rerere: use ll_merge() instead of using xdl_merge()
Date: Sun, 17 Jan 2010 12:52:38 +0100
Message-ID: <201001171252.38826.j6t@kdbg.org>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com> <1263721144-18605-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 12:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWTkb-0006os-3R
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 12:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0AQLxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 06:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504Ab0AQLxn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 06:53:43 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:46381 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750783Ab0AQLxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 06:53:42 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AA2F6A7EBA;
	Sun, 17 Jan 2010 12:53:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2D19319F5BF;
	Sun, 17 Jan 2010 12:52:39 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263721144-18605-6-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137294>

On Sonntag, 17. Januar 2010, Junio C Hamano wrote:
> This allows us to pay attention to the attribute settings and custom
> merge driver the user sets up.

I do not think that this change is necessary; I even think that it is wrong, 
in particular, custom merge drivers should *not* be used anymore.

The code path is about merging the changes between preimage and postimage into 
a file that has conflict markers (thisimage). At the time when this happens, 
all three images have already been processed by the custom merge driver.

Consider this preimage:

<foo><bar>
<<<<<<<
</bar>
=======
<baz>
text
</baz></bar>
>>>>>>>
<more text="here" />
</foo>

and a custom XML merge driver. With your change, you expect that the merge 
driver knows how to treat syntactically incorrect XML (the "<<<<<<<" 
and ">>>>>>>").

Of course, without this change, we do expect that the postimage has 
practically everything outside the conflict markers unchanged[*], otherwise 
the ll_merge() will fail.

But so would a custom XML driver that does not know how to read conflict 
markers.

[*] Which is perhaps an assumption that is easily violated. For example, the 
XML editor used to resolve the conflict could have inserted line-breaks at 
completely different spots than in the conflicted preimage.

-- Hannes
