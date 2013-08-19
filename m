From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Mon, 19 Aug 2013 09:26:56 -0700
Message-ID: <B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de> <20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
 <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
 <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
 <20130816205246.GA6487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 19 18:27:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBSIJ-0008PR-JM
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 18:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab3HSQ07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 12:26:59 -0400
Received: from exhub018-4.exch018.msoutlookonline.net ([64.78.17.19]:48682
	"EHLO EXHUB018-4.exch018.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab3HSQ06 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 12:26:58 -0400
Received: from EXVMBX018-11.exch018.msoutlookonline.net ([64.78.17.52]) by
 EXHUB018-4.exch018.msoutlookonline.net ([64.78.17.19]) with mapi; Mon, 19 Aug
 2013 09:26:58 -0700
Thread-Topic: [PATCH] Git segmentation faults if submodule path is empty.
Thread-Index: Ac6c+OzDq7DwqzO9R4iQIhpvwT2NDQ==
In-Reply-To: <20130816205246.GA6487@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232549>

Updated the patch and the patch submission.

 -- >8 --

Git segmentation faults if submodule path is empty.

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
 t/t1307-null-submodule-path.sh |   14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 t/t1307-null-submodule-path.sh

diff --git a/submodule.c b/submodule.c
index 1821a5b..1a2cf30 100644
--- a/submodule.c
+++ b/submodule.c
@@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
+		if (!value)
+			return config_error_nonbool(var);
+
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
@@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 	} else if (!strcmp(key, "ignore")) {
 		char *name_cstr;
 
+		if (!value)
+			return config_error_nonbool(var);
+
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
diff --git a/t/t1307-null-submodule-path.sh b/t/t1307-null-submodule-path.sh
new file mode 100755
index 0000000..a4470a8
--- /dev/null
+++ b/t/t1307-null-submodule-path.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='test empty submodule path'
+. ./test-lib.sh
+
+setup() {
+    echo '[submodule "test"] path' > .gitmodules
+}
+
+test_expect_success 'git status with empty submodule path should not seg fault' '
+    setup &&
+    test_must_fail git status
+'
+test_done
-- 
1.7.9.5

 On Aug 16, 2013, at 2:52 PM, Jeff King <peff@peff.net> wrote:

> On Fri, Aug 16, 2013 at 10:59:35AM -0700, Jharrod LaFon wrote:
> 
>> Here is an updated patch with a test.
> 
> Bits like this that should not be part of the commit message should
> either go after the "---" lines near the diffstat, or should come before
> a scissors line, like:
> 
>  Here is my new patch.
> 
>  -- >8 --
>  Git segmentation faults etc...
> 
> That way git-am can do the right thing, and the maintainer does not have
> to fix up your patch by hand.
> 
>> diff --git a/submodule.c b/submodule.c
>> index 1821a5b..1e4acfd 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>> 		return 0;
>> 
>> 	if (!strcmp(key, "path")) {
>> +        if (!value)
>> +            return config_error_nonbool(var);
> 
> Your indentation looks like two spaces here, which does not match the
> rest of the block. It should be one tab.
> 
>> @@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>> 	} else if (!strcmp(key, "ignore")) {
>> 		char *name_cstr;
>> 
>> +        if (!value)
>> +            return config_error_nonbool(var);
>> +
> 
> Ditto here.
> 
>> diff --git a/t/t1307-null-submodule-path.sh b/t/t1307-null-submodule-path.sh
>> new file mode 100644
>> index 0000000..eeda2cb
>> --- /dev/null
>> +++ b/t/t1307-null-submodule-path.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh
>> +
>> +test_description='test empty submodule path'
>> +. ./test-lib.sh
>> +
>> +setup() {
>> +    (printf "[submodule \"test\"]\n" && 
>> +    printf "  path\n" &&
>> +    printf "  url") >.gitmodules
>> +}
> 
> You can use single-quotes to avoid having to backslash the embedded
> double-quotes. And I do not see any reason to use printf rather than the
> more readable echo, which can drop the "\n".
> 
> And is there any point in having the "url" field?  The presence of a
> valueless bool "path" should be enough, no? It may be easier to see what
> it is we are testing without the extraneous parameter.
> 
> With those changes, you could even put it all on one line:
> 
>  echo '[submodule "test"] path' >.gitmodules
> 
> -Peff
