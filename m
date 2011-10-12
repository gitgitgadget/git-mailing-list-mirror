From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Wed, 12 Oct 2011 15:47:51 -0400
Message-ID: <4E95EEE7.9040208@cisco.com>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com> <7vipnvccso.fsf@alter.siamese.dyndns.org> <CABURp0p4_oVMmkFDPue4kvhO_bEr_dBh-XFGArdSJFMz-Eboeg@mail.gmail.com> <7vmxd69j72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4mV-0002N0-Pw
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab1JLTrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:47:55 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:42185 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab1JLTry (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3503; q=dns/txt;
  s=iport; t=1318448874; x=1319658474;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=IRKsQunyJ2fYkHSfCyaUGHiWyH5y4DzFOsWrTH40yOM=;
  b=Z0JnHC3saKEG6lp/nTMVX38RY+qgLy0b5RmbsE0zK+lqwiuGlSa1YvDQ
   /EbGhYQB7lTv1ZrZ4rqpXKJSHjyC8H+qLGVR2Trm4pCtedko111jJdPSE
   7Yp2giNcoy8E920oZxCWqni0R4novMCPRehRUhNcZIxJnLbyFaZ5ng6OY
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAGbulU6tJV2b/2dsb2JhbAA5Cqg5gQWBUwEBAQEDEgEUUQEQCxcBCRYPCQMCAQIBDy4IBg0BBQIBAR6jGwGeUoQpgy8Ek3WFKIM6gUqHRA
X-IronPort-AV: E=Sophos;i="4.69,336,1315180800"; 
   d="scan'208";a="27930770"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-2.cisco.com with ESMTP; 12 Oct 2011 19:47:53 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p9CJlrO1007274;
	Wed, 12 Oct 2011 19:47:54 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <7vmxd69j72.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.2.1
X-TagToolbar-Keys: D20111012154751838
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183407>

Junio C Hamano <gitster@pobox.com> sez:
> Phil Hord <phil.hord@gmail.com> writes:
> 
>> On Tue, Oct 11, 2011 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> After looking at this patch and the way the other caller in transport.c
>>> uses it, I am more and more convinced that "is_gitfile()" is a stupid and
>>> horrible mistake.
>>
>> I think I misunderstood your objection before.  Now I think I
>> understand.  Tell me if I am right.
>>
>>
>> I think you mean that instead of this:
>>         } else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
>>
>> you would like to see this:
>>         } else if (is_local(url) && is_file(url) && is_bundle(url)) {
>>
>> Or maybe even this:
>>         } else if (is_bundle(url)) {
> 
> Exactly.

I tried to refactor read_bundle_header, but it was too ugly and I don't quite
understand all the error paths.  Plus, the whole is_bundle part can be just 
10 lines of code.  Maybe read_bundle_header() should be shortened slightly to
use is_bundle() for code duplication avoidance.

-- >8 --
Subject: [PATCH] transport: Add/use is_bundle() to identify a url

Transport currently decides that any local url which is a file
must be a bundle.  This is wrong now if the local url is a
gitfile, and it will be wrong in the future when some other
exception shows up.  Teach transport to verify the file is
really a bundle instead of just assuming it is so.
---
 bundle.c    |   16 ++++++++++++++++
 bundle.h    |    1 +
 transport.c |   10 +---------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/bundle.c b/bundle.c
index f82baae..3a64a43 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,6 +23,22 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
+int is_bundle(const char *path)
+{
+	char buffer[100];
+	FILE *ffd = fopen(path, "rb");
+	int ret=1;
+
+	if (!ffd)
+		return 0;
+
+	if (!fgets(buffer, sizeof(buffer), ffd) ||
+			strcmp(buffer, bundle_signature))
+		ret=0;
+	fclose(ffd);
+	return ret;
+}
+	
 /* returns an fd */
 int read_bundle_header(const char *path, struct bundle_header *header)
 {
diff --git a/bundle.h b/bundle.h
index c5a22c8..35aa0eb 100644
--- a/bundle.h
+++ b/bundle.h
@@ -14,6 +14,7 @@ struct bundle_header {
 	struct ref_list references;
 };
 
+int is_bundle(const char *path);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
diff --git a/transport.c b/transport.c
index f3195c0..bcd9b74 100644
--- a/transport.c
+++ b/transport.c
@@ -881,14 +881,6 @@ static int is_gitfile(const char *url)
 	return !prefixcmp(buf, "gitdir: ");
 }
 
-static int is_file(const char *url)
-{
-	struct stat buf;
-	if (stat(url, &buf))
-		return 0;
-	return S_ISREG(buf.st_mode);
-}
-
 static int external_specification_len(const char *url)
 {
 	return strchr(url, ':') - url;
@@ -929,7 +921,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
-	} else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
+	} else if (is_local(url) && is_bundle(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.7.7.334.g311c9.dirty
