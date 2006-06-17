From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: Shrink "struct object" a bit
Date: Sat, 17 Jun 2006 08:36:22 -0700
Message-ID: <44942176.1070107@mindspring.com>
References: <Pine.LNX.4.64.0606141630570.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 17:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frcqf-0003gP-MQ
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 17:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWFQPga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 11:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWFQPga
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 11:36:30 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:61417 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751662AbWFQPg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 11:36:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=oaDimHGZbUbM+b8kd0aaRdhrynkAe9Y2el3s+jyYekZAjzdedoqFP6fouQZQAuqP;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [67.101.149.109] (helo=[172.21.42.101])
	by elasmtp-mealy.atl.sa.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1FrcqZ-0003o0-2U; Sat, 17 Jun 2006 11:36:27 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606141630570.5498@g5.osdl.org>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4da64a342ebe0440cc78f1e297a3f416a8350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 67.101.149.109
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22021>

Linus Torvalds wrote:

>This shrinks "struct object" by a small amount, by getting rid of the 
>"struct type *" pointer and replacing it with a 3-bit bitfield instead.
>
>@@ -179,9 +179,7 @@ static int loop(void)
> 		 */
> 		if (! (obj->flags & TO_SCAN)) {
> 			if (fetch(obj->sha1)) {
>-				report_missing(obj->type
>-					       ? obj->type
>-					       : "object", obj->sha1);
>+				report_missing(typename(obj->type), obj->sha1);
> 				return -1;
> 			}
> 		}
>  
>

>diff --git a/object.c b/object.c
>index 9adc874..0f70890 100644
>--- a/object.c
>+++ b/object.c
>@@ -9,6 +9,10 @@ struct object **objs;
> static int nr_objs;
> int obj_allocs;
> 
>+const char *type_names[] = {
>+	"none", "blob", "tree", "commit", "bad"
>+};
>+
>  
>

A minor thing, but doesn't this mean the "report_missing" message would 
change from:

 > Cannot obtain needed object ab12cdef1234567890abcd
 > while processing commit fedcbadeadbeefdeadbe

to

 > Cannot obtain needed none ab12cdef1234567890abcd
 > while processing commit fedcbadeadbeefdeadbe

in some cases? I'm not sure that it's possible for the type value to be 
unspecified at this point in the code, but it seemed like the output 
from report_missing would be confusing if this ever happened.

:v)
