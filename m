From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 4/5] Teach transport about the gitfile mechanism
Date: Wed, 05 Oct 2011 09:35:10 -0400
Message-ID: <4E8C5D0E.6080207@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBReV-0000rp-J7
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934765Ab1JENgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 09:36:48 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:58500 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934670Ab1JENgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=871; q=dns/txt;
  s=iport; t=1317821806; x=1319031406;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=zqhC+RqLArta3OSmyZ4Xq9wXTIkZri5oM3Wmg5IrJ6Y=;
  b=UPgMHP1g0KU1ci0YyNPJD8pI6PoV9LEfIfcKJG1I8apm0vPhWlIvyTRJ
   4KIOeE8CThms8iaJN/HS9BQk8gLIf+CfcvESRNM0l1+yWywau1Eyw7Q6x
   Ie5+GgSCAe8S6neDf9HoBaoevu9xrwYL+h1MkYjGSmfRO3kPZYalAIpER
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EALJcjE6tJV2a/2dsb2JhbABCqBGBBYFsARRRATwWGAMCAQIBSwEMAQUCAQEeoDoBngyHKQSTbYUnjDk
X-IronPort-AV: E=Sophos;i="4.68,491,1312156800"; 
   d="scan'208";a="26218907"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-7.cisco.com with ESMTP; 05 Oct 2011 13:36:45 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p95Daj5f005682;
	Wed, 5 Oct 2011 13:36:45 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-Enigmail-Version: 1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182844>

The transport_get() function assumes that a regular file is a
bundle rather than a local git directory. Check if the file is
actually a gitfile.  If so, do not try to process it as a
bundle, but treat it as a local repository instead.

Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/transport.c b/transport.c
index cd49a25..2ff2d68 100644
--- a/transport.c
+++ b/transport.c
@@ -915,7 +915,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
-	} else if (is_local(url) && is_file(url)) {
+	} else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.7.7.505.ga09f6
