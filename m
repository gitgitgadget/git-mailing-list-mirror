From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 10:59:35 -0700
Message-ID: <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de> <20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
 <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 16 19:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAOJJ-0004tB-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 19:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab3HPR7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 13:59:36 -0400
Received: from exhub018-3.exch018.msoutlookonline.net ([64.78.17.18]:43517
	"EHLO EXHUB018-3.exch018.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab3HPR7f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 13:59:35 -0400
Received: from EXVMBX018-11.exch018.msoutlookonline.net ([64.78.17.52]) by
 EXHUB018-3.exch018.msoutlookonline.net ([64.78.17.18]) with mapi; Fri, 16 Aug
 2013 10:59:35 -0700
Thread-Topic: [PATCH] Git segmentation faults if submodule path is empty.
Thread-Index: Ac6aql44B8dCu5KCTCWGcG94GEHWmg==
In-Reply-To: <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232437>

Here is an updated patch with a test. 

Git fails due to a segmentation fault if a submodule path is empty.
Here is an example .gitmodules that will cause a segmentation fault:
[submodule "foo-module"]
  path
  url = http://host/repo.git
$ git status
Segmentation fault (core dumped)

This occurs because in the function parse_submodule_config_option, the
variable 'value' is assumed to be null, and when passed as an argument
to xstrdup a segmentation fault occurs if it is indeed null.
This is the case when using the .gitmodules example above.

This patch addresses the issue by checking to make sure 'value' is not
null before using it as an argument to xstrdup.  For some configuration
options, such as fetchRecurseSubmodules, an empty value is valid.  If
the option being read is 'path', an empty value is not valid, and so
an error message is printed.

Signed-off-by: Jharrod LaFon <jlafon <at> eyesopen.com>
---
 submodule.c                    |    6 ++++++
 t/t1307-null-submodule-path.sh |   16 ++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 t/t1307-null-submodule-path.sh

diff --git a/submodule.c b/submodule.c
index 1821a5b..1e4acfd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
+        if (!value)
+            return config_error_nonbool(var);
+
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
@@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 	} else if (!strcmp(key, "ignore")) {
 		char *name_cstr;
 
+        if (!value)
+            return config_error_nonbool(var);
+
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
diff --git a/t/t1307-null-submodule-path.sh b/t/t1307-null-submodule-path.sh
new file mode 100644
index 0000000..eeda2cb
--- /dev/null
+++ b/t/t1307-null-submodule-path.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description='test empty submodule path'
+. ./test-lib.sh
+
+setup() {
+    (printf "[submodule \"test\"]\n" && 
+    printf "  path\n" &&
+    printf "  url") >.gitmodules
+}
+
+test_expect_success 'git status with empty submodule path should not segfault' '
+    setup &&
+    test_must_fail git status
+'
+test_done
-- 
1.7.9.5



--
Jharrod LaFon
OpenEye Scientific Software

On Aug 16, 2013, at 9:12 AM, Jharrod LaFon <jlafon@eyesopen.com> wrote:

> OK,  I'll incorporate Jeff's changes, add a test and resubmit the patch.
> 
> Thanks,
> 
> --
> Jharrod LaFon
> OpenEye Scientific Software
> 
> On Aug 16, 2013, at 7:14 AM, Jeff King <peff@peff.net> wrote:
> 
>> On Fri, Aug 16, 2013 at 09:09:58AM -0400, Jeff King wrote:
>> 
>>>>> -	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
>>>>> +	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
>>>>> 		return 0;
>>> 
>>> I think this is also the wrong place to make the check, anyway. It is
>>> saying that all values of submodule.X.Y must be non-NULL. But that is
>>> not true. The submodule.X.fetchRecurseSubmodules option can be a
>>> boolean, and:
>>> 
>>> [submodule "foo"]
>>>   fetchRecurseSubmodules
>>> 
>>> is perfectly valid (and is broken by this patch).
>> 
>> IOW, I think this is the right fix:
>> 
>> diff --git a/submodule.c b/submodule.c
>> index 3f0a3f9..c0f93c2 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>> 		return 0;
>> 
>> 	if (!strcmp(key, "path")) {
>> +		if (!value)
>> +			return config_error_nonbool(var);
>> +
>> 		config = unsorted_string_list_lookup(&config_name_for_path, value);
>> 		if (config)
>> 			free(config->util);
>> @@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>> 	} else if (!strcmp(key, "ignore")) {
>> 		char *name_cstr;
>> 
>> +		if (!value)
>> +			return config_error_nonbool(var);
>> +
>> 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
>> 		    strcmp(value, "all") && strcmp(value, "none")) {
>> 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
>> 
>> And new options, as they are added, must decide whether they are boolean
>> or not (and check !value as appropriate).
>> 
>> -Peff
> 
