From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: [PATCH] Git segmentation faults if submodule path is empty.
Date: Thu, 15 Aug 2013 18:51:05 -0700
Message-ID: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9Lr-0006ix-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab3HPCBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:01:12 -0400
Received: from exhub018-1.exch018.msoutlookonline.net ([64.78.17.16]:33563
	"EHLO EXHUB018-1.exch018.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753536Ab3HPCBL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:01:11 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2013 22:01:11 EDT
Received: from EXVMBX018-11.exch018.msoutlookonline.net ([64.78.17.52]) by
 EXHUB018-1.exch018.msoutlookonline.net ([64.78.17.16]) with mapi; Thu, 15 Aug
 2013 18:51:06 -0700
Thread-Topic: [PATCH] Git segmentation faults if submodule path is empty.
Thread-Index: Ac6aIxJG6vRhqLqBRmmfheEn3sUiLQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232391>

Git fails due to a segmentation fault if a submodule path is empty.
Here is an example .gitmodules that will cause a segmentation fault:
[submodule "foo-module"]
    path
    url = http://host/repo.git
$ git status
Segmentation fault (core dumped)

This occurs because in the function parse_submodule_config_option, the
variable 'value' is assumed not to be null, and when passed as an
argument to xstrdup a segmentation fault occurs if it is indeed null.
This is the case when using the .gitmodules example above.

This patch addresses the issue by returning from the function if
'value' is null before the call to xstrdup is made.

Signed-off-by: Jharrod LaFon <jlafon <at> eyesopen.com>
---
 submodule.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 1821a5b..880f21b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -130,7 +130,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 	const char *name, *key;
 	int namelen;
 
-	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
+	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
-- 
1.7.9.5


--
Jharrod LaFon
OpenEye Scientific Software
