From: Willy Tarreau <w@1wt.eu>
Subject: UTF-8 trouble with GIT 1.5.0.3
Date: Sat, 17 Mar 2007 11:27:30 +0100
Message-ID: <20070317102730.GA15256@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jukio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 17 11:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSWIw-0007sm-6c
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 11:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbXCQKi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 06:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbXCQKi2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 06:38:28 -0400
Received: from 1wt.eu ([62.212.114.60]:1224 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965309AbXCQKi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 06:38:27 -0400
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Mar 2007 06:38:27 EDT
Received: (from willy@localhost)
	by pcw.home.local (8.10.2/8.10.2) id l2HARUY15326;
	Sat, 17 Mar 2007 11:27:30 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42429>

Hi Junio,

after upgrading from GIT 1.4 to 1.5, I noticed that I had got
errors when applying patches from mailboxes and that I had to 
manually add "--no-utf8" to git-am. The error was always :

  "fatal: cannot convert from latin1 to utf-8".

This morning, I decided to take a closer look at it, first
trying to fix it in the configuration. Even this fails :

[i18n]
        commitencoding = latin1

$ git-am -3 username.patch 
fatal: cannot convert from latin1 to latin1


So I took a look at the code and noticed that in builtin-mailinfo,
convert_to_utf8() is always called because metainfo_charset is
always set. Also, this function always calls reencode_string(),
no matter what input and outputs are passed. And since it fails
for an unknown reason, I get the error message.

Now I have several options :
 
 - always pass --no-utf8 with git-am to leave metainfo_charset
   NULL and avoid the call to convert_to_utf8()
   => very annoying and I have to rm -rf .dotest every time I forget
      about it

 - add a check to convert_to_utf8() so that when input and output
   charsets are equal, it does not malloc/convert/copy/free the
   result. This would seem necessary anyway.

 - check for empty charset name instead of just a NULL pointer,
   so that it is still possible by configuration to stay compatible
   with old default behaviour which is : not to convert by default.

 - switch back to 1.4 : this will be my immediate option while
   waiting for any advice on the right long-term solution.

I would be glad to get a recommendation for one of the solutions
above. I can workout a patch, but I don't want to waste my time
doing crappy patches that will not be retained.

Please note that I don't know a damn thing about the way iconv
works, which may be one of the reason I really hate it. So it
will take far too much time to me to dig below reencode_string().

Also, I am really worried for buffer overflows here. Looking at
the code, it seems like headers from input mails are passed to
decode_header(), which itself calls decode_header_bq() which in
turns calls convert_to_utf8() with input and output buffers of
256 bytes. Same for mailinfo() which calls check_header_line()
with <line> which has been filled up to sizeof(line) (1000 bytes).

Unless I'm mistaken, encoding from latin1 to utf-8 can grow the
string by a 5-to-1 ratio. So this means that the blind strcpy()
in convert_to_utf8() could overflow on user-crafted mail headers.
Maybe I overlooked something :-/

Regards,
Willy
