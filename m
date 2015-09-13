From: Christoffer Haglund <christoffer.haglund@gmail.com>
Subject: No negotiation for repos on HTTP servers?
Date: Sun, 13 Sep 2015 21:31:54 +0200
Message-ID: <CAGHtn=oXUa2=n2aMWQKndDSfGZ2bPm-dxZ7jin7QOx8dRxp3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 21:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbD0g-0004wP-9E
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 21:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbbIMTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 15:31:56 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34483 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbbIMTbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 15:31:55 -0400
Received: by qgez77 with SMTP id z77so100694017qge.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LOCRHQLbpnpX2mPPZqSC+lNgEBkWxHAX3oRVXmFXPfQ=;
        b=T2vi1ZSJ3fbUCHfkEwWdt4ryNr8czkBQcurR7jtp+vpTf9sI8F2eRb1UGk+chArL3t
         vyzmvPHil5OJDpcdwQwd5U3r1ViGpfXgELXdkF94Kc/XKOa6tcC9mmh9Bf3ltXJsrMVo
         WdsChRm7+3q62gh3t7SlwKgb7DxtmEKRzGgM40nFTRqp36C0wcJRP6nSEu6vAzkBoZdT
         O31dk/KZDmeT5+WpXsJCJ8/n1UY8eShn5/Ec3/yWR+QTIjgg5dumN55OSSnG3UVMTA8D
         2qvK+MBvMUj7cOUTlBupMnuxuoWQ/n/McVXJFweMC1UDOUrLF2hY3YHelWizT9wTSoeh
         pZgg==
X-Received: by 10.140.196.193 with SMTP id r184mr670638qha.77.1442172714325;
 Sun, 13 Sep 2015 12:31:54 -0700 (PDT)
Received: by 10.55.160.15 with HTTP; Sun, 13 Sep 2015 12:31:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277793>

Hi,

I wonder if I've hit a bug in git, or perhaps in libcurl.

Our team that use git repos hosted on a number of different
environments, including HTTP servers using Kerberos or NTLM to
authenticate users. Command-line git needs explicit credentials to
work against these repos, while Visual Studio (i.e. libgit2) does not.
The other day I noticed that when I give null credentials (i.e. empty
username and password) normal command-line git works beautifully,
authenticating as the currently signed-in user.

I digged around a bit and found a potential bug in how libcurl is
used; when using CURLAUTH_ANY, no handshaking will actually be done
unless a user name is specified - even if it's a fake one.

This is consistent with the documentation for curl itself,
http://curl.haxx.se/docs/manpage.html#--negotiate , however I see no
mention of this quirk in the libcurl API documentation.

The fix I'm using locally is quite straightforward:


diff --git a/http.c b/http.c
index 9dce380..f62f6b6 100644
--- a/http.c
+++ b/http.c
@@ -668,6 +668,10 @@ struct active_request_slot *get_active_slot(void)
 #endif
        if (http_auth.password)
                init_curl_http_auth(slot->curl);
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+       else
+               curl_easy_setopt(slot->curl, CURLOPT_USERNAME, "");
+#endif
        return slot;
 }


As far as I can tell this works fine against NTLM and Kerberos HTTP
servers, and has no effect on servers allowing anonymous access.

Against a server using Basic authentication the patch will cause git
to fire off a redundant 'GET' with the empty username before asking
the user for credentials. I'm not sure if that could cause problems
for other users, I would expect that anyone working against a server
with Basic authentication uses stored credentials anyway :-)

But perhaps there is some other case I've not considered?

  // Christoffer
