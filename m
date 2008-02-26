From: <Ken.Fuchs@bench.com>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Date: Tue, 26 Feb 2008 17:46:21 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C01@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU9Vk-0004Tw-6w
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbYBZXqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbYBZXqY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:46:24 -0500
Received: from tx-smtp02.bench.com ([12.163.172.138]:44927 "EHLO
	tx-smtp02.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYBZXqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 18:46:23 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.66])
  by tx-smtp02.bench.com with ESMTP; 26 Feb 2008 17:45:08 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Feb 2008 17:46:22 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach4wzQs8hFqkylpTsCExwoLLGI0LQACcZlw
X-OriginalArrivalTime: 26 Feb 2008 23:46:22.0551 (UTC) FILETIME=[CAC5AE70:01C878D1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75193>

> Ken Fuchs wrote:
> 
> > +       curl_easy_setopt(result, CURLOPT_PROXYAUTH, 
> (long)CURLAUTH_NTLM);
> > +       curl_easy_setopt(result, CURLOPT_PROXYUSERPWD,
> > +               "<user-id>:<password>");

Daniel Stenberg wrote:

> First, you should rather allow any auth and not just the 
> specific one you want.
> 
> Then, the userid and password is probably better passed in 
> embedded in the proxy URL as that's given on the command
> line/environment already. Or as separate arguments.

Agreed.  (I'd just like to get it working first.)

> > It seems that git fetch (via HTLM proxy) works until
> >
> >> fatal: Couldn't find remote ref HEAD
> 
> Well, the CURLOPT_PROXY is set in transport.c as well which 
> your patch didn't address.

Thanks, I just did a similar patch to transport.c:

$ diff -u ../git-1.5.4.2/transport.c.orig \
          ../git-1.5.4.2/transport.c
@@ -456,7 +456,8 @@
        if (transport->remote->http_proxy)
                curl_easy_setopt(slot->curl, CURLOPT_PROXY,
                                 transport->remote->http_proxy);
-
+       curl_easy_setopt(slot->curl, CURLOPT_PROXYAUTH,
(long)CURLAUTH_NTLM);
+       curl_easy_setopt(slot->curl, CURLOPT_PROXYUSERPWD,
"<user-id>:<password>");
        if (start_active_slot(slot)) {
                run_active_slot(slot);
                if (results.curl_result != CURLE_OK) {
$

> If that's the case, I figure the verbose output 
> should've shown some auth failures with the proxy?

No, actually the last 2 lines of debug output (unchanged) is:

* Connection #0 to host <proxy domain> left intact
fatal: Couldn't find remote ref HEAD

So, the proxy communication via NTLM authentication seems to be working.
The patch to transport.c did not change anything as far as I can see.

The fatal error is from remote.c.  Perhaps, it also requires some
changes.

--

Example of curl (sans git) working via an NTLM proxy:

$ curl --proxy-ntlm --proxy-user <user-id> \
    --proxy <proxy-domain>:<proxy-port> http://slashdot.org/
Enter proxy password for user '<user-id>': <non-echoed password>
<HTML of /. home page>

Thus, it seems that git could be modified to work via HTLM
authentication, but my simple changes to http.c and transport.c
above are probably not sufficient.

Suggestions are most welcome.

Thanks,

Ken Fuchs
