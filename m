From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] teach git-archive to auto detect the output format
Date: Sun, 13 Sep 2009 21:36:47 +0400
Message-ID: <1252863407-2598-2-git-send-email-dpotapov@gmail.com>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
 <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 19:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmt6y-00056Z-HG
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 19:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbZIMRmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbZIMRl7
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 13:41:59 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59756 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbZIMRl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 13:41:58 -0400
Received: by fxm17 with SMTP id 17so410491fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hw2EUPcN46bqVw4hlWTGAFHMSj/7bQWzN1T0Rqk1dNE=;
        b=Fmq9Wz8IvW5yplAftN2J6hz+cfa3K6fquVGTCwPU+V3r6fc88OTZrb4TxE19eV4Y6O
         B5BGvI/dNBGjaL97s7DHy3RKER5u1JAvXdHS7Dcln94Rn2vZEy3q6v4hfablzlhgf5BB
         k1Qb3+4A+cC50/P1Xw7hFlPqIUwpgnAxX8k+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vrlzN/HmcA2ULKeGCC2XwxVvqMVZyoQwplIOBzUqnhGYwcO4+iDBiewm8Wj+KycJs0
         j5HL7I1jmeZzndbwQH/DIsX4gOuy+cVdI3VlPbWAQ9nKpqHGFdqdXUJaCPMT2BGPdu9H
         W4nQxeEmGDa3VIC34TbJ/IE6nkJzjdT1Jmfdc=
Received: by 10.204.153.18 with SMTP id i18mr4314658bkw.123.1252863721235;
        Sun, 13 Sep 2009 10:42:01 -0700 (PDT)
Received: from localhost (ppp91-77-225-181.pppoe.mtu-net.ru [91.77.225.181])
        by mx.google.com with ESMTPS id p17sm4014438fka.42.2009.09.13.10.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 10:42:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.2.g6bb993
In-Reply-To: <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128377>

When I type something like this:
  git archive -o my-v2.0.zip v2.0
it is almost certainly that I want to create a zip archive, and not
a tar file.

This patch teaches git-archive to auto detect the output format from the
file name. Currently, only '.zip' is supported. If the auto detect failed,
the tar format is used as default. The auto detect is not used when the
output format is specified explicitly.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Sat, Sep 12, 2009 at 07:47:21PM -0700, Junio C Hamano wrote:
> John Tapsell <johnflux@gmail.com> writes:
>_
> > Why not have  --format=tgz  then or something?  Or better yet, give
> > the filename on the command line and detect the format from the file
> > extension.
>_
> That is an interesting enhancement and sounds like a useful feature.

Here is my first attempt to implement that. I have not added 'tgz' yet,
but only auto detect the format from the output file name.

PS I resend this patch because I forgot to include the git mailing list when
I sent it before. Sorry for inconvinience...

 Documentation/git-archive.txt |   10 +++++++++-
 builtin-archive.c             |   25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index f7a3b95..c6fb21c 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -35,7 +35,9 @@ OPTIONS
 
 --format=<fmt>::
 	Format of the resulting archive: 'tar' or 'zip'.  The default
-	is 'tar'.
+	is 'tar', unless the output file is specified, and it has a known
+	extension (such as '.zip') then the default for the output format
+	will be determined by this extension.
 
 -l::
 --list::
@@ -130,6 +132,12 @@ git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs
 	Put everything in the current head's Documentation/ directory
 	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
 
+git archive -o latest.zip HEAD::
+
+	Create a Zip archive that contains the contents of the latest
+	commit on the current branch. Note that the output format is
+	specified implicitly by the extension of the output file.
+
 
 SEE ALSO
 --------
diff --git a/builtin-archive.c b/builtin-archive.c
index 565314b..878c6b2 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -60,6 +60,17 @@ static int run_remote_archiver(int argc, const char **argv,
 	return !!rv;
 }
 
+static const char* format_from_name(const char *filename)
+{
+	const char *ext = strrchr(filename, '.');
+	if (!ext)
+		return NULL;
+	ext++;
+	if (!strcasecmp(ext, "zip"))
+		return "zip";
+	return NULL;
+}
+
 #define PARSE_OPT_KEEP_ALL ( PARSE_OPT_KEEP_DASHDASH | 	\
 			     PARSE_OPT_KEEP_ARGV0 | 	\
 			     PARSE_OPT_KEEP_UNKNOWN |	\
@@ -70,6 +81,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *exec = "git-upload-archive";
 	const char *output = NULL;
 	const char *remote = NULL;
+	const char *format = NULL;
 	struct option local_opts[] = {
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
@@ -77,14 +89,27 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
+		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_END()
 	};
+	char fmt_opt[32];
 
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
 	if (output)
+	{
 		create_output_file(output);
+		if (!format)
+			format = format_from_name(output);
+	}
+
+	if (format)
+	{
+		sprintf(fmt_opt, "--format=%s", format);
+		argv[argc++] = fmt_opt;
+		argv[argc] = NULL;
+	}
 
 	if (remote)
 		return run_remote_archiver(argc, argv, remote, exec);
-- 
1.6.4
