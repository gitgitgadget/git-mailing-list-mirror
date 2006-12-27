From: Junio C Hamano <junkio@cox.net>
Subject: Re: http git and curl 7.16.0
Date: Wed, 27 Dec 2006 13:46:25 -0800
Message-ID: <7v8xgt57wu.fsf@assigned-by-dhcp.cox.net>
References: <skimo@kotnet.org>
	<200612271457.kBREvkj2011916@laptop13.inf.utfsm.cl>
	<7vlkkt5d49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>,
	George Sherwood <pilot@beernabeer.com>, skimo@liacs.nl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 22:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzgbX-0001y5-B8
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbWL0Vq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbWL0Vq1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:46:27 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48726 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbWL0Vq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:46:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227214626.IIWK7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 16:46:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3xmf1W00n1kojtg0000000; Wed, 27 Dec 2006 16:46:40 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <7vlkkt5d49.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 27 Dec 2006 11:53:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35483>

Junio C Hamano <junkio@cox.net> writes:

>>> FWIW, I've seen the same with curl 7.16.0 on a Solaris 9 machine.
>>> It worked fine with curl 7.15.0.
>>
>> It works fine for me on Aurora Corona (sparc) with curl-7.15.5-1.al3, while
>> it fails as above on Fedora rawhide (i386) with curl-7.16.0-4.fc7.
>>
>> Furthermore, with new curl pulling from HTTP repos when there are updates
>> gives double free errors and a crash.
>
> Hmmm.  Could somebody please run http-fetch under gdb and see
> where it breaks?  The exact command line you need to use would
> be obtainable by running "sh -x git-clone" once.
>
> [jc: Nick CC'ed, although I haven't seen him on the list for
> some time...]

When we do not have NO_CURL_EASY_DUPHANDLE defined, http.c
prepares a single "CURL *curl_default" with get_curl_handle(),
and new request slots clone it using curl_easy_duphandle().
However, the returned "clone" somehow forgets to set the "magic"
number that says it is a GOOD_EASY_HANDLE().  This missing magic
number is checked by cURL library in curl_multi_add_handle(),
which we call from start_active_slot().  Hence the request
fails.

Now, I do not know cURL, and cannot tell if it is just a bug in
easy-duphandle of curl 7.16.0, or if we are not supposed to be
using the "easy" interface when dealing with multi fetch.  In
either case, the attached patch seems to fix it for me.

I am NOT CC'ing curl-library@cool.haxx.se mailing list since I
do not want to subscribe only to be able to post, but some kind
souls who are subscribers could forward the issue to them to
determine if we need to fix our code (and if so how), or if we
need to wait for them to fix curl_easy_duphandle().

-- >8 --

diff --git a/http.h b/http.h
index 6e12e41..70b18dd 100644
--- a/http.h
+++ b/http.h
@@ -18,7 +18,7 @@
 #define curl_global_init(a) do { /* nothing */ } while(0)
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070c04
+#if 1 || (LIBCURL_VERSION_NUM < 0x070c04)
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
