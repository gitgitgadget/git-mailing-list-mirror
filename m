From: <Ken.Fuchs@bench.com>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLMauthentication -- git 1.5.4.2 & curl 7.18.0
Date: Wed, 27 Feb 2008 16:10:57 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C08@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUWE-0004cU-2s
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761133AbYB0WLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761482AbYB0WLA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:11:00 -0500
Received: from tx-smtp01.bench.com ([12.163.172.137]:47616 "EHLO
	tx-smtp01.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761940AbYB0WK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 17:10:59 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.67])
  by tx-smtp01.bench.com with ESMTP; 27 Feb 2008 16:13:17 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 27 Feb 2008 16:10:58 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: git via http protocol _and_ a proxy using NTLMauthentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach5ENQ6yw+0DO1lS4mogyF3vzQuOgAdThew
X-OriginalArrivalTime: 27 Feb 2008 22:10:58.0201 (UTC) FILETIME=[A134F090:01C8798D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75308>

> Ken Fuchs wrote:

Current changes to http.c, get_curl_handle()
        and transport.c, get_refs_via_curl():

> > +       curl_easy_setopt(slot->curl, CURLOPT_PROXYAUTH,
> > (long)CURLAUTH_NTLM);
> > +       curl_easy_setopt(slot->curl, CURLOPT_PROXYUSERPWD,
> > "<user-id>:<password>");

Mike Hommey wrote: 
 
> Starting with curl 7.14.1, you're supposed to be able to use the
> http://user:pass@proxy/ syntax, though I'm not sure it deals well with
> NTLM domains. You can probably leave CURLOPT_PROXYUSERPWD out if you
> set your proxy url correctly.

Leaving out the line above containing CURLOPT_PROXYUSERPWD in both
http.c and transport.c and using curl 7.18.0 ...

$ http_proxy=user-id:password@proxy.domain:<port> GIT_CURL_VERBOSE=1 \
    git fetch http://www.kernel.org/pub/scm/git/git.git

fails proxy NTLM authentication.  The correct user-id is used,
but maybe the password wasn't correctly parsed.

> As for CURLOPT_PROXYAUTH, it would be better to set it from another
> config.
From a later message:
> Or we should set it to CURLOPT_AUTHANY by default.

The code should probably do both.

> > * Connection #0 to host <proxy domain> left intact
> > fatal: Couldn't find remote ref HEAD
> > 
> > So, the proxy communication via NTLM authentication seems 
> > to be working.
> > The patch to transport.c did not change anything as far as 
> > I can see.
> > 
> > The fatal error is from remote.c.  Perhaps, it also requires some
> > changes.
> 
> Does your remote have a HEAD ref ?

The command used to generate the above output is:

$ GIT_CURL_VERBOSE=1 git fetch \
  http://www.kernel.org/pub/scm/git/git.git

I originally tried the following command as suggested by the git
home page for getting "git by git".

$ GIT_CURL_VERBOSE=1 git clone \
  http://www.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /mnt/s2u1/git/test-git/git/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
$

This seemed like a good test for validating my git installation,
but this command doesn't access the proxy at all.  The fetch
command does.  Why the difference?

Thanks,

Ken Fuchs
