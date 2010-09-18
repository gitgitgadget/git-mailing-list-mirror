From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] smart-http: Don't change POST to GET when following redirect
Date: Sat, 18 Sep 2010 10:47:50 +0200
Message-ID: <m21v8rcua1.fsf_-_@whitebox.home>
References: <877hijvff7.fsf@catnip.gol.com>
	<20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
	<m262y3cvpy.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Sep 18 10:48:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owt5e-000446-2n
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 10:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0IRIrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 04:47:53 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38416 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab0IRIrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 04:47:52 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A9A4A1C001BB;
	Sat, 18 Sep 2010 10:47:50 +0200 (CEST)
X-Auth-Info: lb3X7l44CYoC3EQHdNTwJY0rZjxxcM+299gUnz7kDNk=
Received: from whitebox.home (ppp-88-217-109-67.dynamic.mnet-online.de [88.217.109.67])
	by mail.mnet-online.de (Postfix) with ESMTPA id 99F761C00268;
	Sat, 18 Sep 2010 10:47:50 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 5F79C1E5311; Sat, 18 Sep 2010 10:47:50 +0200 (CEST)
X-Yow: This MUST be a good party -- My RIB CAGE is being painfully
 pressed up against someone's MARTINI!!
In-Reply-To: <m262y3cvpy.fsf@whitebox.home> (Andreas Schwab's message of "Sat,
	18 Sep 2010 10:16:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156439>

When the remote HTTP server returns a redirect the default libcurl action
is to change a POST request into a GET request while following the
redirect, but the remote http backend does not expect that.  Tell libcurl
to always keep the POST request.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
Andreas Schwab <schwab@linux-m68k.org> writes:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
>
>> On Sat, Sep 18, 2010 at 01:33:48PM +0900, Miles Bader wrote:
>>
>>> The savannah.gnu.org admins are trying out the git "smart http" server,
>>> but it doesn't seem to handle http redirects properly... should it?
>>> Is this a bug with the git server?
>>> 
>>> The follow is from Sylvain Beucler;
>>> > Hmmm, actually it works, but it doesn't support a HTTP redirect
>>> > (namely git.sv.gnu.org -> git.savannah.gnu.org).
>>> >
>>> > $ git clone http://git.sv.gnu.org/r/freedink.git
>>> > Initialized empty Git repository in /tmp/freedink/.git/
>>> > error: RPC failed; result=22, HTTP code = 405
>>
>> 405 (Method not allowed)? Can you see what request it is trying to send
>> and to where (the request that fails with 405 that is)?
>
> I think this is a bug in the apache setup at savannnah.  It is
> responding to POST .../git-upload-pack with both 301 and 405.  This does
> not happen if you use the redirected address directly.

Looking closer, this is actually a bug in git.  It does not set the
POSTREDIR option, so that libcurl changes the POST into GET when
following a redirection.

Andreas.

---
 remote-curl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 04d4813..309b024 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -393,6 +393,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
+	curl_easy_setopt(slot->curl, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
-- 
1.7.2.3


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
