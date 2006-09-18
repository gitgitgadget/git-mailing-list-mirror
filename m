From: "Art Haas" <ahaas@airmail.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 18:57:53 -0500
Message-ID: <20060918235753.GG1261@artsapartment.org>
References: <20060918225445.GF1261@artsapartment.org> <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 01:58:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPT02-0005BG-KE
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 01:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWIRX57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWIRX57
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 19:57:59 -0400
Received: from wmail-1.airmail.net ([209.196.70.86]:59115 "EHLO
	wmail-1.airmail.net") by vger.kernel.org with ESMTP
	id S1030277AbWIRX56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 19:57:58 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by wmail-1.airmail.net with esmtp (Exim 4.60)
	(envelope-from <ahaas@airmail.net>)
	id 1GPSzt-0002rd-Vu
	for git@vger.kernel.org; Mon, 18 Sep 2006 18:57:58 -0500
Received: (qmail 9917 invoked by uid 1000); 18 Sep 2006 23:57:53 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27262>

On Mon, Sep 18, 2006 at 04:06:45PM -0700, Junio C Hamano wrote:
> "Art Haas" <ahaas@airmail.net> writes:
> 
> > Older curl releases do not define CURLE_HTTP_RETURNED_ERROR, they
> > use CURLE_HTTP_NOT_FOUND instead. The trivial patch below fixes
> > the build error. Newer curl releases keep the CURLE_HTTP_NOT_FOUND
> > definition but using a -DCURL_NO_OLDIES preprocessor flag
> > the old name will not be present in the 'curl.h' header. The
> > comments in 'curl.h' have more info about the name change.
> >
> > Signed-off-by:  Art Haas <ahaas@airmail.net>
> 
> The patch to use older name in a recent program feels going
> backwards.  The header is only trying to be nice so you can
> compile old programs written for older interface that use older
> names. If the new way is the primary way with the new interface,
> and if we are writing a new program, I think we should write for
> the new interface.
> 
> Can we have the main code to target the more recent version,
> while working around problems with older versions with backward
> compatibility macros?
> 
> In other words, if the macro HTTP_RETURNED_ERROR is not defined
> in the header (i.e. older version), you define it to be the same
> as HTTP_NOT_FOUND.
 
Hi.

Here's a patch that does that. I patched 'http.h' as there is already
a number of other curl tests in that file. On the machine where the 
build was failing, the 'curl-config --vernum' returned '070908',
and on my home machine where things build without issue the same
command returns '070f05', so I took that value to do the comparison.
Perhaps an intermediate value would work as well, but I don't have
a suitable version to check.

Signed-off-by:  Art Haas <ahaas@airmail.net>

diff --git a/http.h b/http.h
index 9ca16ac..aeff988 100644
--- a/http.h
+++ b/http.h
@@ -22,6 +22,10 @@ #if LIBCURL_VERSION_NUM < 0x070c04
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
+#if LIBCURL_VERSION_NUM < 0x070f05
+#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
+#endif
+
 struct slot_results
 {
 	CURLcode curl_result;

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
