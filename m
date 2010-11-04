From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] clone: Add the  --recurse-submodules option as alias for
 --recursive
Date: Thu, 04 Nov 2010 21:27:12 +0100
Message-ID: <4CD31720.7080104@web.de>
References: <4CD1ACF7.6040108@web.de> <7vbp66vxuw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6P6-0007uG-Uu
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab0KDU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:27:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44250 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab0KDU1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:27:18 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 05BE11747EAD5;
	Thu,  4 Nov 2010 21:27:17 +0100 (CET)
Received: from [93.246.52.145] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PE6Oy-00058l-00; Thu, 04 Nov 2010 21:27:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vbp66vxuw.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+n/8m7Kd34a4STdvKE09+HPb0JbR00qHJkwATG
	aw/I0k6xcECHIxxcx5Mqc5ORNQn/xYoUy46GRpbD+GPSk0PCYa
	+Nu5j5IuEV/uwK/Ushqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160754>

Since 1.6.5 "git clone" honors the --recursive option to recursively check
out submodules too. As this option can easily be misinterpreted when it is
added to other commands like "git grep", add the new --recurse-submodules
option as an alias for --recursive so the same option can be used for all
commands recursing into submodules.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 03.11.2010 23:36, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> ... For my first recursion patches a
>> few months ago I started with --recurse-submodules but then I noticed
>> that "git clone" already used "--recursive" for the same purpose, and
>> for consistency reasons I switched to using that too. But especially
>> when looking at recursive grep it is really easy to misinterpret
>> --recursive, so the idea came up to use --recurse-submodules everywhere.
>>
>> Opinions?
> 
> I think it would make sense to _add_ --recurse-submodules to "clone" to
> make everybody consistent.
> ... I
> thing it is too strong to _deprecate_ the option in the context of that
> command.

Fine by me, then what about this patch?

And am I right to assume that there are no objections against using
--recurse-submodule for fetch, checkout & friends?


 Documentation/git-clone.txt |    4 +++-
 builtin/clone.c             |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ab72933..d69984b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--recursive] [--] <repository> [<directory>]
+	  [--depth <depth>] [--recursive|--recurse-submodules] [--] <repository>
+	  [<directory>]

 DESCRIPTION
 -----------
@@ -167,6 +168,7 @@ objects from the source repository into a pack in the cloned repository.
 	as patches.

 --recursive::
+--recurse-submodules::
 	After the clone is created, initialize all submodules within,
 	using their default settings. This is equivalent to running
 	`git submodule update --init --recursive` immediately after
diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..61e0989 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,6 +66,8 @@ static struct option builtin_clone_options[] = {
 		    "setup as shared repository"),
 	OPT_BOOLEAN(0, "recursive", &option_recursive,
 		    "initialize submodules in the clone"),
+	OPT_BOOLEAN(0, "recurse_submodules", &option_recursive,
+		    "initialize submodules in the clone"),
 	OPT_STRING(0, "template", &option_template, "path",
 		   "path the template repository"),
 	OPT_STRING(0, "reference", &option_reference, "repo",
-- 
1.7.3.2.194.ge0b67
