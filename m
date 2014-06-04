From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Wed,  4 Jun 2014 21:30:56 +1200
Message-ID: <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
Cc: mara.kim@vanderbilt.edu, gitster@pobox.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 11:31:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws7Xc-0007mz-DU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 11:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbaFDJbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 05:31:23 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55961 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaFDJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 05:31:18 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so5843492pdj.22
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZBn7KfEWz8DraKlowVukiv0tZeSgHj4bfAu81ASGA/M=;
        b=y2tVa0EFLSyh8BNAIYkXxPLKXe1HKnvoRhhGRHi8/dT4myXOsxsBVA4cuW6OHMOzl+
         7FTGGC7YpWv80A0UIMbXJ0Z78YALnGacfhY8/jZuDflAfujVZ67tqAqspe2My8OO2Y5t
         x42G0q2COz8zX/PCwMn1nR1GBXLH33nkBHrBLDlNQXItRzTfNKxHbE5w/d+LlZIX5ejN
         /iWI6J38VNzJUoexz+ICk6zutQKKEc+cm7AaWsu/WfulT8M6qDCSprsYdKP2XZKHgrds
         k7f7sqhOMUgdmts41lz42DU9YjI8opSyNUb/vtKsictvIghbTumU96aV5ZQBvI1GBXKl
         MMFA==
X-Received: by 10.68.103.98 with SMTP id fv2mr37867211pbb.18.1401874277344;
        Wed, 04 Jun 2014 02:31:17 -0700 (PDT)
Received: from linux.lan (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id jt7sm7674483pbc.46.2014.06.04.02.31.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2014 02:31:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.153.g79dcccc
In-Reply-To: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250720>

Add a config option that will cause clone to recurse into submodules as
if the --recurse-submodules option had been specified on the command
line. This can be overridden with the --no-recurse-submodules option.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
On 04/06/14 09:05, Junio C Hamano wrote:
>> Mara Kim <mara.kim@vanderbilt.edu> writes:
>>
>>> Apologies if this question has been asked already, but what is the
>>> reasoning behind making git clone not recursive (--recursive) by
>>> default?
>>
>> The primary reason why submodules are separate repositories is not
>> to require people to have everything.  Some people want recursive,
>> some others don't, and the world is not always "majority wins" (not
>> that I am saying that majority will want recursive).
>>
>> Inertia, aka backward compatibility and not surprising existing
>> users, plays some role when deciding the default.
>>
>> Also, going --recursive when the user did not want is a lot more
>> expensive mistake to fix than not being --recursive when the user
>> wanted to.
> 
> Having said all that, I do not mean to say that I am opposed to
> introduce some mechanism to let the users express their preference
> between recursive and non-recursive better, so that "git clone"
> without an explicit --recursive (or --no-recursive) can work to
> their taste.  A configuration in $HOME/.gitconfig might be a place
> to start, even though that has the downside of assuming that the
> given user would want to use the same settings for all his projects,
> which may not be the case in practice.

And here's a quick proof of concept. Not sure about the config variable name
and it could probably do with a negative test as well.

 builtin/clone.c              |  9 +++++++++
 t/t7407-submodule-foreach.sh | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..92aea81 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -734,6 +734,14 @@ static void write_refspec_config(const char* src_ref_prefix,
 	strbuf_release(&value);
 }
 
+static int git_clone_config(const char *key, const char *value, void *data)
+{
+	if (!strcmp(key, "clone.recursesubmodules"))
+		option_recursive = git_config_bool(key, value);
+
+	return 0;
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -759,6 +767,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_pid = getpid();
 
 	packet_trace_identity("clone");
+	git_config(git_clone_config, NULL);
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 7ca10b8..fc2c189 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -307,6 +307,23 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	)
 '
 
+test_expect_success 'use "git clone" with clone.recursesubmodules to checkout all submodules' '
+	git config --local clone.recursesubmodules true &&
+	git clone super clone7 &&
+	(
+		cd clone7 &&
+		git rev-parse --resolve-git-dir .git &&
+		git rev-parse --resolve-git-dir sub1/.git &&
+		git rev-parse --resolve-git-dir sub2/.git &&
+		git rev-parse --resolve-git-dir sub3/.git &&
+		git rev-parse --resolve-git-dir nested1/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
+		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
+	) &&
+	git config --local --unset clone.recursesubmodules
+'
+
 test_expect_success 'command passed to foreach retains notion of stdin' '
 	(
 		cd super &&
-- 
2.0.0.153.g79dcccc
