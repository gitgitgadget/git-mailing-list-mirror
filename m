From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2 2/2] teach git-archive to auto detect the output format
Date: Mon, 14 Sep 2009 00:17:01 +0400
Message-ID: <20090913201701.GH30385@dpotapov.dyndns.org>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org> <1252863407-2598-1-git-send-email-dpotapov@gmail.com> <1252863407-2598-2-git-send-email-dpotapov@gmail.com> <7vzl8yr81j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmvaL-0002JV-O3
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZIMUWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbZIMUWA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:22:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:3568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbZIMUV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:21:59 -0400
Received: by fg-out-1718.google.com with SMTP id 22so374149fge.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+LcDh3rrterehv8GcADwBXjLnbWsBBmAhqYxgSjPOhQ=;
        b=V7mv5h/hGSYXY/ebiiGpXCEdut5MRDXLKaNiIO9OKMLun7SyWgdRJ1K4tP7yk2PA6D
         VTfJoaWexraf3vLRJAHr6K1D8mViekux0oi5uEPiyYcnHjIibx46t1KE2ubHgomJ+Sys
         6DW8nbvIq4Ja3jTvygRVWYMZyIPryjf4Y9ydo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B7aaVVgj7ElLxrBF2Heoz6nOJfEGVuh2dj+B2BTc6OWm8Z75R0OuYUl9fonnTaVRRC
         M401SPvIjvDfixtYGZwedeIbjKSOzIoTqf5gFiIrm4EwlevILAbuyHQazbNTWvNihxgi
         vwhIQYEuvxPmr9Q8s1ArPupmhVtfIP54MqgRI=
Received: by 10.86.20.8 with SMTP id 8mr4247867fgt.44.1252873322157;
        Sun, 13 Sep 2009 13:22:02 -0700 (PDT)
Received: from localhost (ppp91-77-225-181.pppoe.mtu-net.ru [91.77.225.181])
        by mx.google.com with ESMTPS id l19sm266085fgb.27.2009.09.13.13.22.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 13:22:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzl8yr81j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128407>

When I type something like this:
  git archive -o my-v2.0.zip v2.0
it is almost certainly that I want to create a zip archive, and not
a tar file.

This patch teaches git-archive to auto detect the output format from the
file name. Currently, only '.zip' is supported. If the auto detect failed,
the tar format is used as before. The auto detect is not used when the
output format is specified explicitly.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

I have corrected all remarks except this:

On Sun, Sep 13, 2009 at 11:52:56AM -0700, Junio C Hamano wrote:
> > +		sprintf(fmt_opt, "--format=%s", format);
> > +		argv[argc++] = fmt_opt;
> > +		argv[argc] = NULL;
> 
> Did you make sure you are allowed to write into argv[] and the array is
> large enough?  You probably need to make a copy of the array.

Either --output or --format option was used before, and this option is
extracted from argv[] by parse_options(). So it should be space for at
least one argument in argv.


 Documentation/git-archive.txt |   13 +++++++++++--
 builtin-archive.c             |   25 ++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 1917f2e..3d1c1e7 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -34,8 +34,11 @@ OPTIONS
 -------
 
 --format=<fmt>::
-	Format of the resulting archive: 'tar' or 'zip'.  The default
-	is 'tar'.
+	Format of the resulting archive: 'tar' or 'zip'. If this option
+	is not given, and the output file is specified, the format is
+	inferred from the filename if possible (e.g. writing to "foo.zip"
+	makes the output to be in the zip format). Otherwise the output
+	format is `tar`.
 
 -l::
 --list::
@@ -130,6 +133,12 @@ git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs
 	Put everything in the current head's Documentation/ directory
 	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
 
+git archive -o latest.zip HEAD::
+
+	Create a Zip archive that contains the contents of the latest
+	commit on the current branch. Note that the output format is
+	inferred by the extension of the output file.
+
 
 SEE ALSO
 --------
diff --git a/builtin-archive.c b/builtin-archive.c
index 565314b..6efba6f 100644
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
@@ -77,14 +89,25 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
+		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_END()
 	};
+	char fmt_opt[32];
 
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
-	if (output)
+	if (output) {
 		create_output_file(output);
+		if (!format)
+			format = format_from_name(output);
+	}
+
+	if (format) {
+		sprintf(fmt_opt, "--format=%s", format);
+		argv[argc++] = fmt_opt;
+		argv[argc] = NULL;
+	}
 
 	if (remote)
 		return run_remote_archiver(argc, argv, remote, exec);
-- 
1.6.5.rc1.2.g6bb993
